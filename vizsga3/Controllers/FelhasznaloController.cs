using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using vizsga3.Models;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace vizsga3.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class FelhasznaloController : ControllerBase
    {
        private readonly Vizsga3Context _context;

        public FelhasznaloController(Vizsga3Context context)
        {
            _context = context;
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
            // Ellenőrizzük, hogy a felhasználónév már foglalt-e
            if (await _context.Felhasznaloks.AnyAsync(f => f.Felhasznalonev == felhasznalo.Felhasznalonev))
            {
                return BadRequest(new { message = "Ez a felhasználónév már foglalt." });
            }

            // Ellenőrizzük, hogy az email cím már létezik-e
            if (await _context.Felhasznaloks.AnyAsync(f => f.Email == felhasznalo.Email))
            {
                return BadRequest(new { message = "Ez az email cím már regisztrálva van." });
            }

            // Jelszó hash-elése
            felhasznalo.Jelszo = HashPassword(felhasznalo.Jelszo);

            // Felhasználó hozzáadása az adatbázishoz
            _context.Felhasznaloks.Add(felhasznalo);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Sikeres regisztráció" });
        }

        // PUT endpoint to update user data based on username
        [HttpPut("update/{felhasznalonev}")]
        public async Task<IActionResult> UpdateUser(string felhasznalonev, [FromBody] Felhasznalok updatedUser)
        {
            var felhasznalo = await _context.Felhasznaloks
                .FirstOrDefaultAsync(f => f.Felhasznalonev == felhasznalonev);

            if (felhasznalo == null)
            {
                return NotFound(new { message = "Felhasználó nem található" });
            }

            // Update user properties
            felhasznalo.Email = updatedUser.Email ?? felhasznalo.Email;
            if (!string.IsNullOrEmpty(updatedUser.Jelszo))
            {
                felhasznalo.Jelszo = HashPassword(updatedUser.Jelszo);
            }

            _context.Felhasznaloks.Update(felhasznalo);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Felhasználó adatai frissítve" });
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
