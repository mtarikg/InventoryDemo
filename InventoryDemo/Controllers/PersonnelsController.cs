using InventoryDemo.Business.Abstracts;
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

        [HttpGet("{id}")]
        public async Task<IActionResult> GetPropertiesOfPersonnel(int id)
        {
            var personnelProperties = await userService.GetPersonnelProperties(id);

            return Ok(personnelProperties);
        }
    }
}
