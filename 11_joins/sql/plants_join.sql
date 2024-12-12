SHOW TABLES;
SUMMARIZE main.plants;
SUMMARIZE main.plant_care;


-- left outer join
SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM main.plants AS p
LEFT JOIN main.plant_care AS pc
ON p.plant_id = pc.plant_id
ORDER BY p.plant_id;

-- right outer join
SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM main.plants AS p
RIGHT JOIN main.plant_care AS pc
ON p.plant_id = pc.plant_id;

-- full outer join
SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM main.plants AS p
FULL JOIN main.plant_care AS pc
ON p.plant_id = pc.plant_id;

-- inner join
SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM
    main.plants AS p
INNER JOIN
    main.plant_care AS pc
ON p.plant_id = pc.plant_id;