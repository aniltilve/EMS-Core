using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace EMS.DataAccess
{
    public class EMSRepository<TEntity> : IDataRepository<TEntity> 
        where TEntity : class
    {
        public static readonly string connectionString = "";


        //Calls uspSave stored procedure for type T in the EMS database to add a new entry
        public int Add(SqlCommand command)
        {
            command.Connection = new SqlConnection(connectionString);
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();

            string id = String.Format("@i{0}ID", typeof(TEntity).Name);
            return Convert.ToInt32(command.Parameters[id].Value);
        }

        public void Delete(string SQL)
        {
            throw new NotImplementedException();
        }

        //Calls uspGetList stored procedure for type T in the EMS database
        public IList<TEntity> GetList(string SQL)
        {
            using (var context = new EMSContext())
            {
                return context.Set<TEntity>()
                    .FromSql<TEntity>(SQL)
                    .ToList<TEntity>();
            }
        }

        //Calls uspSave stored procedure for type T in the EMS database to update an existing entry
        public void Update(SqlCommand command)
        {
            command.Connection = new SqlConnection(connectionString);
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
}
