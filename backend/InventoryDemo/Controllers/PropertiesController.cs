using InventoryDemo.Business.Abstracts;
using InventoryDemo.DTOs.Requests;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InventoryDemo.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PropertiesController : ControllerBase
    {
        private readonly IPropertyService propertyService;

        public PropertiesController(IPropertyService propertyService)
        {
            this.propertyService = propertyService;
        }

        [HttpGet]
        public async Task<IActionResult> GetProperties()
        {
            var properties = await propertyService.GetAllProperties();

            return Ok(properties);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetPropertyByID(int id)
        {
            var property = await propertyService.GetPropertyById(id);

            return Ok(property);
        }

        [HttpPost]
        public async Task<IActionResult> AddProperty(PropertyAddRequest request)
        {
            if (ModelState.IsValid)
            {
                var addedPropertyID = await propertyService.AddProperty(request);

                return CreatedAtAction(nameof(GetPropertyByID), routeValues: new { id = addedPropertyID }, null);
            }

            return BadRequest(ModelState);
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteProperty(int id)
        {
            await propertyService.DeleteProperty(id);

            return Ok();
        }

        [HttpPut]
        public async Task<IActionResult> UpdateProperty(int id, PropertyEditRequest request)
        {
            if (ModelState.IsValid)
            {
                await propertyService.EditProperty(request);

                return Ok();
            }

            return BadRequest();
        }
    }
}
