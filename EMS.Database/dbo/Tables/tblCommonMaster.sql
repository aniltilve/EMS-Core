CREATE TABLE [dbo].[tblCommonMaster] (
    [iMasterID] INT          IDENTITY (1, 1) NOT NULL,
    [szType]    VARCHAR (8)  NOT NULL,
    [szCode]    VARCHAR (8)  NULL,
    [szDesc]    VARCHAR (32) NOT NULL
);

