-- we are seeing the top 10 and bottom 10 areas overall based on price growth overtime , i want to track each states full timeline 
-- Absolute Growth


-- lets check 







WITH base_data AS (
    SELECT 
        place_name,
        TO_CHAR(
            date_trunc('quarter', make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1)),
            'YYYY-"Q"Q'
        ) AS quarter,
        index_sa
    FROM hpi_state_analysis hsa 
    WHERE level = 'State'
      AND frequency = 'quarterly'
),
ranked_data AS (
    SELECT 
        place_name,
        quarter,
        index_sa,
        ROW_NUMBER() OVER (PARTITION BY place_name ORDER BY quarter ASC) AS rn_asc,
        ROW_NUMBER() OVER (PARTITION BY place_name ORDER BY quarter DESC) AS rn_desc
    FROM base_data
),
first_last_values AS (
    SELECT
        place_name,
        MAX(CASE WHEN rn_asc = 1 THEN index_sa END) AS first_index,
        MAX(CASE WHEN rn_desc = 1 THEN index_sa END) AS last_index,
        MAX(CASE WHEN rn_desc = 1 THEN quarter END) AS last_quarter,
        MAX(CASE WHEN rn_asc = 1 THEN quarter END) AS first_quarter
    FROM ranked_data
    GROUP BY place_name
),
growth_summary AS (
    SELECT 
        place_name,
        first_quarter,
        last_quarter,
        first_index,
        last_index,
        last_index - first_index AS total_growth,
        ROUND(((last_index - first_index) / first_index) * 100, 2) AS percentage_growth
    FROM first_last_values
)
-- Final Output
(
    SELECT *
    FROM growth_summary
    ORDER BY total_growth DESC
    LIMIT 5  -- Top performing areas by absolute growth
)
UNION ALL
(
    SELECT *
    FROM growth_summary
    ORDER BY total_growth ASC
    LIMIT 5  -- Lowest or negative growth areas by absolute growth

);
