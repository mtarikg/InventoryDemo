using InventoryDemo.DataAccess.Data;
using InventoryDemo.DataAccess.Repositories.Abstracts;
using InventoryDemo.Entities.Abstracts;
using InventoryDemo.Entities.Concretes;
using Microsoft.EntityFrameworkCore;

namespace InventoryDemo.DataAccess.Repositories.Concretes
{
    public class EFUserRepository : EFGenericRepository<User>, IUserRepository
    {
        private readonly InventoryDbContext _dbContext;
        public EFUserRepository(InventoryDbContext dbContext) : base(dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<ICollection<PersonnelsProperties>> GetPersonnelProperties(int userID)
        {
            var personnelProperties = await _dbContext.PersonnelsProperties.Where(pp => pp.UserID == userID).ToListAsync();

            return personnelProperties;
        }

        public async Task<ICollection<User>> GetUsersByRole(int roleID)
        {
            var users = await _dbContext.Users.Where(u => u.RoleID == roleID).ToListAsync();

            return users;
        }

        public async Task<User> ValidateUser(string username, string password)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(u => u.Username == username && u.Password == password);

            return user;
        }
    }
}
