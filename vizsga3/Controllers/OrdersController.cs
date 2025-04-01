using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using vizsga3.Models;

namespace vizsga3.Controllers
{
    [Route("api/orders")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        private readonly Vizsga3Context _context;

        public OrdersController(Vizsga3Context context)
        {
            _context = context;
        }

        [HttpGet]
        public ActionResult<IEnumerable<Order>> GetOrders()
        {
            var orders = _context.Orders.ToList();
            return Ok(new { message = "Orders retrieved successfully.", orders });
        }

        [HttpGet("{id}")]
        public ActionResult<Order> GetOrder(int id)
        {
            var order = _context.Orders.Find(id);
            if (order == null)
            {
                return NotFound(new { message = "Order not found." });
            }
            return Ok(new { message = "Order retrieved successfully.", order });
        }

        [HttpPost]
        public ActionResult<Order> CreateOrder(Order order)
        {
            _context.Orders.Add(order);
            _context.SaveChanges();
            return CreatedAtAction(nameof(GetOrder), new { id = order.Id }, new { message = "Order created successfully.", order });
        }

        [HttpPut("{id}")]
        public IActionResult UpdateOrder(int id, Order order)
        {
            if (id != order.Id)
            {
                return BadRequest(new { message = "Order ID mismatch." });
            }

            _context.Entry(order).State = EntityState.Modified;
            _context.SaveChanges();

            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteOrder(int id)
        {
            var order = _context.Orders.Find(id);
            if (order == null)
            {
                return NotFound(new { message = "Order not found." });
            }

            _context.Orders.Remove(order);
            _context.SaveChanges();

            return NoContent();
        }

        [HttpGet("count")]
        public ActionResult<int> GetOrderCount()
        {
            var count = _context.Orders.Count();
            return Ok(new { message = "Order count retrieved successfully.", count });
        }
    }
}
