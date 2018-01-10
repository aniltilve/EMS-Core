CREATE PROCEDURE [dbo].[uspSaveTown]
(
	@iTownID INT = NULL OUTPUT,
	@iAgencyID INT = NULL,
	@szName VARCHAR(100),
	@bIsActive BIT,
	@szInsertedBy VARCHAR(64),
	@szUpdatedBy VARCHAR(64) = NULL
)
AS
BEGIN
	BEGIN TRY
		IF (@iTownID IS NULL OR @iTownID <= 0)
		BEGIN
			INSERT INTO 
				dbo.tblTown
			(
				iAgencyID,
				szName,
				bIsActive,
				dtInserted,
				szInsertedBy
			)
			VALUES
			(
				@iAgencyID,
				@szName,
				1,
				GETDATE(),
				@szInsertedBy
			)
			SELECT @iTownID = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE dbo.tblTown
			SET
				iAgencyID = @iAgencyID,
				szName = @szName,
				bIsActive = @bIsActive,
				dtUpdated = GETDATE(),
				szUpdatedBy = @szUpdatedBy
			WHERE
				iTownID = @iTownID
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