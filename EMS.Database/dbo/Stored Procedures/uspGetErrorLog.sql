



  CREATE  PROCEDURE [dbo].[uspGetErrorLog]
  (
		@iAgencyID INT,
		@dtFromtDate DATETIME = NULL,
		@dtToDate DATETIME = NULL
  )
  AS
  BEGIN
	SET NOCOUNT ON 

	SET @dtFromtDate =CAST(ISNULL(@dtFromtDate,GETDATE()) AS DATE)
	SET @dtToDate =CAST(ISNULL(@dtToDate,GETDATE())  AS DATE)

	SELECT 
		iAgencyID
	,	dtInserted
	,	szController
	,	szAction
	,	szErrorText
	FROM 
		[dbo].[tblErrorLog] (NOLOCK)
	WHERE 
		CAST(dtInserted AS DATE)  BETWEEN @dtFromtDate AND @dtToDate
		AND ((@iAgencyID = 0 AND iAgencyID IS NULL) OR ( iAgencyID = @iAgencyID))
	ORDER BY dtInserted ASC
  END 




