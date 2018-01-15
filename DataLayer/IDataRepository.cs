using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace EMS.DataAccess
{
    interface IDataRepository<T> where T : class
    {
        IList<T> GetList(String SQL);
        int Add(SqlCommand command);
        void Update(String SQL);
        void Delete(String SQL);
    }
}
