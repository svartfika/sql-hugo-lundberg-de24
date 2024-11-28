SELECT * FROM mock.orders_jan;
SELECT * FROM mock.orders_feb;

SELECT * FROM mock.orders_jan
UNION
SELECT * FROM mock.orders_feb;

SELECT product_name FROM mock.orders_jan
UNION
SELECT product_name FROM mock.orders_feb;

SELECT product_name FROM mock.orders_jan
UNION ALL
SELECT product_name FROM mock.orders_feb;

SELECT product_name FROM mock.orders_jan
INTERSECT
SELECT product_name FROM mock.orders_feb;

SELECT product_name FROM mock.orders_jan
EXCEPT
SELECT product_name FROM mock.orders_feb;