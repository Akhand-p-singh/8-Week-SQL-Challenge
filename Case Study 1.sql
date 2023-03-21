SELECt * from members
select * from menu
select * from sales


**Question 1**
-- 1. What is the total amount each customer spent at the restaurant?
```sql
SELECT SUM(price) AS Total_Amt_spend, customer_id
from sales
join menu
on sales.product_id = menu.product_id
group by customer_id
```

-- 2. How many days has each customer visited the restaurant?

SELECT  customer_id, Count(distinct order_date) AS No_of_times_visited
from sales
group by customer_id

-- 3. What was the first item from the menu purchased by each customer?
/*
WITH CTE AS (
SELECT  product_name, min(order_date) AS First_order_date,  customer_id
from menu
join sales
on menu.product_id = sales.product_id
group by product_name, customer_id
)

SELECT members.customer_id, cte.product_name,  cte.First_order_date
from members
join cte
on members.customer_id = cte.customer_id
*/


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT top 1 menu.product_name, COUNT(order_date) as total_time
from menu
join sales
on menu.product_id = sales.product_id
group by menu.product_id, menu.product_name
order by total_time desc


-- 5. Which item was the most popular for each customer?
/*
SELECT menu.product_name, COUNT(sales.order_date)
from menu
join sales
on menu.product_id = sales.product_id
Group by menu.product_name
*/


-- 6. Which item was purchased first by the customer after they became a member?

WITH CTE AS 
( SELECT members.customer_id , sales.product_id, sales.order_date, members.join_date, row_number() over(partition by members.customer_id order by members.customer_id) as rnk
from members
join sales
on members.customer_id = sales.customer_id
WHERE order_date >= join_date 
)
select  menu.product_name, cte.order_date, cte.join_date
from cte
join menu
on menu.product_id = CTE.product_id
WHERE rnk = 1


-- 7. Which item was purchased just before the customer became a member?

WITH CTE AS 
( SELECT members.customer_id , sales.product_id, sales.order_date, members.join_date, row_number() over(partition by members.customer_id order by members.customer_id) as rnk
from members
join sales
on members.customer_id = sales.customer_id
WHERE order_date < join_date 
)
select  menu.product_name, cte.order_date, cte.join_date
from cte
join menu
on menu.product_id = CTE.product_id
WHERE rnk = 1

-- 8. What is the total items and amount spent for each member before they became a member?
with cte as (
SELECT customer_id, sales.order_date, sum(price) AS Total_amount, COUNT(order_date) Total_items
from menu
join sales
on menu.product_id = sales.product_id
Group by customer_id,sales.order_date
)

SELECT *
from members
join cte
on members.customer_id = cte.customer_id
WHERE order_date > join_date


-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT sales.customer_id, Sum(menu.price) total_Amount_spent, SUM(CASE WHEN menu.product_id = 1  then  20*price else 10*price END) as points
from menu
join sales
on menu.product_id = sales.product_id
GROUP BY sales.customer_id


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi -
-- how many points do customer A and B have at the end of January?

SELECT *
from sales
join members
