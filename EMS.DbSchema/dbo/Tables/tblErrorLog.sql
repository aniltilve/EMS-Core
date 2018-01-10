CREATE TABLE [dbo].[tblErrorLog] (
    [iID]          INT            IDENTITY (1, 1) NOT NULL,
    [iAgencyID]    INT            NULL,
    [dtInserted]   DATETIME       NOT NULL,
    [szController] VARCHAR (128)  NOT NULL,
    [szAction]     VARCHAR (128)  NOT NULL,
    [szErrorText]  NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_tblErrorLog] PRIMARY KEY CLUSTERED ([iID] ASC),
    CONSTRAINT [FK_tblErrorLog_tblAgency] FOREIGN KEY ([iAgencyID]) REFERENCES [dbo].[tblAgency] ([iAgencyID])
);

