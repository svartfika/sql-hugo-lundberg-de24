SELECT 42 AS meaning_of_life;

SELECT 42;

SELECT * AS moo FROM (VALUES ('m'), ('o'), ('o'));

--

SELECT * FROM information_schema.schemata;

CREATE SCHEMA IF NOT EXISTS synthetic;

CREATE TABLE IF NOT EXISTS synthetic.generated AS (
SELECT
	*
FROM
    (
        VALUES
            (1, 'Mario'),
            (2, 'Luigi')
    ) AS t(id, name)	
);

SELECT * FROM synthetic.generated g ;

ALTER TABLE synthetic.generated ADD COLUMN rnd_age INTEGER;

UPDATE synthetic.generated 
SET rnd_age = FLOOR(RANDOM () *100);

UPDATE synthetic.generated 
SET rnd_age = FLOOR(RANDOM () *100)
WHERE name = 'Mario';

--

-- inclusive stop w/ generate_series
SELECT UNNEST (generate_series (1, 100)) AS id;

-- exclusive stop w/ range
SELECT UNNEST (range(1, 101)) AS id;

-- dice simulation
SELECT
    RANDOM() * 6 + 1 AS dice
-- FROM generate_series(100)
FROM range(100);

-- simple synthetic data
SELECT
    UNNEST (generate_series(1,100)) AS id,
    'student_' || id AS student,
    ROUND(RANDOM() * 100) AS score;

-- select data from simple subquery

SELECT
    id
FROM (
    SELECT UNNEST (generate_series(1,100)) as id
);

-- another subquery

SELECT id, student, score
FROM (
    SELECT
        UNNEST (range(1,101)) as id,
        'student_' || id AS student,
        ROUND(RANDOM() * 100.0) as score
);

-- subquery with CASE.
-- Note: PostgreSQL dialect allows for referencing column aliases from the same select clause in later expressions.
--       id and the following concatentation is therefore possible without subquery.
--       CASE expressions are not supported, needs subquerry.

-- SELECT
--     UNNEST (range(1,101)) as id,
--     'student_' || id AS student,
--     ROUND(RANDOM() * 100.0) as score,
--     CASE WHEN score < 50 THEN 'boo' END AS grade;

-- while the following partly works, not generating id alongside score only generates a single value

-- SELECT
--     UNNEST (range(1,101)) as id,
--     'student_' || id AS student,
--     score,
--     CASE
--         WHEN score < 50 THEN 'boo'
--         ELSE 'moo'
--     END AS grade
-- FROM (
--     SELECT
--         ROUND(RANDOM() * 100.0) as score
-- );

SELECT
    id,
    'student_' || id AS student,
    score,
    CASE
        WHEN score < 50 THEN 'F'
        WHEN score < 75 THEN 'G'
        ELSE 'VG'
    END AS grade
FROM (
    SELECT
        UNNEST (range(1,101)) as id,
        ROUND(RANDOM() * 100.0) as score
);

-- generating customer data

SELECT
    'customer_' || order_id as customer_name,
    DATE '2024-01-01' + (order_id-1) * INTERVAL 1 DAY as order_date,
    ROUND(RANDOM() * 1000) AS order_qty,
    CASE
        WHEN RANDOM() < 0.7 THEN 'completed'
        WHEN RANDOM() < 0.9 THEN 'pending'
        ELSE 'cancelled'
    END AS order_status
FROM (
    SELECT
        UNNEST (range(1,101)) as order_id
);

-- generating temporal data

SELECT
    UNNEST (generate_series(
        DATE '2025-01-01',
        DATE '2025-12-31',
        INTERVAL 1 DAY
    )) AS dateseries;

SELECT *
FROM
    generate_series(
        DATE '2025-01-01',
        DATE '2025-12-31',
        INTERVAL 1 DAY
    ) AS t(dateseries);  -- t(...) to set column name, otherwise sets as generate_series

SELECT
    strftime(dateseries, '%m/%Y') AS date,
    month(dateseries) AS month,
    week(dateseries) AS week_number,
    weekday(dateseries) AS day_of_week

FROM  -- generate_series is like a table; FROM table_name AS t(column_name); equivalent
    generate_series(
        DATE '2025-01-01',
        DATE '2025-12-31',
        INTERVAL 1 DAY
    ) AS t(dateseries);  -- t(...) to set column name, otherwise sets as generate_series

