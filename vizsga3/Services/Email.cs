using vizsga3.Models.Dtos;
using vizsga3.Services.IEmailService;
using MimeKit;
using MimeKit.Text;
using MailKit.Net.Smtp;
using MailKit.Security;

namespace vizsga3.Services
{
    public class Email : IEmail
    {
        private readonly IConfiguration _configuration;

        public Email(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public void SendEmail(EmailRequestDto emailRequestDto)
        {
            var email = new MimeMessage();
            email.From.Add(MailboxAddress.Parse(_configuration.GetSection("EmailSettings:EmailUserName").Value));
            email.To.Add(MailboxAddress.Parse(emailRequestDto.To));
            email.Subject = emailRequestDto.Subject;
            email.Body = new TextPart(TextFormat.Html) { Text = emailRequestDto.Body };

            using var smtp = new SmtpClient();
            smtp.Connect(_configuration.GetSection("EmailSettings:EmailHost").Value,
                587, MailKit.Security.SecureSocketOptions.StartTls);
            smtp.Authenticate(_configuration.GetSection("EmailSettings:EmailUserName").Value, _configuration.GetSection("EmailSettings:EmailPassword").Value);

            smtp.Send(email);

            smtp.Disconnect(true);
        }
    }
}
