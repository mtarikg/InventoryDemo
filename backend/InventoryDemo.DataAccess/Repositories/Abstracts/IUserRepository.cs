using InventoryDemo.Entities.Abstracts;
using InventoryDemo.Entities.Concretes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DataAccess.Repositories.Abstracts
{
    public interface IUserRepository : IRepository<User>
    {
        Task<User> ValidateUser(string username, string password);
        Task<ICollection<User>> GetUsersByRole(int roleID);
        Task<ICollection<PersonnelsProperties>> GetPersonnelProperties(int userID);
        Task<PersonnelsProperties> GetPersonnelsPropertiesByID(int userID, int propertyID);
        Task<ICollection<int>> AddPropertyToPersonnel(PersonnelsProperties personnelProperty);
        Task DeletePropertyFromPersonnel(int userID, int propertyID);
        Task<int> UpdatePersonnelProperty(PersonnelsProperties personnelsProperty);
    }
}
