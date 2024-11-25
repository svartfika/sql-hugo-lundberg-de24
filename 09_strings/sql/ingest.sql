DESC;

-- create schemas
CREATE SCHEMA IF NOT EXISTS ingest;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS warehouse;

SELECT * FROM information_schema.schemata;

-- ingest data from csv
CREATE TABLE IF NOT EXISTS ingest.sql_terms AS
SELECT * FROM 'data/sql_terms.csv';

DESC;
SUMMARIZE ingest.sql_terms;