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

        [Display(Name = "EMT ID (six digit number)")]
        public int? iEMTID { get; set; }

        [Required(ErrorMessage = "Please enter your username")]
        [Display(Name = "Username")]
        public string szUserName { get; set; }

        [Required(ErrorMessage = "Please enter your password")]
        [Display(Name = "Password")]
        public string szPassword { get; set; }

        [Required(ErrorMessage = "Please enter your full name")]
        [Display(Name = "Full Name")]
        public string szFullName { get; set; }

        [Required(ErrorMessage = "Please enter user type ")]
        [Display(Name = "User Type (U-User, S-Admin, I-Inactive, R-Report)")]
        [RegularExpression("^[uUsSiIrR]{1}$", ErrorMessage = "Please enter only one charcter code")]
        public string szType { get; set; }

        public bool? bIsActive { get; set; }

        public DateTime? dtInserted { get; set; }

        public string szInsertedBy { get; set; }

        public DateTime? dtUpdated { get; set; }

        public string szUpdatedBy { get; set; }
    }
}
