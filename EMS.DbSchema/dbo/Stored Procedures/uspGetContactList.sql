CREATE PROCEDURE [dbo].[uspGetContactList]
(
	@iContactID INT = NULL
)
AS
BEGIN
	BEGIN TRY
		SELECT
			iContactID,
			iAgencyID,
			szContactName,
			szPhoneNumber,
			szContactEmail,
			szNotifyEmail,
			bAutoNotify,
			bIsActive,
			dtInserted,
			szInsertedBy,
			dtUpdated,
			szUpdatedBy
		FROM
			tblContact (NOLOCK)
		WHERE
			((@iContactID IS NULL) OR (iAgencyID = @iContactID)) AND bIsActive = 1
	END TRY
	BEGIN CATCH
		DECLARE @errorMessage VARCHAR(256)

		SELECT @errorMessage =
			'Number = ' + cast(ERROR_NUMBER() AS VARCHAR(8)) + ' ' +
			'Severity = ' + cast(ERROR_SEVERITY() AS VARCHAR(8)) + ' ' +
			'Procedure = ' + ERROR_PROCEDURE() + ' ' + 
			'Line = ' + cast(ERROR_LINE()  AS VARCHAR(8)) + ' ' + 
			'Message = ' + ERROR_MESSAGE() + ' '

		RAISERROR(@errorMessage, 16, 1)
	END CATCH
END
