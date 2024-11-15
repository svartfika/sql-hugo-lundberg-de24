CREATE TABLE
    IF NOT EXISTS hemnet AS (
        SELECT
            *
        FROM
            'data/hemnet_data_clean.csv'
    );