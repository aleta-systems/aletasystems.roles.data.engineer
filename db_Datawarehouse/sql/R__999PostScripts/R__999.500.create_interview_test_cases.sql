EXEC tSQLt.NewTestClass @ClassName = N'Interview' ; -- nvarchar(max)
GO

-- TestCase [1]
DROP PROCEDURE IF EXISTS Interview.[test that etl.usp_load_event loads event_id 1] ;
GO
CREATE PROCEDURE Interview.[test that etl.usp_load_event loads event_id 1]
AS
BEGIN

    DECLARE @event_id INT = 1 ;
	DECLARE @expected NVARCHAR(100) = N'Autumn Lam' , @actual NVARCHAR(100) = NULL

	-- PREPARE 
    EXEC tSQLt.FakeTable
        @TableName = N'stage' -- nvarchar(max)
      , @SchemaName = N'sales_event_data' ; -- nvarchar(max)

    EXEC etl.usp_load_event @event_id = @event_id ; -- int

	-- EXECUTE 
    SELECT 
		@actual = Customer.customer_name
    FROM
        stage.sales_event_data
   CROSS APPLY
        OPENJSON( event_data )
        WITH (customer_id INT '$.customer[0].customer_id', customer_name NVARCHAR( 200 ) '$.customer[0].customer_name') AS Customer
    WHERE
        Customer.customer_id = 95 AND event_id = @event_id ;

	-- ASSERT 

	EXEC tSQLt.AssertEqualsString
	    @Expected = @expected -- nvarchar(max)
	  , @Actual = @actual -- nvarchar(max)
	  , @Message = N'The Loaded Event (1) data does not contain `Autumn Lam`' -- nvarchar(max)
	
END ;
GO

-- TestCase [2]
DROP PROCEDURE IF EXISTS Interview.[test SCD2 works for Autumn Lam];
GO
CREATE PROCEDURE Interview.[test SCD2 works for Autumn Lam]
AS
BEGIN

    DECLARE @customer_nk INT = 95 ;
	DECLARE @expected NVARCHAR(100) = N'Autumn Lam' , @actual NVARCHAR(100) = NULL
	DECLARE @false BIT = 0 , @is_current_flag BIT
	
	-- PREPARE 

    
	-- EXECUTE 
    SELECT TOP 1
		@actual = customer_name , @is_current_flag=is_current_flag
	FROM sales.dim_customer
	WHERE customer_nk = @customer_nk
	ORDER BY customer_sk ASC



	-- ASSERT 
	EXEC tSQLt.AssertEqualsString
	    @Expected = @expected -- nvarchar(max)
	  , @Actual = @actual -- nvarchar(max)
	  , @Message = N'The customer_name for customer_id:95 in the first load is wrong' -- nvarchar(max)
	
	EXEC tSQLt.AssertEquals
	    @Expected = @false-- sql_variant
	  , @Actual = @is_current_flag -- sql_variant
	  , @Message = N'The is_current_flag for customer_id:95 should be false' -- nvarchar(max)
	
END ;
GO