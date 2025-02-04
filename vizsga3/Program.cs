
using Microsoft.EntityFrameworkCore;
using System.Text.Json.Serialization;
using vizsga3.Models;
using vizsga3.Services;
using vizsga3.Services.IEmailService;

namespace vizsga3
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddControllers().AddJsonOptions(x => x.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);

            builder.Services.AddDbContext<Vizsga3Context>(option =>
            {
                var connectionString = builder.Configuration.GetConnectionString("MySql");
                option.UseMySQL(connectionString);
            }
            );

            builder.Services.AddCors(options => { options.AddPolicy("AllowReactApp", p => { p.WithOrigins("http://localhost:3000").AllowAnyHeader().AllowAnyMethod(); }); });
        
            // Add services to the container.

            builder.Services.AddScoped<IEmail, Email>();

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();


            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

       
            app.UseHttpsRedirection();

            app.UseCors("AllowReactApp");

            app.UseAuthorization();

           



            app.MapControllers();

            app.Run();
        }
    }
}
