using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Entities.Concretes
{
    public class PersonnelsProperties
    {
        public int UserID { get; set; }
        public Personnel Personnel { get; set; }
        public int PropertyID { get; set; }
        public Property Property { get; set; }
        public DateTime DueOn { get; set; }
        public bool IsWaiting { get; set; }
    }
}
