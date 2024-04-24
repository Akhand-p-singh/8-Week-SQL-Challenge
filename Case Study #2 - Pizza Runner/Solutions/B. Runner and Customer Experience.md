
# Case Study #2:  Runner and Customer Experience
---
### B. Runner and Customer Experience
---
## 🚀 Solutions

### **1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)**
```sql
SELECT DATEPART(WEEK,  registration_DATE) as week, COUNT(runner_id) as count
from runners
group by DATEPART(WEEK,  registration_DATE)
```
#### Output:
| week | count  |
|-------------|---------------|
| 1           | 1             |
| 2           | 2             |
| 3           | 1             |

---

### **Q2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?**

```SQL

SELECT ro.runner_id,  AVG(DATEDIFF(MINUTE, co.order_time ,  ro.pickup_time )) avg_time
from cleaned_runner_orders ro
join cleaned_customer_orders co
on ro.order_id =  co.order_id
where cancellation is Null
group by ro.runner_id
```
#### Output:
| runner_id | avg_time |
|-----------|---------------------|
| 1         | 15                  |
| 2         | 14                  |
| 3         | 10                  |

---
### **Q3 Is there any relationship between the number of pizzas and how long the order takes to prepare?**

```SQL
with cte 
as ( 
SELECT  COUNT(pizza_id) pizza_order, DATEDIFF(MINUTE , co.order_time, ro.pickup_time) time_taken_per_order
from cleaned_customer_orders co
join cleaned_runner_orders ro
on co.order_id = ro.order_id
where cancellation is Null
group by  co.order_time, ro.pickup_time
)

select pizza_order, AVG(time_taken_per_order) avg_time
from cte
group by pizza_order
```

#### Output:
| pizza_order | avg_time  |
|-----------|--------------------|
| 1         | 12                  |
| 2         | 18                  |
| 3         | 30                  |
---
### **Q4. What was the average distance travelled for each customer?**

```
SELECT co.customer_id, round(AVG(ro.distance),2) average_distance
from cleaned_customer_orders co
join cleaned_runner_orders ro
on co.order_id = ro.order_id 
group by co.customer_id
```
#### Output:
| customer_id | average_distance  |
|-------------|-------------------|
| 101         | 20                |
| 102         | 16.7              |
| 103         | 23.4              |
| 104         | 10                |
| 105         | 25                |

---

### **Q5. What was the difference between the longest and shortest delivery times for all orders?**

```
SELECT MAX(duration) - Min(duration) as time_diff
from cleaned_runner_orders

```

#### Output:
| time_diff|
|----------------|
| 30             |

---

### **Q6. What was the average speed for each runner for each delivery and do you notice any trend for these values?**

```
Select runner_id, order_id,distance, duration , round(distance/duration * 60, 2) avg_speed
from cleaned_runner_orders
where cancellation is null
order by runner_id,  round(distance/duration * 60, 2) 

```
#### Output:

| runner_id | order_id | distance | duration_min | avg_speed  |
|-----------|----------|----------|--------------|------------|
| 1         | 1        | 20       | 32           |  37.5      |
| 1         | 2        | 20       | 27           |  44.4      |
| 1         | 3        | 13.4     | 20           | 40.2       |
| 1         | 10       | 10       | 10           |  60        |
| 2         | 4        | 23.4     | 40           | 35.1       |
| 2         | 7        | 25       | 25           | 60         |
| 2         | 8        | 23.4     | 15           | 93.6       |
| 3         | 5        | 10       | 15           |  40        |


---

### **7. What is the successful delivery percentage for each runner?**

```
select runner_id, COUNT(order_id) total_order, COUNT(pickup_time) total_orders_delivered, 
cast(COUNT(pickup_time)as float)/ cast(COUNT(order_id) as float) * 100.0  as successful_delivery_percent
from cleaned_runner_orders
group by runner_id
```
#### Output:
| runner_id | total_order | total_orders_delivered | successful_delivery_percent |
|-----------|-----------|-------|-----------------|
| 1         | 4         | 4     | 100             |
| 2         | 4         | 3     | 75              |
| 3         | 2         | 1     | 50              |

---
