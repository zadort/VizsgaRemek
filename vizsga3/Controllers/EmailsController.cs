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
                return Ok(new { message = "Email sent successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = $"Email sending failed: {ex.Message}" });
            }
        }
    }
}



