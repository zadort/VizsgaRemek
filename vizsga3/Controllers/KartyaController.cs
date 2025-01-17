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
            using var db = new Vizsga3Context();
            var kartya = db.Kartyaks.Find(id);
            if (kartya == null)
            {
                return NotFound();
            }
            return Ok(kartya);
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
    }
}
