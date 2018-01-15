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
        public string szAddress1 { get; set; }

        public string szAddress2 { get; set; }
        public string szCity { get; set; }
        public string szState { get; set; }
        public string szPostalCode { get; set; }
        public bool bIsActive { get; set; }
        public DateTime dtInserted { get; set; }
        public string szInsertedBy { get; set; }
        public DateTime? dtUpdated { get; set; }
        public string szUpdatedBy { get; set; }
    }
}
