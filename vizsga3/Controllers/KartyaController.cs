using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using vizsga3.Models;

namespace vizsga3.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class KartyaController : ControllerBase
    {
        private readonly Vizsga3Context _context;

        public KartyaController(Vizsga3Context context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Get()
        {
            var kartyak = _context.Kartyaks.ToList();
            return Ok(kartyak);
        }

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var kartya = _context.Kartyaks.Find(id);
            if (kartya == null)
            {
                return NotFound();
            }
            return Ok(kartya);
        }

        [HttpPost]
        public IActionResult Post([FromBody] Kartyak kartya)
        {
            _context.Kartyaks.Add(kartya);
            _context.SaveChanges();
            return Ok();
        }

        [HttpPut("{id}")]
        public IActionResult Put(int id, [FromBody] Kartyak kartya)
        {
            var kartyaToUpdate = _context.Kartyaks.Find(id);
            if (kartyaToUpdate == null)
            {
                return NotFound();
            }
            kartyaToUpdate.Nev = kartya.Nev;
            kartyaToUpdate.Ar = kartya.Ar;
            kartyaToUpdate.Leiras = kartya.Leiras;
            kartyaToUpdate.KepUrl = kartya.KepUrl;
            _context.SaveChanges();
            return Ok();
        }

        [HttpPatch("{id}")]
        public IActionResult Patch(int id, [FromBody] Kartyak kartya)
        {
            var kartyaToUpdate = _context.Kartyaks.Find(id);
            if (kartyaToUpdate == null)
            {
                return NotFound();
            }
            kartyaToUpdate.Nev = kartya.Nev;
            kartyaToUpdate.Ar = kartya.Ar;
            kartyaToUpdate.Leiras = kartya.Leiras;
            kartyaToUpdate.KepUrl = kartya.KepUrl;
            _context.SaveChanges();
            return Ok();
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            var kartya = _context.Kartyaks.Find(id);
            if (kartya == null)
            {
                return NotFound();
            }
            _context.Kartyaks.Remove(kartya);
            _context.SaveChanges();
            return Ok();
        }

        [HttpHead("{id}")]
        public IActionResult Head(int id)
        {
            var kartya = _context.Kartyaks.Find(id);
            if (kartya == null)
            {
                return NotFound();
            }
            return Ok();
        }

        [HttpOptions]
        public IActionResult Options()
        {
            Response.Headers.Add("Allow", "GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS");
            return Ok();
        }
    }
}
