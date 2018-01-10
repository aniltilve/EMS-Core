



-- =============================================
-- Author:		Alex Sadykov
-- Create date: 10/22/2013
-- Description:	Get Monthly Call Stats By Town
-- =============================================
CREATE PROCEDURE [dbo].[uspGetMonthlyCallStatsByTown] (
	@iAgencyID int, 
	@dtStartDate DATETIME
	,@dtEndDate DATETIME
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON

	--DECLARE @dtStartDate DATETIME = '10/01/2013'
	--	,@dtEndDate DATETIME = '10/31/2013'
	
	SELECT 
		tt.szName
		,x.Calls as 'Calls'
		,x.Miles as 'Miles'
		,RIGHT('0' + CAST((x.[Total Minutes] / 60) AS VARCHAR(8)),2)+ ':' + RIGHT('0' + CAST((x.[Total Minutes] % 60) AS VARCHAR(2)), 2) AS 'Hours'
		,RIGHT('0' + CAST((x.[Crew Total Minutes] / 60) AS VARCHAR(8)),2) + ':' + RIGHT('0' + CAST((x.[Crew Total Minutes] % 60) AS VARCHAR(2)), 2) AS 'Crew Hours'
	FROM (
	SELECT tbl.itownid
		,COUNT(tbl.iTBVACLogID) AS 'Calls'
		,SUM(tbl.dMilesTotal) AS 'Miles'
		,SUM(DATEPART(hh, Cast(tbl.tTimeTotal AS DATETIME))* 60 + DATEPART(MINUTE, Cast(tbl.tTimeTotal AS DATETIME))) AS 'Total Minutes'
		,SUM(ctxref.crewcount * (DATEPART(hh, Cast(tbl.tTimeTotal AS DATETIME))* 60 + DATEPART(MINUTE, Cast(tbl.tTimeTotal AS DATETIME)))) AS 'Crew Total Minutes'
	FROM tblTBVACLog tbl
	INNER JOIN(SELECT ITBVACLogID,COUNT(iCrewID) as CrewCount FROM tblXrefCrewTBVAC where bIsActive = 1 GROUP BY ITBVACLogID) as ctxref 
	ON ctxref.iTBVACLogID = tbl.iTBVACLogID
	WHERE 
		tbl.iAgencyID = @iAgencyID
		and tbl.dtDate >= @dtStartDate
		AND tbl.dtDate <= @dtEndDate
		and tbl.bIsActive = 1 
	GROUP BY tbl.itownid
	) AS x
	INNER JOIN tblTowns tt ON x.itownid=tt.itownid
END



