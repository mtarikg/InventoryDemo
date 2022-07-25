using System.ComponentModel.DataAnnotations;

namespace InventoryDemo.API.Models
{
    public class UserLoginModel
    {
        [Required(ErrorMessage = "Username can not be null.")]
        public string Username { get; set; }
        [DataType(DataType.Password)]
        [Required(ErrorMessage = "Password can not be null.")]
        public string Password { get; set; }
    }
}
