using EMS.DataAccess;
using EMS.Entity;
using System;
using System.Collections.Generic;
using System.Reflection;

namespace Test
{
    public class Program
    {
        static void Main(string[] args)
        {
            DataRepository<Agency> repository = new DataRepository<Agency>();

            IList<Agency> list = repository.GetList("EXEC dbo.uspGetAgencyList");
            foreach (var item in list)
            {
                IList<PropertyInfo> properties = new List<PropertyInfo>(item.GetType().GetProperties());

               foreach (PropertyInfo property in properties)
                {
                    var obj = property.GetValue(item, null);

                    Console.Write(property.Name + ": ");
                    Console.WriteLine((obj !=null) ? obj.ToString(): string.Empty);
                }

                Console.WriteLine("|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
            }
            Console.ReadKey();
        }
    }
}
