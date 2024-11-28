-- DESC;
-- SELECT * FROM information_schema.schemata;
-- SHOW TABLES;
-- SHOW DATABASES;

-- DROP TABLE mock.orders_jan;
-- DROP TABLE mock.orders_feb;

CREATE SCHEMA IF NOT EXISTS  mock;

CREATE OR REPLACE SEQUENCE id_order_seq START 1;

CREATE OR REPLACE TABLE mock.orders_jan AS (
SELECT
    nextval('id_order_seq') AS order_id,
    CASE rand_val
        WHEN 0 THEN 'Chair'
        WHEN 1 THEN 'Headphones'
        WHEN 2 THEN 'Keyboard'
        WHEN 3 THEN 'Laptop'
        WHEN 4 THEN 'Monitor'
        WHEN 5 THEN 'Mouse'
        WHEN 6 THEN 'Smartphone'
        WHEN 7 THEN 'Table'
    END AS product_name,
    DATE '2024-01-01' + floor(random() * 32)::INTEGER * INTERVAL '1 DAY' AS order_date
FROM (
    SELECT
        UNNEST(range(1,4)),
        floor(random() * 8)::INTEGER AS rand_val
));

SUMMARIZE mock.orders_jan;

CREATE OR REPLACE TABLE mock.orders_feb AS (
SELECT
    nextval('id_order_seq') AS order_id,
    CASE rand_val
        WHEN 0 THEN 'Chair'
        WHEN 1 THEN 'Headphones'
        WHEN 2 THEN 'Keyboard'
        WHEN 3 THEN 'Laptop'
        WHEN 4 THEN 'Monitor'
        WHEN 5 THEN 'Mouse'
        WHEN 6 THEN 'Smartphone'
        WHEN 7 THEN 'Table'
    END AS product_name,
    DATE '2024-02-01' + floor(random() * 29)::INTEGER * INTERVAL '1 DAY' AS order_date
FROM (
    SELECT
        UNNEST(range(1,4)),
        floor(random() * 8)::INTEGER AS rand_val
));

SUMMARIZE mock.orders_feb;

SELECT * FROM mock.orders_jan;
SELECT * FROM mock.orders_feb;