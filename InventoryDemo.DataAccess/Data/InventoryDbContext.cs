using InventoryDemo.Entities.Abstracts;
using InventoryDemo.Entities.Concretes;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DataAccess.Data
{
    public class InventoryDbContext : DbContext
    {
        public InventoryDbContext(DbContextOptions options) : base(options) { }
        public DbSet<User> Users { get; set; }
        public DbSet<Property> Properties { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<PersonnelsProperties> PersonnelsProperties { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Property>().HasOne(p => p.Category)
                .WithMany(c => c.Properties)
                .HasForeignKey(p => p.CategoryID)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<User>().HasOne(u => u.Role)
                .WithMany(r => r.Users)
                .HasForeignKey(u => u.RoleID)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<PersonnelsProperties>().HasKey(pp => new { pp.UserID, pp.PropertyID });

            modelBuilder.Entity<Personnel>().HasMany(p => p.Properties)
                .WithOne(pp => pp.Personnel)
                .HasForeignKey(x => x.UserID)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Property>().HasMany(p => p.Personnels)
                .WithOne(pp => pp.Property)
                .HasForeignKey(x => x.PropertyID)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<Category>().HasData(
                new Category { ID = 1, Name = "Mobile Phones" },
                new Category { ID = 2, Name = "Computers" }
                );

            modelBuilder.Entity<Role>().HasData(new Role { ID = 1, Name = "Admin" });

            modelBuilder.Entity<Role>().HasData(new Role { ID = 2, Name = "Personnel" });

            modelBuilder.Entity<Admin>().HasData(new Admin { ID = 1, Username = "admin1", Password = "Test", RoleID = 1 });

            modelBuilder.Entity<Personnel>().HasData(
                new Personnel { ID = 2, FullName = "Tarık Göl", Username = "mtarikg", Password = "Test", RoleID = 2 }
                );
        }
    }
}
