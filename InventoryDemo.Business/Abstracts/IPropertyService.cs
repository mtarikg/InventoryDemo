﻿using InventoryDemo.DTOs.Requests;
using InventoryDemo.DTOs.Responses;
using InventoryDemo.Entities.Concretes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Business.Abstracts
{
    public interface IPropertyService
    {
        Task<ICollection<PropertyListResponse>> GetAllProperties();
        Task<PropertyListResponse> GetPropertyById(int id);
        Task<int> AddProperty(PropertyAddRequest propertyAddRequest);
        Task<int> EditProperty(PropertyEditRequest propertyEditRequest);
        Task DeleteProperty(int id);
    }
}
