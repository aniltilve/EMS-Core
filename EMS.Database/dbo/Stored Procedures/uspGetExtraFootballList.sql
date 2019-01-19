


CREATE procedure [dbo].[uspGetExtraFootballList]
(
	@iAgencyID int,
	@StartDate datetime,
	@EndDate DateTime 
)
As 
Begin 

	--DECLARE @StartDate DATETIME = '05/01/2015'
	--	,@EndDate DATETIME = '05/30/2015'

	select 
			l.iSeqNumID
	,		l.dtDate
	,		case 
				when l.sFootBallExtraCode = 'F' then 'Football Game'
				else 'Extra'
			end szFootBallExtra 
	,		l.szExtraDesc
	,		c.szFullName
	from 
			tblTBVACLog (nolock) l 
	join	tblXrefCrewTBVAC (nolock) cl on l.iTBVACLogID = cl.iTBVACLogID
	join	tblCrew  (nolock) c on c.iCrewID = cl.iCrewID AND cl.bIsActive = 1
	where	l.iAgencyID = 3
	and		l.dtDate between @StartDate and @EndDate
	and		l.sFootBallExtraCode in ('E','F')
	order by l.dtDate 
End 



