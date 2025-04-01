using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using vizsga3.Models;
using System.Security.Cryptography;
using System.Text;
using vizsga3.Models.Dtos;
using vizsga3.Services.IEmailService;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Org.BouncyCastle.Crypto.Utilities;

namespace vizsga3.Controllers
{
    [Route("User")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly Vizsga3Context _context;
        private readonly IEmail _email;
        private readonly ILogger<UserController> _logger;
        private readonly IConfiguration _configuration;

        public UserController(Vizsga3Context context, IEmail email, ILogger<UserController> logger, IConfiguration configuration)
        {
            _context = context;
            _email = email;
            _logger = logger;
            _configuration = configuration;
        }

        // Login endpoint (with hashed password verification)
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            _logger.LogInformation($"Login request: {request.Username}");

            var user = await _context.Users
                .FirstOrDefaultAsync(f => f.Username == request.Username);

            if (user == null)
            {
                _logger.LogWarning($"User not found: {request.Username}");
                return Unauthorized(new { message = "Invalid username or password" });
            }

            if (!VerifyPassword(request.Password, user.Password))
            {
                _logger.LogWarning($"Invalid password attempt for user: {request.Username}");
                return Unauthorized(new { message = "Invalid username or password" });
            }

            var token = GenerateJwtToken(user);

            _logger.LogInformation($"Successful login: {request.Username}");
            return Ok(new { message = "Login successful", token });
        }

        // Registration endpoint (with hashed password)
        [HttpPost("registration")]
        public async Task<IActionResult> Register([FromBody] User user)
        {
            if (await _context.Users.AnyAsync(f => f.Username == user.Username))
            {
                return BadRequest(new { message = "This username is already taken." });
            }

            if (await _context.Users.AnyAsync(f => f.Email == user.Email))
            {
                return BadRequest(new { message = "This email address is already registered." });
            }

            user.Password = HashPassword(user.Password);
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            // Send email
            var emailRequest = new EmailRequestDto(
                user.Email,
                "Successful registration",
                $"Dear {user.Username},\n\nYou have successfully registered!\n\nBest regards,\nThe team"
            );

            _email.SendEmail(emailRequest);

            return Ok(new { message = "Registration successful! The email has been sent." });
        }

        // Password reset endpoint (by email)
        [HttpPost("reset-password")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordRequest request)
        {
            var user = await _context.Users.FirstOrDefaultAsync(f => f.Email == request.Email);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            // Generate a new password or send a password reset link via email
            var newPassword = GenerateRandomPassword();
            user.Password = HashPassword(newPassword);

            await _context.SaveChangesAsync();

            // Send email with the new password
            var emailRequest = new EmailRequestDto(
                user.Email,
                "Password reset",
                $"Dear {user.Username},\n\nYour new password is: {newPassword}\n\nBest regards,\nThe team"
            );

            _email.SendEmail(emailRequest);

            return Ok(new { message = "Password reset and sent via email" });
        }

        // List all users
        [HttpGet("all-users")]
        public async Task<IActionResult> GetAllUsers()
        {
            var users = await _context.Users.ToListAsync();
            return Ok(new { message = "Users retrieved successfully", users });
        }

        // Get user details by ID
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUserById(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            return Ok(new
            {
                id = user.Id,
                username = user.Username,
                email = user.Email
            });
        }

        // Get user details by username
        [HttpGet("username/{username}")]
        public async Task<IActionResult> GetUserByUsername(string username)
        {
            var user = await _context.Users.FirstOrDefaultAsync(f => f.Username == username);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }
            return Ok(new { message = "User retrieved successfully", user });
        }

        // Get user details by email
        [HttpGet("email/{email}")]
        public async Task<IActionResult> GetUserByEmail(string email)
        {
            var user = await _context.Users.FirstOrDefaultAsync(f => f.Email == email);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }
            return Ok(new { message = "User retrieved successfully", user });
        }

        // Update user details by ID
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateUserById(int id, [FromBody] User updatedUser)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            // Ellenőrizzük, hogy az új jelszó különbözik-e a jelenlegitől
            if (!string.IsNullOrEmpty(updatedUser.Password))
            {
                var hashedNewPassword = HashPassword(updatedUser.Password);
                if (hashedNewPassword == user.Password)
                {
                    return BadRequest(new { message = "Az új jelszó nem lehet ugyanaz, mint a jelenlegi jelszó." });
                }

                user.Password = hashedNewPassword;
            }

            user.Username = updatedUser.Username ?? user.Username;
            user.Email = updatedUser.Email ?? user.Email;

            await _context.SaveChangesAsync();
            return Ok(new { message = "User details updated successfully", username = user.Username, email = user.Email });
        }

        // Delete user by ID
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUserById(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            _context.Users.Remove(user);
            await _context.SaveChangesAsync();
            return Ok(new { message = "User deleted successfully" });
        }

        // Change password
        [HttpPost("change-password")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == request.Username);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            if (!VerifyPassword(request.OldPassword, user.Password))
            {
                return BadRequest(new { message = "Current password is incorrect" });
            }

            var newPassword = GenerateRandomPassword();
            user.Password = HashPassword(newPassword);
            await _context.SaveChangesAsync();

            // Send email with the new password
            var emailRequest = new EmailRequestDto(
                user.Email,
                "Password changed",
                $"Dear {user.Username},\n\nYour new password is: {newPassword}\n\nBest regards,\nThe team"
            );

            _email.SendEmail(emailRequest);

            return Ok(new { message = "Password changed successfully and sent via email" });
        }

        // Send current password to email
        [HttpPost("send-password")]
        public async Task<IActionResult> SendPassword([FromBody] SendPasswordRequest request)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == request.Email);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            // Decrypt the password before sending
            var decryptedPassword = DecryptPassword(user.Password);

            // Send email with the current password
            var emailRequest = new EmailRequestDto(
                user.Email,
                "Your current password",
                $"Dear {user.Username},\n\nYour current password is: {decryptedPassword}\n\nBest regards,\nThe team"
            );

            _email.SendEmail(emailRequest);

            return Ok(new { message = "Password sent to email successfully" });
        }

        // Get orders for the specified user
        [HttpGet("my-orders/{username}")]
        public async Task<IActionResult> GetMyOrders(string username)
        {
            _logger.LogInformation($"GetMyOrders request for username: {username}");

            var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == username);

            if (user == null)
            {
                _logger.LogWarning($"User not found: {username}");
                return NotFound(new { message = "User not found" });
            }

            var orders = await _context.Orders
                .Where(o => o.UserId == user.Id)
                .ToListAsync();

            if (orders.Count == 0)
            {
                _logger.LogInformation($"No orders found for user: {username}");
                return Ok(new { message = "No orders found for this user" });
            }

            _logger.LogInformation($"Orders retrieved successfully for user: {username}");
            return Ok(new { message = "Orders retrieved successfully", orders });
        }

        // Get all usernames
        [HttpGet("all-active-orders")]
        public async Task<IActionResult> GetAllActiveOrders()
        {
            var users = await _context.Users
                .Select(u => u.Username)
                .ToListAsync();

            return Ok(new { message = "Usernames retrieved successfully", users });
        }

        [Authorize]
        [HttpPut("update-profile")]
        public async Task<IActionResult> UpdateUserProfile([FromBody] UpdateUserProfileRequest request)
        {
            try
            {
                // JWT tokenből kinyerjük a felhasználónevet
                var username = User.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Sub)?.Value;

                if (string.IsNullOrEmpty(username))
                {
                    return Unauthorized(new { message = "A felhasználó azonosítása sikertelen." });
                }

                // Lekérjük a felhasználót az adatbázisból
                var user = await _context.Users.FirstOrDefaultAsync(u => u.Username == username);
                if (user == null)
                {
                    return NotFound(new { message = "Felhasználó nem található." });
                }

                // Frissítjük a felhasználó adatait
                if (!string.IsNullOrEmpty(request.Username))
                {
                    if (await _context.Users.AnyAsync(u => u.Username == request.Username && u.Id != user.Id))
                    {
                        return BadRequest(new { message = "Ez a felhasználónév már foglalt." });
                    }
                    user.Username = request.Username;
                }

                if (!string.IsNullOrEmpty(request.Email))
                {
                    if (await _context.Users.AnyAsync(u => u.Email == request.Email && u.Id != user.Id))
                    {
                        return BadRequest(new { message = "Ez az e-mail cím már használatban van." });
                    }
                    user.Email = request.Email;
                }

                // Mentjük a változtatásokat
                await _context.SaveChangesAsync();

                return Ok(new { message = "Profil sikeresen frissítve.", user });
            }
            catch (Exception ex)
            {
                _logger.LogError($"Hiba történt a profil frissítése során: {ex.Message}");
                return StatusCode(StatusCodes.Status500InternalServerError, new { message = "Hiba történt a profil frissítése során." });
            }
        }

        private string GenerateRandomPassword()
        {
            // Generate a random password
            const string validChars = "ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var random = new Random();
            return new string(Enumerable.Repeat(validChars, 8)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        // Hash password
        private string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        // Verify password
        private bool VerifyPassword(string inputPassword, string hashedPassword)
        {
            return HashPassword(inputPassword) == hashedPassword;
        }

        // Encrypt password
        private string EncryptPassword(string password)
        {
            using (var aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(_configuration["EncryptionKey"]);
                aes.IV = Encoding.UTF8.GetBytes(_configuration["EncryptionIV"]);

                var encryptor = aes.CreateEncryptor(aes.Key, aes.IV);
                using (var ms = new MemoryStream())
                {
                    using (var cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                    {
                        using (var sw = new StreamWriter(cs))
                        {
                            sw.Write(password);
                        }
                    }
                    return Convert.ToBase64String(ms.ToArray());
                }
            }
        }

        // Decrypt password
        private string DecryptPassword(string encryptedPassword)
        {
            using (var aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(_configuration["EncryptionKey"]);
                aes.IV = Encoding.UTF8.GetBytes(_configuration["EncryptionIV"]);

                var decryptor = aes.CreateDecryptor(aes.Key, aes.IV);
                using (var ms = new MemoryStream(Convert.FromBase64String(encryptedPassword)))
                {
                    using (var cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                    {
                        using (var sr = new StreamReader(cs))
                        {
                            return sr.ReadToEnd();
                        }
                    }
                }
            }
        }

        // Generate JWT token
        private string GenerateJwtToken(User user)
        {
            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JwtSettings:SecretKey"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: _configuration["JwtSettings:Issuer"],
                audience: _configuration["JwtSettings:Audience"],
                claims: claims,
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: creds);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }

    public class LoginRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }

    public class ChangePasswordRequest
    {
        public string Username { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }

    public class CreateUserRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
    }

    public class UpdateUserRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
    }

    public class UpdateUserProfileRequest
    {
        public string Username { get; set; }
        public string Email { get; set; }
    }

    public class ResetPasswordRequest
    {
        public string Email { get; set; }
    }

    public class SendPasswordRequest
    {
        public string Email { get; set; }
    }
}
