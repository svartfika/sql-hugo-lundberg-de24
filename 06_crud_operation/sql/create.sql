CREATE SCHEMA IF NOT EXISTS database;

CREATE SCHEMA IF NOT EXISTS programming;

SELECT * FROM information_schema.schemata;

CREATE SEQUENCE IF NOT EXISTS id_sql_sequence START 1;
CREATE SEQUENCE IF NOT EXISTS id_python_sequence START 1;
CREATE SEQUENCE IF NOT EXISTS id_duckdb_sequence START 1;

SELECT * FROM pg_catalog.pg_sequences;

CREATE TABLE IF NOT EXISTS database.sql (
	id INTEGER DEFAULT nextval('id_sql_sequence'),
	word STRING,
	description STRING
);

CREATE TABLE IF NOT EXISTS database.duckdb (
	id INTEGER DEFAULT nextval('id_duckdb_sequence'),
	word STRING,
	description STRING
);

CREATE TABLE IF NOT EXISTS programming.python (
	id INTEGER DEFAULT nextval('id_python_sequence'),
	word STRING,
	description STRING
);

SELECT * FROM information_schema.tables;



INSERT INTO database.sql (word, description)
VALUES
	('query','request made to a database to retrieve, modify or manipulate data');

SELECT * FROM database.sql s ;

INSERT INTO database.sql (word, description)
VALUES
	('CRUD',
	'Create, Read, Update, Delete'),
	('range condition',
	'filter within a specific range of values')
	
SELECT * FROM database.sql s ;

INSERT INTO programming.python (word, description)
VALUES
	('class',
	'code template for creating objects');

SELECT * FROM programming.python p ;

INSERT
	INTO
	database.duckdb (word,
	description)
VALUES
	('DuckDB',
	'An in-process SQL OLAP database management system designed for fast analytical queries.'),
	('Sequence',
	'A database object that generates a sequence of unique numbers, typically used for auto-incrementing columns.'),
	('VARCHAR',
	'A variable-length character data type that stores text strings of varying lengths.'),
	('TIMESTAMPTZ',
	'A data type that stores both date and time, including time zone information.'),
	('ARRAY',
	'A data type in DuckDB that allows for the storage of ordered collections of elements of the same type.'),
	('CREATE TABLE',
	'A SQL statement used to define a new table in DuckDB.'),
	('DROP SCHEMA',
	'A SQL statement used to remove a schema and all its contained objects like tables.'),
	('AUTO_INCREMENT',
	'In DuckDB, achieved by using sequences to automatically generate unique values for an ID column.'),
	('pg_catalog',
	'A schema in DuckDB that stores system tables and metadata about the database objects.'),
	('INFORMATION_SCHEMA',
	'A set of views in DuckDB that provides information about the database metadata such as tables, columns, and data types.');

SELECT * FROM database.duckdb d ;

