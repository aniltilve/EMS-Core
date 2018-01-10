


CREATE PROCEDURE [dbo].[uspGetAgencyList] 
(
	@iAgencyID INT = NULL
)
AS
BEGIN
    BEGIN TRY
        SELECT
            [iAgencyID],
            [szName],
            [szShortName],
            [szEIN],
            [szRegState],
            [szStatus],
            [dtSubscribeStart],
            [dtSubscribeEnd],
            [bTaxExempt],
            [mLicensePrice],
            [mRenewalPrice],
            [bIsActive],
            [dtInserted],
            [szInsertedBy],
            [dtUpdated],
            [szUpdatedBy],
            [szNotificationEmail],
            [bNotificationRequired],
            [bAgreement],
            [dtAgreementAccepted],
            [iAgreementAcceptedUserID],
            [szIPAddress],
            [szLogoFileName]
        FROM 
			tblAgency(NOLOCK)
        WHERE 
		((@iAgencyID IS NULL) OR (iAgencyID = @iAgencyID)) AND
		bIsActive = 1
    END TRY
    BEGIN CATCH
        DECLARE @errorMessage varchar(256)

        SELECT
            @errorMessage =
            'Number = ' + CAST(ERROR_NUMBER() AS VARCHAR(8)) + ' ' +
            'Severity = ' + CAST(ERROR_SEVERITY() AS VARCHAR(8)) + ' ' +
            'Procedure = ' + ERROR_PROCEDURE() + ' ' +
            'Line = ' + CAST(ERROR_LINE() AS VARCHAR(8)) + ' ' +
            'Message = ' + ERROR_MESSAGE() + ' '

        RAISERROR (@errorMessage, 16, 1)
    END CATCH
END
