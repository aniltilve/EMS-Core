using EMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;

namespace EMS.Business
{
    public class Agency
    {
        public int AddAgency(Entity.Agency agency)
        {
            int agencyID = 0;

            using (SqlCommand command = new SqlCommand("dbo.uspSaveAgency"))
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;

                PropertyInfo[] propertyInfo = agency.GetType().
                    GetProperties().
                    Where(property => property.Name != "bIsActive"
                        && property.Name != "dtInserted"
                        && property.Name != "dtUpdated").
                    ToArray();

                propertyInfo.ToList().
                    ForEach(property => command.Parameters.
                        Add(new SqlParameter(String.Format("@{0}", property.Name),
                            (property.GetValue(agency) ?? DBNull.Value))));

                command.Parameters["@iAgencyID"].Direction = System.Data.ParameterDirection.Output;

                agencyID = new EMSRepository<Agency>().Add(command);
            }

            return agencyID;
        }

        public int UpdateAgency(Entity.Agency agency)
        {
            int agencyID = 0;

            using (SqlCommand command = new SqlCommand("dbo.uspSaveAgency"))
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;

                PropertyInfo[] propertyInfo = agency.GetType().
                    GetProperties().
                    Where(property => property.Name != "bIsActive"
                        && property.Name != "dtInserted"
                        && property.Name != "dtUpdated").
                    ToArray();

                propertyInfo.ToList().
                    ForEach(property => command.Parameters.
                        Add(new SqlParameter(String.Format("@{0}", property.Name),
                            (property.GetValue(agency) ?? DBNull.Value))));

                command.Parameters["@iAgencyID"].Direction = System.Data.ParameterDirection.Output;

                new EMSRepository<Agency>().Update(command);
            }

            return agencyID;
        }

        public IList<Agency> GetAgencyList(int? agencyID)
        {
            string SQL = String.Format("EXEC dbo.uspGetAgencyList {0}", agencyID);

            return new EMSRepository<Agency>().GetList(SQL);
        }
    }
}
