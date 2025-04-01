using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using vizsga3.Models;
using Microsoft.EntityFrameworkCore;
using vizsga3.Models.Requests;

namespace vizsga3.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class CardController : ControllerBase
    {
        private readonly Vizsga3Context _context;

        public CardController(Vizsga3Context context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var products = await _context.Products.ToListAsync();
            return Ok(new { status = "success", message = "Products retrieved successfully", products });
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound(new { status = "error", message = "Product not found" });
            }
            return Ok(new { status = "success", message = "Product retrieved successfully", product });
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] Product product)
        {
            _context.Products.Add(product);
            await _context.SaveChangesAsync();
            return Ok(new { status = "success", message = "Product created successfully" });
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] Product product)
        {
            var productToUpdate = await _context.Products.FindAsync(id);
            if (productToUpdate == null)
            {
                return NotFound(new { status = "error", message = "Product not found" });
            }
            productToUpdate.Name = product.Name;
            productToUpdate.Price = product.Price;
            productToUpdate.Description = product.Description;
            productToUpdate.Image = product.Image;
            productToUpdate.Category = product.Category;
            await _context.SaveChangesAsync();
            return Ok(new { status = "success", message = "Product updated successfully" });
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound(new { status = "error", message = "Product not found" });
            }
            _context.Products.Remove(product);
            await _context.SaveChangesAsync();
            return Ok(new { status = "success", message = "Product deleted successfully" });
        }

        // Get products by category
        [HttpGet("category/{category}")]
        public async Task<IActionResult> GetProductsByCategory(string category)
        {
            var categoryExists = await _context.Categories.AnyAsync(c => c.Category1 == category);
            if (!categoryExists)
            {
                return NotFound(new { status = "error", message = "Category not found" });
            }

            var products = await _context.Products.Where(p => p.Category == category).ToListAsync();
            return Ok(new { status = "success", message = "Products retrieved successfully", products });
        }
    }
}
