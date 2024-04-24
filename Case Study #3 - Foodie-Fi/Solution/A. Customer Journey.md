
# 🌽 Case Study #3: Foodie-Fi

### A. Customer Journey

----
## 🚀 Solutions

#### Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.

```
SELECT s.customer_id, p.plan_name, s.start_date,DATEDIFF(day, LAG(start_date) over(partition by customer_id order by customer_id),start_date) as day_diff
from plans p
join subscriptions s
on p.plan_id = s.plan_id
WHERE customer_id in (2,4,6,8,10,12,14,16)
```
#### Output:

| customer_id | plan_name     | start_date | day_diff |
|-------------|---------------|------------|----------|
| 2           | trial         | 2020-09-20 | NULL     |
| 2           | pro annual    | 2020-09-27 | 7        |
| 4           | trial         | 2020-01-17 | NULL     |
| 4           | basic monthly | 2020-01-24 | 7        |
| 4           | churn         | 2020-04-21 | 88       |
| 6           | trial         | 2020-12-23 | NULL     |
| 6           | basic monthly | 2020-12-30 | 7        |
| 6           | churn         | 2020-02-26 | 58       |
| 8           | trial         | 2021-08-11 | NULL     |
| 8           | basic monthly | 2020-06-18 | 7        |
| 8           | pro monthly   | 2020-08-03 | 46       |
| 10          | trial         | 2020-09-19 | NULL     |
| 10          | pro monthly   | 2020-09-26 | 7        |
| 12          | trial         | 2020-09-22 | NULL     |
| 12          | basic monthly | 2020-09-29 | 7        |
| 14          | trial         | 2020-09-22 | NULL     |
| 14          | basic monthly | 2020-09-29 | 7        |
| 16          | trial         | 2020-05-31 | NULL     |
| 16          | basic monthly | 2020-06-07 | 7        |
| 16          | pro annual    | 2022-10-21 | 136      |

### Insight based on these 8 random customer.

**Note:**

* Customer 4 and 6 tried our basic monthly plan then after 88 and 58 days respectively they left.

* Customer 16 is the only customer with pro annual subscription.