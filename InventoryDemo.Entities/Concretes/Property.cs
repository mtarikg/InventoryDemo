using InventoryDemo.Entities.Abstracts;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Entities.Concretes
{
    public class Property : IEntity
    {
        public int ID { get; set; }
        [Required(ErrorMessage = "The name of a property can not be empty.")]
        public string Name { get; set; }
        public string? ImageURL { get; set; }
        public int Quantity { get; set; }
        public string? ShortDescription { get; set; }
        public string? FullDetail { get; set; }
        public DateTime CreatedDate { get; set; }

        public Category Category { get; set; }
        public int CategoryID { get; set; }

        public ICollection<UsersProperties> Users { get; set; }
    }
}
