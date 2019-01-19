





CREATE procedure [dbo].[uspGetMonthlyStatisticalAnalysisSummary]
(
	   @iAgencyID int,
       @dtStartDate datetime,
       @dtEndDate datetime
)
as 
 begin 
     
        declare @StatSummary table (
              SummaryType int,
              SortOrder int,
              szDesc varchar(64),
              Value int,
              CallNumber varchar(16) null
       )



    insert into @StatSummary 
       select top 1  
                     1,
                     1,
                 'Fastest In Service Time',
                 DATEDIFF(mi,dtDispatch,dtTimeStart) InMinitue,
                     m.CallNumber
                     
       from ( 
       select 
                     RIGHT(CONVERT(VARCHAR(8), dtDate, 1),2) + '-' + STUFF('0000',4-LEN(iSeqNumID)+1,LEN(iSeqNumID),iSeqNumID) CallNumber
              ,      CAST(CAST(dtDate AS DATE) AS DATETIME) +
                           CAST(tTimeDispatch AS DATETIME)   dtDispatch    
              ,      dtTimeStart
              ,      dtTimeEnd
       from [dbo].[tblTBVACLog] (nolock)
       where  iAgencyID = @iAgencyID and 
              dtDate >= @dtStartDate and dtDate <= @dtEndDate and bNoTransport = 0 and bIsActive = 1  ) m
       order by InMinitue asc 
       -- union
       insert into @StatSummary 
       select top 1  
                     1,
                     2,
                 'Slowest In Service Time',
                 DATEDIFF(mi,dtDispatch,dtTimeStart) InMinitue,
                     m.CallNumber
                     
       from ( 
       select 
                     RIGHT(CONVERT(VARCHAR(8), dtDate, 1),2) + '-' + STUFF('0000',4-LEN(iSeqNumID)+1,LEN(iSeqNumID),iSeqNumID) CallNumber
              ,      CAST(CAST(dtDate AS DATE) AS DATETIME) +
                           CAST(tTimeDispatch AS DATETIME)   dtDispatch    
              ,      dtTimeStart
              ,      dtTimeEnd
       from [dbo].[tblTBVACLog] (nolock)
       where 
			  iAgencyID = @iAgencyID and 
              dtDate >= @dtStartDate and dtDate <= @dtEndDate and bNoTransport = 0 and bIsActive = 1) m
       order by InMinitue desc 

         insert into @StatSummary 
         select top 1  
                     1,
                     3,
                 'Average  In Service Time',
                     m.average,
                 ''  
              from ( 

			  
					select AVG(DATEDIFF(mi,CAST(CAST(dtDate AS DATE) AS DATETIME) +  CAST(tTimeDispatch AS DATETIME),dtTimeStart))average
					from [dbo].[tblTBVACLog] (nolock)
					where iAgencyID = @iAgencyID and 
						dtDate >= @dtStartDate and dtDate <= @dtEndDate and bNoTransport = 0  and bIsActive = 1
                     /*select AVG(Value) average
                     from @StatSummary 
                     where SummaryType = 1 */
                     ) m
              



       insert into @StatSummary 
       select top 1  
                     2,
                     1,
                 'Shortest Call',
                 DATEDIFF(mi,dtDispatch,dtTimeEnd) InMinitue,
                     m.CallNumber
                     
       from ( 
       select 
                     RIGHT(CONVERT(VARCHAR(8), dtDate, 1),2) + '-' + STUFF('0000',4-LEN(iSeqNumID)+1,LEN(iSeqNumID),iSeqNumID) CallNumber
              ,      CAST(CAST(dtDate AS DATE) AS DATETIME) +
                           CAST(tTimeDispatch AS DATETIME)   dtDispatch    
              ,      dtTimeStart
              ,      dtTimeEnd
       from [dbo].[tblTBVACLog] (nolock)
       where  iAgencyID = @iAgencyID and 
              dtDate >= @dtStartDate and dtDate <= @dtEndDate and bNoTransport = 0 and bIsActive = 1) m
       order by InMinitue asc 
       -- union
       insert into @StatSummary 
       select top 1  
                     2,
                     2,
                 'Longest Call',
                 DATEDIFF(mi,dtDispatch,dtTimeEnd) InMinitue,
                     m.CallNumber
                     
       from ( 
       select 
                     RIGHT(CONVERT(VARCHAR(8), dtDate, 1),2) + '-' + STUFF('0000',4-LEN(iSeqNumID)+1,LEN(iSeqNumID),iSeqNumID) CallNumber
              ,      CAST(CAST(dtDate AS DATE) AS DATETIME) +
                           CAST(tTimeDispatch AS DATETIME)   dtDispatch    
              ,      dtTimeStart
              ,      dtTimeEnd
       from [dbo].[tblTBVACLog] (nolock)
       where iAgencyID = @iAgencyID and 
              dtDate >= @dtStartDate and dtDate <= @dtEndDate and bNoTransport = 0 and bIsActive = 1) m
       order by InMinitue desc 


         insert into @StatSummary 
         select top 1  
                     2,
                     3,
                 'Average  Call Length',
                     m.average,
                 ''
                     
              from ( 

					select AVG( DATEDIFF(mi,CAST(CAST(dtDate AS DATE) AS DATETIME) +
                           CAST(tTimeDispatch AS DATETIME)  ,dtTimeEnd))average
					from [dbo].[tblTBVACLog] (nolock)
					where iAgencyID = @iAgencyID and 
						dtDate >= @dtStartDate and dtDate <= @dtEndDate and bNoTransport = 0 and bIsActive = 1


                     /*select AVG(Value) average
                     from @StatSummary 
                     where SummaryType = 2 */
                     ) m
              


       insert into @StatSummary 
       select top 1  
                     3,
                     1,
                 'High Mileage',
                 dMilesEnd - dMilesStart as TotalMiles,
                     m.CallNumber
                     
       from ( 
       select 
                     RIGHT(CONVERT(VARCHAR(8), dtDate, 1),2) + '-' + STUFF('0000',4-LEN(iSeqNumID)+1,LEN(iSeqNumID),iSeqNumID) CallNumber
              ,      CAST(CAST(dtDate AS DATE) AS DATETIME) +
                           CAST(tTimeDispatch AS DATETIME)   dtDispatch    
              ,      dMilesEnd
              ,      dMilesStart
       from [dbo].[tblTBVACLog] (nolock)
       where iAgencyID = @iAgencyID and 
              dtDate >= @dtStartDate and dtDate <= @dtEndDate  and bNoTransport = 0 and bIsActive = 1) m
       order by TotalMiles desc 

       insert into @StatSummary 
       select top 1  
                     3,
                     2,
                 'Low Mileage',
                 dMilesEnd - dMilesStart as TotalMiles,
                     m.CallNumber
                     
       from ( 
       select 
                     RIGHT(CONVERT(VARCHAR(8), dtDate, 1),2) + '-' + STUFF('0000',4-LEN(iSeqNumID)+1,LEN(iSeqNumID),iSeqNumID) CallNumber
              ,      CAST(CAST(dtDate AS DATE) AS DATETIME) +
                           CAST(tTimeDispatch AS DATETIME)   dtDispatch    
              ,      dMilesEnd
              ,      dMilesStart
       from [dbo].[tblTBVACLog] (nolock)
       where iAgencyID = @iAgencyID and 
              dtDate >= @dtStartDate and dtDate <= @dtEndDate and bNoTransport = 0 and bIsActive = 1 ) m
       order by TotalMiles asc 

       insert into @StatSummary 
         select top 1  
                     3,
                     3,
                 'Average Mileage',
                     m.average,
                 ''
                     
              from ( 


					select AVG(dMilesEnd - dMilesStart) average
					from [dbo].[tblTBVACLog] (nolock)
					where iAgencyID = @iAgencyID and 
						dtDate >= @dtStartDate and dtDate <= @dtEndDate and bNoTransport = 0  and bIsActive = 1

                     /*select AVG(Value) average
                     from @StatSummary 
                     where SummaryType = 3 */
                     ) m
                     
       --select * from      @StatSummary         
       select
              x.SummaryType,
              x.SortOrder,
              x.szDesc,
              case 
                     when SummaryType = 1 or  SummaryType = 2  then 
                           right('0' + convert(varchar,x.Value / 60),2) + ':' + right('0' + convert(varchar,x.Value % 60),2)
                     else 
                            convert(varchar,x.Value)
              end Value,
              x.CallNumber
       from @StatSummary x
       
                           
                     
              
              
        

       

End 
       









