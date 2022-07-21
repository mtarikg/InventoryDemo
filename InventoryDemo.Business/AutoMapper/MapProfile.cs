using AutoMapper;
using InventoryDemo.DTOs.Requests;
using InventoryDemo.DTOs.Responses;
using InventoryDemo.Entities.Abstracts;
using InventoryDemo.Entities.Concretes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Business.AutoMapper
{
    public class MapProfile : Profile
    {
        public MapProfile()
        {
            CreateMap<Category, CategoryListResponse>();
            CreateMap<CategoryAddRequest, Category>();
            CreateMap<Property, PropertyListResponse>();
            CreateMap<PropertyAddRequest, Property>();
            CreateMap<PropertyEditRequest, Property>();
            CreateMap<Personnel, PersonnelListResponse>();
            CreateMap<PersonnelsProperties, PersonnelPropertyListResponse>();
        }
    }
}
