# Case Study #4: Data Bank


![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/Case%20Study%203.png)


## 🛠️ Problem Statement

There is a new innovation in the financial industry called Neo-Banks: new aged digital only banks without physical branches.

Danny thought that there should be some sort of intersection between these new age banks, cryptocurrency and the data world…so he decides to launch a new initiative - Data Bank!

Data Bank runs just like any other digital bank - but it isn’t only for banking activities, they also have the world’s most secure distributed data storage platform!

Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. There are a few interesting caveats that go with this business model, and this is where the Data Bank team need your help!

The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.

This case study is all about calculating metrics, growth and helping the business analyse their data in a smart way to better forecast and plan for their future developments!


---
## Entity Relationship Diagram

![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/er4.png)

---

## About Dataset :-

### Table 1: regions

![App Screenshot](Add Table image)

Just like popular cryptocurrency platforms - Data Bank is also run off a network of nodes where both money and data is stored across the globe. In a traditional banking sense - you can think of these nodes as bank branches or stores that exist around the world.

This regions table contains the region_id and their respective region_name values

--- 

### Table 2: customer_nodes

![App Screenshot](Add Table image)

Customers are randomly distributed across the nodes according to their region - this also specifies exactly which node contains both their cash and data.

This random distribution changes frequently to reduce the risk of hackers getting into Data Bank’s system and stealing customer’s money and data!

---

### Table 2: customer_transactions

![App Screenshot](Add Table image)

This table stores all customer deposits, withdrawals and purchases made using their Data Bank debit card.

---

### Case Study Questions
---

### A. Customer Nodes Exploration
---

1. How many unique nodes are there on the Data Bank system?

2. What is the number of nodes per region?

3. How many customers are allocated to each region?

4. How many days on average are customers reallocated to a different node?

5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%234%20-%20Data%20Bank/Solution/A.%20Customer%20Nodes%20Exploration.md)

--- 

### B. Customer Transactions
----

1. What is the unique count and total amount for each transaction type?

2. What is the average total historical deposit counts and amounts for all customers?

3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?

4. What is the closing balance for each customer at the end of the month?

5. What is the percentage of customers who increase their closing balance by more than 5%?

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%234%20-%20Data%20Bank/Solution/B.%20Customer%20Transactions.md)


---