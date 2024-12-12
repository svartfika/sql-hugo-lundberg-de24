-- a) Generate 10 rows of dice rolls data

SELECT floor(random() * 6 + 1) as dice
FROM range(10);


-- b) Calculate the average of getting a six
SELECT
    (count(*) FILTER (r.dice = 6)) / count(*)::FLOAT AS a
FROM (
    SELECT floor(random() * 6 + 1) as dice
    FROM range(10)
) AS r;


-- c) Generate 100 rows of dice rolls and calculate average of getting a six
SELECT
    (count(*) FILTER (r.dice = 6)) / count(*)::FLOAT AS a
FROM (
    SELECT floor(random() * 6 + 1) as dice
    FROM range(100)
) AS r;


-- d) Repeat the experiment with 1000, 10000, 100000, 1000000 rolls.

-- first step, cartesian product limited by where clause to generate right amount of rows for each roll simulation
WITH p AS (
    SELECT 10 ** i AS n_rolls
    FROM range(2, 7) AS t(i)
)
SELECT *
FROM p
CROSS JOIN (
    SELECT *
    FROM range((SELECT max(p.n_rolls) FROM p) ::INTEGER) AS t(range_rolls)
) AS r
WHERE r.range_rolls < p.n_rolls
ORDER BY p.n_rolls;


-- confirm row count is correct for each dice simulation
WITH p AS (
    SELECT 10 ** i AS n_rolls
    FROM range(2, 7) AS t(i)
    )
SELECT
    count(*)
FROM p
CROSS JOIN (
    SELECT *
    FROM range((SELECT max(p.n_rolls) FROM p) ::INTEGER) AS t(range_rolls)
) AS r
WHERE r.range_rolls < p.n_rolls
GROUP BY p.n_rolls;


-- dice probabilites grouped by experiment size
WITH p AS (
    SELECT 10 ** i AS n_rolls
    FROM range(2, 7) AS t(i)
    )
SELECT
    p.n_rolls,
    (count(*) FILTER (r.dice = 6)) / count(*)::FLOAT AS a
FROM p
CROSS JOIN (
    SELECT
        *,
        floor(random() * 6 + 1) as dice
    FROM range((SELECT max(p.n_rolls) FROM p)::INTEGER) AS t(range_rolls)
) AS r
WHERE r.range_rolls < p.n_rolls
GROUP BY p.n_rolls
ORDER BY p.n_rolls;


-- e) What is the theoretical mean?

-- TODO!