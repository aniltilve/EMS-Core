using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace EMS.Entity
{
    public class Crew
    {
        [Key]
        public int iCrewID { get; set; }
        public int? iAgencyID { get; set; }
        public int? iEMTID { get; set; }
        public String szUserName { get; set; }
        public String szPassword { get; set; }
        public String szFullName { get; set; }
        public String szType { get; set; }
        public bool? bIsActive { get; set; }
        public DateTime? dtInserted { get; set; }
        public String szInsertedBy { get; set; }
        public DateTime? dtUpdated { get; set; }
        public String szUpdatedBy { get; set; }
    }
}
