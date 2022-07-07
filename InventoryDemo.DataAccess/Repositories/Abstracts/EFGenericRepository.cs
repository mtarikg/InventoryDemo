using InventoryDemo.DataAccess.Data;
using InventoryDemo.Entities.Abstracts;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DataAccess.Repositories.Abstracts
{
    public class EFGenericRepository<T> : IRepository<T> where T : class, IEntity, new()
    {
        protected readonly InventoryDbContext dbContext;
        protected readonly DbSet<T> dbSet;

        public EFGenericRepository(InventoryDbContext dbContext)
        {
            this.dbContext = dbContext;
            dbSet = dbContext.Set<T>();
        }

        public async Task<int> Add(T entity)
        {
            await dbSet.AddAsync(entity);
            await dbContext.SaveChangesAsync();

            return entity.ID;
        }

        public async Task Delete(int id)
        {
            var entity = await dbSet.FirstOrDefaultAsync(e => e.ID == id);
            dbSet.Remove(entity);
            await dbContext.SaveChangesAsync();
        }

        public async Task<IList<T>> GetAllEntities()
        {
            var entities = await dbSet.ToListAsync();

            return entities;
        }

        public async Task<T> GetEntityByID(int id)
        {
            var entity = await dbSet.AsNoTracking().FirstOrDefaultAsync(e => e.ID == id);

            return entity;
        }

        public async Task<bool> IsExist(int id)
        {
            var result = await dbSet.AnyAsync(e => e.ID == id);

            return result;
        }

        public async Task<int> Update(T entity)
        {
            dbSet.Update(entity);

            return await dbContext.SaveChangesAsync();
        }
    }
}
