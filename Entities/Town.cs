using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace EMS.Entity
{
    public class Town
    {
        [Key]
        public int iTownID { get; set; }
        public int? iAgencyID { get; set; }
        public string szName { get; set; }
        public bool bIsActive { get; set; }
        public DateTime dtInserted { get; set; }
        public string szInsertedBy { get; set; }
        public DateTime? dtUpdated { get; set; }
        public string szUpdatedBy { get; set; }
    }
}
