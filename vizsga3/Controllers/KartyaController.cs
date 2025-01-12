using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using vizsga3.Models;

namespace vizsga3.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KartyaController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get()
        {
            using var db = new Vizsga3Context();
            return Ok(db.Kartyaks);
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
    }
}
