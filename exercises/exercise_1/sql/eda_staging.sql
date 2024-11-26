SUMMARIZE staging.cleaned_salaries;

-- a) Count number of Data engineers jobs. For simplicity just go for job_title Data Engineer.

SELECT COUNT(job_title)
FROM staging.cleaned_salaries
WHERE job_title = 'Data Engineer';

-- b) Count number of unique job titles in total.

SELECT COUNT(DISTINCT job_title)
FROM staging.cleaned_salaries;

-- c) Find out how many jobs that goes into each salary level.

SELECT salary_level, COUNT(salary_level) AS job_count
FROM staging.cleaned_salaries
GROUP BY salary_level
ORDER BY job_count;

-- d) Find out the median and mean salaries for each seniority levels.

SELECT
    experience_level,
    round(avg(salary_monthly_sek))::INTEGER AS mean_salary_monthly_sek,
    round(median(salary_monthly_sek))::INTEGER AS median_salary_monthly_sek,
FROM staging.cleaned_salaries
GROUP BY experience_level
ORDER BY mean_salary_monthly_sek ASC;

-- e) Find out the top earning job titles based on their median salaries and how much they earn.

SELECT
    job_title,
    round(median(salary_monthly_sek))::INTEGER AS median_salary_monthly_sek
FROM staging.cleaned_salaries
GROUP BY job_title
ORDER BY median_salary_monthly_sek DESC
LIMIT 10;

-- f) How many percentage of the jobs are fully remote, 50 percent remote and fully not remote.

SELECT
    remote_ratio,
    round(
        (COUNT(remote_ratio) / (SELECT COUNT(*)FROM staging.cleaned_salaries)) * 100.0
        ,2) AS pct_remote
FROM staging.cleaned_salaries
GROUP BY remote_ratio
ORDER BY remote_ratio;

-- g) Pick out a job title of interest and figure out if company size affects the salary.
--    Make a simple analysis as a comprehensive one requires causality investigations which are much harder to find.

-- finding job titles present in all different company sizes

SELECT
    job_title,
    COUNT(*) AS jobs_total
FROM staging.cleaned_salaries
GROUP BY job_title
HAVING
    COUNT(DISTINCT company_size) = 3
ORDER BY jobs_total DESC
LIMIT 10;

-- calculating percentage difference between size-specific avg salary and avg salary

SELECT
    company_size,
    round(avg(salary_annual_sek)) ::INTEGER AS avg_salary,
    round(
        ((avg_salary / (SELECT avg(salary_annual_sek) FROM staging.cleaned_salaries)) - 1) * 100.0
        , 2) AS pct_diff_from_avg
FROM staging.cleaned_salaries
WHERE job_title = 'Machine Learning Engineer'
GROUP BY company_size
ORDER BY avg_salary DESC;


-- h) Feel free to explore other things

SUMMARIZE staging.cleaned_salaries;

-- filter job titles with more than 100 data points for full time employment
SELECT
    job_title,
    count(employment_type) AS full_time_count
FROM staging.cleaned_salaries
WHERE employment_type = 'Full time'
GROUP BY job_title
HAVING full_time_count > 100
ORDER BY full_time_count DESC;

-- most common employment types for expereince level
SELECT DISTINCT
    experience_level,
    first_value(employment_type) OVER (
        PARTITION BY experience_level
        ORDER BY count(*) DESC
    ) as employment_type
FROM staging.cleaned_salaries
GROUP BY experience_level, employment_type
ORDER BY experience_level ASC;