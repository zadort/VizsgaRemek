using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;
using vizsga3.Models;
using vizsga3.Services.IEmailService;
using vizsga3.Services;

namespace vizsga3
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            // JWT beállítások
            var jwtSettings = builder.Configuration.GetSection("JwtSettings");

            builder.Services.AddScoped<IEmail, Email>();

            builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidIssuer = jwtSettings["Issuer"],
                        ValidateAudience = true,
                        ValidAudience = jwtSettings["Audience"],
                        ValidateLifetime = true,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings["SecretKey"])),
                        ClockSkew = TimeSpan.Zero // Ha nem akarod, hogy a lejárati idõ nehezebben lejárjon
                    };
                });

            // JSON sorosítás beállítása (optional)
            builder.Services.AddControllers().AddJsonOptions(x => x.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles);

            // DB Context beállítása
            builder.Services.AddDbContext<Vizsga3Context>(option =>
            {
                var connectionString = builder.Configuration.GetConnectionString("MySql");
                option.UseMySQL(connectionString);
            });

            // CORS beállítás
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowReactApp", policy =>
                {
                    policy.WithOrigins("http://localhost:3000") // Engedélyezett frontend cím
                          .AllowAnyHeader()                   // Bármilyen fejléc engedélyezése
                          .AllowAnyMethod();                  // Bármilyen HTTP metódus engedélyezése
                });
            });

            // Swagger konfigurálása
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(options =>
            {
                options.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "Vizsga3 API",
                    Version = "v1",
                    Description = "A backend API a felhasználói bejelentkezéshez és más funkciókhoz"
                });
            });

            var app = builder.Build();

            // Fejlesztési módban engedélyezze a Swagger UI-t
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI(c =>
                {
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Vizsga3 API V1");
                });
            }

            // HTTPS átirányítás
            app.UseHttpsRedirection();

            // CORS engedélyezése
            app.UseCors("AllowReactApp");

            // Authorization (ha szükséges a jövõben)
            app.UseAuthorization();

            // API végpontok hozzárendelése
            app.MapControllers();

            // Az alkalmazás futtatása
            app.Run();
        }
    }
}
