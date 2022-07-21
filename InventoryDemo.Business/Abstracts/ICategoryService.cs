using InventoryDemo.DTOs.Requests;
using InventoryDemo.DTOs.Responses;

namespace InventoryDemo.Business.Abstracts
{
    public interface ICategoryService
    {
        Task<ICollection<CategoryListResponse>> GetAllCategories();
        Task<int> AddCategory(CategoryAddRequest request);
        Task DeleteCategory(int id);
    }
}
