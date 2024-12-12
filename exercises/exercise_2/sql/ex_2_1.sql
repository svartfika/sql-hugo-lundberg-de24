-- Continue working on the data from lecture 09_strings.
-- In this lecture you created a schema called staging and ingested the raw data into the staging schema.

-- 0) Ingest 'sql_terms.csv' into the staging schema

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.sql_terms AS (
    SELECT * FROM 'data/sql_terms.csv'
);
    

-- a) Create a schema called refined. This is the schema where you'll put the transformed data.

CREATE SCHEMA IF NOT EXISTS refined;

SUMMARIZE information_schema.schemata;
SELECT * FROM information_schema.schemata WHERE schema_name IN ('staging', 'refined');


-- b) Now transform and clean the data and place the cleaned table inside the refined schema.

-- c) Practice filtering and searching for different keywords in different columns. Discuss with a friend why this could be useful in this case.