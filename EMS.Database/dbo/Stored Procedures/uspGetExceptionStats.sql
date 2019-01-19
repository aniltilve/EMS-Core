




-- =============================================
-- Author:           Alex Sadykov
-- Create date: 10/22/2013
-- Description:      Get Exception Stats
-- =============================================
CREATE PROCEDURE [dbo].[uspGetExceptionStats](
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
       --,@dtEndDate DATETIME = '10/31/2013'
       
       --SELECT @Year = iYearNo FROM tblTBVACSeq
       SELECT tl.dtDate
                     , iSeqNumID
                     , tt.szName
                     , tc.szCPRDesc
                     , tl.bEpiPen
                     , tl.bNarcan
                     , tl.bStork
                     , tl.bIncidentReport
                     FROM tblTBVACLog tl 
                     INNER JOIN tblTowns tt
                     ON tl.iTownID = tt.iTownID
                     INNER JOIN tblCPRType tc
                     ON tl.iCPRID = tc.iCPRID
                     WHERE 
					 tl.iAgencyID = @iAgencyID 
					 and tl.dtDate >= @dtStartDate
                     AND tl.dtDate <= @dtEndDate
					 and tl.bIsActive = 1 
                     AND (tl.iCPRID IN ('2','3') 
                     OR bEpiPen = 1  
                     or bNarcan = 1 
                     OR bStork = 1 
                     OR bIncidentReport = 1)
                                         
END




