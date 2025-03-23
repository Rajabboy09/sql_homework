--1
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql = @sql + 
'SELECT 
    ''' + name + ''' AS DatabaseName, 
    s.name AS SchemaName, 
    t.name AS TableName, 
    c.name AS ColumnName, 
    ty.name AS DataType 
FROM ' + QUOTENAME(name) + '.sys.schemas s
JOIN ' + QUOTENAME(name) + '.sys.tables t ON s.schema_id = t.schema_id
JOIN ' + QUOTENAME(name) + '.sys.columns c ON t.object_id = c.object_id
JOIN ' + QUOTENAME(name) + '.sys.types ty ON c.user_type_id = ty.user_type_id
UNION ALL '
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

-- Remove the last "UNION ALL"
SET @sql = LEFT(@sql, LEN(@sql) - 10);

-- Execute the dynamically generated query
EXEC sp_executesql @sql;

--2
CREATE PROCEDURE GetProceduresAndFunctionsInfo
    @DatabaseName NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = '';

    -- If a specific database is provided, retrieve only from that database
    IF @DatabaseName IS NOT NULL
    BEGIN
        SET @sql = '
        SELECT 
            ''' + @DatabaseName + ''' AS DatabaseName,
            s.name AS SchemaName, 
            o.name AS RoutineName, 
            p.name AS ParameterName, 
            t.name AS DataType,
            p.max_length AS MaxLength
        FROM ' + QUOTENAME(@DatabaseName) + '.sys.objects o
        JOIN ' + QUOTENAME(@DatabaseName) + '.sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN ' + QUOTENAME(@DatabaseName) + '.sys.parameters p ON o.object_id = p.object_id
        LEFT JOIN ' + QUOTENAME(@DatabaseName) + '.sys.types t ON p.user_type_id = t.user_type_id
        WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'');';  -- P: Stored Procedure, FN: Scalar Function, IF: Inline Table Function, TF: Table Function
    END
    ELSE
    BEGIN
        -- Generate dynamic SQL for all user databases
        SELECT @sql = @sql + '
        SELECT 
            ''' + name + ''' AS DatabaseName,
            s.name AS SchemaName, 
            o.name AS RoutineName, 
            p.name AS ParameterName, 
            t.name AS DataType,
            p.max_length AS MaxLength
        FROM ' + QUOTENAME(name) + '.sys.objects o
        JOIN ' + QUOTENAME(name) + '.sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN ' + QUOTENAME(name) + '.sys.parameters p ON o.object_id = p.object_id
        LEFT JOIN ' + QUOTENAME(name) + '.sys.types t ON p.user_type_id = t.user_type_id
        WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'')
        UNION ALL ' 
        FROM sys.databases 
        WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

        -- Remove the last "UNION ALL"
        SET @sql = LEFT(@sql, LEN(@sql) - 10);
    END

    -- Execute the dynamically generated SQL
    EXEC sp_executesql @sql;
END;
EXEC GetProceduresAndFunctionsInfo @DatabaseName = 'class8';
EXEC GetProceduresAndFunctionsInfo;

