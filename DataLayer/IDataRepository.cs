using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace EMS.DataAccess
{
    interface IDataRepository<T> where T : class
    {
        IList<T> GetList(string SQL);
        int Add(SqlCommand command);
        void Update(SqlCommand command);
        void Delete(string SQL);
    }
}
