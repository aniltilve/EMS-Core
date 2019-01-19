CREATE PROCEDURE [dbo].[uspGetAddressList]
(
	@iAgencyID INT,
	@iAddressID INT = NULL
)
AS 
BEGIN 
	BEGIN TRY
		SELECT 
			[iAddressID], 
			[iAgencyID], 
			[szAddress1], 
			[szAddress2], 
			[szCity], 
			[szState], 
			[szPostalCode], 
			[bIsActive], 
			[dtInserted], 
			[szInsertedBy], 
			[dtUpdated], 
			[szUpdatedBy]
		FROM 
			tblAddress (NOLOCK) 
		WHERE
			((@iAddressID IS NULL) OR (iAddressID = @iAddressID)) AND
			 iAgencyID = @iAgencyID
	END TRY 
	BEGIN CATCH 
		DECLARE @errorMessage VARCHAR(256)

		SELECT @errorMessage = 
				'Number = ' + CAST(ERROR_NUMBER() AS VARCHAR(8)) + ' ' +
				'Severity = ' + CAST(ERROR_SEVERITY() AS VARCHAR(8)) + ' ' +
				'Procedure = ' + ERROR_PROCEDURE() + ' ' + 
				'Line = ' + CAST(ERROR_LINE() AS VARCHAR(8)) + ' ' + 
				'Message = ' + ERROR_MESSAGE() + ' ' 

		RAISERROR(@errorMessage,16,1)
	END CATCH 
END 
