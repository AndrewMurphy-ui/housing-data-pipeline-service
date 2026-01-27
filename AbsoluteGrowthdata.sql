WITH base_data AS (
  SELECT
    place_name,
    date_trunc('quarter', make_date(yr::int, (period::int) * 3, 1)) AS quarter_start,
    index_sa
  FROM hpi_state_analysis
  WHERE level = 'State'
    AND frequency = 'quarterly'
),
first_last AS (
  SELECT DISTINCT
    place_name,
    FIRST_VALUE(index_sa) OVER (PARTITION BY place_name ORDER BY quarter_start)      AS first_index,
    FIRST_VALUE(quarter_start) OVER (PARTITION BY place_name ORDER BY quarter_start) AS first_quarter,
    FIRST_VALUE(index_sa) OVER (PARTITION BY place_name ORDER BY quarter_start DESC) AS last_index,
    FIRST_VALUE(quarter_start) OVER (PARTITION BY place_name ORDER BY quarter_start DESC) AS last_quarter
  FROM base_data
),
growth AS (
  SELECT
    place_name,
    to_char(first_quarter, 'YYYY-"Q"Q') AS first_quarter,
    to_char(last_quarter,  'YYYY-"Q"Q') AS last_quarter,
    first_index,
    last_index,
    (last_index - first_index) AS total_growth,
    ROUND(((last_index - first_index) / NULLIF(first_index, 0)) * 100, 2) AS percentage_growth
  FROM first_last
),
ranked AS (
  SELECT
    *,
    DENSE_RANK() OVER (ORDER BY total_growth DESC) AS r_top,
    DENSE_RANK() OVER (ORDER BY total_growth ASC)  AS r_bottom
  FROM growth
)
SELECT *
FROM ranked
WHERE r_top <= 5 OR r_bottom <= 5
ORDER BY
  CASE
    WHEN r_top <= 5 THEN 1
    ELSE 2
  END,
  total_growth DESC;


