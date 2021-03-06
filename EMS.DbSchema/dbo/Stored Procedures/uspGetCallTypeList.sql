﻿CREATE PROCEDURE [dbo].[uspGetCallTypeList]
(
	@iCallTypeID INT = NULL,
	@iAgencyID INT
)
AS
BEGIN
	BEGIN TRY
		IF (@iAgencyID IS NULL OR @iAgencyID <= 0)
			RAISERROR('An Agency ID is required', 16, 1)

		SELECT 
			[iCallTypeID], 
			[iAgencyID], 
			[szCode], 
			[szName], 
			[bIsActive], 
			[dtInserted], 
			[szInsertedBy], 
			[dtUpdated], 
			[szUpdatedBy]
		FROM
			[dbo].[tblCallType] (NOLOCK)
		WHERE
			((@iCallTypeID IS NULL) OR (iCallTypeID = @iCallTypeID)) AND
			 iAgencyID = @iAgencyID
	END TRY
	BEGIN CATCH
		DECLARE @errorMessage VARCHAR(256)

		SELECT @errorMessage =
			'Number = ' + CAST(ERROR_NUMBER() AS VARCHAR(8)) + ' ' +
			'Severity = ' + CAST(ERROR_SEVERITY() AS VARCHAR(8)) + ' ' +
			'Procedure = ' + ERROR_PROCEDURE() + ' ' + 
			'Line = ' + CAST(ERROR_LINE()  AS VARCHAR(8)) + ' ' + 
			'Message = ' + ERROR_MESSAGE() + ' '

		RAISERROR(@errorMessage, 16, 1)
	END CATCH
END
