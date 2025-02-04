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
        public ActionResult SendNewEmail( EmailRequestDto emailRequestDto)
        {
            email.SendEmail(emailRequestDto);
            return Ok(new { message = "Sikeres email küldés"});
        }
    }
}
