-- EDA; exploratory data analysis
DESC;
SUMMARIZE ingest.raw_salaries;

-- explore country codes
SELECT DISTINCT company_location
FROM ingest.raw_salaries;

COPY (SELECT DISTINCT company_location AS country_code FROM ingest.raw_salaries) TO 'data/country_codes.csv';

-- explore currencies
SELECT DISTINCT salary_currency
FROM ingest.raw_salaries;

COPY (SELECT DISTINCT salary_currency AS currency FROM ingest.raw_salaries) TO 'data/currencies.csv';

-- explore salaries
SELECT
    MIN(salary_in_usd) AS salary_min,
    round(AVG(salary_in_usd)) AS salary_mean,
    round(MEDIAN(salary_in_usd)) AS salary_median,
    MAX(salary_in_usd) AS salary_max
FROM ingest.raw_salaries;

-- explore the job title Data Engineer
SELECT DISTINCT job_title
FROM ingest.raw_salaries;

SELECT COUNT(*)
FROM ingest.raw_salaries
WHERE job_title = 'Data Engineer';

SELECT DISTINCT company_location
FROM ingest.raw_salaries
WHERE job_title = 'Data Engineer';