IF SCHEMA_ID('sales') IS NULL
	EXEC ('CREATE SCHEMA [sales] AUTHORIZATION dbo'); 

IF SCHEMA_ID('stage') IS NULL
	EXEC ('CREATE SCHEMA [stage] AUTHORIZATION dbo'); 