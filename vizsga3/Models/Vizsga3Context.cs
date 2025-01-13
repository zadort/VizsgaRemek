using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace vizsga3.Models;

public partial class Vizsga3Context : DbContext
{
    public Vizsga3Context()
    {
    }

    public Vizsga3Context(DbContextOptions<Vizsga3Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Felhasznalok> Felhasznaloks { get; set; }

    public virtual DbSet<Kartyak> Kartyaks { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseMySQL("server=localhost;database=vizsga3;user=root;password=;sslmode=none;");

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
                .HasDefaultValueSql("'NULL'")
                .HasColumnName("felhasznalonev");
            entity.Property(e => e.Jelszo)
                .HasMaxLength(255)
                .HasDefaultValueSql("'NULL'")
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
                .HasDefaultValueSql("'NULL'")
                .HasColumnType("int(255)")
                .HasColumnName("ar");
            entity.Property(e => e.KepUrl)
                .HasMaxLength(255)
                .HasDefaultValueSql("'NULL'")
                .HasColumnName("kep_url");
            entity.Property(e => e.Leiras)
                .HasMaxLength(255)
                .HasDefaultValueSql("'NULL'")
                .HasColumnName("leiras");
            entity.Property(e => e.Nev)
                .HasMaxLength(255)
                .HasDefaultValueSql("'NULL'")
                .HasColumnName("nev");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
