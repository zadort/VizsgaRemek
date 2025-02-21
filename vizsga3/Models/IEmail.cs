using vizsga3.Models.Dtos;

public interface IEmail
{
    void SendEmail(EmailRequestDto emailRequest);
}
