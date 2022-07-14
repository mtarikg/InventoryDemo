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
        public DbSet<PersonnelsProperties> PersonnelsProperties { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Property>().HasOne(p => p.Category)
                .WithMany(c => c.Properties)
                .HasForeignKey(p => p.CategoryID)
                .OnDelete(DeleteBehavior.NoAction);

            modelBuilder.Entity<PersonnelsProperties>().HasKey(pp => new { pp.PersonnelID, pp.PropertyID });

            modelBuilder.Entity<Personnel>().HasMany(p => p.Properties)
                .WithOne(pp => pp.Personnel)
                .HasForeignKey(x => x.PersonnelID)
                .OnDelete(DeleteBehavior.NoAction);
        }
    }
}
