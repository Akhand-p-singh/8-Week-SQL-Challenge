
# 🏦 Case Study #4: Data Bank

### B. Customer Transactions

----

## 🚀 Solutions

### **Q1. What is the unique count and total amount for each transaction type?**

```sql
SELECT txn_type, COUNT( customer_id) as no_of_customer, SUM(txn_amount) as txn_amount
from customer_transactions
group by txn_type
```
#### Output:
| txn_type   | no_of_customer | txn_amount    |
|------------|--------------  |---------------|
| withdrawal | 1580           | 793003        |
| deposit    | 2671           | 1359168       |
| purchase   | 1617           | 806537        |
---

### **Q2. What is the average total historical deposit counts and amounts for all customers?**

```
with cte as (
Select  customer_id,
		COUNT(customer_id) ttl_cust,
		avg(txn_amount) ttl_amt
from customer_transactions
where txn_type = 'deposit'
group by customer_id
)

select AVG(ttl_cust) deposit_count , AVG(ttl_amt) total_money
from cte

```
#### Output:
| deposit_count | total_money     |
|---------------|-----------------|
| 5             | 508             |

---
### **Q3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?**

```SQL
with cte as (
SELECT 
	MONTH(txn_date) month, customer_id,
	sum(case when txn_type = 'deposit' then 0 else 1 END) as deposit,
	sum(case when txn_type = 'puchase' then 0 else 1 END) as purchase,
	sum(case when txn_type = 'withdrawal' then 0 else 1 END) as withdrawal
from customer_transactions
group by customer_id,MONTH(txn_date)
)

SELECT
  month,
  COUNT(DISTINCT customer_id) AS customer_count
FROM cte
WHERE deposit > 1 
  AND (purchase >= 1 OR withdrawal >= 1)
GROUP BY month
ORDER BY month;
```

#### Output:
| months | customer_count  |
|--------|-----------------|
| 1      | 170             |
| 2      | 289             |
| 3      | 300             |
| 4      | 118             |

---
### **Q4. What is the closing balance for each customer at the end of the month?**


---

### **Q5. What is the percentage of customers who increase their closing balance by more than 5%?**

---