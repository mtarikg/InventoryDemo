using InventoryDemo.Entities.Abstracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DataAccess.Repositories.Abstracts
{
    public interface IRepository<T> where T : class, IEntity
    {
        Task<IList<T>> GetAllEntities();
        Task<T> GetEntityByID(int id);
        Task<int> Add(T entity);
        Task<int> Update(T entity);
        Task Delete(int id);
        Task<bool> IsExist(int id);
    }
}
