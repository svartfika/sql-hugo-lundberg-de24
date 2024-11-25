DESC;

SUMMARIZE staging.sql_terms;

SELECT
    *
FROM
    staging.sql_terms
WHERE
    -- lower(description) LIKE '%select%';
    -- description ILIKE '%select%';  -- ILIKE = case-insensitive
    -- regexp_matches (lower(description), 'select\b');
    regexp_matches (description, '(?i)SELECT\b');  -- (?i) = case-insensitive regexp

-- transformation into warehouse

CREATE OR REPLACE TABLE warehouse.sql_terms AS
SELECT
    upper(word) as word,
    description,
    example
FROM
    staging.sql_terms
WHERE
    regexp_matches (description, '(?i)SELECT\b');

SUMMARIZE warehouse.sql_terms;
DESC;
