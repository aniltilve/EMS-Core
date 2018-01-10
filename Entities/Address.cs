using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace EMS.Entity
{
    public class Address
    {
        [Key]
        public int iAddressID { get; set; }
        public int iAgencyID { get; set; }
        public String szAddress1 { get; set; }

        public String szAddress2 { get; set; }
        public String szCity { get; set; }
        public String szState { get; set; }
        public String szPostalCode { get; set; }
        public bool bIsActive { get; set; }
        public DateTime dtInserted { get; set; }
        public String szInsertedBy { get; set; }
        public DateTime? dtUpdated { get; set; }
        public String szUpdatedBy { get; set; }
    }
}
