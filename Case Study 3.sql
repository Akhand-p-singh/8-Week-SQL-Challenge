SELECT * FROM plans
SELECT * FROM subscriptions


                          -- B. Data Analysis Questions

-- 11 How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
WITH downgraded_cust AS 
(
 SELECT 
        customer_id,
		plan_id, start_date,
		Lead(plan_id) over(partition by customer_id order by customer_id) as down_plan
from subscriptions
WHERE plan_id in (1,2) and YEAR(start_date) = 2020
)
SELECT COUNT(down_plan)
from downgraded_cust 
where down_plan = 1

-- 10 Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)


-- 9 How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
WITH annual_customer AS 
(
  SELECT customer_id,plan_id, start_date, Lead(start_date) over(partition by customer_id order by customer_id) as Annual_plan_date,
DATEDIFF(day, start_date,Lead(start_date) over(partition by customer_id order by customer_id)) as diff_in_day
from subscriptions
where plan_id in (0,3) 
)
SELECT AVG(diff_in_day) as avg_days
from annual_customer



-- 8 How many customers have upgraded to an annual plan in 2020?
SELECT count(customer_id)
from subscriptions
where DATEPART(YEAR, start_date) = 2020 and plan_id = 3


-- 7 What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
/* SELECT customer_id,p.plan_name,LEAD(p.plan_name,1) OVER (PARTITION BY customer_id ORDER BY s.start_date) AS next_plan 
-- Ordering by start_date ensures that the next_plan value is the next plan opted by the customer and not the next plan_id in serial order (which happens when you order by plan_id)
FROM subscriptions s
JOIN plans p
ON s.plan_id = p.plan_id
WHERE start_date <= '2020-12-31' */


-- 6 What is the number and percentage of customer plans after their initial free trial?
--SELECT customer_id, plan_id, lead(plan_id, 1) over(partition by customer_id order by plan_id)
--from subscriptions



-- 5 How many customers have churned straight after their initial free trial - 
-- what percentage is this rounded to the nearest whole number?
correct way: Use of case and lag function
   


/*SELECT customer_id, s.plan_id, ROW_NUMBER() over(partition by customer_id order by customer_id)
from plans p
join subscriptions s
on p.plan_id = s.plan_id
where s.plan_id in (1, 4)*/


-- 4 What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

Declare @total_cust float = (SELECT count(distinct customer_id) from subscriptions)

SELECT COUNT(customer_id) as churned_customer,
COUNT(customer_id)/ @total_cust * 100 as churned_cust
from subscriptions
where plan_id = 4

-- 3 What plan start_date values occur after the year 2020 for our dataset? 
-- Show the breakdown by count of events for each plan_name

SELECT plan_name, COUNT(customer_id)
from plans p
join subscriptions s
on p.plan_id = s.plan_id 
where datepart(year, start_date) > 2020 
group by plan_name


-- 2 What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month
-- as the group by value

SELECT datepart(month, start_date) start_month, count(customer_id) as total_customer
from subscriptions
where plan_id = 0 
group by datepart(month, start_date)
order by start_month

-- 1 How many customers has Foodie-Fi ever had?
SELECT count (distinct customer_id) Total_customers
from subscriptions





                            /* A. Customer Journey
Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about
each customer’s onboarding journey.

Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier! */

SELECT s.customer_id, p.plan_name, s.start_date,DATEDIFF(day, LAG(start_date) over(partition by customer_id order by customer_id),start_date) as day_diff
from plans p
join subscriptions s
on p.plan_id = s.plan_id
WHERE customer_id in (2,4,6,8,10,12,14,16)

-- Insight based on random 8 customer.

/* customer 4 and 6 tried our basic monthly plan then after 88 and 58 days respectively they left. 
customer 16 is the only customer with pro annual subscription. */