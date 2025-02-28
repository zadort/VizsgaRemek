using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using vizsga3.Models;
using System.Security.Cryptography;
using System.Text;
using vizsga3.Models.Dtos;
using vizsga3.Services.IEmailService;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace vizsga3.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class FelhasznaloController : ControllerBase
    {
        private readonly Vizsga3Context _context;
        private readonly IEmail _email;
        private readonly ILogger<FelhasznaloController> _logger;
        private readonly IConfiguration _configuration;

        public FelhasznaloController(Vizsga3Context context, IEmail email, ILogger<FelhasznaloController> logger, IConfiguration configuration)
        {
            _context = context;
            _email = email;
            _logger = logger;
            _configuration = configuration;
        }

        // Bejelentkezési endpoint (hash-elt jelszó ellenőrzéssel)
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            _logger.LogInformation($"Bejelentkezési kérelem: {request.Felhasznalonev}");

            var felhasznalo = await _context.Felhasznaloks
                .FirstOrDefaultAsync(f => f.Felhasznalonev == request.Felhasznalonev);

            if (felhasznalo == null)
            {
                _logger.LogWarning($"Felhasználó nem található: {request.Felhasznalonev}");
                return Unauthorized(new { message = "Hibás felhasználónév vagy jelszó" });
            }

            if (!VerifyPassword(request.Jelszo, felhasznalo.Jelszo))
            {
                _logger.LogWarning($"Hibás jelszó próbálkozás a felhasználónál: {request.Felhasznalonev}");
                return Unauthorized(new { message = "Hibás felhasználónév vagy jelszó" });
            }

            var token = GenerateJwtToken(felhasznalo);

            _logger.LogInformation($"Sikeres bejelentkezés: {request.Felhasznalonev}");
            return Ok(new { message = "Sikeres bejelentkezés", token });
        }

        // Regisztráció új felhasználóval (hash-elt jelszóval)
        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] Felhasznalok felhasznalo)
        {
            if (await _context.Felhasznaloks.AnyAsync(f => f.Felhasznalonev == felhasznalo.Felhasznalonev))
            {
                return BadRequest(new { message = "Ez a felhasználónév már foglalt." });
            }

            if (await _context.Felhasznaloks.AnyAsync(f => f.Email == felhasznalo.Email))
            {
                return BadRequest(new { message = "Ez az email cím már regisztrálva van." });
            }

            felhasznalo.Jelszo = HashPassword(felhasznalo.Jelszo);
            _context.Felhasznaloks.Add(felhasznalo);
            await _context.SaveChangesAsync();

            // Email küldés
            var emailRequest = new EmailRequestDto(
                felhasznalo.Email,
                "Sikeres regisztráció",
                $"Kedves {felhasznalo.Felhasznalonev},\n\nSikeresen regisztráltál!\n\nÜdv,\nA csapat"
            );

            _email.SendEmail(emailRequest);

            return Ok(new { message = "Sikeres regisztráció! Az emailt elküldtük." });
        }

        // Felhasználó adatainak lekérdezése
        [HttpGet("user/{id}")]
        public async Task<IActionResult> GetUser(int id)
        {
            var felhasznalo = await _context.Felhasznaloks.FindAsync(id);
            if (felhasznalo == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }
            return Ok(felhasznalo);
        }

        // Felhasználó adatainak módosítása
        [HttpPut("user/{id}")]
        public async Task<IActionResult> UpdateUser(int id, [FromBody] Felhasznalok updatedUser)
        {
            var felhasznalo = await _context.Felhasznaloks.FindAsync(id);
            if (felhasznalo == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }

            felhasznalo.Felhasznalonev = updatedUser.Felhasznalonev;
            felhasznalo.Email = updatedUser.Email;
            // Jelszó frissítése, ha szükséges
            if (!string.IsNullOrEmpty(updatedUser.Jelszo))
            {
                felhasznalo.Jelszo = HashPassword(updatedUser.Jelszo);
            }

            await _context.SaveChangesAsync();
            return Ok(new { message = "Felhasználó adatai frissítve" });
        }

        [HttpPut("user/{id}/change-password")]
        public async Task<IActionResult> ChangePassword(int id, [FromBody] ChangePasswordRequest request)
        {
            var felhasznalo = await _context.Felhasznaloks.FindAsync(id);
            if (felhasznalo == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }

            if (!VerifyPassword(request.OldPassword, felhasznalo.Jelszo))
            {
                return BadRequest(new { message = "Hibás régi jelszó" });
            }

            felhasznalo.Jelszo = HashPassword(request.NewPassword);
            await _context.SaveChangesAsync();
            return Ok(new { message = "Jelszó sikeresen módosítva" });
        }

        public class ChangePasswordRequest
        {
            public string OldPassword { get; set; }
            public string NewPassword { get; set; }
        }



        // Felhasználó törlése
        [HttpDelete("user/{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var felhasznalo = await _context.Felhasznaloks.FindAsync(id);
            if (felhasznalo == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }

            _context.Felhasznaloks.Remove(felhasznalo);
            await _context.SaveChangesAsync();
            return Ok(new { message = "Felhasználó törölve" });
        }

        // Felhasználók listázása
        [HttpGet("users")]
        public async Task<IActionResult> GetUsers()
        {
            var felhasznalok = await _context.Felhasznaloks.ToListAsync();
            return Ok(felhasznalok);
        }

        // Felhasználó keresése felhasználónév alapján
        [HttpGet("user/search/{felhasznalonev}")]
        public async Task<IActionResult> SearchUserByUsername(string felhasznalonev)
        {
            var felhasznalo = await _context.Felhasznaloks.FirstOrDefaultAsync(f => f.Felhasznalonev == felhasznalonev);
            if (felhasznalo == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }
            return Ok(felhasznalo);
        }

        // Jelszó hash-elése
        private string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        // Jelszó ellenőrzése
        private bool VerifyPassword(string inputPassword, string hashedPassword)
        {
            return HashPassword(inputPassword) == hashedPassword;
        }

        // JWT token generálása
        private string GenerateJwtToken(Felhasznalok felhasznalo)
        {
            var jwtSettings = _configuration.GetSection("JwtSettings").Get<JwtSettings>();

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, felhasznalo.Felhasznalonev),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SecretKey));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: jwtSettings.Issuer,
                audience: jwtSettings.Audience,
                claims: claims,
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: creds);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }

    public class LoginRequest
    {
        public string Felhasznalonev { get; set; }
        public string Jelszo { get; set; }
    }
}
