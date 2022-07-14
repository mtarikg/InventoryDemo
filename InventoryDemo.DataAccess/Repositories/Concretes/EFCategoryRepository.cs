using InventoryDemo.DataAccess.Data;
using InventoryDemo.DataAccess.Repositories.Abstracts;
using InventoryDemo.Entities.Concretes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DataAccess.Repositories.Concretes
{
    public class EFCategoryRepository : EFGenericRepository<Category>, ICategoryRepository
    {
        public EFCategoryRepository(InventoryDbContext dbContext) : base(dbContext) { }
    }
}
