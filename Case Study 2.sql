SELECT * from customer_orders
SELECT * FROM cleaned_runner_orders
SELECT * from pizza_names
SELECT * from pizza_recipes
SELECT * from pizza_toppings
SELECT * from runners  

                    -- C. Ingredient Optimisation
SELECT *
from pizza_recipes
cross apply string_split(toppings, ',')

DEclare @toppings as VARCHAR




-- 1 What are the standard ingredients for each pizza?
SELECT pizza_id, toppings
from pizza_recipes
where toppings in 

-- 2 What was the most commonly added extra?
select 









                      --  B. Runner and Customer Experience  -- 

--1 How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT DATEPART(WEEK,  registration_DATE) as Week, COUNT(runner_id) as count
from runners
group by DATEPART(WEEK,  registration_DATE)

-- 2 What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
--SELECT ro.runner_id,  AVG(DATEDIFF(MINUTE, ro.pickup_time , co.order_time))
--from runner_orders ro
--join customer_orders co
--on ro.order_id =  co.order_id
--group by ro.runner_id

-- 3 Is there any relationship between the number of pizzas and how long the order takes to prepare?
--SELECT co.order_id, COUNT(pizza_id), DATEDIFF(MINUTE , co.order_time, ro.pickup_time ) time_taken_per_order,
--DATEDIFF(MINUTE , co.order_time, ro.pickup_time ) /  COUNT(pizza_id) as time_taken_per_pizaa
--from customer_orders co
--join runner_orders ro
--on co.order_id = ro.order_id
--group by co.order_id, co.order_time, ro.pickup_time

--4 What was the average distance travelled for each customer?
SELECT co.customer_id, AVG(ro.distance)
from customer_orders co
join cleaned_runner_orders ro
on co.order_id = ro.order_id 

--5 What was the difference between the longest and shortest delivery times for all orders?
SELECT  Min(duration) min_time, MAX(duration) max_time, MAX(duration) - Min(duration) as time_diff
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

                                --  A. Pizza Metrics  --


-- 1 How many pizzas were ordered?
SELECT COUNT(order_id)as Delivered_pizza from customer_orders

-- 2 How many unique customer orders were made?

select count(distinct order_id) as unique_customers from customer_orders


-- 3 How many successful orders were delivered by each runner?
/*
SELECT runner_id, COUNT(order_id) as no_of_order_delivered
from cleaned_runner_orders
where cancellation is NULL
group by runner_id
*/

-- 4 How many of each type of pizza was delivered?
/*
select pizza_id, COUNT(order_id) as no_of_pizza_delivered
from customer_orders
group by pizza_id
*/



-- 5 How many Vegetarian and Meatlovers were ordered by each customer?
/*
SELECT co.customer_id, pn.pizza_name, count(co.customer_id)
from pizza_names pn
join customer_orders co
on pn.pizza_id = co.pizza_id
group by  co.customer_id, pn.pizza_name
*/


-- 6 What was the maximum number of pizzas delivered in a single order?

SELECT top 1 order_id, count(order_id) no_of_times_pizza_ordered
from customer_orders
group by order_id
order by no_of_times_pizza_ordered desc


-- 7 For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

-- 8 How many pizzas were delivered that had both exclusions and extras?
/*
SELECT COUNT(order_id)
from customer_orders

select *
from customer_orders
where  not NULL IN(exclusions,extras)
*/

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
