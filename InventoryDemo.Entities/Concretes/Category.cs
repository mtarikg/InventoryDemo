using InventoryDemo.Entities.Abstracts;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Entities.Concretes
{
    public class Category : IEntity
    {
        public int ID { get; set; }
        [Required(ErrorMessage = "The name of a category can not be empty.")]
        public string Name { get; set; }

        public List<Property> Properties { get; set; }
    }
}
