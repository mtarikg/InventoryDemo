﻿using InventoryDemo.Entities.Abstracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InventoryDemo.DataAccess.Repositories.Abstracts
{
    public interface IUserRepository : IRepository<User>
    {
        Task<User> ValidateUser(string username, string password);
    }
}