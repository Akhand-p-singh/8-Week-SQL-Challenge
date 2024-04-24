
# Case Study #2: Pizza Runner
---
## Solution - A. Pizza Metrics

---
## 🚀 Solutions

### **1. How many pizzas were ordered?**
```sql
SELECT COUNT(order_id)as Delivered_pizza
from customer_orders
```
#### Output:
| Delivered_pizza  |
|--------------|
| 14           |
---

### **Q2. How many unique customer orders were made?**

```SQL
select count(distinct order_id) as unique_customers
from customer_orders
```
#### Output:
| unique_customers |
|--------------|
| 10           |

---
### **Q3. How many successful orders were delivered by each runner?**

```SQL
SELECT runner_id, COUNT(order_id) as no_of_order_delivered
from cleaned_runner_orders
where cancellation is NULL
group by runner_id
```

#### Output:
| runner_id | no_of_order_delivered  |
|-----------|--------------------|
| 1         | 4                  |
| 2         | 3                  |
| 3         | 1                  |
---
### **Q4. How many of each type of pizza was delivered?**

```
SELECT CAST(pizza_name AS VARCHAR(MAX)) AS pizza_name, COUNT(co.order_id) AS total_order
FROM customer_orders co
JOIN pizza_names pn ON pn.pizza_id = co.pizza_id
join runner_orders ro ON  co.order_id = ro.order_id
GROUP BY CAST(pizza_name AS VARCHAR(MAX));
```
#### Output:
| pizza_name | total_order    |
|------------|----------------|
| Meatlovers | 10             |
| Vegetarian | 4              |

---

### **Q5. How many Vegetarian and Meatlovers were ordered by each customer?**

```
SELECT 
  customer_id,
  SUM(CASE WHEN pizza_id = 1 THEN 1 ELSE 0 END) AS Meatlovers,
  SUM(CASE WHEN pizza_id = 2 THEN 1 ELSE 0 END) AS Vegetarian
FROM customer_orders
GROUP BY customer_id;

```

#### Output:
| customer_id | Meatlovers | Vegetarian  |
|-------------|------------|-------------|
| 101         | 2          | 1           |
| 102         | 2          | 1           |
| 103         | 3          | 1           |
| 104         | 3          | 0           |
| 105         | 0          | 1           |

---

### **Q6. What was the maximum number of pizzas delivered in a single order?**

```
SELECT top 1 order_id, count(order_id) no_of_times_pizza_ordered
from customer_orders
group by order_id
order by no_of_times_pizza_ordered desc


```
#### Output:

| order_id | no_of_times_pizza_ordered    |
|------------|----------------|
| 4 | 3            |


---

### **Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

```
SELECT 
  coc.customer_id,
  SUM(CASE WHEN (exclusions IS NOT NULL OR extras IS NOT NULL) THEN 1 ELSE 0 END) AS change_in_pizza,
  SUM(CASE WHEN (exclusions IS NULL AND extras IS NULL) THEN 1 ELSE 0 END) AS no_change_in_pizza
FROM cleaned_customer_orders AS coc
INNER JOIN cleaned_runner_orders AS roc 
  ON coc.order_id = roc.order_id
WHERE roc.cancellation IS NULL
  OR roc.cancellation NOT IN  ('Restaurant Cancellation', 'Customer Cancellation')
GROUP BY coc.customer_id
ORDER BY coc.customer_id;
```
#### Output:
| customer_id | change_in_pizza | no_change_in_pizza  |
|-------------|------------|------------|
| 101         | 0          | 2          |
| 102         | 0          | 3          |
| 103         | 3          | 0          |
| 104         | 2          | 1          |
| 105         | 1          | 0          |

---

### **Q8. How many pizzas were delivered that had both exclusions and extras?**
```

SELECT  
  SUM(
    CASE WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN 1
    ELSE 0
    END) AS pizza_count
FROM cleaned_customer_orders AS c
JOIN cleaned_runner_orders AS r
  ON c.order_id = r.order_id
WHERE r.distance >= 1 
  AND exclusions <> ' ' 
  AND extras <> ' '; 
```
#### Output:
| pizza_count | 
| ----------- | 
| 1           |


---

### **Q9. What was the total volume of pizzas ordered for each hour of the day?**

```
SELECT 
     DATEPART(HOUR, order_time) as hour_of_day,
	 COUNT(pizza_id) as total_orders
FROM customer_orders
GROUP BY DATEPART(HOUR, order_time)

```
#### Output:
| hour_of_day | total_orders  |
|-------------|---------------|
| 11          | 1             |
| 13          | 3             |
| 18          | 3             |
| 19          | 1             |
| 21          | 3             |
| 23          | 3             |

### **Q10. What was the volume of orders for each day of the week?**

```
SELECT 
	FORMAT(order_time, 'dddd') as day_of_week,
	COUNT(pizza_id) as total_orders
FROM customer_orders
GROUP BY FORMAT(order_time, 'dddd');
```
#### Output:
| week_day  | order_volume  |
|-----------|---------------|
| Friday    | 1             |
| Saturday  | 5             |
| Thursday  | 3             |
| Wednesday | 5             |

