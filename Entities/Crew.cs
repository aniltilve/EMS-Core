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
        public string szUserName { get; set; }
        public string szPassword { get; set; }
        public string szFullName { get; set; }
        public string szType { get; set; }
        public bool? bIsActive { get; set; }
        public DateTime? dtInserted { get; set; }
        public string szInsertedBy { get; set; }
        public DateTime? dtUpdated { get; set; }
        public string szUpdatedBy { get; set; }
    }
}
