using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace vizsga3.Models
{
    public partial class Vizsga3Context : DbContext
    {
        private readonly IConfiguration _configuration;

        public Vizsga3Context(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public Vizsga3Context(DbContextOptions<Vizsga3Context> options, IConfiguration configuration)
            : base(options)
        {
            _configuration = configuration;
        }

        public virtual DbSet<Felhasznalok> Felhasznaloks { get; set; }
        public virtual DbSet<Kartyak> Kartyaks { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var connectionString = _configuration.GetConnectionString("MySql");
                optionsBuilder.UseMySQL(connectionString);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Felhasznalok>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("PRIMARY");

                entity.ToTable("felhasznalok");

                entity.Property(e => e.Id)
                    .HasColumnType("int(255)")
                    .HasColumnName("id");
                entity.Property(e => e.Felhasznalonev)
                    .HasMaxLength(255)
                    .HasDefaultValue(null)
                    .HasColumnName("felhasznalonev");
                entity.Property(e => e.Jelszo)
                    .HasMaxLength(255)
                    .HasDefaultValue(null)
                    .HasColumnName("jelszo");
            });

            modelBuilder.Entity<Kartyak>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("PRIMARY");

                entity.ToTable("kartyak");

                entity.Property(e => e.Id)
                    .HasColumnType("int(255)")
                    .HasColumnName("id");
                entity.Property(e => e.Ar)
                    .HasDefaultValue(null)
                    .HasColumnType("int(255)")
                    .HasColumnName("ar");
                entity.Property(e => e.KepUrl)
                    .HasMaxLength(255)
                    .HasDefaultValue(null)
                    .HasColumnName("kep_url");
                entity.Property(e => e.Leiras)
                    .HasMaxLength(255)
                    .HasDefaultValue(null)
                    .HasColumnName("leiras");
                entity.Property(e => e.CurrentUser)
                    .HasMaxLength(255)
                    .HasDefaultValue(null)
                    .HasColumnName("nev");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
