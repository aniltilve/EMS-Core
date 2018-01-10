




-- =============================================
-- Author:		Mandar Tilve
-- Create date: 11/11/2013
-- Description:	Audit Report
-- =============================================
CREATE PROCEDURE [dbo].[uspAuditLog] (
	@iAgencyID int , 
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
		l.iSeqNumID
		, l.dtDate
		, c.szFullName
		, ct.szName
	from 
		tblTBVACLog (nolock) l 
	join tblXrefCrewTBVAC (nolock) cl  on l.iTBVACLogID = cl.iTBVACLogID and cl.bisactive = 1 
	join tblCrew (nolock) c on c.iCrewID  = cl.iCrewID and c.bisactive = 1 
	join tblCrewType (nolock) ct on ct.iCrewTypeID = cl.iCrewTypeID
	where l.dtDate >= @dtStartDate and l.dtdate <= @dtEndDate and 
	l.iAgencyID = @iAgencyID   and l.bisactive = 1 
	order by l.dtDate,l.iSeqNumID


END





