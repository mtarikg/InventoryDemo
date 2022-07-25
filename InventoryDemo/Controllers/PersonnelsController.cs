using InventoryDemo.Business.Abstracts;
using InventoryDemo.DTOs.Requests;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InventoryDemo.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PersonnelsController : ControllerBase
    {
        private readonly IUserService userService;

        public PersonnelsController(IUserService userService)
        {
            this.userService = userService;
        }

        [HttpGet]
        public async Task<IActionResult> GetPersonnels()
        {
            var personnels = await userService.GetAllPersonnels();

            return Ok(personnels);
        }

        [HttpGet("{id}/Properties")]
        public async Task<IActionResult> GetPropertiesOfPersonnel(int id)
        {
            var personnelProperties = await userService.GetPersonnelProperties(id);

            return Ok(personnelProperties);
        }

        [HttpPost("{userID}/Properties")]
        public async Task<IActionResult> AddPropertyToPersonnel(PersonnelPropertyAddRequest request)
        {
            if (ModelState.IsValid)
            {
                var result = await userService.AddPropertyToPersonnel(request);

                return Ok(result);
            }

            return BadRequest(ModelState);
        }

        [HttpDelete("{userID}/Properties/{propertyID}")]
        public async Task<IActionResult> DeletePersonnelProperty(int userID, int propertyID)
        {
            await userService.DeletePersonnelProperty(userID, propertyID);

            return Ok();
        }

        [HttpPut("{userID}/Properties/{propertyID}")]
        public async Task<IActionResult> UpdatePersonnelProperty(PersonnelPropertyEditRequest request)
        {
            if (ModelState.IsValid)
            {
                await userService.EditPersonnelProperty(request);

                return Ok();
            }

            return BadRequest(ModelState);
        }
    }
}
