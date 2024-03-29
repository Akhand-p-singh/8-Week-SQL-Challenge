  /*   1. Data Cleaning Steps
In a single query, perform the following operations and generate a new table in the data_mart schema named clean_weekly_sales:


-- 1. Convert the week_date to a DATE format

-- 2. Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc

-- 3. Add a month_number with the calendar month for each week_date value as the 3rd column

-- 4. Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values

--5 Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value

segment	         age_band
  1	            Young Adults
  2	            Middle Aged
3 or 4	          Retirees

--6 Add a new demographic column using the following mapping for the first letter in the segment values:

segment	          demographic
  C	                Couples
  F	                Families

--7 Ensure all null string values with an "unknown" string value in the original segment column as well as the new age_band and demographic columns

--8 Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record
*/



SELECT
     CONVERT(date, week_date, 3) as week_date,                            --1
     DATEPART(week, CONVERT(date, week_date, 3)) as week_number,          --2
	 DATEPART(month, CONVERT(date, week_date, 3)) as month_number,        --3
	 DATEPART(year, CONVERT(date, week_date, 3)) as calender_year,        --4
	 region, 
     platform, 
     segment,
	 sales,
	 transactions,
	 CASE                                                                  --5
	     When segment Like '%1' then  'Young Adults'
		 When segment Like '%2' then  'Middle Aged'
		 When segment Like '%3' or segment like '%4' then  'Retires'
		 else 'unknown'                                                    --7
		 end as age_band,
	 CASE                                                                  --6   
	     When segment Like '%C%' then 'Couples'
		 When segment Like '%F%' then 'Families'
		 else 'unknown'                                                    --7
		 end as demographic,
	 ROUND(CAST(sales AS FLOAT)/transactions, 2) AS avg_transaction        --8
	 INTO clean_weekly_sales
from data_mart


                            