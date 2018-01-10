using System;
using System.Collections.Generic;

namespace EMS.DataAccess
{
    interface IDataRepository<T> where T : class
    {
        IList<T> GetList(String SQL);
        int Add(String SQL);
        void Update(String SQL);
        void Delete(String SQL);
    }
}
