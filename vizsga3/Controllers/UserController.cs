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
    [Route("User")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly Vizsga3Context _context;
        private readonly IEmail _email;
        private readonly ILogger<UserController> _logger;
        private readonly IConfiguration _configuration;

        public UserController(Vizsga3Context context, IEmail email, ILogger<UserController> logger, IConfiguration configuration)
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
            _logger.LogInformation($"Bejelentkezési kérelem: {request.Username}");

            var user = await _context.Users
                .FirstOrDefaultAsync(f => f.Username == request.Username);

            if (user == null)
            {
                _logger.LogWarning($"Felhasználó nem található: {request.Username}");
                return Unauthorized(new { message = "Hibás felhasználónév vagy jelszó" });
            }

            if (!VerifyPassword(request.Password, user.Password))
            {
                _logger.LogWarning($"Hibás jelszó próbálkozás a felhasználónál: {request.Username}");
                return Unauthorized(new { message = "Hibás felhasználónév vagy jelszó" });
            }

            var token = GenerateJwtToken(user);

            _logger.LogInformation($"Sikeres bejelentkezés: {request.Username}");
            return Ok(new { message = "Sikeres bejelentkezés", token });
        }

        // Regisztráció új felhasználóval (hash-elt jelszóval)
        [HttpPost("registration")]
        public async Task<IActionResult> Register([FromBody] User user)
        {
            if (await _context.Users.AnyAsync(f => f.Username == user.Username))
            {
                return BadRequest(new { message = "Ez a felhasználónév már foglalt." });
            }

            if (await _context.Users.AnyAsync(f => f.Email == user.Email))
            {
                return BadRequest(new { message = "Ez az email cím már regisztrálva van." });
            }

            user.Password = HashPassword(user.Password);
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            // Email küldés
            var emailRequest = new EmailRequestDto(
                user.Email,
                "Sikeres regisztráció",
                $"Kedves {user.Username},\n\nSikeresen regisztráltál!\n\nÜdv,\nA csapat"
            );

            _email.SendEmail(emailRequest);

            return Ok(new { message = "Sikeres regisztráció! Az emailt elküldtük." });
        }

        // Felhasználó jelszavának visszaállítása email alapján
        [HttpPost("reset-password")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordRequest request)
        {
            var user = await _context.Users.FirstOrDefaultAsync(f => f.Email == request.Email);
            if (user == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }

            // Generálj egy új jelszót vagy küldj egy jelszó visszaállítási linket emailben
            var newPassword = GenerateRandomPassword();
            user.Password = HashPassword(newPassword);

            await _context.SaveChangesAsync();

            // Küldj emailt az új jelszóval
            var emailRequest = new EmailRequestDto(
                user.Email,
                "Jelszó visszaállítás",
                $"Kedves {user.Username},\n\nAz új jelszavad: {newPassword}\n\nÜdv,\nA csapat"
            );

            _email.SendEmail(emailRequest);

            return Ok(new { message = "Jelszó visszaállítva és elküldve emailben" });
        }

        // Felhasználók listázása
        [HttpGet("all-user")]
        public async Task<IActionResult> GetAllUsers()
        {
            var users = await _context.Users.ToListAsync();
            return Ok(users);
        }

        // Felhasználó adatainak lekérdezése ID alapján
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUserById(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }
            return Ok(user);
        }

        // Felhasználó adatainak lekérdezése felhasználónév alapján
        [HttpGet("{username}")]
        public async Task<IActionResult> GetUserByUsername(string username)
        {
            var user = await _context.Users.FirstOrDefaultAsync(f => f.Username == username);
            if (user == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }
            return Ok(user);
        }

        // Felhasználó adatainak lekérdezése email alapján
        [HttpGet("{email}")]
        public async Task<IActionResult> GetUserByEmail(string email)
        {
            var user = await _context.Users.FirstOrDefaultAsync(f => f.Email == email);
            if (user == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }
            return Ok(user);
        }

        // Felhasználó adatainak módosítása ID alapján
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUserById(int id, [FromBody] User updatedUser)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }

            user.Username = updatedUser.Username;
            user.Email = updatedUser.Email;
            // Jelszó frissítése, ha szükséges
            if (!string.IsNullOrEmpty(updatedUser.Password))
            {
                user.Password = HashPassword(updatedUser.Password);
            }

            await _context.SaveChangesAsync();
            return Ok(new { message = "Felhasználó adatai frissítve" });
        }

        // Felhasználó törlése ID alapján
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUserById(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }

            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            return Ok(new { message = "Felhasználó törölve" });
        }

        private string GenerateRandomPassword()
        {
            // Generálj egy véletlenszerű jelszót
            const string validChars = "ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var random = new Random();
            return new string(Enumerable.Repeat(validChars, 8)
                .Select(s => s[random.Next(s.Length)]).ToArray());
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
        private string GenerateJwtToken(User user)
        {
            var jwtSettings = _configuration.GetSection("JwtSettings").Get<JwtSettings>();

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Username),
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
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class ChangePasswordRequest
    {
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }

    public class CreateUserRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
    }

    public class UpdateUserRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
    }

    public class UpdateUserProfileRequest
    {
        public string Username { get; set; }
        public string Email { get; set; }
    }

    public class ResetPasswordRequest
    {
        public string Email { get; set; }
    }
}
