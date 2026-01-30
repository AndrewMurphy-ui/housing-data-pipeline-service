

create index idx_housing_trends_state
on hpi_state_analysis(level, frequency, yr, period, place_name);

CREATE INDEX idx_housing_trends_state_date
ON hpi_state_analysis ((make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1)));


-- We need to convert the date to integer cause some columns might be a string 

SELECT 
    make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1) AS date,
    place_name,
    index_sa
FROM hpi_state_analysis
WHERE level = 'State'
  AND frequency = 'quarterly'
ORDER BY CAST(yr AS INTEGER), CAST(period AS INTEGER), place_name;


EXPLAIN ANALYZE
SELECT 
    make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1) AS date,
    place_name,
    index_sa
FROM hpi_state_analysis
WHERE level = 'State'
  AND frequency = 'quarterly'
ORDER BY CAST(yr AS INTEGER), CAST(period AS INTEGER), place_name;

-- i see that the index was not used in this query even though i made a index, it depends on postgreswl it may use a index or not to see if its more optimial 

ANALYZE hpi_state_analysis;


-- i see that its using sequental scan not index seek , sequental scan is non-indexed scan reading data from a table 
-- i see why the index was not used, makes sense logically the index you created doesnt correlate to the query of house price trends overtime 
-- postgresql uses a cost estimation to decide whether using an index or doing a sequental scan is more effecient 
SELECT COUNT(*) FROM hpi_state_analysis;

SET enable_seqscan TO off;
EXPLAIN ANALYZE 
SELECT 
    make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1) AS date,
    place_name,
    index_sa
FROM hpi_state_analysis
WHERE level = 'State'
  AND frequency = 'quarterly'
ORDER BY CAST(yr AS INTEGER), CAST(period AS INTEGER), place_name;

-- creating a table to view this in power BI 

CREATE TABLE house_price_trends AS
SELECT 
    make_date(CAST(yr AS INTEGER), CAST(period AS INTEGER) * 3, 1) AS date,
    place_name,
    index_sa
FROM hpi_state_analysis
WHERE level = 'State'
  AND frequency = 'quarterly'
ORDER BY date, place_name;
