using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace vizsga3.Migrations
{
    /// <inheritdoc />
    public partial class AddKategoriaColumn : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "category",
                table: "Kartyaks",
                type: "nvarchar(max)",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "category",
                table: "Kartyaks");
        }
    }

}
