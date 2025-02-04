using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using System.Linq;
using System.Security.Claims;
using vizsga3.Models;

namespace vizsga3.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FelhasznaloController : ControllerBase
    {
        private readonly Vizsga3Context _context;
        private readonly string _jwtSecret = "NagyonBiztonsagosTitkosKulcs12345NagyonBiztonsagosTitkosKulcs12345"; // A secret kulcs a JWT generálásához
        private readonly int _jwtExpireMinutes = 60; // Token lejárati idő

        public FelhasznaloController(Vizsga3Context context)
        {
            _context = context;
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            var user = _context.Felhasznaloks
                .FirstOrDefault(u => u.Felhasznalonev == request.Username);

            if (user == null || user.Jelszo != request.Password)
            {
                return Unauthorized(new { message = "Hibás felhasználónév vagy jelszó." });
            }

            // JWT token generálása
            var token = GenerateJwtToken(user);

            return Ok(new { token });
        }

        private string GenerateJwtToken(Felhasznalok user)
        {
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, user.Felhasznalonev),
                new Claim(ClaimTypes.Name, user.Felhasznalonev),
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtSecret));
            var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: "yourapp",
                audience: "yourapp",
                claims: claims,
                expires: DateTime.Now.AddMinutes(_jwtExpireMinutes),
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        // Bejelentkezési kérés modellje
        public class LoginRequest
        {
            public string Username { get; set; }
            public string Password { get; set; }
        }

        // Felhasználók lekérdezése
        [HttpGet("GetAll")]
        public IActionResult GetAll()
        {
            var felhasznalok = _context.Felhasznaloks.ToList();
            return Ok(felhasznalok);
        }

        // Felhasználó lekérdezése ID alapján
        [HttpGet("GetById/{id}")]
        public IActionResult GetById(int id)
        {
            var felhasznalo = _context.Felhasznaloks.Find(id);
            if (felhasznalo == null)
            {
                return NotFound();
            }
            return Ok(felhasznalo);
        }

        // Felhasználó törlése ID alapján
        [HttpDelete("DeleteById/{id}")]
        public IActionResult DeleteById(int id)
        {
            var felhasznalo = _context.Felhasznaloks.Find(id);
            if (felhasznalo == null)
            {
                return NotFound();
            }

            _context.Felhasznaloks.Remove(felhasznalo);
            _context.SaveChanges();
            return Ok();
        }

        // Új felhasználó hozzáadása
        [HttpPost("Post")]
        public IActionResult Post([FromBody] Felhasznalok felhasznalo)
        {
            _context.Felhasznaloks.Add(felhasznalo);
            _context.SaveChanges();
            return Ok();
        }

        // Felhasználó frissítése ID alapján
        [HttpPut("PutById/{id}")]
        public IActionResult PutById(int id, [FromBody] Felhasznalok felhasznalo)
        {
            var felhasznaloToUpdate = _context.Felhasznaloks.Find(id);
            if (felhasznaloToUpdate == null)
            {
                return NotFound();
            }

            felhasznaloToUpdate.Felhasznalonev = felhasznalo.Felhasznalonev;
            felhasznaloToUpdate.Jelszo = felhasznalo.Jelszo;
            _context.SaveChanges();
            return Ok();
        }
    }
}
