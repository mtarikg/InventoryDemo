using InventoryDemo.Entities.Abstracts;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Entities.Concretes
{
    public class Personnel : User
    {
        [Required(ErrorMessage = "The name of a personnel can not be empty.")]
        public string FullName { get; set; }
        public ICollection<PersonnelsProperties> Properties { get; set; }
    }
}
