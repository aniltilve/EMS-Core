using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace EMS.DataAccess
{
    public class EMSContext<T> : DbContext, IDisposable
        where T : class
    {
        bool isDisposed;

        public DbSet<T> DbSet { get; set; }

        public EMSContext()
        {
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(
                "server=DESKTOP-PE3EO5G; database=ems; Integrated Security=false; user=emsuser1; pwd=emsuser1; MultipleActiveResultSets=true");
        }

        //public void Dispose()
        //{
        //    Dispose(true);
        //    GC.SuppressFinalize(this);
        //}

        //protected virtual void Dispose(bool isDisposing)
        //{
        //    if (isDisposed)
        //        return;

        //    if (isDisposing)
        //    {

        //    }

        //    isDisposed = true;
        //}
    }
}
