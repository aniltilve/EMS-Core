﻿CREATE TABLE [emsdcrt].[tblTBVACLog_04222018] (
    [iTBVACLogID]        INT          IDENTITY (1, 1) NOT NULL,
    [iAgencyID]          INT          NULL,
    [iSeqNumID]          INT          NOT NULL,
    [dtDate]             DATETIME     NOT NULL,
    [iDispatchTypeID]    INT          NOT NULL,
    [iCallTypeID]        INT          NOT NULL,
    [dtTimeStart]        DATETIME     NOT NULL,
    [dtTimeEnd]          DATETIME     NOT NULL,
    [tTimeTotal]         TIME (7)     NOT NULL,
    [dMilesStart]        BIGINT       NOT NULL,
    [dMilesEnd]          BIGINT       NOT NULL,
    [dMilesTotal]        BIGINT       NOT NULL,
    [iTownID]            INT          NOT NULL,
    [iHospitalID]        INT          NOT NULL,
    [iRigID]             INT          NOT NULL,
    [tTimeDispatch]      TIME (7)     NOT NULL,
    [iAlsTypeID]         INT          NOT NULL,
    [iCrewID]            INT          NOT NULL,
    [iCPRID]             INT          NOT NULL,
    [bEpiPen]            BIT          NOT NULL,
    [bStork]             BIT          NOT NULL,
    [bIncidentReport]    BIT          NOT NULL,
    [bNoTransport]       BIT          NOT NULL,
    [bNarcan]            BIT          NOT NULL,
    [bEmailSend]         BIT          NOT NULL,
    [sFootBallExtraCode] CHAR (1)     NULL,
    [szExtraDesc]        VARCHAR (24) NULL,
    [bIsActive]          BIT          NOT NULL,
    [dtInserted]         DATETIME     NULL,
    [szInsertedBy]       VARCHAR (64) NULL,
    [dtUpdated]          DATETIME     NULL,
    [szUpdatedBy]        VARCHAR (64) NULL
);

