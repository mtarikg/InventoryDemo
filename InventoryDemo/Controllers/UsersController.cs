using InventoryDemo.API.Models;
using InventoryDemo.Business.Abstracts;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

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

        [HttpPost]
        public async Task<IActionResult> Login(UserLoginModel model)
        {
            var user = await userService.ValidateUser(model.Username, model.Password);

            if (user != null)
            {
                var claims = new[] {
                    new Claim(JwtRegisteredClaimNames.UniqueName, user.ID.ToString()),
                    new Claim(ClaimTypes.Role.Replace(ClaimTypes.Role.ToString(), "role"), user.RoleID.ToString())
                };

                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("A very very secret key."));
                var credential = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                var token = new JwtSecurityToken(
                    issuer: "inventory",
                    audience: "inventory",
                    claims: claims,
                    notBefore: DateTime.UtcNow,
                    signingCredentials: credential
                    );

                return Ok(new { token = new JwtSecurityTokenHandler().WriteToken(token) });
            }

            return Ok(new { message = "Hatalı kullanıcı adı veya şifre, lütfen tekrar deneyiniz!" });
        }
    }
}
