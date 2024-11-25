§CREATE TABLE
    IF NOT EXISTS people_records AS (
        SELECT
            *
        FROM
            (
                VALUES
                    (1, 'Mario'),
                    (2, 'Luigi')
            ) AS people (id, name)
    );

SELECT
    *
FROM
    people_records;

SELECT
    FLOOR(RANDOM () * 6 + 1) AS dice
FROM
    -- generating 10 fields
    generate_series (1, 10);

SELECT
    UNNEST (generate_series (1, 100)) AS id,
    'student_' || id AS student,
    ROUND(RANDOM () * 100) AS score;

SELECT
    *
FROM
    generate_series (
        DATE '2024-11-01',
        DATE '2024-11-30',
        INTERVAL 1 DAY
    ) AS t (november);

DROP TABLE IF EXISTS dim_date;
CREATE TABLE
    IF NOT EXISTS dim_date AS (
        SELECT
            *
        FROM
            generate_series (
                DATE '2024-12-01',
                DATE '2024-12-31',
                INTERVAL 1 DAY
            ) AS t(date_series)
    );

SELECT
    strftime ('%Y-%m-%d', date_series) AS datetime,
    month (date_series) AS month,
    week (date_series) AS week_number,
    weekday (date_series) AS day_of_week,
FROM
    dim_date;