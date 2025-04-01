using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using vizsga3.Models.Dtos;
using vizsga3.Services.IEmailService;

namespace vizsga3.Controllers
{
    [Route("emails")]
    [ApiController]
    public class EmailsController : ControllerBase
    {
        private readonly IEmail email;

        public EmailsController(IEmail email)
        {
            this.email = email;
        }

        [HttpPost]
        public ActionResult SendNewEmail(EmailRequestDto emailRequestDto)
        {
            try
            {
                email.SendEmail(emailRequestDto);
                return Ok(new { status = "success", message = "Email sent successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { status = "error", message = $"Email sending failed: {ex.Message}" });
            }
        }

        [HttpGet("test")]
        public ActionResult TestEmail()
        {
            return Ok(new { status = "success", message = "Email service is running" });
        }
    }
}
