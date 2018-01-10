

-- =============================================
-- Author:		Alex Sadykov
-- Create date: 10/22/2013
-- Description:	Get Yearly Activity All
-- =====================================================
--
--
--Alex S	12/27/2013 Fixed Crosstab to SUM Total Calls 
-- =====================================================
CREATE PROCEDURE [dbo].[uspGetYearlyActivityAll](
	@iAgencyId int ,
	@dtStartDate DATETIME
	,@dtEndDate DATETIME
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	
	--DECLARE @dtStartDate DATETIME = '10/01/2013'
	--,@dtEndDate DATETIME = '12/31/2013'
	SELECT szFullName AS 'NAME'
    ,[January]=MAX(CASE WHEN [Month]= 1 THEN [Total Calls] ELSE 0 END) 
    ,[February]=MAX(CASE WHEN [Month]= 2 THEN [Total Calls] ELSE 0 END) 
    ,[March]=MAX(CASE WHEN [Month]= 3 THEN [Total Calls] ELSE 0 END) 
    ,[April]=MAX(CASE WHEN [Month]= 4 THEN [Total Calls] ELSE 0 END) 
    ,[May]=MAX(CASE WHEN [Month]= 5 THEN [Total Calls] ELSE 0 END) 
    ,[June]=MAX(CASE WHEN [Month]= 6 THEN [Total Calls] ELSE 0 END) 
    ,[July]=MAX(CASE WHEN [Month]= 7 THEN [Total Calls] ELSE 0 END) 
    ,[August]=MAX(CASE WHEN [Month]= 8 THEN [Total Calls] ELSE 0 END) 
    ,[September]=MAX(CASE WHEN [Month]= 9 THEN [Total Calls] ELSE 0 END) 
    ,[October]=MAX(CASE WHEN [Month]=10 THEN [Total Calls] ELSE 0 END) 
    ,[November]=MAX(CASE WHEN [Month]=11 THEN [Total Calls] ELSE 0 END) 
    ,[December]=MAX(CASE WHEN [Month]=12 THEN [Total Calls] ELSE 0 END) 
    ,[Total Calls]=SUM([Total Calls])
    ,[Total Hours]=STUFF(CONVERT(VARCHAR(8), CAST(DATEADD(minute, SUM([minutes])%60, 0) AS DATETIME), 108),1,2,SUM([Minutes]/60))
	FROM (
		SELECT SUM(x.[Total Calls]) AS [Total Calls]
		,SUM(MINUTES) AS MINUTES
		,x.[MONTH],x.[szFullName]
		FROM(
		SELECT COUNT(txref.iTBVACLogID) AS 'Total Calls'
		,SUM(DATEPART(hh, CAST(tbl.tTimeTotal AS DATETIME))* 60 + DATEPART(MINUTE, CAST(tbl.tTimeTotal AS DATETIME))) AS 'minutes'
		,CAST(DATEPART(MONTH, tbl.[dtdate]) AS INT) AS [MONTH]
		,tc.szFullName
		FROM [dbo].[tblTBVACLog] tbl
		INNER JOIN tblXrefCrewTBVAC txref ON tbl.iTBVACLogID = txref.iTBVACLogID  and  txref.bIsActive = 1
		INNER JOIN tblCrew tc ON txref.iCrewID = tc.iCrewID
		WHERE tbl.iagencyid = @iAgencyId and 
		tbl.dtDate >= @dtStartDate
		AND tbl.dtDate <= @dtEndDate
		GROUP BY tc.szFullName,tbl.[dtdate]) AS x
		GROUP BY x.szFullName,x.[month]) src
	GROUP BY szFullName;
		
END


