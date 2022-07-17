using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace InventoryDemo.DataAccess.Migrations
{
    public partial class initial : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Categories",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Categories", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Roles",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Roles", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Properties",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ImageURL = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    ShortDescription = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    FullDetail = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CategoryID = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Properties", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Properties_Categories_CategoryID",
                        column: x => x.CategoryID,
                        principalTable: "Categories",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Username = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Password = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    RoleID = table.Column<int>(type: "int", nullable: false),
                    Discriminator = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    FullName = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Users_Roles_RoleID",
                        column: x => x.RoleID,
                        principalTable: "Roles",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "PersonnelsProperties",
                columns: table => new
                {
                    UserID = table.Column<int>(type: "int", nullable: false),
                    PropertyID = table.Column<int>(type: "int", nullable: false),
                    DueOn = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PersonnelsProperties", x => new { x.UserID, x.PropertyID });
                    table.ForeignKey(
                        name: "FK_PersonnelsProperties_Properties_PropertyID",
                        column: x => x.PropertyID,
                        principalTable: "Properties",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PersonnelsProperties_Users_UserID",
                        column: x => x.UserID,
                        principalTable: "Users",
                        principalColumn: "ID");
                });

            migrationBuilder.InsertData(
                table: "Categories",
                columns: new[] { "ID", "Name" },
                values: new object[,]
                {
                    { 1, "Mobile Phones" },
                    { 2, "Computers" }
                });

            migrationBuilder.InsertData(
                table: "Roles",
                columns: new[] { "ID", "Name" },
                values: new object[,]
                {
                    { 1, "Admin" },
                    { 2, "Personnel" }
                });

            migrationBuilder.InsertData(
                table: "Properties",
                columns: new[] { "ID", "CategoryID", "CreatedDate", "FullDetail", "ImageURL", "Name", "Quantity", "ShortDescription" },
                values: new object[] { 1, 1, new DateTime(2022, 7, 16, 22, 14, 17, 490, DateTimeKind.Local).AddTicks(16), null, "https://cdn.vatanbilgisayar.com/Upload/PRODUCT/apple/thumb/v2-87996_large.jpg", "iPhone 8 PLUS", 10, "64 GB, UZAY GRİSİ" });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "ID", "Discriminator", "Password", "RoleID", "Username" },
                values: new object[] { 1, "Admin", "Test", 1, "admin1" });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "ID", "Discriminator", "FullName", "Password", "RoleID", "Username" },
                values: new object[] { 2, "Personnel", "Tarık Göl", "Test", 2, "mtarikg" });

            migrationBuilder.InsertData(
                table: "PersonnelsProperties",
                columns: new[] { "PropertyID", "UserID", "DueOn" },
                values: new object[] { 1, 2, new DateTime(2022, 12, 31, 23, 59, 59, 0, DateTimeKind.Unspecified) });

            migrationBuilder.CreateIndex(
                name: "IX_PersonnelsProperties_PropertyID",
                table: "PersonnelsProperties",
                column: "PropertyID");

            migrationBuilder.CreateIndex(
                name: "IX_Properties_CategoryID",
                table: "Properties",
                column: "CategoryID");

            migrationBuilder.CreateIndex(
                name: "IX_Users_RoleID",
                table: "Users",
                column: "RoleID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PersonnelsProperties");

            migrationBuilder.DropTable(
                name: "Properties");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropTable(
                name: "Categories");

            migrationBuilder.DropTable(
                name: "Roles");
        }
    }
}
