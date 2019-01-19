


-- =============================================
-- Author:		Alex Sadykov
-- Create date: 08/19/2014
-- Description:	Get Hour by hour Activity All
-- =====================================================
--
--
--Alex S	08/19/2014 Fixed Hours and Minutes
--Alex S	08/20/2014 Removed Total Hours
--Alex S	08/25/2014 Fixed time intervals
--Alex S	03/11/2015 Fixed overlapped calls
--Alex S	06/01/2015 Added tblXrefCrewTBVAC.bIsActive = 1
-- =====================================================
CREATE PROCEDURE [dbo].[uspGetHourByHourActivityAll](
	@iAgencyId int ,
	@dtStartDate DATETIME
	,@dtEndDate DATETIME
	)
AS
BEGIN TRY
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	
	--DECLARE @dtStartDate DATETIME = '07/01/2014'
	--,@dtEndDate DATETIME = '07/31/2014'
	--,@iAgencyID INT = 3

SELECT szFullName AS 'NAME'
    ,[12_04] = SUM(CASE WHEN [MINUTES] BETWEEN 1    AND 239 THEN [Calls] ELSE 0 END)
    ,[04_08] = SUM(CASE WHEN [MINUTES] BETWEEN 240  AND 479 THEN [Calls] ELSE 0 END)
    ,[08_12] = SUM(CASE WHEN [MINUTES] BETWEEN 480  AND 719 THEN [Calls] ELSE 0 END)
    ,[12_16] = SUM(CASE WHEN [MINUTES] BETWEEN 720  AND 999 THEN [Calls] ELSE 0 END)
    ,[16_20] = SUM(CASE WHEN [MINUTES] BETWEEN 1000 AND 1239 THEN [Calls] ELSE 0 END)
    ,[20_24] = SUM(CASE WHEN [MINUTES] BETWEEN 1240 AND 1480 THEN [Calls] ELSE 0 END)
    , count([Calls]) AS 'Total_Calls'
   
    FROM (
        SELECT 1 'Calls'
        ,DATEPART(hh, CAST(tbl.tTimeDispatch AS DATETIME))* 60 + DATEPART(MINUTE, CAST(tbl.tTimeDispatch AS DATETIME)) AS 'minutes'
        ,tbl.dtTimeStart
        ,tc.szFullName
        FROM [dbo].[tblTBVACLog] tbl
        INNER JOIN tblXrefCrewTBVAC txref ON tbl.iTBVACLogID = txref.iTBVACLogID --AND txref.iCrewTypeID = 1
			and  txref.bIsActive = 1
        INNER JOIN tblCrew tc ON txref.iCrewID = tc.iCrewID AND txref.bIsActive = 1
        WHERE
        tbl.iAgencyID = @iAgencyId
        and tbl.dtDate >= @dtStartDate
        AND tbl.dtDate <= @dtEndDate
        ) src
    GROUP BY szFullName

	--SELECT szFullName AS 'NAME'
 --   ,[12_04] = SUM(CASE WHEN [MINUTES] BETWEEN 1    AND 239 THEN [Total Calls] ELSE 0 END)
	--,[04_08] = SUM(CASE WHEN [MINUTES] BETWEEN 240  AND 479 THEN [Total Calls] ELSE 0 END)
 --   ,[08_12] = SUM(CASE WHEN [MINUTES] BETWEEN 480  AND 719 THEN [Total Calls] ELSE 0 END) 
 --   ,[12_16] = SUM(CASE WHEN [MINUTES] BETWEEN 720  AND 999 THEN [Total Calls] ELSE 0 END)
 --   ,[16_20] = SUM(CASE WHEN [MINUTES] BETWEEN 1000 AND 1239 THEN [Total Calls] ELSE 0 END) 
 --   ,[20_24] = SUM(CASE WHEN [MINUTES] BETWEEN 1240 AND 1480 THEN [Total Calls] ELSE 0 END)
 --   ,[Total_Calls] = SUM([Total Calls])
	--FROM (
	--	SELECT COUNT(txref.iTBVACLogID) AS 'Total Calls'
	--	,SUM(DATEPART(hh, CAST(tbl.tTimeDispatch AS DATETIME))* 60 + DATEPART(MINUTE, CAST(tbl.tTimeDispatch AS DATETIME))) AS 'minutes'
	--	,tbl.dtTimeStart
	--	,tc.szFullName
	--	FROM [dbo].[tblTBVACLog] tbl
	--	INNER JOIN tblXrefCrewTBVAC txref ON tbl.iTBVACLogID = txref.iTBVACLogID --AND txref.iCrewTypeID = 1
	--	INNER JOIN tblCrew tc ON txref.iCrewID = tc.iCrewID
	--	WHERE 
	--	tbl.iAgencyID = @iAgencyId
	--	and tbl.dtDate >= @dtStartDate
	--	AND tbl.dtDate <= @dtEndDate
	--	GROUP BY tc.szFullName,tbl.[dtTimeStart]) src
	--GROUP BY szFullName

END TRY

BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber
     ,ERROR_SEVERITY() AS ErrorSeverity
     ,ERROR_STATE() AS ErrorState
     ,ERROR_PROCEDURE() AS ErrorProcedure
     ,ERROR_LINE() AS ErrorLine
     ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH



