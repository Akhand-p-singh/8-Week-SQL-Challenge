SELECT * from product_details
SELECT * from product_hierarchy
SELECT * from product_prices
SELECT * from sales

                                 -- C. Product Analysis
-- 1. What are the top 3 products by total revenue before discount?
SELECT Top 3 pd.product_name, SUM(s.qty * s.price ) as revenue
from product_details AS pd
join sales s
on  pd.product_id = s.prod_id
group by pd.product_name
order by revenue desc

-- 2. What is the total quantity, revenue and discount for each segment?
Select pd.segment_name, sum(s.qty) AS total_qunt, SUM(s.qty* s.price ) AS total_revenue, SUM(s.qty* s.price * s.discount)  As revenue_before_discount
from product_details AS pd
join sales AS s
on pd.product_id = s.prod_id
group by segment_name

-- 3. What is the top selling product for each segment?
-- 4. What is the total quantity, revenue and discount for each category?
-- 5. What is the top selling product for each category?
-- 6. What is the percentage split of revenue by product for each segment?
-- 7. What is the percentage split of revenue by segment for each category?
-- 8. What is the percentage split of total revenue by category?
-- 9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
-- 10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

                             
							   -- A. High Level Sales Analysis
-- 1. What was the total quantity sold for all products?
SELECT SUM(qty) AS total_quantity
from sales

-- 2. What is the total generated revenue for all products before discounts?
SELECT  SUM(qty*price) AS total_revenue
from sales

-- 3. What was the total discount amount for all products?
SELECT CAST(SUM(qty * price * discount/100.0) AS float)
from sales

                              -- B. Transaction Analysis
-- 1. How many unique transactions were there?
SELECT COUNT(Distinct txn_id) AS unique_transaction
from sales

-- 2. What is the average unique products purchased in each transaction?
SELECT cast(AVG(total_prod) as float) as avg_product_purchased
from (
SELECT txn_id, count(prod_id) AS total_prod
from sales 
group by txn_id ) f

-- 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
WITH revenue_list AS ( 
SELECT txn_id, SUM(qty * price ) AS revenue
from sales
group by txn_id ) 
SELECT Distinct PERCENTILE_CONT(0.25) within group (order by revenue) over() AS pct_25th,
PERCENTILE_CONT(0.50) within group (order by revenue) over() AS pct_50th,
PERCENTILE_CONT(0.75) within group (order by revenue) over() AS pct_75th
from revenue_list


-- 4. What is the average discount value per transaction?
SELECT cast(Avg(total_trans) as decimal (5,2)) AS avg_disc
from (
SELECT txn_id, sum(qty * price * discount/100.0) AS total_trans
from sales
group by txn_id ) t

-- 5. What is the percentage split of all transactions for members vs non-members?
SELECT 
       CAST(100.0 * Count(DISTINCT Case when member = 1 then txn_id end) / Count(DISTINCT txn_id ) AS float) AS member,
       CAST(100.0 *COUNT(DISTINCT Case when member = 0 then txn_id end)/ Count(DISTINCT txn_id ) AS float)  AS non_member
from sales

-- 6. What is the average revenue for member transactions and non-member transactions?
WITH revenue AS  
( 
SELECT  member, txn_id,  sum(qty * price )	AS total_transaction						   
from sales
group by member, txn_id
)
SELECT member, CAST(AVG(1.0*total_transaction) as decimal(10,2))
from revenue 
group by member
