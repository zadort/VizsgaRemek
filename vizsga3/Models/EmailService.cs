using vizsga3.Models.Dtos;
using vizsga3.Services.IEmailService;
using MimeKit;
using MimeKit.Text;
using MailKit.Net.Smtp;
using MailKit.Security;
using Microsoft.Extensions.Configuration;

public class EmailService : IEmail
{
    private readonly IConfiguration _configuration;

    public EmailService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public void SendEmail(EmailRequestDto emailRequest)
    {
        var email = new MimeMessage();
        var fromName = _configuration.GetSection("EmailSettings:FromName").Value;
        var fromEmail = _configuration.GetSection("EmailSettings:EmailUserName").Value;
        email.From.Add(new MailboxAddress(fromName, fromEmail));
        email.To.Add(MailboxAddress.Parse(emailRequest.To));
        email.Subject = emailRequest.Subject;
        email.Body = new TextPart(TextFormat.Html) { Text = emailRequest.Body };

        using var smtp = new SmtpClient();
        smtp.Connect(_configuration.GetSection("EmailSettings:EmailHost").Value,
            587, SecureSocketOptions.StartTls);
        smtp.Authenticate(fromEmail, _configuration.GetSection("EmailSettings:EmailPassword").Value);

        smtp.Send(email);

        smtp.Disconnect(true);
    }
}
