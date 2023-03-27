                                      2. Data Exploration
Select * from clean_weekly_sales

--1 What day of the week is used for each week_date value?
SELECT DATENAME(WEEKDAY,week_date) as Weekdate 
from clean_weekly_sales

--2 What range of week numbers are missing from the dataset?

/* This is correct syntax used to generate sequence number
WITH Emp_CTE (ID) AS
(
SELECT 1
UNION ALL

SELECT ID + 1 FROM Emp_CTE WHERE ID < 52
)
 SELECT * FROM Emp_CTE
*/



--3 How many total transactions were there for each year in the dataset?

SELECT calender_year, SUM(transactions) as total_transaction 
from  clean_weekly_sales
group by calender_year

--4 What is the total sales for each region for each month?
SELECT region,month_number, sum(cast(sales as bigint))
from clean_weekly_sales
group by region,month_number
order by region, month_number


--5 What is the total count of transactions for each platform
SELECT platform, SUM(transactions) as total_transactions
from clean_weekly_sales
group by platform

Select * from clean_weekly_sales 
--6 What is the percentage of sales for Retail vs Shopify for each month?
/*
With sales_cte As ( 
Select calender_year, month_number, PLATFORM, sum(cast(sales as bigint)) as monthly_sales
from clean_weekly_sales
group by calender_year, month_number, PLATFORM
)

SELECT calender_year, month_number,
       CAST(100.0 * MAX(CASE when PLATFORM = 'Shopify' then monthly_sales END) / sum(cast(sales as bigint)) as decimal (5,2)) as shp_Lmt,
	   CAST(100.0 * MAX(CASE when PLATFORM = 'Retail' then monthly_sales END) / sum(cast(sales as bigint)) as decimal (5,2))  as Ret_Lmt
from sales_cte
*/ 


--7 What is the percentage of sales by demographic for each year in the dataset?



--8 Which age_band and demographic values contribute the most to Retail sales?
/*
Declare @retailsales bigint = 
(
sum(cast(sales as bigint))
from clean_weekly_sales 
where platform = 'Retail'
)

SELECT age_band, demographic, sum(cast(sales as bigint)),
       Cast(Sum(cast(sales as bigint))/@retailsales as Decimal) as wer
from clean_weekly_sales
where platform = 'Retail' 
group by age_band, demographic

*/


--9 Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? 
-- If not - how would you calculate it instead?
SELECT 
      calender_year,
	  PLATFORM,
	  Round(AVG( avg_transaction),0) as avg_transaction
from clean_weekly_sales
group by calender_year, platform
order by calender_year