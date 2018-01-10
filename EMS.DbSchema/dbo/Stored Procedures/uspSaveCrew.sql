CREATE PROCEDURE [dbo].[uspSaveCrew]
(
	@iCrewID INT = NULL OUTPUT,
	@iAgencyID INT = NULL,
	@iEMTID INT = NULL,
	@szUserName VARCHAR(100),
	@szPassword VARCHAR(128),
	@szFullName VARCHAR(100),
	@szType VARCHAR(1),
	@bIsActive BIT,
	@szInsertedBy VARCHAR(64),
	@szUpdatedBy VARCHAR(64) = NULL
)
AS
BEGIN
	BEGIN TRY
		IF (@iCrewID IS NULL OR @iCrewID <= 0)
		BEGIN
			INSERT INTO 
				dbo.tblCrew
			(
				iAgencyID,
				iEMTID,
				szUserName,
				szPassword,
				szFullName,
				szType,
				bIsActive,
				dtInserted,
				szInsertedBy
			)
			VALUES
			(
				@iAgencyID,
				@iEMTID,
				@szUserName,
				@szPassword,
				@szFullName,
				@szType,
				1,
				GETDATE(),
				@szInsertedBy
			)
			SELECT @iCrewID = @@IDENTITY
		END
		ELSE
		BEGIN
			UPDATE dbo.tblCrew
			SET
				iAgencyID = @iAgencyID,
				iEMTID = @iEMTID,
				szUserName = @szUserName,
				szPassword = @szPassword,
				szFullName = @szFullName,
				szType = @szType,
				bIsActive = @bIsActive,
				dtUpdated = GETDATE(),
				szUpdatedBy = @szUpdatedBy
			WHERE
				iCrewID = @iCrewID
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
