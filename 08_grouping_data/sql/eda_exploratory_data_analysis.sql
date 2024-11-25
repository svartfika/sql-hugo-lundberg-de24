DESC;

SUMMARIZE main.seasonality;


SELECT COUNT(*) FROM main.seasonality;

SELECT DISTINCT id FROM main.seasonality;

SELECT COUNT(DISTINCT id) FROM main.seasonality;


SELECT id, week_id, value
FROM main.seasonality
WHERE id = 'pumpkin';


SELECT
    -- week_id[:4] as year,
    -- week_id[-2:] as week,
    strptime(week_id, '%Y-%W') as timestamp,
    week(timestamp) as week_number,
    month(timestamp) as month,
    year(timestamp) as year
FROM main.seasonality;

SELECT
    id AS food,
    week(timestamp) as week_number,
    month(timestamp) as month,
    year(timestamp) as year,
FROM (
    SELECT *, strptime(week_id, '%Y-%W') as timestamp
    FROM main.seasonality
);

SELECT
    id AS food,
    value AS interest,
    week(timestamp) as week_number,
    month(timestamp) as month,
    year(timestamp) as year,
FROM (
    SELECT *, strptime(week_id, '%Y-%W') as timestamp
    FROM main.seasonality
)
WHERE
    week_number = 26
    AND food = 'ice-cream';