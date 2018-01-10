
CREATE PROCEDURE [dbo].[uspSaveAgencyTable]
(
	@iAgencyID INT = NULL OUTPUT,
	@szName VARCHAR(128),
	@szShortName VARCHAR(32),
	@szEIN VARCHAR(64),
	@szRegState VARCHAR(2),
	@szStatus VARCHAR(1),
	@dtSubscribeStart DATETIME,
	@dtSubscribeEnd DATETIME = NULL,
	@bTaxExempt BIT,
	@mLicensePrice MONEY,
	@mRenewalPrice MONEY,
	@bIsActive BIT,
	@szInsertedBy VARCHAR(64),
	@szUpdatedBy VARCHAR(128) = NULL,
	@szNotificationEmail VARCHAR(64) = NULL,
	@bNotificationRequired BIT,
	@bAgreement BIT,
	@dtAgreementAccepted DATETIME = NULL,
	@iAgreementAcceptedUserID INT = NULL,
	@szIPAddress VARCHAR(32) = NULL,
	@szLogoFileName VARCHAR(64) = NULL
)
AS
BEGIN
	BEGIN TRY
		SET @iAgencyID = ISNULL(@iAgencyID, 0)
		IF (@iAgencyID <= 0)
		BEGIN
			INSERT INTO 
				dbo.tblAgency
			(
				szName,
				szShortName,
				szEIN,
				szRegState,
				szStatus,
				dtSubscribeStart,
				dtSubscribeEnd,
				bTaxExempt,
				mLicensePrice,
				mRenewalPrice,
				bIsActive,
				dtInserted,
				szInsertedBy,
				szNotificationEmail,
				bNotificationRequired,
				[bAgreement ],
				dtAgreementAccepted,
				iAgreementAcceptedUserID,
				szIPAddress,
				szLogoFileName
			)
			VALUES
			(
				@szName,
				@szShortName,
				@szEIN,
				@szRegState,
				@szStatus,
				@dtSubscribeStart,
				@dtSubscribeEnd,
				@bTaxExempt,
				@mLicensePrice,
				@mRenewalPrice,
				1,
				getdate(),
				@szInsertedBy,
				@szNotificationEmail,
				@bNotificationRequired,
				@bAgreement,
				@dtAgreementAccepted,
				@iAgreementAcceptedUserID,
				@szIPAddress,
				@szLogoFileName
			)
			SELECT @iAgencyID = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE dbo.tblAgency
			SET
				szName = @szName,
				szShortName = @szShortName,
				szEIN = @szEIN,
				szRegState = @szRegState,
				szStatus = @dtSubscribeEnd,
				dtSubscribeStart = @dtSubscribeStart,
				dtSubscribeEnd = @dtSubscribeEnd,
				bTaxExempt = @bTaxExempt,
				mLicensePrice = @mLicensePrice,
				mRenewalPrice = @mRenewalPrice,
				bIsActive = @bIsActive,
				dtUpdated = getdate(),
				szUpdatedBy = szUpdatedBy,
				szNotificationEmail = @szNotificationEmail,
				bNotificationRequired = @bNotificationRequired,
				[bAgreement ] = @bAgreement,
				dtAgreementAccepted = @dtAgreementAccepted,
				iAgreementAcceptedUserID = @iAgreementAcceptedUserID,
				szIPAddress = @szIPAddress,
				szLogoFileName = @szLogoFileName
			WHERE
				iAgencyID = @iAgencyID
		END
	END TRY
	BEGIN CATCH
        DECLARE @errorMessage VARCHAR(256)

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
