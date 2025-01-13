using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using vizsga3.Models;

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
        [HttpGet("GetAll")]
        public IActionResult Get()
        {
            var felhasznalok = _context.Felhasznaloks.ToList();
            return Ok(felhasznalok);
        }
        [HttpGet("GetById")]
        public IActionResult Get(int id)
        {
            using var db = new Vizsga3Context();
            var felhasznalo = db.Felhasznaloks.Find(id);
            if (felhasznalo == null)
            {
                return NotFound();
            }
            return Ok(felhasznalo);
        }
        [HttpDelete("DeleteById")]
        public IActionResult Delete(int id)
        {
            using var db = new Vizsga3Context();
            var felhasznalo = db.Felhasznaloks.Find(id);
            if (felhasznalo == null)
            {
                return NotFound();
            }
            db.Felhasznaloks.Remove(felhasznalo);
            db.SaveChanges();
            return Ok();
        }
        [HttpPost("Post")]
        public IActionResult Post([FromBody] Felhasznalok felhasznalo)
        {
            using var db = new Vizsga3Context();
            db.Felhasznaloks.Add(felhasznalo);
            db.SaveChanges();
            return Ok();
        }
        [HttpPut("PutById")]
        public IActionResult Put(int id, [FromBody] Felhasznalok felhasznalo)
        {
            using var db = new Vizsga3Context();
            var felhasznaloToUpdate = db.Felhasznaloks.Find(id);
            if (felhasznaloToUpdate == null)
            {
                return NotFound();
            }
            felhasznaloToUpdate.Felhasznalonev = felhasznalo.Felhasznalonev;
            felhasznaloToUpdate.Jelszo = felhasznalo.Jelszo;
            db.SaveChanges();
            return Ok();
        }
    }
}
