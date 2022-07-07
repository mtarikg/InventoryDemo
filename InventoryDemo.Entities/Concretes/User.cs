using InventoryDemo.Entities.Abstracts;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Entities.Concretes
{
    public class User : IEntity
    {
        public int ID { get; set; }
        [Required(ErrorMessage = "The name of a user can not be empty.")]
        public string FullName { get; set; }
        [Required(ErrorMessage = "The username field can not be empty.")]
        public string Username { get; set; }
        [Required(ErrorMessage = "The email of a user can not be empty.")]
        public string Email { get; set; }
        [Required(ErrorMessage = "The password field can not be empty.")]
        public string Password { get; set; }

        public ICollection<UsersProperties> Properties { get; set; }
    }
}
