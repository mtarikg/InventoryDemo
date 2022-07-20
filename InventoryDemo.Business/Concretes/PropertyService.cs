using AutoMapper;
using InventoryDemo.Business.Abstracts;
using InventoryDemo.DataAccess.Repositories.Abstracts;
using InventoryDemo.DTOs.Requests;
using InventoryDemo.DTOs.Responses;
using InventoryDemo.Entities.Concretes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Business.Concretes
{
    public class PropertyService : IPropertyService
    {
        private readonly IPropertyRepository propertyRepository;
        private readonly IMapper mapper;

        public PropertyService(IPropertyRepository propertyRepository, IMapper mapper)
        {
            this.propertyRepository = propertyRepository;
            this.mapper = mapper;
        }

        public async Task<int> AddProperty(PropertyAddRequest propertyAddRequest)
        {
            var property = mapper.Map<Property>(propertyAddRequest);
            var result = await propertyRepository.Add(property);

            return result;
        }

        public async Task<bool> AddPropertyToPersonnel(int userID, int propertyID, DateTime dueDate)
        {
            throw new NotImplementedException();
        }

        public async Task DeleteProperty(int id)
        {
            await propertyRepository.Delete(id);
        }

        public async Task<int> EditProperty(PropertyEditRequest propertyEditRequest)
        {
            var property = await propertyRepository.GetEntityByID(propertyEditRequest.ID);
            var editedProperty = mapper.Map<Property>(propertyEditRequest);
            editedProperty.Name = property.Name;
            editedProperty.CategoryID = property.CategoryID;
            property = editedProperty;
            var result = await propertyRepository.Update(property);

            return result;
        }

        public async Task<ICollection<PropertyListResponse>> GetAllProperties()
        {
            var allProperties = await propertyRepository.GetAllEntities();
            var propertiesListResponse = mapper.Map<List<PropertyListResponse>>(allProperties);

            return propertiesListResponse;
        }

        public async Task<PropertyListResponse> GetPropertyById(int id)
        {
            var property = await propertyRepository.GetEntityByID(id);
            var propertyListResponse = mapper.Map<PropertyListResponse>(property);

            return propertyListResponse;
        }
    }
}
