using vizsga3.Models.Dtos;
using vizsga3.Services.IEmailService;
using System;

public class EmailService : IEmail
{
    public void SendEmail(EmailRequestDto emailRequest)
    {
        Console.WriteLine("=== EMAIL KÜLDÉSE ===");
        Console.WriteLine($"Címzett: {emailRequest.To}");
        Console.WriteLine($"Tárgy: {emailRequest.Subject}");
        Console.WriteLine($"Tartalom: {emailRequest.Body}");
        Console.WriteLine("=====================");
    }
}
