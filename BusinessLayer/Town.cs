using EMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Text;

namespace EMS.Business
{
    public class Town
    {
        public IList<Town> GetTownList(int agencyID, int? townID)
        {
            string SQL = String.Format("EXEC dbo.uspGetCrewList {0}, {1}", agencyID, townID);

            return new EMSRepository<Town>().GetList(SQL);
        }
    }
}
