using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace EMS.Entity
{
    public class Agency
    {
        [Key]
        public int iAgencyID { get; set; }

        [Required(ErrorMessage = "Please enter a name.")]
        [MaxLength(128, ErrorMessage = "This field has a max length of 128 characters.")]
        [Display(Name = "Name:")]
        public string szName { get; set; }

        [Required(ErrorMessage = "Please enter a shortened name for this agency.")]
        [Display(Name = "Shortened Name:")]
        public string szShortName { get; set; }

        [Display(Name = "EIN Number:")]
        public string szEIN { get; set; }

        public string szRegState { get; set; }

        public string szStatus { get; set; }

        [Required(ErrorMessage = "Please select a subscriber start date.")]
        [Display(Name = "Subscriber Start Date:")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime dtSubscribeStart { get; set; }

        [Display(Name = "Subscriber End Date:")]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? dtSubscribeEnd { get; set; }

        [Display(Name = "Tax Exempt?:")]
        public bool bTaxExempt { get; set; }

        [Required(ErrorMessage = "Please enter a license price.")]
        [Display(Name = "License Price:")]
        public decimal mLicensePrice { get; set; }

        [Required(ErrorMessage = "Please enter a renewal price.")]
        [Display(Name = "Renewal Price:")]
        public decimal mRenewalPrice { get; set; }

        public bool bIsActive { get; set; }

        public DateTime dtInserted { get; set; }

        public string szInsertedBy { get; set; }

        public DateTime? dtUpdated { get; set; }

        public string szUpdatedBy { get; set; }

        [MaxLength(128, ErrorMessage = "This field has a max length of 128 characters.")]
        [Display(Name = "Notification Email:")]
        public string szNotificationEmail { get; set; }

        [Required(ErrorMessage = "Please select whether a notification is required.")]
        [Display(Name = "Notification Required?:")]
        public bool bNotificationRequired { get; set; }

        [Required(ErrorMessage = "Please select whether the agreement has been accepted.")]
        [Display(Name = "Agreement Accepted?:")]
        public bool bAgreement { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? dtAgreementAccepted { get; set; }

        public int? iAgreementAcceptedUserID { get; set; }

        public string szIPAddress { get; set; }

        public string szLogoFileName { get; set; }
    }
}
