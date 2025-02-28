using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using vizsga3.Models;
using Microsoft.EntityFrameworkCore;

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
        public async Task<IActionResult> Get()
        {
            var kartyak = await _context.Kartyaks.ToListAsync();
            return Ok(kartyak);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            var kartya = await _context.Kartyaks.FindAsync(id);
            if (kartya == null)
            {
                return NotFound();
            }
            return Ok(kartya);
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Kartyak kartya)
        {
            _context.Kartyaks.Add(kartya);
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] Kartyak kartya)
        {
            var kartyaToUpdate = await _context.Kartyaks.FindAsync(id);
            if (kartyaToUpdate == null)
            {
                return NotFound();
            }
            kartyaToUpdate.CurrentUser = kartya.CurrentUser;
            kartyaToUpdate.Ar = kartya.Ar;
            kartyaToUpdate.Leiras = kartya.Leiras;
            kartyaToUpdate.KepUrl = kartya.KepUrl;
            kartyaToUpdate.Kategoria = kartya.Kategoria;
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var kartya = await _context.Kartyaks.FindAsync(id);
            if (kartya == null)
            {
                return NotFound();
            }
            _context.Kartyaks.Remove(kartya);
            await _context.SaveChangesAsync();
            return Ok();
        }

        // Kártyák kategória szerinti lekérdezése
        [HttpGet("kategoria/{kategoria}")]
        public async Task<IActionResult> GetKartyakByKategoria(string kategoria)
        {
            var kartyak = await _context.Kartyaks.Where(k => k.Kategoria == kategoria).ToListAsync();
            return Ok(kartyak);
        }
    }
}
