DROP PROCEDURE IF EXISTS etl.usp_load_event ;
GO

CREATE PROCEDURE etl.usp_load_event @event_id AS INT
AS
BEGIN
    SET NOCOUNT ON ;

    BEGIN TRY
        DECLARE
            @file_path    NVARCHAR(100)
          , @is_processed BIT ;

        DECLARE @dySQL NVARCHAR(MAX) ;

        SELECT @file_path = file_path, @is_processed = is_processed FROM etl.input_file WHERE event_id = @event_id ;

        DELETE FROM stage.sales_event_data WHERE event_id = @event_id ;

        SET @dySQL = 
			'INSERT stage.sales_event_data (event_id,event_data)
			 SELECT ' + @event_id + N',B.BulkColumn
			 FROM OPENROWSET( BULK '+  QUOTENAME( @file_path, N'''' )+ ', SINGLE_CLOB ) AS B;' 
			 

        EXEC (@dySQL) ;

    END TRY
    BEGIN CATCH
        THROW ;
    END CATCH ;
END ;
GO
