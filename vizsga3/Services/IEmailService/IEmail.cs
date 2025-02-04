using vizsga3.Models.Dtos;

namespace vizsga3.Services.IEmailService
{
    public interface IEmail
    {
        void SendEmail(EmailRequestDto emailRequestDto);
    }
}
