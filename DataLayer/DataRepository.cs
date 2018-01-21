using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace EMS.DataAccess
{
    public class DataRepository<T> : IDataRepository<T> 
        where T : class
    {
        private string connectionString = "server=DESKTOP-PE3EO5G; database=ems; Integrated Security=false; user=emsuser1; pwd=emsuser1; MultipleActiveResultSets=true";
        //Calls uspSave stored procedure for type T in EMS database to add new entry
        public int Add(SqlCommand command)
        {
            command.Connection = new SqlConnection(connectionString);
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();

            string id = String.Format("@i{0}ID", typeof(T).Name);
            return Convert.ToInt32(command.Parameters[id].Value);
        }

        public void Delete(string SQL)
        {
            throw new NotImplementedException();
        }

        //Calls uspGetList stored procedure for type T in EMS database
        public IList<T> GetList(string SQL)
        {
            using (var context = new EMSContext<T>())
            {
                return context.DbSet
                    .FromSql<T>(SQL)
                    .ToList<T>();
            }
        }

        public void Update(SqlCommand command)
        {
            command.Connection = new SqlConnection(connectionString);
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
}
