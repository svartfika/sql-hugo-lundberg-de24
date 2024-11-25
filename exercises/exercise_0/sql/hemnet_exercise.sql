-- b) Make a wildcard selection to checkout the data
SELECT
	*
FROM
	main.hemnet
LIMIT
	100;

-- c) Find out how many rows there are in the table
SELECT
	COUNT(*) AS number_rows
FROM
	main.hemnet;

-- d) Describe the table that you have ingested to see the columns and data types.
DESC main.hemnet;

-- e) Find out the 5 most expensive homes sold.
SELECT
	*
FROM
	main.hemnet h
ORDER BY
	final_price DESC
LIMIT
	5;

-- f) Find out the 5 cheapest homes sold.
SELECT
	*
FROM
	main.hemnet h
ORDER BY
	final_price ASC
LIMIT
	5;

-- g) Find out statistics on minimum, mean, median and maximum prices of homes sold.
SELECT
	MIN(final_price) AS final_price_min,
	AVG(final_price) AS final_price_mean,
	MEDIAN (final_price) AS final_price_median,
	MAX(final_price) AS final_price_max
FROM
	main.hemnet;

-- h) Find out statistics on minimum, mean, median and maximum prices of price per area.
SELECT
	MIN(price_per_area) AS price_per_area_min,
	round(AVG(price_per_area)) AS price_per_area_mean,
	MEDIAN (price_per_area) AS price_per_area_median,
	MAX(price_per_area) AS price_per_area_max
FROM
	main.hemnet;

-- i) How many unique communes are represented in the dataset.
SELECT
	COUNT(DISTINCT commune) AS number_communes
FROM
	main.hemnet;

-- j) How many percentage of homes cost more than 10 million?
WITH
	homes_10m AS (
		SELECT
			COUNT(*) AS number_rows,
			COUNT(
				CASE
					WHEN final_price > 10000000 THEN 1
				END
			) AS number_milli,
		FROM
			main.hemnet
	)
SELECT
	(number_milli / number_rows) * 100.0 AS percentage
FROM
	homes_10m;

-- j) ...
SELECT
	COUNT(*) FILTER (WHERE final_price > 10000000)
FROM
	main.hemnet;

SELECT
	ROUND(100.0 * COUNT(*) FILTER (WHERE final_price > 10000000) / COUNT(*), 2) as homes_10m
FROM
	main.hemnet
WHERE
	-- You might get unexpected percentages because NULL prices are included in total count
	final_price IS NOT NULL;

-- j) ...
SELECT
	COUNT(*)
FROM
	main.hemnet;

SELECT
	COUNT(CASE WHEN final_price > 10000000 THEN 1 END)
FROM
	main.hemnet;

SELECT
	ROUND(100.0 * COUNT(CASE WHEN final_price > 10000000 THEN 1 END) / COUNT(*), 2)
FROM
	main.hemnet;

SELECT
	ROUND(100.0 * COUNT(CASE WHEN final_price > 10000000 THEN 1 END) / COUNT(*), 2)
FROM
	main.hemnet
WHERE
	-- You might get unexpected percentages because NULL prices are included in total count
	final_price IS NOT NULL;

-- k) Feel free to explore anything else you find interesting in this dataset.
SELECT
	*,
	round(rooms / area, 3) AS room_density
FROM
	main.hemnet
ORDER BY
	room_density DESC;

-- x)

SUMMARIZE main.hemnet;