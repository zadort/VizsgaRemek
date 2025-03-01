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
            return Ok(new { message = "User retrieved successfully", user });
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

            user.Username = updatedUser.Username;
            user.Email = updatedUser.Email;
            // Update password if necessary
            if (!string.IsNullOrEmpty(updatedUser.Password))
            {
                user.Password = HashPassword(updatedUser.Password);
            }

            await _context.SaveChangesAsync();
            return Ok(new { message = "User details updated successfully" });
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

        // Generate JWT token
        private string GenerateJwtToken(User user)
        {
            var jwtSettings = _configuration.GetSection("JwtSettings").Get<JwtSettings>();

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Username),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SecretKey));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: jwtSettings.Issuer,
                audience: jwtSettings.Audience,
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
}


