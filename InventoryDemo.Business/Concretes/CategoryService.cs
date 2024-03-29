﻿using AutoMapper;
using InventoryDemo.Business.Abstracts;
using InventoryDemo.DataAccess.Repositories.Abstracts;
using InventoryDemo.DTOs.Requests;
using InventoryDemo.DTOs.Responses;
using InventoryDemo.Entities.Concretes;

namespace InventoryDemo.Business.Concretes
{
    public class CategoryService : ICategoryService
    {
        private readonly ICategoryRepository categoryRepository;
        private readonly IMapper mapper;

        public CategoryService(ICategoryRepository categoryRepository, IMapper mapper)
        {
            this.categoryRepository = categoryRepository;
            this.mapper = mapper;
        }

        public async Task<int> AddCategory(CategoryAddRequest request)
        {
            var category = mapper.Map<Category>(request);
            var result = await categoryRepository.Add(category);

            return result;
        }

        public async Task DeleteCategory(int id)
        {
            await categoryRepository.Delete(id);
        }

        public async Task<ICollection<CategoryListResponse>> GetAllCategories()
        {
            var allCategories = await categoryRepository.GetAllEntities();
            var categoriesListResponse = mapper.Map<List<CategoryListResponse>>(allCategories);

            return categoriesListResponse;
        }
    }
}
