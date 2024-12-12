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

SUMMARIZE staging.sql_terms;
SELECT * FROM staging.sql_terms;

-- SELECT 
--     trim(upper(sql_word)) AS sql_word,
--     trim(regexp_replace(description, '\s+', ' ', 'g')) AS description,
--     trim(lower(regexp_replace(
--         regexp_replace(example, '(\()\s+|\s+(\))|\s+([,;])', '\1\2\3', 'g')
--         , '(\s+)', ' ', 'g')
--     )) AS example
-- FROM staging.sql_terms;

CREATE TABLE refined.sql_terms AS (
    SELECT 
        trim(upper(sql_word)) AS sql_word,
        trim(regexp_replace(description, '\s+', ' ', 'g')) AS description,
        trim(lower(regexp_replace(
            regexp_replace(example, '(\()\s+|\s+(\))|\s+([,;])', '\1\2\3', 'g')
            , '(\s+)', ' ', 'g')
        )) AS example
    FROM staging.sql_terms    
);

SUMMARIZE refined.sql_terms;
SELECT * FROM refined.sql_terms;

-- c) Practice filtering and searching for different keywords in different columns. Discuss with a friend why this could be useful in this case.

TODO!