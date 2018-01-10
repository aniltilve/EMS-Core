CREATE TABLE [dbo].[tblTBVACSeq] (
    [iAgencyID] INT NOT NULL,
    [iSeqNumID] INT NOT NULL,
    [iYearNo]   INT NOT NULL,
    CONSTRAINT [PK_tblTBVACSeq] PRIMARY KEY CLUSTERED ([iAgencyID] ASC, [iYearNo] ASC),
    CONSTRAINT [FK_tblTBVACSeq_tblAgency] FOREIGN KEY ([iAgencyID]) REFERENCES [dbo].[tblAgency] ([iAgencyID])
);

