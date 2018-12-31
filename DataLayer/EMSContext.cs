using Microsoft.EntityFrameworkCore;
using System;
using System.Configuration;
using Microsoft.Extensions.Configuration;

namespace EMS.DataAccess
{
    public class EMSContext : DbContext
    {
        bool isDisposed;
        

        public EMSContext()
        {
            //Microsoft.Extensions.Configuration.ConfigurationExtensions.GetConnectionString();
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var connectionString = "";
        }
    }
}
