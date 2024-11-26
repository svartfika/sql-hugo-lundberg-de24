DESC;

-- create schemas; containers for tables, records, fields and values
CREATE SCHEMA IF NOT EXISTS ingest;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS warehouse;

-- verify that schemas are created 
SELECT catalog_name, schema_name
FROM information_schema.schemata
WHERE catalog_name = 'salaries';

-- ingest salaries csv data
CREATE TABLE IF NOT EXISTS ingest.salaries AS
SELECT *
FROM 'data/salaries.csv';

-- verify salaries csv data ingestion
DESC;
SUMMARIZE ingest.salaries;

-- rename table, because reasons
ALTER TABLE ingest.salaries RENAME TO raw_salaries;

DESC;
SUMMARIZE ingest.raw_salaries;