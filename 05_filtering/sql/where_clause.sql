SELECT * FROM main.data_jobs dj ;

SELECT
	COUNT(*) AS salary_under_50k
FROM
	main.data_jobs dj
WHERE
	dj.salary < 50000;∫

	
SELECT
	*
FROM
	main.data_jobs dj 
WHERE
	dj.experience_level = 'EN';


SELECT 
	MEDIAN(dj.salary_in_usd) AS median_salary_in_usd 
FROM
	main.data_jobs dj 
WHERE 
	dj.experience_level = 'MI';



