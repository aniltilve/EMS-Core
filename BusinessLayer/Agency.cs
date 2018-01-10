using EMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Text;

namespace EMS.Business
{
    public class Agency
    {
        public IList<Agency> GetAgencyList(int? agencyID)
        {
            String SQL = String.Format("EXEC dbo.uspGetAgencyList {0}", agencyID);

            return new DataRepository<Agency>().GetList(SQL);
        }
    }
}
