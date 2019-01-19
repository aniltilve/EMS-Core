CREATE TABLE [emsuser].[tblXrefCrewTBVAC_08232014] (
    [iXREFCREWTBVACID] INT          IDENTITY (1, 1) NOT NULL,
    [iTBVACLogID]      INT          NOT NULL,
    [iCrewTypeID]      INT          NOT NULL,
    [iCrewID]          INT          NOT NULL,
    [bIsActive]        BIT          NOT NULL,
    [dtInserted]       DATETIME     NOT NULL,
    [szInsertedBy]     VARCHAR (64) NOT NULL,
    [dtUpdated]        DATETIME     NULL,
    [szUpdatedBy]      VARCHAR (64) NULL
);

