CREATE TABLE [dbo].[tblTBVACLog] (
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
    [bEpiPen]            BIT          CONSTRAINT [DF_tblTBVacLog_bEpiPen] DEFAULT ((0)) NOT NULL,
    [bStork]             BIT          CONSTRAINT [DF_tblTBVacLog_bStork] DEFAULT ((0)) NOT NULL,
    [bIncidentReport]    BIT          CONSTRAINT [DF_tblTBVACLog_bIncidentReport] DEFAULT ((0)) NOT NULL,
    [bNoTransport]       BIT          NOT NULL,
    [bNarcan]            BIT          NOT NULL,
    [bEmailSend]         BIT          NOT NULL,
    [sFootBallExtraCode] CHAR (1)     NULL,
    [szExtraDesc]        VARCHAR (24) NULL,
    [bIsActive]          BIT          CONSTRAINT [DF_tblTBVACLog_bIsActive] DEFAULT ((1)) NOT NULL,
    [dtInserted]         DATETIME     CONSTRAINT [DF_tblTBVACLog_dtInserted] DEFAULT (getdate()) NULL,
    [szInsertedBy]       VARCHAR (64) NULL,
    [dtUpdated]          DATETIME     NULL,
    [szUpdatedBy]        VARCHAR (64) NULL,
    CONSTRAINT [PK_tblTBVACLog_1] PRIMARY KEY CLUSTERED ([iTBVACLogID] ASC),
    CONSTRAINT [FK_tblTBVACLog_tblAgency] FOREIGN KEY ([iAgencyID]) REFERENCES [dbo].[tblAgency] ([iAgencyID]),
    CONSTRAINT [FK_tblTBVACLog_tblALSType] FOREIGN KEY ([iAlsTypeID]) REFERENCES [dbo].[tblALSType] ([iALSTypeID]),
    CONSTRAINT [FK_tblTBVACLog_tblCallType] FOREIGN KEY ([iCallTypeID]) REFERENCES [dbo].[tblCallType] ([iCallTypeID]),
    CONSTRAINT [FK_tblTBVACLog_tblCPRType1] FOREIGN KEY ([iCPRID]) REFERENCES [dbo].[tblCPRType] ([iCPRID]),
    CONSTRAINT [FK_tblTBVACLog_tblCrew] FOREIGN KEY ([iCrewID]) REFERENCES [dbo].[tblCrew] ([iCrewID]),
    CONSTRAINT [FK_tblTBVACLog_tblDispatchType] FOREIGN KEY ([iDispatchTypeID]) REFERENCES [dbo].[tblDispatchType] ([iDispatchTypeID]),
    CONSTRAINT [FK_tblTBVACLog_tblHospital1] FOREIGN KEY ([iHospitalID]) REFERENCES [dbo].[tblHospital] ([iHospitalID]),
    CONSTRAINT [FK_tblTBVACLog_tblRig] FOREIGN KEY ([iRigID]) REFERENCES [dbo].[tblRig] ([iRigID]),
    CONSTRAINT [FK_tblTBVACLog_tblTowns] FOREIGN KEY ([iTownID]) REFERENCES [dbo].[tblTowns] ([iTownID])
);


GO
CREATE NONCLUSTERED INDEX [ix_tbltbvaclog_dmilestotal]
    ON [dbo].[tblTBVACLog]([dMilesTotal] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_tbltbvaclog_dtdate_bEpiPen_bNarcan_bStork_bIncidentReport_bisactive]
    ON [dbo].[tblTBVACLog]([dtDate] ASC, [bEpiPen] ASC, [bNarcan] ASC, [bStork] ASC, [bIncidentReport] ASC, [bIsActive] ASC);


GO
CREATE NONCLUSTERED INDEX [ix_tbvaclog_dtdate_sfootballextracode_bisactive]
    ON [dbo].[tblTBVACLog]([dtDate] ASC, [sFootBallExtraCode] ASC, [bIsActive] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_DCh_4464_4463_tblTBVACLog]
    ON [dbo].[tblTBVACLog]([iAgencyID] ASC)
    INCLUDE([dtDate]);


GO

CREATE TRIGGER tblTBVACLog_ChangeTracking ON tblTBVACLog FOR INSERT, UPDATE
AS
 
DECLARE @bit INT ,
@field INT ,
@maxfield INT ,
@char INT ,
@fieldname VARCHAR(128) ,
@TableName VARCHAR(128) ,
@PKCols VARCHAR(1000) ,
@sql VARCHAR(2000),
@UpdateDate VARCHAR(21) ,
@UserName VARCHAR(128) ,
@Type CHAR(1) ,
@PKFieldSelect VARCHAR(1000),
@PKValueSelect VARCHAR(1000)

SET NOCOUNT ON 
SELECT @TableName = 'tblTBVACLog'
 
-- Action
IF EXISTS (SELECT * FROM inserted)
IF EXISTS (SELECT * FROM deleted)
SELECT @Type = 'U'
ELSE
SELECT @Type = 'I'
 
-- get list of columns
SELECT * INTO #ins FROM inserted
SELECT * INTO #del FROM deleted
 
-- Get primary key columns for full outer join
SELECT @PKCols = COALESCE(@PKCols + ' aND', ' oN') + ' i.' + c.COLUMN_NAME + ' = d.' + c.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,
INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
WHERE pk.TABLE_NAME = @TableName
AND CONSTRAINT_TYPE = 'PRIMARY KEY'
AND c.TABLE_NAME = pk.TABLE_NAME
AND c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME
 
-- Get primary key fields select for insert
SELECT @PKFieldSelect = COALESCE(@PKFieldSelect+'+','') + '''' + COLUMN_NAME + ''''
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,
INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
WHERE pk.TABLE_NAME = @TableName
AND CONSTRAINT_TYPE = 'PRIMARY KEY'
AND c.TABLE_NAME = pk.TABLE_NAME
AND c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME
 
SELECT @PKValueSelect = COALESCE(@PKValueSelect+'+','') + 'CONVERT(VARCHAR(100), COALESCE(i.' + COLUMN_NAME + ',d.' + COLUMN_NAME + '))'
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk ,
INFORMATION_SCHEMA.KEY_COLUMN_USAGE c
WHERE pk.TABLE_NAME = @TableName
AND CONSTRAINT_TYPE = 'PRIMARY KEY'
AND c.TABLE_NAME = pk.TABLE_NAME
AND c.CONSTRAINT_NAME = pk.CONSTRAINT_NAME

IF (@type = 'U')
	BEGIN
		SELECT @UserName = szUpdatedBy FROM #ins
		SELECT @UpdateDate = dtUpdated FROM #ins
	END
ELSE
	BEGIN
		SELECT @UserName = szInsertedBy FROM #ins
		SELECT @UpdateDate = dtInserted FROM #ins
	END
	 
IF @PKCols IS NULL
BEGIN
RAISERROR('NO PK ON TABLE %s', 16, -1, @TableName)
RETURN
END
 
SELECT @field = 0, @maxfield = MAX(ORDINAL_POSITION) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName
AND COLUMN_NAME NOT IN('dtInserted','szInsertedBy','dtUpdated','szUpdatedBy')
WHILE @field < @maxfield
BEGIN
SELECT @field = MIN(ORDINAL_POSITION) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName AND ORDINAL_POSITION > @field
SELECT @bit = (@field - 1 )% 8 + 1
SELECT @bit = POWER(2,@bit - 1)
SELECT @char = ((@field - 1) / 8) + 1
IF SUBSTRING(COLUMNS_UPDATED(),@char, 1) & @bit > 0 OR @Type IN ('I','U')
BEGIN
SELECT @fieldname = COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName AND ORDINAL_POSITION = @field
SELECT @sql = 'INSERT EMS_Audit.emsdcrt.tblAudit (TYPE, TableName, PrimaryKeyField, PrimaryKeyValue, FieldName, OldValue, NewValue, UpdateDate, UserName)'
SELECT @sql = @sql + ' SELECT ''' + @Type + ''''
SELECT @sql = @sql + ',''' + @TableName + ''''
SELECT @sql = @sql + ',' + @PKFieldSelect
SELECT @sql = @sql + ',' + @PKValueSelect
SELECT @sql = @sql + ',''' + @fieldname + ''''
SELECT @sql = @sql + ',CONVERT(VARCHAR(1000),d.' + @fieldname + ')'
SELECT @sql = @sql + ',CONVERT(VARCHAR(1000),i.' + @fieldname + ')'
SELECT @sql = @sql + ',''' + @UpdateDate + ''''
SELECT @sql = @sql + ',''' + @UserName + ''''
SELECT @sql = @sql + ' FROM #ins i FULL OUTER JOIN #del d'
SELECT @sql = @sql + @PKCols
SELECT @sql = @sql + ' WHERE i.' + @fieldname + ' <> d.' + @fieldname
SELECT @sql = @sql + ' OR (i.' + @fieldname + ' IS NULL AND d.' + @fieldname + ' IS NOT NULL)'
SELECT @sql = @sql + ' OR (i.' + @fieldname + ' IS NOT NULL AND d.' + @fieldname + ' IS NULL)'
EXEC (@sql)
END
END
