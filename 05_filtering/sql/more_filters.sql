SELECT
	COUNT(*)
FROM
	main.data_jobs dj
WHERE
	dj.company_size IN ('S', 'M');


SELECT
	COUNT(*) AS jobs_total,
	COUNT(*) FILTER (
	WHERE remote_ratio = 100) AS remote_jobs,
	ROUND((remote_jobs / jobs_total) * 100,
	2) AS pct_remote_jobs
FROM
	main.data_jobs dj;


SELECT
	*
FROM
	main.data_jobs dj
OFFSET 10
LIMIT 5;
