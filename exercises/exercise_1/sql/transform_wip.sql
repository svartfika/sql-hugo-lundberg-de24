DESC;
SUMMARIZE ingest.raw_salaries;

-- create staging table

DROP TABLE staging.cleaned_salaries;

CREATE TABLE IF NOT EXISTS staging.cleaned_salaries AS
SELECT *
FROM ingest.raw_salaries;

DESC;

-- define queries before updating table
-- a) Transform employment type column based on this table

SELECT DISTINCT employment_type FROM ingest.raw_salaries ORDER BY employment_type ASC;

SELECT
    CASE
        WHEN employment_type = 'CT' THEN 'Contract'
        WHEN employment_type = 'FL' THEN 'Freelance'
        WHEN employment_type = 'FT' THEN 'Full time'
        WHEN employment_type = 'PT' THEN 'Part time'
    END AS employment_type
FROM ingest.raw_salaries;

-- b) Do similar for company size, but you have to figure out what the abbreviations could stand for.

SELECT DISTINCT company_size FROM ingest.raw_salaries ORDER BY employment_type ASC;

SELECT
    CASE
        WHEN company_size = 'S' THEN 'Small'
        WHEN company_size = 'M' THEN 'Medium'
        WHEN company_size = 'L' THEN 'Large'
    END AS company_size
FROM ingest.raw_salaries;

-- update columns company_size, employment_type

UPDATE staging.cleaned_salaries
SET
    company_size = CASE
        WHEN company_size = 'S' THEN 'small'
        WHEN company_size = 'M' THEN 'medium'
        WHEN company_size = 'L' THEN 'large'
    END,
    employment_type = CASE
        WHEN employment_type = 'CT' THEN 'contract'
        WHEN employment_type = 'FL' THEN 'freelance'
        WHEN employment_type = 'FT' THEN 'full_time'
        WHEN employment_type = 'PT' THEN 'part_time'
    END;

SELECT DISTINCT company_size, employment_type FROM staging.cleaned_salaries;

-- c) Make a salary column with Swedish currency for yearly salary.
-- d) Make a salary column with Swedish currency for monthly salary.
-- define queries before creating columns

SET VARIABLE fx_rate_usd_sek = 10.4;
SELECT getvariable('fx_rate_usd_sek') AS fx;

SELECT
    salary_in_usd,
    round(salary_in_usd * getvariable('fx_rate_usd_sek')) ::INTEGER AS salary_in_sek,
    round(salary_in_sek / 12) ::INTEGER AS salary_in_sek_month
FROM staging.cleaned_salaries;

-- update staging table with columns salary_in_sek, salary_in_sek_month

ALTER TABLE staging.cleaned_salaries ADD COLUMN salary_in_sek INTEGER;
ALTER TABLE staging.cleaned_salaries ADD COLUMN salary_in_sek_month INTEGER;

UPDATE staging.cleaned_salaries SET salary_in_sek = round(salary_in_usd * getvariable('fx_rate_usd_sek')) ::INTEGER;
UPDATE staging.cleaned_salaries SET salary_in_sek_month = round(salary_in_sek / 12) ::INTEGER;

SUMMARIZE staging.cleaned_salaries;
SELECT COUNT(*) FROM staging.cleaned_salaries;


-- e) Make a salary_level column with the following categories: low, medium, high, insanely_high.
--    Decide your thresholds for each category. Make it base on the monthly salary in SEK.
-- define queries before creating columns

SELECT
    MIN(salary_in_sek_month) AS salary_min,
    round(AVG(salary_in_sek_month)) AS salary_mean,
    round(MEDIAN(salary_in_sek_month)) AS salary_median,
    MAX(salary_in_sek_month) AS salary_max
FROM staging.cleaned_salaries;

-- x < 50000, x < 100000, x < 200000, x < 500000

SELECT
    CASE
        WHEN salary_in_sek_month <= 50000 THEN 'low'
        WHEN salary_in_sek_month <= 100000 THEN 'medium'
        WHEN salary_in_sek_month <= 200000 THEN 'high'
        WHEN salary_in_sek_month <= 500000 THEN 'insanely_high'
    END AS salary_level
FROM staging.cleaned_salaries;

-- update table with column salary_level

ALTER TABLE staging.cleaned_salaries ADD COLUMN salary_level VARCHAR;

UPDATE staging.cleaned_salaries
SET
    salary_level = CASE
        WHEN salary_in_sek_month <= 50000 THEN 'low'
        WHEN salary_in_sek_month <= 100000 THEN 'medium'
        WHEN salary_in_sek_month <= 200000 THEN 'high'
        WHEN salary_in_sek_month <= 500000 THEN 'insanely_high'
    END;   

SUMMARIZE staging.cleaned_salaries;


--   f) Choose the following columns to include in your table: experience_level, employment_type, job_title, salary_annual_sek, salary_monthly_sek, remote_ratio, company_size, salary_level

SELECT
    job_title,
    experience_level,
    employment_type,
    remote_ratio,
    company_size,
    salary_in_sek AS salary_annual_sek,
    salary_in_sek_month AS salary_monthly_sek,
    salary_level
FROM staging.cleaned_salaries
WHERE job_title = 'Data Engineer';

-- g) Think of other transformation that you want to do.

SELECT DISTINCT experience_level
FROM staging.cleaned_salaries
ORDER BY experience_level;

SELECT
    CASE
        WHEN experience_level = 'EN' THEN 'entry'
        WHEN experience_level = 'EX' THEN 'executive'
        WHEN experience_level = 'MI' THEN 'intermediate'
        WHEN experience_level = 'SE' THEN 'senior'
    END AS experience_level
FROM staging.cleaned_salaries;

UPDATE staging.cleaned_salaries
SET
    experience_level = CASE
        WHEN experience_level = 'EN' THEN 'entry'
        WHEN experience_level = 'EX' THEN 'executive'
        WHEN experience_level = 'MI' THEN 'intermediate'
        WHEN experience_level = 'SE' THEN 'senior'
    END;

SUMMARIZE staging.cleaned_salaries;

