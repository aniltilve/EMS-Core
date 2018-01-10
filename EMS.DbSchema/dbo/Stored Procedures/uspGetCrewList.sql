
CREATE PROCEDURE [dbo].[uspGetCrewList]
(
	@iAgencyID INT,
	@iCrewID INT = NULL
)
AS
BEGIN
	BEGIN TRY
		IF (@iAgencyID IS NULL OR @iAgencyID <= 0)
			RAISERROR('An Agency ID is required', 16, 1)

		SELECT
			[iCrewID],
			[iAgencyID],
			[iEMTID],
			[szUserName],
			[szPassword],
			[szFullName],
			[szType],
			[bIsActive],
			[dtInserted],
			[szInsertedBy],
			[dtUpdated],
			[szUpdatedBy]
		FROM
			tblCrew (NOLOCK)
		WHERE
			((@iCrewID IS NULL) OR (iCrewID = @iCrewID)) AND
			 iAgencyID = @iAgencyID AND 
			 bIsActive = 1
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
