using InventoryDemo.DTOs.Responses;
using InventoryDemo.Entities.Abstracts;

namespace InventoryDemo.Business.Abstracts
{
    public interface IUserService
    {
        Task<User> ValidateUser(string username, string password);
        Task<ICollection<PersonnelListResponse>> GetAllPersonnels();
        Task<ICollection<PersonnelPropertyListResponse>> GetPersonnelProperties(int personnelID);
    }
}
