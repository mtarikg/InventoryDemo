using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Entities.Concretes
{
    public class UsersProperties
    {
        public int UserID { get; set; }
        public User User { get; set; }
        public int PropertyID { get; set; }
        public Property Property { get; set; }

        public DateTime DueOn { get; set; }
    }
}
