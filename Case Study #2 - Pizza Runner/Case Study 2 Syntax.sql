select * from customer_orders    
select * from cleaned_customer_orders 
					  
					  
					  
					  --  A. Pizza Metrics  --


-- 1 How many pizzas were ordered?

SELECT COUNT(order_id)as Delivered_pizza
from customer_orders

-- 2 How many unique customer orders were made?

select count(distinct order_id) as unique_customers
from customer_orders


-- 3 How many successful orders were delivered by each runner?

SELECT runner_id, COUNT(order_id) as no_of_order_delivered
from cleaned_runner_orders
where cancellation is NULL
group by runner_id



-- 4 How many of each type of pizza was delivered?

SELECT CAST(pizza_name AS VARCHAR(MAX)) AS pizza_name, COUNT(co.order_id) AS total_order
FROM customer_orders co
JOIN pizza_names pn ON pn.pizza_id = co.pizza_id
join runner_orders ro ON  co.order_id = ro.order_id
GROUP BY CAST(pizza_name AS VARCHAR(MAX));


-- Changing Data type:

ALTER TABLE pizza_names
ALTER COLUMN pizza_name VARCHAR(MAX);


-- 5 How many Vegetarian and Meatlovers were ordered by each customer?

SELECT 
  customer_id,
  SUM(CASE WHEN pizza_id = 1 THEN 1 ELSE 0 END) AS Meatlovers,
  SUM(CASE WHEN pizza_id = 2 THEN 1 ELSE 0 END) AS Vegetarian
FROM customer_orders
GROUP BY customer_id;


-- 6 What was the maximum number of pizzas delivered in a single order?

SELECT top 1 order_id, count(order_id) no_of_times_pizza_ordered
from customer_orders
group by order_id
order by no_of_times_pizza_ordered desc



-- 7 For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

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

-- 8 How many pizzas were delivered that had both exclusions and extras?


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


-- 9 What was the total volume of pizzas ordered for each hour of the day?
SELECT 
     DATEPART(HOUR, order_time) as hour_of_day,
	 COUNT(pizza_id) as total_orders
FROM customer_orders
GROUP BY DATEPART(HOUR, order_time)

-- 10 What was the volume of orders for each day of the week?
SELECT 
	FORMAT(order_time, 'dddd') as day_of_week,
	COUNT(pizza_id) as total_orders
FROM customer_orders
GROUP BY FORMAT(order_time, 'dddd');


                                --  B. Runner and Customer Experience  -- 

--1 How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT DATEPART(WEEK,  registration_DATE) as Week, COUNT(runner_id) as count
from runners
group by DATEPART(WEEK,  registration_DATE)




-- 2 What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

SELECT ro.runner_id,  AVG(DATEDIFF(MINUTE, co.order_time ,  ro.pickup_time ))
from runner_orders ro
join customer_orders co
on ro.order_id =  co.order_id
where cancellation is Null
group by ro.runner_id


-- 3 Is there any relationship between the number of pizzas and how long the order takes to prepare?
with cte 
as ( 
SELECT  COUNT(pizza_id) pizza_order, DATEDIFF(MINUTE , co.order_time, ro.pickup_time) time_taken_per_order
from customer_orders co
join runner_orders ro
on co.order_id = ro.order_id
where cancellation is Null
group by  co.order_time, ro.pickup_time
)

select pizza_order, AVG(time_taken_per_order) avg_time
from cte
group by pizza_order

--4 What was the average distance travelled for each customer?
SELECT co.customer_id, round(AVG(ro.distance),2)
from customer_orders co
join cleaned_runner_orders ro
on co.order_id = ro.order_id 
group by co.customer_id

--5 What was the difference between the longest and shortest delivery times for all orders?
SELECT MAX(duration) - Min(duration) as time_diff
from cleaned_runner_orders

--6 What was the average speed for each runner for each delivery and do you notice any trend for these values?
Select runner_id, distance, duration , round(distance/duration * 60, 2) avg_speed
from cleaned_runner_orders
where cancellation is null
order by runner_id,  round(distance/duration * 60, 2) 

-- 7 What is the successful delivery percentage for each runner?
select runner_id, COUNT(order_id) total_order, COUNT(pickup_time) total_orders_delivered, 
cast(COUNT(pickup_time)as float)/ cast(COUNT(order_id) as float) * 100.0  as successful_delivery_percent
from cleaned_runner_orders
group by runner_id




                         -- C. Ingredient Optimisation
SELECT *
from pizza_recipes
cross apply string_split(toppings, ',')

DEclare @toppings as VARCHAR

select * from customer_orders
select * from pizza_names
select * from runner_orders
select * from pizza_recipes
select * from plans
select * from pizza_toppings
select * from runners
select * from subscriptions


-- 1 What are the standard ingredients for each pizza?
SELECT pn.pizza_id, topping_name
from pizza_names pn
join pizza_recipes pr
on pn.pizza_id = pr.pizza_id
join pizza_toppings pt
on pt.topping_id = pr.toppings



-- 2 What was the most commonly added extra?
select 




-- Cleaning customer_orders (Null value)

select order_id, customer_id, pizza_id, 
CASE
     WHEN exclusions = 'NULL' then NULL
     else exclusions
END as exclusions,
Case 
     WHEN extras = 'NULL' then NULL
      else extras
END as extras, order_time
INTO cleaned_customer_orders
from customer_orders

-- Cleaned runner_data 

-- UPDATE runner_orders
-- SET cancellation = 'Null'
-- WHERE cancellation = 'NULL'

Update runner_orders

set duration = 'NULL'
WHERE duration = 'LL'

SELECT * FROM runner_orders

SELECT Trim('km' from distance)
from runner_orders

-- We used this remove km from distance column
update runner_orders set distance=TRIM('km' from distance)


-- We used this remove minutes from duration column
update runner_orders set duration=TRIM('minutes' from duration)
