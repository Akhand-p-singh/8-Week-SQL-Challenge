
# Case Study #4: Data Bank

----
### Solution A. Customer Nodes Exploration
----

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

![App Screenshot](Enter url er4)

---

### Case Study Questions

1. How many unique nodes are there on the Data Bank system?

2. What is the number of nodes per region?

3. How many customers are allocated to each region?

4. How many days on average are customers reallocated to a different node?

5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

---
## 🚀 Solutions

### **Q1. How many unique nodes are there on the Data Bank system?**

```sql
SELECT count(DISTINCT node_id) no_of_nodes
from customer_nodes
```
#### Output:
| no_of_nodes  |
|--------------|
| 5            |

---

### **Q2. What is the number of nodes per region?**

```
SELECT cn.region_id,r.region_name, COUNT(node_id) as no_of_nodes
from customer_nodes cn
join regions r
on cn.region_id = r.region_id
group by cn.region_id, region_name
order by region_id

```
#### Output:
| region_id | region_name | nodes  |
|-----------|-------------|--------|
| 1         | Australia   | 770    |
| 2         | America     | 735    |
| 3         | Africa      | 714    |
| 4         | Asia        | 665    |
| 5         | Europe      | 616    |

---
### **Q3. How many customers are allocated to each region?**

```SQL
SELECT region_id, COUNT(Distinct customer_id) as no_of_customers
from customer_nodes
group by region_id
order by region_id
```

#### Output:
| region_id |no_of_customers  |
|-----------|---------------- |
| 1         |110              |
| 2         |105              |
| 3         |102              |
| 4         |95               |
| 5         |88               |

---
### **Q4. How many days on average are customers reallocated to a different node?**


---

### **Q5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?**
