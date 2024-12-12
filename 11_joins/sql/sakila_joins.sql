DESC;
LOAD SQLITE;
ATTACH 'data/sqlite-sakila.db' AS sakila_sqlite (TYPE SQLITE);
SHOW DATABASES;
USE sakila_sqlite;
SHOW TABLES;


-- can we get which actors played which films?
SUMMARIZE main.film;
SUMMARIZE main.film_actor;
SUMMARIZE main.actor;

SELECT actor_id, first_name, last_name
FROM main.actor;

SELECT film_id, actor_id
FROM main.film_actor
GROUP BY film_id, actor_id
ORDER BY film_id;


-- which actor has played which film_id
SELECT a.actor_id, a.first_name, a.last_name, f.film_id
FROM main.actor a
JOIN main.film_actor f
ON a.actor_id = f.actor_id
ORDER BY a.actor_id, f.film_id;


-- which actor has played which film?
-- joining 3 tables
SELECT a.actor_id, a.first_name, a.last_name, fa.film_id, f.title
FROM main.actor a
JOIN main.film_actor fa
    ON a.actor_id = fa.actor_id
JOIN main.film f
    ON fa.film_id = f.film_id
ORDER BY a.first_name, a.last_name, f.title;


-- if doing LEFT JOIN get all films including those without a category -> the category becomes NULL
-- INNER JOIN - get all films with associated category

SUMMARIZE main.category;
SUMMARIZE main.film;
SUMMARIZE main.film_category;

SELECT f.title, c.name
FROM main.film AS f
JOIN main.film_category AS fc
ON f.film_id = fc.film_id
JOIN main.category AS c
ON fc.category_id = c.category_id;


SELECT
	f.title,
	c.name AS category,
FROM
	main.film_category fc
INNER JOIN main.category c ON
	fc.category_id = c.category_id
INNER JOIN main.film f ON
	f.film_id = fc.film_id ;


SELECT
	*
FROM
	main.film_category fc
LEFT JOIN main.category c ON
	fc.category_id = c.category_id
WHERE c.name IS NULL;

SELECT 
    f.title,
    c.name AS category
FROM 
    main.film f
LEFT JOIN main.film_category fc ON 
    f.film_id = fc.film_id
LEFT JOIN main.category c ON
    fc.category_id = c.category_id
WHERE 
    c.name IS NULL;

-- in which address, city and country does the staff live?

-- TODO!