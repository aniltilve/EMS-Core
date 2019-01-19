using Microsoft.EntityFrameworkCore;
using System;
using System.Configuration;
using Microsoft.Extensions.Configuration;

namespace EMS.DataAccess
{
    public class EMSContext : DbContext
    {
        public static string connectionString { get; set; }

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
