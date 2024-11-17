SELECT
	dj.experience_level,
	dj.job_title,
	(10.68 * dj.salary_in_usd) / 12 AS monthly_salary_in_sek
FROM
	main.data_jobs dj
WHERE
	monthly_salary_in_sek > 200000
	AND monthly_salary_in_sek < 500000
ORDER BY
	monthly_salary_in_sek DESC ;


SELECT
	dj.experience_level,
	dj.job_title,
	(10.68 * dj.salary_in_usd) / 12 AS monthly_salary_in_sek
FROM
	main.data_jobs dj
WHERE
	monthly_salary_in_sek BETWEEN 200000 AND 500000
ORDER BY
	monthly_salary_in_sek DESC ;


SELECT
	COUNT(*)
FROM
	main.data_jobs dj
WHERE
	dj.experience_level = 'Expert'
	OR dj.experience_level = 'Senior';


SELECT
	COUNT(*)
FROM
	main.data_jobs dj
WHERE
	NOT (dj.experience_level = 'Expert'
	OR dj.experience_level = 'Senior')


	
