



-- =============================================
-- Author:		Alex Sadykov
-- Create date: 10/22/2013
-- Description:	Get Monthly Call Stats
-- =============================================
CREATE PROCEDURE [dbo].[uspGetMonthlyCallStats] (
     @iAgencyID int
	,@dtStartDate DATETIME
	,@dtEndDate DATETIME
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON

	--DECLARE @dtStartDate DATETIME = '10/01/2013'
	--		,@dtEndDate DATETIME = '10/31/2013'
	--SELECT x.[Rig No.]
	--	,x.[Calls Per Rig]
	--	,x.[Miles Per Rig]
	--	,TIMEFROMPARTS(x.Hours, x.Minutes, x.Seconds, 0, 0) AS 'Hours Per Rig'
	--	,x.iAlsTypeID
	--FROM (
	--	SELECT tr.szName AS 'Rig No.'
	--		,Count(tbl.iTBVACLogID) AS 'Calls Per Rig'
	--		,SUM(tbl.dMilesTotal) AS 'Miles Per Rig'
	--		,Sum(datepart(hh, Cast(tbl.tTimeTotal AS DATETIME))) + (sum(datepart(MINUTE, Cast(tbl.tTimeTotal AS DATETIME))) / 60) + (sum(datepart(MINUTE, Cast(tbl.tTimeTotal AS DATETIME))) % 60 + (sum(datepart(SECOND, Cast(tbl.tTimeTotal AS DATETIME))) / 60)) / 60 AS 'Hours'
	--		,(sum(datepart(MINUTE, Cast(tbl.tTimeTotal AS DATETIME))) % 60 + (sum(datepart(SECOND, Cast(tbl.tTimeTotal AS DATETIME))) / 60)) % 60 AS 'Minutes'
	--		,sum(datepart(SECOND, Cast(tbl.tTimeTotal AS DATETIME))) % 60 AS 'Seconds'
	--		,tbl.iAlsTypeID
	--	FROM tblTBVACLog tbl
	--	INNER JOIN tblCallType tct ON tbl.iCallTypeID = tct.iCallTypeID
	--	INNER JOIN tblrig tr ON tbl.iRigID = tr.iRigID
	--	WHERE 1 = 1
	--		AND tbl.dtDate >= @dtStartDate
	--		AND tbl.dtDate <= @dtEndDate
	--		AND tct.szCode = ISNULL(@CallType,tct.szCode)
	--	GROUP BY tr.szName
	--		,tct.szCode
	--		,tbl.iAlsTypeID
	--	) AS x

	SELECT distinct tbllog.iTBVACLogID
			, tbllog.iRigID
			, tbllog.dMilesTotal
			, tbllog.tTimeTotal
			, tbllog.iDispatchTypeID
			, tbllog.iCallTypeID
			, tbllog.iHospitalID
			, tbllog.iAlsTypeID
	FROM tblTBVACLog tbllog
	 join [dbo].[tblXrefCrewTBVAC] x on x.[iTBVACLogID] = tbllog.iTBVACLogID  
	--INNER JOIN tblrig tr 
	--ON tbllog.iRigID = tr.iRigID 
	--INNER JOIN tblDispatchType tdt
	--ON tbllog.iDispatchTypeID=tdt.iDispatchTypeID
	--INNER JOIN tblCallType tct
	--ON tbllog.iCallTypeID=tct.iCallTypeID
	--INNER JOIN tblHospital th
	--ON tbllog.iHospitalID=th.iHospitalID
	--INNER JOIN tblALSType tat
	--on tbllog.iAlsTypeID=tat.iALSTypeID
	WHERE iAgencyId = @iAgencyID and 
	tbllog.dtDate >= @dtStartDate
	AND tbllog.dtDate <= @dtEndDate
	and tbllog.bIsActive = 1 



END



