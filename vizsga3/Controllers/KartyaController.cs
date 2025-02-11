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
        public IActionResult Get([FromQuery] string? kategoria)
        {
            var kartyak = _context.Kartyaks.AsQueryable();

            if (!string.IsNullOrEmpty(kategoria))
            {
                kartyak = kartyak.Where(k => k.Kategoria == kategoria);
            }

            return Ok(kartyak.ToList());
        }


        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            using var db = new Vizsga3Context();
            var kartya = db.Kartyaks.Find(id);
            if (kartya == null)
            {
                return NotFound();
            }
            return Ok(kartya);
        }

        [HttpPost]
        public IActionResult Post([FromBody] Kartyak kartya)
        {
            using var db = new Vizsga3Context();
            db.Kartyaks.Add(kartya);
            db.SaveChanges();
            return Ok();
        }

        [HttpPut("{id}")]
        public IActionResult Put(int id, [FromBody] Kartyak kartya)
        {
            using var db = new Vizsga3Context();
            var kartyaToUpdate = db.Kartyaks.Find(id);
            if (kartyaToUpdate == null)
            {
                return NotFound();
            }
            kartyaToUpdate.Nev = kartya.Nev;
            kartyaToUpdate.Ar = kartya.Ar;
            kartyaToUpdate.Leiras = kartya.Leiras;
            kartyaToUpdate.KepUrl = kartya.KepUrl;
            db.SaveChanges();
            return Ok();
        }

        [HttpPatch("{id}")]
        public IActionResult Patch(int id, [FromBody] Kartyak kartya)
        {
            using var db = new Vizsga3Context();
            var kartyaToUpdate = db.Kartyaks.Find(id);
            if (kartyaToUpdate == null)
            {
                return NotFound();
            }
            kartyaToUpdate.Nev = kartya.Nev;
            kartyaToUpdate.Ar = kartya.Ar;
            kartyaToUpdate.Leiras = kartya.Leiras;
            kartyaToUpdate.KepUrl = kartya.KepUrl;
            db.SaveChanges();
            return Ok();
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            using var db = new Vizsga3Context();
            var kartya = db.Kartyaks.Find(id);
            if (kartya == null)
            {
                return NotFound();
            }
            db.Kartyaks.Remove(kartya);
            db.SaveChanges();
            return Ok();
        }

        [HttpHead("{id}")]
        public IActionResult Head(int id)
        {
            using var db = new Vizsga3Context();
            var kartya = db.Kartyaks.Find(id);
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
