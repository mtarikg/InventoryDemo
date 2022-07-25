using AutoMapper;
using InventoryDemo.Business.Abstracts;
using InventoryDemo.DataAccess.Repositories.Abstracts;
using InventoryDemo.DTOs.Requests;
using InventoryDemo.DTOs.Responses;
using InventoryDemo.Entities.Abstracts;
using InventoryDemo.Entities.Concretes;

namespace InventoryDemo.Business.Concretes
{
    public class UserService : IUserService
    {
        private readonly IUserRepository userRepository;
        private readonly IMapper mapper;

        public UserService(IUserRepository userRepository, IMapper mapper)
        {
            this.userRepository = userRepository;
            this.mapper = mapper;
        }

        public async Task<ICollection<int>> AddPropertyToPersonnel(PersonnelPropertyAddRequest personnelPropertyAddRequest)
        {
            var personnelProperty = mapper.Map<PersonnelsProperties>(personnelPropertyAddRequest);
            var result = await userRepository.AddPropertyToPersonnel(personnelProperty);

            return result;
        }

        public async Task DeletePersonnelProperty(int personnelID, int propertyID)
        {
            await userRepository.DeletePropertyFromPersonnel(personnelID, propertyID);
        }

        public async Task<ICollection<PersonnelListResponse>> GetAllPersonnels()
        {
            var allPersonnels = await userRepository.GetUsersByRole(2);
            var personnelsListResponse = mapper.Map<List<PersonnelListResponse>>(allPersonnels);

            return personnelsListResponse;
        }

        public async Task<ICollection<PersonnelPropertyListResponse>> GetPersonnelProperties(int personnelID)
        {
            var propertiesOfPersonnel = await userRepository.GetPersonnelProperties(personnelID);
            var personnelPropertiesListResponse = mapper.Map<List<PersonnelPropertyListResponse>>(propertiesOfPersonnel);

            return personnelPropertiesListResponse;
        }

        public async Task<int> EditPersonnelProperty(PersonnelPropertyEditRequest personnelPropertyEditRequest)
        {
            var personnelProperty = await userRepository
                .GetPersonnelsPropertiesByID(personnelPropertyEditRequest.UserID, personnelPropertyEditRequest.PropertyID);
            var editedPersonnelProperty = mapper.Map<PersonnelsProperties>(personnelPropertyEditRequest);
            editedPersonnelProperty.DueOn = personnelProperty.DueOn;
            personnelProperty = editedPersonnelProperty;
            var result = await userRepository.UpdatePersonnelProperty(personnelProperty);

            return result;
        }

        public async Task<User> ValidateUser(string username, string password)
        {
            var allUsers = await userRepository.GetAllEntities();
            var user = allUsers.FirstOrDefault(u => u.Username == username && u.Password == password);

            return user;
        }
    }
}
