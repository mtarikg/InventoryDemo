using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DTOs.Requests
{
    public class PersonnelPropertyEditRequest
    {
        public int PropertyID { get; set; }
        public int UserID { get; set; }
        public bool IsWaiting { get; set; }
    }
}
