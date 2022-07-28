using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace InventoryDemo.DataAccess.Migrations
{
    public partial class updatedInitial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "ID", "Discriminator", "FullName", "Password", "RoleID", "Username" },
                values: new object[] { 3, "Personnel", "Kaan Uzer", "Test", 2, "kaanuzer" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "ID",
                keyValue: 3);
        }
    }
}
