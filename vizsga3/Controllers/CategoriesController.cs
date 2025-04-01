using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using vizsga3.Models;

namespace vizsga3.Controllers
{
    [Route("api/categories")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly Vizsga3Context _context;

        public CategoriesController(Vizsga3Context context)
        {
            _context = context;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Category>> GetCategories()
        {
            var categories = _context.Categories.ToList();
            return Ok(new { message = "Categories retrieved successfully.", categories });
        }

        [HttpGet("{id}")]
        public ActionResult<Category> GetCategory(int id)
        {
            var category = _context.Categories.Find(id);
            if (category == null)
            {
                return NotFound(new { message = "Category not found." });
            }
            return Ok(new { message = "Category retrieved successfully.", category });
        }

        [HttpPost]
        public ActionResult<Category> CreateCategory(Category category)
        {
            _context.Categories.Add(category);
            _context.SaveChanges();
            return CreatedAtAction(nameof(GetCategory), new { id = category.Id }, new { message = "Category created successfully.", category });
        }

        [HttpPut("{id}")]
        public IActionResult UpdateCategory(int id, Category category)
        {
            if (id != category.Id)
            {
                return BadRequest(new { message = "Category ID mismatch." });
            }

            _context.Entry(category).State = EntityState.Modified;
            _context.SaveChanges();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteCategory(int id)
        {
            var category = _context.Categories.Find(id);
            if (category == null)
            {
                return NotFound(new { message = "Category not found." });
            }

            _context.Categories.Remove(category);
            _context.SaveChanges();

            return NoContent();
        }

        [HttpGet("count")]
        public ActionResult<int> GetCategoryCount()
        {
            var count = _context.Categories.Count();
            return Ok(new { message = "Category count retrieved successfully.", count });
        }
    }
}
