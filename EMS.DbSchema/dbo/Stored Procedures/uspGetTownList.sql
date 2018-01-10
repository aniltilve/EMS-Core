

CREATE PROCEDURE [dbo].[uspGetTownList]
(
	@iAgencyID INT,
	@iTownID INT = NULL
)
AS
BEGIN
	BEGIN TRY
		IF (@iAgencyID IS NULL OR @iAgencyID <= 0)
			RAISERROR('An Agency ID is required', 16, 1)

		SELECT
			[iTownID],
			[iAgencyID],
			[szName],
			[bIsActive],
			[dtInserted],
			[szInsertedBy],
			[dtUpdated],
			[szUpdatedBy]
		FROM
			tblTowns (NOLOCK)
		WHERE
			((@iTownID IS NULL) OR (iTownID = @iTownID)) AND
			 iAgencyID = @iAgencyID AND 
			 bIsActive = 1
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
