using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DTOs.Responses
{
    public class PersonnelPropertyListResponse
    {
        public int PropertyID { get; set; }
        public DateTime DueOn { get; set; }
        public bool IsWaiting { get; set; }
    }
}
