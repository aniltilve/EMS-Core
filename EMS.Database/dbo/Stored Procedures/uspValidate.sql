CREATE PROCEDURE [dbo].[uspValidate]
	@szAgency		VARCHAR(128),
	@szUserName		VARCHAR(100),
	@szPassword		VARCHAR(128)
AS
	BEGIN TRY
		SELECT	CASE WHEN EXISTS(SELECT * FROM dbo.tblAgency DA WHERE DA.szShortName = @szAgency)		THEN 1 	ELSE 0	END AS bAgencyExists,
				CASE WHEN EXISTS(SELECT * FROM dbo.tblCrew DC WHERE DC.szUserName = @szUserName)	THEN 1	ELSE 0	END AS bUserExists,
				CASE WHEN EXISTS(SELECT * FROM dbo.tblCrew DC WHERE DC.szPassword = @szPassword)	THEN 1	ELSE 0	END AS bPasswordExists
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