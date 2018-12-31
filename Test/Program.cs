using EMS.DataAccess;
using EMS.Entity;
using EMS.Business;
using System;
using System.Collections.Generic;
using System.Reflection;

namespace Test
{
    public class Program
    {
        void TestGet<T>() where T: class
        {
            EMSRepository<T> repository = new EMSRepository<T>();
            string SQL = String.Format("EXEC dbo.uspGet{0}List", typeof(T).Name);

            IList<T> list = repository.GetList(SQL);
            foreach (var item in list)
            {
                IList<PropertyInfo> propertyInfo = new List<PropertyInfo>(item.GetType().GetProperties());

                foreach (PropertyInfo property in propertyInfo)
                {
                    var propertyValue = property.GetValue(item);

                    Console.Write(property.Name + ": ");
                    Console.WriteLine((propertyValue != null) ? propertyValue.ToString() : string.Empty);
                }

                Console.WriteLine("|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
            }
        }

        static void Main(string[] args)
        {

            EMS.Entity.Agency agency = new EMS.Entity.Agency();
            agency.szName = "Anil Agency";
            agency.szShortName = "Anil";
            agency.szEIN = "1234";
            agency.szRegState = "y";
            agency.szStatus = "t";
            agency.dtSubscribeStart = DateTime.Now;
            agency.dtSubscribeEnd = null;
            agency.bTaxExempt = true;
            agency.mLicensePrice = 300m;
            agency.mRenewalPrice = 400m;
            agency.szInsertedBy = "Anil";
            agency.szUpdatedBy = "";
            agency.szNotificationEmail = "tilve";
            agency.bNotificationRequired = false;
            agency.bAgreement = true;
            agency.dtAgreementAccepted = null;
            agency.iAgreementAcceptedUserID = 1;
            agency.szIPAddress = "192.0.02";
            agency.szLogoFileName = "test";

            EMS.Business.Agency bisAgency = new EMS.Business.Agency();

            Console.WriteLine(bisAgency.AddAgency(agency));

            Console.ReadKey();
        }
    }
}
