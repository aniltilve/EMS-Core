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
        public string szName { get; set; }
        public string szShortName { get; set; }
        public string szEIN { get; set; }
        public string szRegState { get; set; }
        public string szStatus { get; set; }
        public DateTime dtSubscribeStart { get; set; }
        public DateTime? dtSubscribeEnd { get; set; }
        public bool bTaxExempt { get; set; }
        public decimal mLicensePrice { get; set; }
        public decimal mRenewalPrice { get; set; }
        public bool bIsActive { get; set; }
        public DateTime dtInserted { get; set; }
        public string szInsertedBy { get; set; }
        public DateTime? dtUpdated { get; set; }
        public string szUpdatedBy { get; set; }
        public string szNotificationEmail { get; set; }
        public bool bNotificationRequired { get; set; }
        public bool bAgreement  { get; set; }
        public DateTime? dtAgreementAccepted { get; set; }
        public int? iAgreementAcceptedUserID { get; set; }
        public string szIPAddress { get; set; }
        public string szLogoFileName { get; set; }
    }
}
