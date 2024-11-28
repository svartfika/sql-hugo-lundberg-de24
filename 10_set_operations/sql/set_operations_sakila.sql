-- must run attach_sakila.sql

SHOW DATABASES;
SHOW TABLES;

SELECT
    'actor' as type,
    a.first_name,
    a.last_name
FROM main.actor a
WHERE
    a.first_name LIKE 'J%'
    AND a.last_name LIKE 'D%'
UNION ALL
SELECT
    'customer' as type,
    c.first_name,
    c.last_name
FROM main.customer c
WHERE
    c.first_name LIKE 'J%'
    AND c.last_name LIKE 'D%'
ORDER BY first_name, last_name;

SELECT
    a.first_name,
    a.last_name
FROM main.actor a
INTERSECT
SELECT
    c.first_name,
    c.last_name
FROM main.customer c;