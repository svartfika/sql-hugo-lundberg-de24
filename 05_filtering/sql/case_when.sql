SELECT * FROM main.data_jobs dj ;


SELECT 
	CASE
		WHEN dj.experience_level = 'EX' THEN 'Expert'
		WHEN dj.experience_level = 'SE' THEN 'Senior'
		WHEN dj.experience_level = 'MI' THEN 'Mid-level'
		WHEN dj.experience_level = 'EN' THEN 'Entry-level'
	END AS experience_level, 
	* EXCLUDE (experience_level)
FROM
	main.data_jobs dj ;


UPDATE 
	main.data_jobs as dj
SET 
	experience_level = CASE
		WHEN dj.experience_level = 'EX' THEN 'Expert'
		WHEN dj.experience_level = 'SE' THEN 'Senior'
		WHEN dj.experience_level = 'MI' THEN 'Mid-level'
		WHEN dj.experience_level = 'EN' THEN 'Entry-level'
	END;


SELECT DISTINCT dj.experience_level 
FROM main.data_jobs dj ;