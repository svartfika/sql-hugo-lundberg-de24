-- alias
SELECT DISTINCT
    salary_currency AS unique_currency
FROM
    main.data_jobs;

-- aggregate function as alias
SELECT
    COUNT(DISTINCT salary_currency) AS number_currencies
FROM
    main.data_jobs;