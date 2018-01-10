using EMS.DataAccess;
using System;
using System.Collections.Generic;

namespace EMS.Business
{
    public class Address
    {
        public IList<Address> GetAddressList(int agencyID, int? addressID)
        {
            String SQL = String.Format("EXEC dbo.uspGetAddressList {0}, {1}", agencyID, addressID);

            return new DataRepository<Address>().GetList(SQL);
        }
    }
}
