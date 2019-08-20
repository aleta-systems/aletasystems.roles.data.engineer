-- SEED DATA

TRUNCATE TABLE etl.input_file;

INSERT INTO etl.input_file (file_path, business_date)
VALUES (N'/json-data-files/event_1.json','2018-05-15')
     , (N'/json-data-files/event_2.json','2018-05-16')
     , (N'/json-data-files/event_3.json','2018-05-17')
     , (N'/json-data-files/event_4.json','2018-05-18')
     , (N'/json-data-files/event_5.json','2018-05-19') ;