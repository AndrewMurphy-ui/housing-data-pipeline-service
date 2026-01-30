-- top and Bottom Performing States (Quarterly Growth)

-- need to channge the aruments to integers to compute that make_date function , you can see that yr is a varchar  
WITH base_data AS (
    SELECT 
        place_name,
        TO_CHAR(
            date_trunc('quarter', make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1)),
            'YYYY-"Q"Q'
        ) AS quarter,
        AVG(index_sa) AS avg_index_sa
    FROM hpi_state_analysis hsa 
    WHERE level = 'State'
      AND frequency = 'quarterly'
    GROUP BY 
        place_name,
        TO_CHAR(
            date_trunc('quarter', make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1)),
            'YYYY-"Q"Q'
        )
),
growth AS (
    SELECT 
        place_name,
        quarter,
        avg_index_sa,
        avg_index_sa - LAG(avg_index_sa) OVER (
            PARTITION BY place_name ORDER BY quarter
        ) AS quarterly_growth
    FROM base_data
)
SELECT *
FROM growth
ORDER BY quarterly_growth DESC NULLS LAST;



-- to plot this you need to x axis as quarterly growth and y axis as place_name and filter as quarter 
-- you might need to create a table to view this on power bi or copy and paste the code to power bi 


EXPLAIN analyze
WITH base_data AS (
    SELECT 
        place_name,
        TO_CHAR(
            date_trunc('quarter', make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1)),
            'YYYY-"Q"Q'
        ) AS quarter,
        AVG(index_sa) AS avg_index_sa
    FROM hpi_state_analysis hsa 
    WHERE level = 'State'
      AND frequency = 'quarterly'
    GROUP BY 
        place_name,
        TO_CHAR(
            date_trunc('quarter', make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1)),
            'YYYY-"Q"Q'
        )
),
growth AS (
    SELECT 
        place_name,
        quarter,
        avg_index_sa,
        avg_index_sa - LAG(avg_index_sa) OVER (
            PARTITION BY place_name ORDER BY quarter
        ) AS quarterly_growth
    FROM base_data
)
SELECT *
FROM growth
ORDER BY quarterly_growth DESC NULLS LAST;


-- we need to do some cleaning for this table , the quarter date , time formatt is wrong ,  date_trunc('quarter', make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER), 1)) AS quarter,
-- we need to change this 


-- lets make it into a table 
CREATE TABLE quarterly_growth_data AS
WITH base_data AS (
    SELECT 
        place_name,
        TO_CHAR(
            date_trunc('quarter', make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1)),
            'YYYY-"Q"Q'
        ) AS quarter,
        AVG(index_sa) AS avg_index_sa
    FROM hpi_state_analysis hsa 
    WHERE level = 'State'
      AND frequency = 'quarterly'
    GROUP BY 
        place_name,
        TO_CHAR(
            date_trunc('quarter', make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1)),
            'YYYY-"Q"Q'
        )
),
growth AS (
    SELECT 
        place_name,
        quarter,
        avg_index_sa,
        avg_index_sa - LAG(avg_index_sa) OVER (
            PARTITION BY place_name ORDER BY quarter
        ) AS quarterly_growth
    FROM base_data
)
SELECT *
FROM growth
ORDER BY quarterly_growth DESC NULLS LAST;
