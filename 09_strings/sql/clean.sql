DESC;
SUMMARIZE ingest.sql_terms;

CREATE TABLE IF NOT EXISTS staging.sql_terms AS 
SELECT
    lower(trim(sql_word)) AS word,
    regexp_replace(trim(description), '\s+', ' ', 'g') as description,
    regexp_replace(lower(trim(example)), '\s+', ' ', 'g') AS example
FROM ingest.sql_terms;

DESC;
SUMMARIZE staging.sql_terms;