using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DTOs.Responses
{
    public class PropertyListResponse
    {
        public string Name { get; set; }
        public string? ImageURL { get; set; }
        public string? FullDetail { get; set; }
    }
}
