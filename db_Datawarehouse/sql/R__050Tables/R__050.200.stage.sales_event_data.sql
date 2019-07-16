DROP TABLE IF EXISTS stage.sales_event_data ;

CREATE TABLE stage.sales_event_data  (
	event_id INT IDENTITY (1,1),
	event_data NVARCHAR(MAX) NOT NULL
)