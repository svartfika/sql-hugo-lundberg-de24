-- must run attach_sakila.sql

SHOW DATABASES;
SHOW TABLES;

SUMMARIZE main.film;
DESC TABLE main.film;

-- film_id, language_id

SELECT COUNT(*) FROM main.film;
SELECT DISTINCT COUNT(title) FROM main.film;
SELECT * FROM main.film ORDER BY random() LIMIT 5;

SELECT * FROM main.actor ORDER BY random() LIMIT 5;
SELECT * FROM main.film_actor ORDER BY random() LIMIT 5;

SELECT DISTINCT first_name, last_name FROM main.actor;  -- returns 199 rows
SELECT COUNT(DISTINCT actor_id) FROM main.actor;  -- returns 200 rows

-- check for NULL names
SELECT *
FROM main.actor
WHERE (
    first_name IS NULL
    OR last_name IS NULL
);  -- returns 0 records w/ NULL names

-- find duplicates
SELECT
    first_name,
    last_name,
    COUNT(*) AS count
FROM main.actor
GROUP BY
    first_name,
    last_name
HAVING count > 1;  -- SUSAN DAVIS

-- query specfic rows
SELECT *
FROM main.actor
WHERE (
    first_name = 'SUSAN'
    AND last_name = 'DAVIS'
);  -- actor_id 101 and 110


SELECT DISTINCT COUNT(*) FROM main.film_actor;
SELECT COUNT(DISTINCT actor_id) FROM main.film_actor;