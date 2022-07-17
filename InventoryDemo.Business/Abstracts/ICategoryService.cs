using InventoryDemo.DTOs.Responses;

namespace InventoryDemo.Business.Abstracts
{
    public interface ICategoryService
    {
        Task<ICollection<CategoryListResponse>> GetAllCategories();
    }
}
