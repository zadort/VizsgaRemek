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
            // JWT be�ll�t�sok
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
                        ClockSkew = TimeSpan.Zero // Ha nem akarod, hogy a lej�rati id� nehezebben lej�rjon
                    };
                });

            // JSON soros�t�s be�ll�t�sa (optional)
            builder.Services.AddControllers().AddJsonOptions(x => x.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles);

            // DB Context be�ll�t�sa
            builder.Services.AddDbContext<Vizsga3Context>(option =>
            {
                var connectionString = builder.Configuration.GetConnectionString("MySql");
                option.UseMySQL(connectionString);
            });

            // CORS be�ll�t�s
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowReactApp", policy =>
                {
                    policy.WithOrigins("http://localhost:3000") // Enged�lyezett frontend c�m
                          .AllowAnyHeader()                   // B�rmilyen fejl�c enged�lyez�se
                          .AllowAnyMethod();                  // B�rmilyen HTTP met�dus enged�lyez�se
                });
            });

            // Swagger konfigur�l�sa
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(options =>
            {
                options.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "Vizsga3 API",
                    Version = "v1",
                    Description = "A backend API a felhaszn�l�i bejelentkez�shez �s m�s funkci�khoz"
                });
            });

            var app = builder.Build();

            // Fejleszt�si m�dban enged�lyezze a Swagger UI-t
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI(c =>
                {
                    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Vizsga3 API V1");
                });
            }

            // HTTPS �tir�ny�t�s
            app.UseHttpsRedirection();

            // CORS enged�lyez�se
            app.UseCors("AllowReactApp");

            // Authorization (ha sz�ks�ges a j�v�ben)
            app.UseAuthorization();

            // API v�gpontok hozz�rendel�se
            app.MapControllers();

            // Az alkalmaz�s futtat�sa
            app.Run();
        }
    }
}
