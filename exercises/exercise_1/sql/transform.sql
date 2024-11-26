DESC;
SUMMARIZE ingest.raw_salaries;
DROP TABLE staging.cleaned_salaries;


SET VARIABLE fx_rate_usd_sek = 10.4;

CREATE TABLE IF NOT EXISTS staging.cleaned_salaries AS (
    SELECT
        job_title,
        CASE
            WHEN experience_level = 'EN' THEN 'Junior'
            WHEN experience_level = 'MI' THEN 'Intermediate'
            WHEN experience_level = 'SE' THEN 'Expert'
            WHEN experience_level = 'EX' THEN 'Executive'
        END AS experience_level,
        CASE
            WHEN employment_type = 'FT' THEN 'Full time'
            WHEN employment_type = 'PT' THEN 'Part time'
            WHEN employment_type = 'CT' THEN 'Contract'
            WHEN employment_type = 'FL' THEN 'Freelance'
        END AS employment_type,
        remote_ratio,
        CASE
            WHEN company_size = 'S' THEN 'Small'
            WHEN company_size = 'M' THEN 'Medium'
            WHEN company_size = 'L' THEN 'Large'
        END AS company_size,
        round(salary_in_usd * getvariable('fx_rate_usd_sek')) ::INTEGER AS salary_annual_sek,
        round(salary_annual_sek / 12) ::INTEGER AS salary_monthly_sek,
        CASE
            WHEN salary_monthly_sek <= 50000 THEN 'Low'
            WHEN salary_monthly_sek BETWEEN 50000 AND 100000 THEN 'Medium'
            WHEN salary_monthly_sek BETWEEN 100000 AND 200000 THEN 'High'
            WHEN salary_monthly_sek >= 200000 THEN 'Insanely high'
        END AS salary_level
    FROM ingest.raw_salaries
    -- WHERE job_title = 'Data Engineer' 
);

SUMMARIZE staging.cleaned_salaries;