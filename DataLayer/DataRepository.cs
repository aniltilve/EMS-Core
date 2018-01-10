using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace EMS.DataAccess
{
    public class DataRepository<T> : IDataRepository<T> 
        where T : class
    {
        public int Add(string SQL)
        {
            throw new NotImplementedException();
        }

        public void Delete(string SQL)
        {

        }

        public IList<T> GetList(string SQL)
        {
            using (var context = new EMSContext<T>())
            {
                return context.DbSet
                    .FromSql<T>(SQL)
                    .ToList<T>();
            }
        }

        public void Update(string SQL)
        {
            throw new NotImplementedException();
        }
    }
}
