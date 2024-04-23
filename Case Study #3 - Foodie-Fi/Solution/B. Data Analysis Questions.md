
# Case Study #3: Foodie-Fi


### B. Data Analysis Questions

---
##  Solutions

### **Q1. How many customers has Foodie-Fi ever had?**

```sql
SELECT count (distinct customer_id) Total_customers
from subscriptions
```
#### Output:
| Total_customers  |
|--------------|
| 1000           |

---

### **Q2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value**

```SQL
SELECT datepart(month, start_date) start_month, count(customer_id) as total_customer
from subscriptions
where plan_id = 0 
group by datepart(month, start_date)
order by start_month
```
#### Output:
| months | distribution_values  |
|--------|----------------------|
| 1      | 88                   |
| 2      | 68                   |
| 3      | 94                   |
| 4      | 81                   |
| 5      | 88                   |
| 6      | 79                   |
| 7      | 89                   |
| 8      | 88                   |
| 9      | 87                   |
| 10     | 79                   |
| 11     | 75                   |
| 12     | 84                   |

---
### **Q3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name**

```SQL
SELECT plan_name, COUNT(customer_id) no_of_events
from plans p
join subscriptions s
on p.plan_id = s.plan_id 
where datepart(year, start_date) > 2020 
group by plan_name
```

#### Output:
| plan_name     | counts  |
|---------------|---------|
| basic monthly | 8       |
| churn         | 71      |
| pro annual    | 63      |
| pro monthly   | 60      |

---
### **Q4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?**

```
Declare @total_cust float = (SELECT count(distinct customer_id) from subscriptions)

SELECT COUNT(customer_id) as churned_customer,
COUNT(customer_id)/ @total_cust * 100 as churned_pct
from subscriptions
where plan_id = 4	
```
#### Output:
| churn_count | churn_pct   |
|-------------|-------------|
| 307         | 30.7        |

---

### **Q5. How many customers have churned straight after their initial free trial what percentage is this rounded to the nearest whole number?**

```
with cte as 
(
SELECT customer_id, p.plan_id,LEAD(p.plan_id) over(partition by customer_id order by start_date) nxt_plan
from plans p
join subscriptions s
on p.plan_id = s.plan_id
) ,
cte2 as (
select * 
from cte 
where plan_id = 0 and nxt_plan = 4
)

Select COUNT(customer_id) churn_after_trial, round(100 *count(customer_id)/
               (SELECT count(DISTINCT customer_id) AS 'distinct customers'
                FROM subscriptions), 2) AS churn_pct
from cte2

```

#### Output:
| churn_after_trial | pct         |
|-------------------|-------------|
| 92                | 9           |

---

### **Q6. What is the number and percentage of customer plans after their initial free trial?**

```
WITH next_plans AS (
  SELECT 
    customer_id, 
    plan_id, 
    LEAD(plan_id) OVER(
      PARTITION BY customer_id 
      ORDER BY plan_id) as next_plan_id
  FROM subscriptions
)

SELECT 
  next_plan_id AS plan_id, 
  COUNT(customer_id) AS converted_customers,
  ROUND(100 * 
    COUNT(customer_id) 
    / (SELECT COUNT(DISTINCT customer_id) 
      FROM subscriptions)
  ,1) AS conversion_percentage
FROM next_plans
WHERE next_plan_id IS NOT NULL 
  AND plan_id = 0
GROUP BY next_plan_id
ORDER BY next_plan_id;

```
#### Output:

| plan_id     | customer_plan | percentage  |
|-------------|---------------|-------------|
| 1           | 546           | 54          |
| 2           | 325           | 32          |
| 3           | 37            | 3           |
| 4           | 92            | 9           |


---

### **Q7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

```
WITH latest_plan_cte AS
  (SELECT customer_id, plans.plan_id, plan_name,
          row_number() over(PARTITION BY customer_id
                            ORDER BY start_date DESC) AS latest_plan
   FROM subscriptions
   JOIN plans 
   on subscriptions.plan_id = plans.plan_id
   WHERE start_date <='2020-12-31' )
SELECT plan_id,
       plan_name,
       count(customer_id) AS customer_count,
       CAST(100*COUNT(*) AS FLOAT) 
      / (SELECT COUNT(DISTINCT customer_id) FROM subscriptions) AS conversion_rate
                
FROM latest_plan_cte
WHERE latest_plan = 1
GROUP BY plan_id, plan_name
ORDER BY plan_id;
```
#### Output:
| plan_id | plan_name     | customer_count | conversion_rate  |
|---------|---------------|-----------|------------------|
| 0       | trial         | 19        | 1.9              |
| 1       | basic monthly | 224       | 22.4             |
| 2       | pro monthly   | 326       | 32.6             |
| 3       | pro annual    | 195       | 19.5             |
| 4       | churn         | 236       | 23.6             |

---

### **Q8. How many customers have upgraded to an annual plan in 2020?**
```
SELECT count(customer_id) total_customer
from subscriptions
where DATEPART(YEAR, start_date) = 2020 and plan_id = 3
```
#### Output:
| total_customer | 
| -----------    | 
| 195            |


---

### **Q9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?**

```
WITH annual_customer AS 
(
  SELECT customer_id,plan_id, start_date, Lead(start_date) over(partition by customer_id order by customer_id) as Annual_plan_date,
DATEDIFF(day, start_date,Lead(start_date) over(partition by customer_id order by customer_id)) as diff_in_day
from subscriptions
where plan_id in (0,3) 
)
SELECT AVG(diff_in_day) as avg_day
from annual_customer

```
#### Output:
| avg_day     |
|-------------|
| 104         |

### **Q10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)**

### **Q11 How many customers downgraded from a pro monthly to a basic monthly plan in 2020?**

```
WITH downgraded_cust AS 
(
 SELECT 
        customer_id,
		plan_id, start_date,
		Lead(plan_id) over(partition by customer_id order by customer_id) as down_plan
from subscriptions
WHERE plan_id in (1,2) and YEAR(start_date) = 2020
)
SELECT COUNT(down_plan) total_cust_downgraded
from downgraded_cust 
where down_plan = 1

```
#### Output:
| total_cust_downgraded    |
|--------------------------|
| 0                        |


