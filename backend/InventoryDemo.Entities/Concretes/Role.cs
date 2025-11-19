using InventoryDemo.Entities.Abstracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.Entities.Concretes
{
    public class Role : IEntity
    {
        public int ID { get; set; }
        public string Name { get; set; }

        public ICollection<User> Users { get; set; }
    }
}
