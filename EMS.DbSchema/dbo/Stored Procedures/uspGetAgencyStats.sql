
CREATE procedure [dbo].[uspGetAgencyStats]
(
	 @StartDate datetime, 
	 @EndtDate datetime 
)
As 
Begin 
		declare @AgencyStat table (
			iAgencyId int not null primary key,
			iNumberOfCalls int,
			iNumberOfUsers int,
			iNextCallNumber int 
		)

		--Insert Agency 
		insert into @AgencyStat(iAgencyId)
		select iAgencyID
		from tblAgency a (nolock) 
		where a.bIsActive = 1

		update st
		set st.iNumberOfUsers = c.Nos,
			st.iNextCallNumber = se.iSeqNumID,
			st.iNumberOfCalls = l.Nos
		from @AgencyStat st 
		inner join (
			select c.iAgencyID, count(c.iAgencyID) Nos
			from [dbo].[tblCrew] c (nolock)   
			where c.bIsActive = 1 
			group by c.iAgencyID) c on c.iAgencyID = st.iAgencyID
		inner join (
			select l.iAgencyID, count(l.iAgencyID) Nos
			from [dbo].[tblTBVACLog] l (nolock)   
			where l.bIsActive = 1 and 
				  l.dtDate between @StartDate and @EndtDate
			group by l.iAgencyID) l on l.iAgencyID = st.iAgencyID
		left join [dbo].[tblTBVACSeq] se (nolock) on se.iAgencyID = st.iAgencyID
			and se.iYearNo = year(getdate())

		select 
			st.iAgencyId,
			a.szShortName,
			a.szName,
			iNumberOfCalls,
			iNumberOfUsers,
			iNextCallNumber 
		 from @AgencyStat st
		 join [dbo].[tblAgency] a on st.iAgencyId = a.iAgencyID 
		 order by szName
End 



