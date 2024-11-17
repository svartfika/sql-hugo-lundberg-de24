CREATE TABLE weather (
	city VARCHAR,
	temp_lo INTEGER,
	temp_hi INTEGER,
	prcp FLOAT,
	date DATE
);

SELECT *
FROM main.weather w;

CREATE TABLE IF NOT EXISTS cities (
	city VARCHAR,
	lat DECIMAL,
	lon DECIMAL
);

ALTER TABLE main.cities RENAME COLUMN city TO name;

SELECT *
FROM main.cities;

INSERT INTO main.cities 
VALUES ('San Francisco', -194.0, 53.0);

INSERT INTO main.weather
VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');

INSERT INTO main.weather (city, temp_lo, temp_hi, prcp, date)
VALUES ('San Francisco', 43, 57, 0.0, '1994-11-29');

INSERT INTO main.weather (date, city, temp_lo, temp_hi)
VALUES ('1994-11-29', 'Hayward', 54, 37);

SELECT *
FROM main.weather w;

SELECT city,
	(temp_hi + temp_lo) / 2 AS temp_avg,
	date
FROM main.weather;

SELECT *
FROM main.weather
WHERE city = 'San Francisco'
	AND prcp > 0.0;

SELECT *
FROM main.weather
ORDER BY city, date ;

SELECT DISTINCT city
FROM main.weather
ORDER BY city;

SELECT *
FROM main.cities c, main.weather;

SELECT city, temp_lo , temp_hi, prcp, date
FROM main.cities, main.weather
WHERE city = name;

SELECT w.city, w.temp_lo, w.temp_hi, w.prcp, w.date, c.lat, c.lon 
FROM main.cities c , main.weather w
WHERE city = name;

SELECT *
FROM  main.weather w
INNER JOIN main.cities c ON w.city = c.name;

SELECT *
FROM main.weather w 
LEFT OUTER JOIN main.cities c ON w.city = c.name ;

SELECT max(temp_lo)
FROM main.weather w ;

SELECT city
FROM main.weather w 
-- WHERE w.temp_lo = max(w.temp_lo);
WHERE w.temp_lo = (SELECT max(temp_lo) FROM main.weather);

SELECT w.city, max(w.temp_lo)
FROM main.weather w
GROUP BY city;

SELECT w.city, max(w.temp_hi)
FROM main.weather w
GROUP BY w.city
HAVING max(w.temp_hi) < 40;
