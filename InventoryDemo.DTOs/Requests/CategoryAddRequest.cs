using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DTOs.Requests
{
    public class CategoryAddRequest
    {
        [Required(ErrorMessage = "The name of a category can not be empty.")]
        public string Name { get; set; }
    }
}
