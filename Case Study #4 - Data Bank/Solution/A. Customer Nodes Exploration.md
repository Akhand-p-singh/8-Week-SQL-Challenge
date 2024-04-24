
# 🏦 Case Study #4: Data Bank

### A. Customer Nodes Exploration

----
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
---