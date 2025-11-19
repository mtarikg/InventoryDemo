using InventoryDemo.Business.Abstracts;
using InventoryDemo.DTOs.Requests;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InventoryDemo.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly ICategoryService categoryService;

        public CategoriesController(ICategoryService categoryService)
        {
            this.categoryService = categoryService;
        }

        [HttpGet]
        public async Task<IActionResult> GetCategories()
        {
            var categories = await categoryService.GetAllCategories();

            return Ok(categories);
        }

        [HttpPost]
        public async Task<IActionResult> AddCategory(CategoryAddRequest request)
        {
            if (ModelState.IsValid)
            {
                var addedCategoryID = await categoryService.AddCategory(request);

                return Ok(addedCategoryID);
            }

            return BadRequest(ModelState);
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            await categoryService.DeleteCategory(id);

            return Ok();
        }
    }
}
