CREATE PROCEDURE [dbo].[uspSaveCrewType]
(
	@iCrewTypeID INT = NULL OUTPUT,
	@iAgencyID INT = NULL,
	@szCode VARCHAR(1),
	@szName VARCHAR(100),
	@bIsActive BIT,
	@szInsertedBy VARCHAR(64),
	@szUpdatedBy VARCHAR(64) = NULL
)
AS
BEGIN
	BEGIN TRY
		IF (@iCrewTypeID IS NULL OR @iCrewTypeID <= 0)
		BEGIN
			INSERT INTO 
				dbo.tblCrewType
			(
				iAgencyID,
				szCode,
				szName,
				bIsActive,
				dtInserted,
				szInsertedBy
			)
			VALUES
			(
				@iAgencyID,
				@szCode,
				@szName,
				1,
				GETDATE(),
				@szInsertedBy
			)
			SELECT @iCrewTypeID = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE dbo.tblCrewType
			SET
				iAgencyID = @iAgencyID,
				szCode = @szCode,
				szName = @szName,
				bIsActive = @bIsActive,
				dtUpdated = GETDATE(),
				szUpdatedBy = @szUpdatedBy
			WHERE
				iCrewTypeID = @iCrewTypeID
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
