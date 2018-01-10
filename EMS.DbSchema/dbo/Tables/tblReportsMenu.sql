CREATE TABLE [dbo].[tblReportsMenu] (
    [iReportID]         INT          IDENTITY (1, 1) NOT NULL,
    [szControllerName]  VARCHAR (64) NOT NULL,
    [szActionName]      VARCHAR (64) NOT NULL,
    [szReportTitle]     VARCHAR (64) NOT NULL,
    [szReportSubTitle]  VARCHAR (64) NULL,
    [bActive]           BIT          NOT NULL,
    [szLabel]           VARCHAR (64) NOT NULL,
    [iOrder]            INT          NOT NULL,
    [iGroupID]          INT          NOT NULL,
    [bMemberTypeSelect] BIT          CONSTRAINT [DF_tblReportsMenu_bMemberTypeSelect] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_tblReportsMenu] PRIMARY KEY CLUSTERED ([iReportID] ASC)
);

