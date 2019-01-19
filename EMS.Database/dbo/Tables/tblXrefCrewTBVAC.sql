CREATE TABLE [dbo].[tblXrefCrewTBVAC] (
    [iXREFCREWTBVACID] INT          IDENTITY (1, 1) NOT NULL,
    [iTBVACLogID]      INT          NOT NULL,
    [iCrewTypeID]      INT          NOT NULL,
    [iCrewID]          INT          NOT NULL,
    [bIsActive]        BIT          CONSTRAINT [DF_tblXrefCrewTBVAC_bIsActive] DEFAULT ((1)) NOT NULL,
    [dtInserted]       DATETIME     CONSTRAINT [DF_tblXrefCrewTBVAC_dtInserted] DEFAULT (getdate()) NOT NULL,
    [szInsertedBy]     VARCHAR (64) NOT NULL,
    [dtUpdated]        DATETIME     NULL,
    [szUpdatedBy]      VARCHAR (64) NULL,
    CONSTRAINT [PK_tblXrefCrewTBVAC] PRIMARY KEY CLUSTERED ([iXREFCREWTBVACID] ASC),
    CONSTRAINT [FK_tblXrefCrewTBVAC_tblCrew1] FOREIGN KEY ([iCrewID]) REFERENCES [dbo].[tblCrew] ([iCrewID]),
    CONSTRAINT [FK_tblXrefCrewTBVAC_tblCrewType1] FOREIGN KEY ([iCrewTypeID]) REFERENCES [dbo].[tblCrewType] ([iCrewTypeID]),
    CONSTRAINT [FK_tblXrefCrewTBVAC_tblTBVACLog1] FOREIGN KEY ([iTBVACLogID]) REFERENCES [dbo].[tblTBVACLog] ([iTBVACLogID])
);


GO

CREATE TRIGGER tblXrefCrewTBVAC_ChangeTracking ON tblXrefCrewTBVAC FOR INSERT, UPDATE
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
SELECT @TableName = 'tblXrefCrewTBVAC'
 
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
