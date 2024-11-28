INSTALL SQLITE;
LOAD SQLITE;

ATTACH 'data/sqlite-sakila.db' AS sakila_sqlite (TYPE SQLITE);
USE sakila_sqlite;

SHOW DATABASES;
SHOW TABLES;