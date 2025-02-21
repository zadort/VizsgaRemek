using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using vizsga3.Models;
using System.Security.Cryptography;
using System.Text;
using vizsga3.Models.Dtos;
using vizsga3.Services.IEmailService;

namespace vizsga3.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class FelhasznaloController : ControllerBase
    {
        private readonly Vizsga3Context _context;
        private readonly IEmail _email;

        public FelhasznaloController(Vizsga3Context context, IEmail email)
        {
            _context = context;
            _email = email;
        }

        // Bejelentkezési endpoint (hash-elt jelszó ellenőrzéssel)
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            Console.WriteLine($"Bejelentkezési kérelem: {request.Felhasznalonev}, {request.Jelszo}");

            var felhasznalo = await _context.Felhasznaloks
                .FirstOrDefaultAsync(f => f.Felhasznalonev == request.Felhasznalonev);

            if (felhasznalo == null)
            {
                Console.WriteLine($"Felhasználó nem található: {request.Felhasznalonev}");
                return Unauthorized(new { message = "Hibás felhasználónév vagy jelszó" });
            }

            if (!VerifyPassword(request.Jelszo, felhasznalo.Jelszo))
            {
                Console.WriteLine($"Hibás jelszó próbálkozás a felhasználónál: {request.Felhasznalonev}");
                return Unauthorized(new { message = "Hibás felhasználónév vagy jelszó" });
            }

            Console.WriteLine($"Sikeres bejelentkezés: {request.Felhasznalonev}");
            return Ok(new { message = "Sikeres bejelentkezés" });
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
    }

    public class LoginRequest
    {
        public string Felhasznalonev { get; set; }
        public string Jelszo { get; set; }
    }
}