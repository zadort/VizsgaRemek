using Microsoft.EntityFrameworkCore.Migrations;
using MySql.EntityFrameworkCore.Metadata;

#nullable disable

namespace vizsga3.Migrations
{
    /// <inheritdoc />
    public partial class AddKategoriaToKartyak : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("MySQL:Charset", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "felhasznalok",
                columns: table => new
                {
                    id = table.Column<int>(type: "int(255)", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    felhasznalonev = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: true),
                    Email = table.Column<string>(type: "longtext", nullable: true),
                    jelszo = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.id);
                })
                .Annotation("MySQL:Charset", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "kartyak",
                columns: table => new
                {
                    id = table.Column<int>(type: "int(255)", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    nev = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: true),
                    ar = table.Column<int>(type: "int(255)", nullable: true),
                    leiras = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: true),
                    kep_url = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PRIMARY", x => x.id);
                })
                .Annotation("MySQL:Charset", "utf8mb4");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "felhasznalok");

            migrationBuilder.DropTable(
                name: "kartyak");
        }
    }
}
