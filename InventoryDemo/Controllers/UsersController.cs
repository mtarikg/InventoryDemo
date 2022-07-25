using InventoryDemo.API.Models;
using InventoryDemo.Business.Abstracts;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InventoryDemo.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly IUserService userService;

        public UsersController(IUserService userService)
        {
            this.userService = userService;
        }

        //public async Task<IActionResult> Login(UserLoginModel model)
        //{
        //    return Ok();
        //}
    }
}
