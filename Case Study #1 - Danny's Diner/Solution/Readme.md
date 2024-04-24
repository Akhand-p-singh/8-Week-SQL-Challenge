
# 🍴 Case Study #1: Danny's Dinner


## 🚀 Solutions
---

### **Q1. What is the total amount each customer spent at the restaurant?**
```sql
SELECT  customer_id, SUM(price) AS Total_amt_spend
from sales 
join menu
on sales.product_id = menu.product_id
group by customer_id
```
#### Output:
| customer_id | total_spent |
| ----------- | ----------- |
| A           | 76          |
| B           | 74          |
| C           | 36          |

---

### **Q2. How many days has each customer visited the restaurant?**

```SQL
SELECT  customer_id, Count(distinct order_date) AS No_of_times_visited
from sales
group by customer_id
```
#### Output:
|customer_id|visited_days|
|-----------|------------|
|A          |4           |
|B          |6           |
|C          |2           |

---
### **Q3. What was the first item from the menu purchased by each customer?**

```SQL
With cte as ( 
select product_name, customer_id, MIN(order_date) dte , DENSE_RANK() over(partition by  customer_id order by MIN(order_date)) as rnk
from menu
join sales
on menu.product_id = sales.product_id
group by product_name, customer_id
)
select customer_id, product_name
from cte
where rnk = 1
```

#### Output:
| customer_id | product_name |
| ----------- | ------------ |
| A           | curry        |
| A           | sushi        |
| B           | curry        |
| C           | ramen        |

---
### **Q4. What is the most purchased item on the menu and how many times was it purchased by all customers?**

```
SELECT top 1 menu.product_name, COUNT(order_date) as total_time
from menu
join sales
on menu.product_id = sales.product_id
group by menu.product_id, menu.product_name
order by total_time desc
```
#### Output:
|product_name|total_time|
|------------|-----------|
|ramen       |8          |

---

### **Q5. Which item was the most popular for each customer?**

```
With cte as 
(
		select sales.customer_id, product_name, COUNT(menu.product_name)  cnt,
		DENSE_RANK() over(partition by customer_id order by COUNT(menu.product_name) desc) as rnk
from sales
join menu 
on menu.product_id = sales.product_id
group by customer_id, product_name
)

Select customer_id, product_name, cnt
from cte 
where rnk = 1
```

#### Output:
| customer_id | product_name | cnt |
| ----------- | ---------- |------------  |
| A           | ramen        |  3   |
| B           | sushi        |  2   |
| B           | curry        |  2   |
| B           | ramen        |  2   |
| C           | ramen        |  3   |

---

### **Q6. Which item was purchased first by the customer after they became a member?**

```
WITH CTE AS 
( SELECT members.customer_id , sales.product_id, sales.order_date, members.join_date, row_number() over(partition by members.customer_id order by members.customer_id) as rnk
from members
join sales
on members.customer_id = sales.customer_id
WHERE order_date >= join_date 
)
select  customer_id, menu.product_name, cte.order_date
from cte
join menu
on menu.product_id = CTE.product_id
WHERE rnk = 1


```
#### Output:

| customer_id | product_name | order_date               |
| ----------- | ------------ | ------------------------ |
| A           | curry        | 2021-01-07 | 
| B           | sushi        | 2021-01-11 | 

---

### **Q7. Which item was purchased just before the customer became a member?**

```
WITH CTE AS 
( SELECT members.customer_id , sales.product_id, sales.order_date, members.join_date, row_number() over(partition by members.customer_id order by members.customer_id) as rnk
from members
join sales
on members.customer_id = sales.customer_id
WHERE order_date < join_date 
)
select  customer_id, menu.product_name, cte.order_date
from CTE
join menu
on menu.product_id = CTE.product_id
WHERE rnk = 1
```
#### Output:
| customer_id | product_name | order_date               |
| ----------- | ------------ | ------------------------ |
| A           | sushi        | 2021-01-01 |
| B           | curry        | 2021-01-01 |

---

### **Q8. What is the total items and amount spent for each member before they became a member?**
```
SELECT sales.Customer_id, sum(price) AS Total_amount, COUNT(product_name) Total_items
from menu
inner join sales on menu.product_id = sales.product_id
INNER JOIN members AS mem ON mem.customer_id = sales.customer_id
WHERE order_date < join_date
Group by sales.customer_id
```
#### Output:
| Customer_id | Total_spent | Total_items |
| ----------- | ----------- | ----------- |
| A           | 25          | 2           |
| B           | 40          | 3           |

---

### **Q9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?**

```
SELECT sales.customer_id, SUM(CASE WHEN menu.product_id = 1  then  20*price else 10*price END) as total_points
from menu
join sales
on menu.product_id = sales.product_id
GROUP BY sales.customer_id
```
#### Output:
| customer_id | total_points | 
| ----------- | ---------- |
| A           | 860 |
| B           | 940 |
| C           | 360 |

### **Q10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?**

```
With cte as 
(
SELECT members.customer_id, order_date, join_date, price, (case when DATEDIFF(day, order_date, join_date) <=7  then price*2
else price end) as points

from sales
join menu on sales.product_id = menu.product_id
join members on members.customer_id = sales.customer_id
)

Select customer_id, SUM(points) points
from cte
where order_date <= '2021-01-31'
group by customer_id
```
#### Output:
| customer_id | points |
| ----------- | ------------ |
| A           | 152          |
| B           | 109          |