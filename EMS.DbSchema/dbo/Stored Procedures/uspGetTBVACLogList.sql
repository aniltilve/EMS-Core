CREATE PROCEDURE [dbo].[uspGetTBVACLogList]
(
	@iTBVACLogID INT = NULL,
	@iAgencyID INT
)
AS
BEGIN
	BEGIN TRY
		IF (@iAgencyID IS NULL OR @iAgencyID <= 0)
			RAISERROR('An Agency ID is required', 16, 1)

		SELECT 
			[iTBVACLogID], 
			[iAgencyID], 
			[iSeqNumID], 
			[dtDate], 
			[iDispatchTypeID], 
			[iCallTypeID], 
			[dtTimeStart], 
			[dtTimeEnd], 
			[tTimeTotal], 
			[dMilesStart], 
			[dMilesEnd], 
			[dMilesTotal], 
			[iTownID], 
			[iHospitalID], 
			[iRigID], 
			[tTimeDispatch], 
			[iAlsTypeID], 
			[iCrewID], 
			[iCPRID], 
			[bEpiPen], 
			[bStork], 
			[bIncidentReport], 
			[bNoTransport], 
			[bNarcan], 
			[bEmailSend], 
			[sFootBallExtraCode], 
			[szExtraDesc], 
			[bIsActive], 
			[dtInserted], 
			[szInsertedBy], 
			[dtUpdated], 
			[szUpdatedBy]
		FROM
			tblTBVACLog (NOLOCK)
		WHERE
			((@iTBVACLogID IS NULL) OR (iTBVACLogID = @iTBVACLogID)) AND
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
