SELECT * from interest_map
SELECT * from interest_metrics
SELECT * from json_data
                                 -- B. Segment Analysis
-- 1. Using our filtered dataset by removing the interests with less than 6 months worth of data, which are the top
--    10 and bottom 10 interests which have the largest composition values in any month_year? 
--    Only use the maximum composition value for each interest but you must keep the corresponding month_year



-- 2. Which 5 interests had the lowest average ranking value?

-- 3. Which 5 interests had the largest standard deviation in their percentile_ranking value?

-- 4. For the 5 interests found in the previous question - what was minimum and maximum percentile_ranking values 
-- for each interest and its corresponding year_month value? Can you describe what is happening for these 5 interests?

-- 5. How would you describe our customers in this segment based off their composition and ranking values?
-- What sort of products or services should we show to these customers and what should we avoid?
                               
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   
							   -- A. Data Exploration and Cleansing
-- 1. Update the fresh_segments.interest_metrics table by modifying the month_year column to be a date data type
-- with the start of the month
--Modify the length of column month_year so it can store 10 characters
ALTER TABLE dbo.interest_metrics
ALTER COLUMN month_year VARCHAR(10);

--Update values in month_year column
UPDATE interest_metrics
SET month_year =  CONVERT(DATE, '01-' + month_year, 105)

--Convert month_year to DATE
ALTER TABLE dbo.interest_metrics
ALTER COLUMN month_year DATE;


-- 2. What is count of records in the fresh_segments.interest_metrics for each month_year value sorted in 
-- chronological order (earliest to latest) with the null values appearing first?
SELECT month_year, 
       COUNT(*) AS no_of_records
from interest_metrics
group by month_year
order by month_year 


-- 3. What do you think we should do with these null values in the fresh_segments.interest_metrics
SELECT COUNT(*)
from interest_metrics
where month_year is NULL

SELECT *
from interest_metrics
where month_year is NULL

-- Removed all the NULL value

DELETE from interest_metrics
where month_year is null

-- 4. How many interest_id values exist in the fresh_segments.interest_metrics table but not in the 
-- fresh_segments.interest_map table? What about the other way around?
SELECT ( SELECT Count(interest_id)
from interest_metrics
where not exists (
                  SELECT id 
				  from interest_map
				  Where interest_metrics.interest_id = interest_map.id ) 
				  ) AS not_in_map ,
(
SELECT Count(id)
from interest_map
where not exists (
                  SELECT interest_id 
				  from interest_metrics
				  Where interest_metrics.interest_id = interest_map.id )  )AS not_in_metric


-- 5. Summarise the id values in the fresh_segments.interest_map by its total record count in this table
Select COUNT(*) As Total
from interest_map

-- 6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows 
-- where interest_id = 21246 in your joined output and include all columns from fresh_segments.interest_metrics 
-- and all columns from fresh_segments.interest_map except from the id column.
SELECT metrics.*,  map.* 
from interest_metrics AS metrics
Join interest_map AS map
on metrics.interest_id = map.id
where interest_id = 21246


SELECT * from interest_metrics
SELECT * from interest_map
-- 7. Are there any records in your joined table where the month_year value is before the created_at value from 
-- the fresh_segments.interest_map table? Do you think these values are valid and why?
SELECT COUNT(*) as cnt
from interest_metrics  metrics
join interest_map  map
on metrics.interest_id = map.id
WHERE metrics.month_year < CAST(map.created_at AS DATE);



UPDATE interest_metrics
SET _month = CASE WHEN _month = 'NULL' THEN NULL::INTEGER ELSE _month::INTEGER END;

-- This one is working : 
 -- Oh, NULL::INTERGER only works for PostgreSQL. For SQL Server, you should use CAST

UPDATE interest_metrics
SET _month = CASE WHEN _month = 'NULL' THEN CAST(NULL AS INTEGER) ELSE CAST(_month AS INTEGER) END;

UPDATE interest_metrics
SET _year = CASE WHEN _year = 'NULL' THEN CAST(NULL AS INTEGER) ELSE CAST(_year AS INTEGER) END;


-- To create and insert json_data table, you have to replace json with  nvarchar(MAX) if you using SQL Server.And you have to remove JSON from INSERT statement.


-- The data types text and varchar are incompatible in the equal to operator.

--UPDATE interest_map
--SET interest_summary = NULL
--WHERE Convert(VARCHAR , interest_summary) = (' ');