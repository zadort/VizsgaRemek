using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;
using vizsga3.Models;
using vizsga3.Services;
using Microsoft.Extensions.Logging;
using vizsga3.Middleware;

namespace vizsga3
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            var configuration = builder.Configuration;

            // Add logging
            builder.Logging.ClearProviders();
            builder.Logging.AddConsole();

            // Bind JWT settings
            builder.Services.Configure<JwtSettings>(configuration.GetSection("JwtSettings"));

            builder.Services.AddScoped<IEmail, EmailService>();

            builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    var jwtSettings = configuration.GetSection("JwtSettings").Get<JwtSettings>();
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidIssuer = jwtSettings.Issuer,
                        ValidateAudience = true,
                        ValidAudience = jwtSettings.Audience,
                        ValidateLifetime = true,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SecretKey)),
                        ClockSkew = TimeSpan.Zero
                    };
                });

            // JSON serialization settings (optional)
            builder.Services.AddControllers().AddJsonOptions(x => x.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles);

            // DB Context settings
            builder.Services.AddDbContext<Vizsga3Context>(options =>
            {
                var connectionString = configuration.GetConnectionString("MySql");
                options.UseMySQL(connectionString);
            });

            // CORS settings
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowReactApp", policy =>
                {
                    policy.WithOrigins("http://localhost:3000")
                          .AllowAnyHeader()
                          .AllowAnyMethod();
                });
            });

            // Swagger configuration
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(options =>
            {
                options.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "ASP.NET Core Web API",
                    Version = "v1",
                    Description = "Vizsga3 API"
                });
            });

            // Add health checks
            builder.Services.AddHealthChecks();

            var app = builder.Build();

            // Enable Swagger UI in development mode
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI(c =>
                {
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Vizsga3 API V1");
                });
            }

            // Middleware setup
            app.UseHttpsRedirection();
            app.UseCors("AllowReactApp");
            app.UseAuthentication();
            app.UseAuthorization();

            // Add global exception handling middleware
            app.UseMiddleware<ExceptionHandlingMiddleware>();

            // Map API endpoints
            app.MapControllers();
            app.MapHealthChecks("/health");

            // Run the application
            app.Run();
        }
    }

    public class JwtSettings
    {
        public string Issuer { get; set; }
        public string Audience { get; set; }
        public string SecretKey { get; set; }
    }
}
