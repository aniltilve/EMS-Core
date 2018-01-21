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

                foreach (PropertyInfo property in propertyInfo)
                {
                    SqlParameter parameter = new SqlParameter(String.Format("@{0}", property.Name), 
                        (property.GetValue(agency) ?? DBNull.Value));

                    command.Parameters.Add(parameter);
                }

                command.Parameters["@iAgencyID"].Direction = System.Data.ParameterDirection.Output;

                agencyID = new DataRepository<Agency>().Add(command);
            }

            return agencyID;
        }
        public IList<Agency> GetAgencyList(int? agencyID)
        {
            string SQL = String.Format("EXEC dbo.uspGetAgencyList {0}", agencyID);

            return new DataRepository<Agency>().GetList(SQL);
        }
    }
}
