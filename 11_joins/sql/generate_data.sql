DESC;

CREATE OR REPLACE TABLE plants (
    plant_id INTEGER NOT NULL PRIMARY KEY,
    plant_name VARCHAR,
    type VARCHAR
);

CREATE OR REPLACE TABLE plant_care (
    id INTEGER,
    plant_id INTEGER NOT NULL PRIMARY KEY,
    water_schedule VARCHAR,
    sunlight VARCHAR
);


INSERT INTO main.plants (plant_id, plant_name, type) 
VALUES
    (1, 'Rose', 'Flower'),
    (2, 'Oak', 'Tree'),
    (3, 'Tulip', 'Flower'),
    (4, 'Cactus', 'Succulent'),
    (5, 'Sunflower', 'Flower');

INSERT INTO main.plant_care (id, plant_id, water_schedule, sunlight) 
VALUES
    (1, 1, 'Daily', 'Full Sun'),
	(2, 3, 'Weekly', 'Partial Sun'),
	(3, 4, 'Biweekly', 'Full Sun'),
	(4, 6, 'Daily', 'Shade');

SUMMARIZE main.plants;
SUMMARIZE main.plant_care;