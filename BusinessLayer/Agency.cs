using EMS.DataAccess;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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

                SqlParameter iAgencyID = new SqlParameter("@iAgencyID", agency.iAgencyID);
                iAgencyID.Direction = System.Data.ParameterDirection.Output;

                command.Parameters.Add(iAgencyID);
                command.Parameters.Add(new SqlParameter("@szName", agency.szName));
                command.Parameters.Add(new SqlParameter("@szShortName", agency.szShortName));
                command.Parameters.Add(new SqlParameter("@szEIN", agency.szEIN));
                command.Parameters.Add(new SqlParameter("@szRegState", agency.szRegState));
                command.Parameters.Add(new SqlParameter("@szStatus", agency.szStatus));
                command.Parameters.Add(new SqlParameter("@dtSubscribeStart", agency.dtSubscribeStart));
                command.Parameters.Add(new SqlParameter("@dtSubscribeEnd", (object)agency.dtSubscribeEnd ?? DBNull.Value));
                command.Parameters.Add(new SqlParameter("@bTaxExempt", agency.bTaxExempt));
                command.Parameters.Add(new SqlParameter("@mLicensePrice", agency.mLicensePrice));
                command.Parameters.Add(new SqlParameter("@mRenewalPrice", agency.mRenewalPrice));
                command.Parameters.Add(new SqlParameter("@szInsertedBy", agency.szInsertedBy));
                command.Parameters.Add(new SqlParameter("@szUpdatedBy", (object)agency.szUpdatedBy ?? DBNull.Value));
                command.Parameters.Add(new SqlParameter("@szNotificationEmail", agency.szNotificationEmail));
                command.Parameters.Add(new SqlParameter("@bNotificationRequired", agency.bNotificationRequired));
                command.Parameters.Add(new SqlParameter("@bAgreement", agency.bAgreement));
                command.Parameters.Add(new SqlParameter("@dtAgreementAccepted", (object)agency.dtAgreementAccepted ?? DBNull.Value));
                command.Parameters.Add(new SqlParameter("@iAgreementAcceptedUserID", (object)agency.iAgreementAcceptedUserID ?? DBNull.Value));
                command.Parameters.Add(new SqlParameter("@szIPAddress", agency.szIPAddress));
                command.Parameters.Add(new SqlParameter("@szLogoFileName", agency.szLogoFileName));

                agencyID = new DataRepository<Agency>().Add(command);
            }

            return agencyID;
        }
        public IList<Agency> GetAgencyList(int? agencyID)
        {
            String SQL = String.Format("EXEC dbo.uspGetAgencyList {0}", agencyID);

            return new DataRepository<Agency>().GetList(SQL);
        }
    }
}
