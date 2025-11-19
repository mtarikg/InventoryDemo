using InventoryDemo.Entities.Concretes;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Entities.Abstracts
{
    public abstract class User : IEntity
    {
        public int ID { get; set; }
        [Required(ErrorMessage = "The username field can not be empty.")]
        public string Username { get; set; }
        [Required(ErrorMessage = "The password field can not be empty.")]
        public string Password { get; set; }
        [Required(ErrorMessage = "Role ID can not be empty.")]
        public int RoleID { get; set; }

        public Role Role { get; set; }
    }
}
