﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DTOs.Responses
{
    public class PropertyListResponse
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string? ImageURL { get; set; }
        public string? FullDetail { get; set; }
        public string? ShortDescription { get; set; }
    }
}
