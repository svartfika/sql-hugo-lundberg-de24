DESC;
SUMMARIZE main.seasonality;

-- id->food; week_id->week,month,year; value->interest

CREATE TABLE IF NOT EXISTS cleaned_seasonality AS 
SELECT
    id AS food,
    year(timestamp) as year,
    month(timestamp) as month,
    week(timestamp) as week,
    value AS interest
FROM (
    SELECT *,
        strptime(week_id, '%Y-%W') as timestamp
    FROM main.seasonality
);

SELECT *
FROM main.cleaned_seasonality;