using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DTOs.Requests
{
    public class PropertyEditRequest
    {
        public int ID { get; set; }
        public string? ImageURL { get; set; }
        public int Quantity { get; set; }
        public string? ShortDescription { get; set; }
        public string? FullDetail { get; set; }
    }
}
