SELECT
	MIN(salary_in_usd) AS min_salary_usd,
	round(AVG(salary_in_usd)) AS avg_min_salary_usd,
	MEDIAN(salary_in_usd) AS median_min_salary_usd,
	MAX(salary_in_usd) AS max_min_salary_usd,
FROM main.data_jobs;