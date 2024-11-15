DESC;

SELECT
	*
FROM
	main.data_jobs;

-- limit clause
SELECT
	*
FROM
	main.data_jobs AS dj
LIMIT
	5;

-- column projection
SELECT
	work_year,
	job_title,
	salary_in_usd,
	company_location
FROM
	main.data_jobs;

-- column exclusion
SELECT
	* EXCLUDE (salary, work_year)
FROM
	main.data_jobs;

-- row deduplication
SELECT DISTINCT
	employment_type
FROM
	main.data_jobs;

SELECT DISTINCT
	experience_level
FROM
	main.data_jobs;