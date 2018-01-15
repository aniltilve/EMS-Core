using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace EMS.DataAccess
{
    interface IDataRepository<T> where T : class
    {
        IList<T> GetList(string SQL);
        int Add(SqlCommand command);
        void Update(string SQL);
        void Delete(string SQL);
    }
}
