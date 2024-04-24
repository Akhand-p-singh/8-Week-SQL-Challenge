#  Case Study #2 - Pizza Runner

![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/Case%20Study%202.png)
  

---
## 🛠️ Bussiness Task

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

---
##  Entity Relationship Diagram


![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/er2.png)

----

## About Dataset :-


### Table 1: runners 

![App Screenshot](Add Table image)

The runners table shows the registration_date for each new runner

----

### Table 2: customer_orders

![App Screenshot](Add Table image)

Customer pizza orders are captured in the customer_orders table with 1 row for each individual pizza that is part of the order.

The pizza_id relates to the type of pizza which was ordered whilst the exclusions are the ingredient_id values which should be removed from the pizza and the extras are the ingredient_id values which need to be added to the pizza.

Note that customers can order multiple pizzas in a single order with varying exclusions and extras values even if the pizza is the same type!

The exclusions and extras columns will need to be cleaned up before using them in your queries.

---
### Table 3: runner_orders

![App Screenshot](Add Table image)

After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer.

The pickup_time is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. The distance and duration fields are related to how far and long the runner had to travel to deliver the order to the respective customer.

---

### Table 4: pizza_names

![App Screenshot](Add Table image)

At the moment - Pizza Runner only has 2 pizzas available the Meat Lovers or Vegetarian!

---

### Table 5: pizza_recipes

![App Screenshot](Add Table image)

Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.

---

### Table 6: pizza_toppings

![App Screenshot](Add Table image)

This table contains all of the topping_name values with their corresponding topping_id value

---
## Case Study Questions

### A.  Pizza Metrics

1. How many pizzas were ordered?

2. How many unique customer orders were made?

3. How many successful orders were delivered by each runner?

4. How many of each type of pizza was delivered?

5. How many Vegetarian and Meatlovers were ordered by each customer?

6. What was the maximum number of pizzas delivered in a single order?

7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

8. How many pizzas were delivered that had both exclusions and extras?

9. What was the total volume of pizzas ordered for each hour of the day?

10. What was the volume of orders for each day of the week?

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%232%20-%20Pizza%20Runner/Solutions/A.%20Pizza%20Metrics.md)

---
### B. Runner and Customer Experience

1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

4. What was the average distance travelled for each customer?

5. What was the difference between the longest and shortest delivery times for all orders?

6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

7. What is the successful delivery percentage for each runner?

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%232%20-%20Pizza%20Runner/Solutions/B.%20Runner%20and%20Customer%20Experience.md)

---
