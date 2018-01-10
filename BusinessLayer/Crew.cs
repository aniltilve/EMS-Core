using EMS.DataAccess;
using System;
using System.Collections.Generic;

namespace EMS.Business
{
    class Crew
    {
        public IList<Crew> GetCrewList(int agencyID, int? crewID)
        {
            String SQL = String.Format("EXEC dbo.uspGetCrewList {0}, {1}", agencyID, crewID);

            return new DataRepository<Crew>().GetList(SQL);
        }
    }
}
