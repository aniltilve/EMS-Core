using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;

namespace EMS.Business
{
    public interface IAppConfiguration 
    {
        string GetConnectionString { get; }
    }
    public class AppConfiguration : IAppConfiguration
    {
        private IConfiguration config;
        

        public AppConfiguration(IConfiguration config)
        {
            this.config = config;
        }

        public string GetConnectionString
        {
            get { return this.config["ConnectionStrings:SQLConnection"]; }
        }


    }
}
