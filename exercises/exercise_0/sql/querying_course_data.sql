-- a) Select all the exercises in this course
SELECT
    *
FROM
    main.course
WHERE
    content_type = 'exercise';

-- b) Select all the lectures in this course
SELECT
    *
FROM
    main.course
WHERE
    content_type = 'lecture';

-- c) Select all records for week 48
SELECT
    *
FROM
    main.course c
WHERE
    week = 48;

-- d) Select all records for week 47-49
SELECT
    *
FROM
    main.course c
    -- WHERE week >=47 AND week <= 49;
WHERE
    week BETWEEN 47 AND 49;

-- e) How many lectures are in the table?
SELECT
    COUNT(*) AS number_lectures
FROM
    main.course c
WHERE
    content_type = 'lecture';

-- f) How many other content are there?
SELECT
    COUNT(*) AS number_others
FROM
    main.course c
WHERE
    content_type != 'lecture';

-- g) Which are the unique content types in this table?
SELECT DISTINCT
    content_type
FROM
    main.course;

-- h) Delete the row with content 02_setup_duckdb and add it again.
DELETE FROM main.course
WHERE
    content = '02_setup_duckdb';

INSERT INTO
    main.course (content, week, content_type)
VALUES
    ('02_setup_duckdb', 46, 'lecture')
SELECT
    *
FROM
    main.course;

-- i) You see that 02_setup_duckdb comes in the end of your table, even though the week is 46. Now make a query where you sort the weeks in ascending order.
SELECT
    *
FROM
    main.course
WHERE
    content_type = 'lecture'
ORDER BY
    week ASC,
    content ASC;

-- j) Now you can choose what you want to explore in this table.