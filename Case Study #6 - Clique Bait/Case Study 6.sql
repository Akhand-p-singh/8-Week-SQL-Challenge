Select * from clique_bait.campaign_identifier
Select * from clique_bait.event_identifier
Select * from clique_bait.events
Select * from clique_bait.page_hierarchy
Select * from clique_bait.users

                              2. Digital Analysis

-- 1. How many users are there?

Select count(distinct user_id) total_users
from clique_bait.users


-- 2. How many cookies does each user have on average?
with cte as (
			select user_id, count(cookie_id) AS cookie_count
			from clique_bait.users
			group by user_id
			)
		select round(avg(cookie_count), 2) avg_cookies
		from cte


-- 3. What is the unique number of visits by all users per month?

Select  month(event_time) Month, count(distinct visit_id) total_visit
from clique_bait.events
group by month(event_time)
order by month


-- 4. What is the number of events for each event type?

SELECT 
  e.event_type,
  ei.event_name,
  COUNT(*) AS event_count
FROM clique_bait.events e
JOIN clique_bait.event_identifier ei
  ON e.event_type = ei.event_type
GROUP BY e.event_type, ei.event_name
ORDER BY e.event_type;

-- 5. What is the percentage of visits which have a purchase event?

Select cast( 100.0 * COUNT( distinct visit_id) / (Select COUNT(distinct visit_id)from clique_bait.events ) as decimal(10,2)) purchase_pct
from clique_bait.events e
join clique_bait.event_identifier ei
on e.event_type = ei.event_type
where ei.event_name = 'Purchase'


-- 6. What is the percentage of visits which view the checkout page but do not have a purchase event?
with cte AS (
Select COUNT(visit_id) as cnt
from clique_bait.events e
join clique_bait.event_identifier ei
on e.event_type = ei.event_type
join clique_bait.page_hierarchy ph
on ph.page_id = e.page_id
where ei.event_name = 'Page view' AND ph.page_name = 'Checkout'
)

Select cast(100-( 100.0 * COUNT( distinct e.visit_id) / (Select cnt from cte )) as decimal(10,2)) as non_puchase_pct_visit
from clique_bait.events e
JOIN clique_bait.event_identifier ei ON e.event_type = ei.event_type
WHERE ei.event_name = 'Purchase'


-- 7. What are the top 3 pages by number of views?
Select top 3 page_name, COUNT(visit_id) total_view
from clique_bait.page_hierarchy ph
join clique_bait.events e
on ph.page_id = e.page_id
join clique_bait.event_identifier ei
on e.event_type = ei.event_type
where event_name = 'Page view'
group by page_name
order by total_view desc


-- 8. What is the number of views and cart adds for each product category?

Select product_category, 
		SUM(case when ei.event_name = 'Page View' then 1 else 0 end)page_view,
		SUM(case when ei.event_name = 'Add to Cart' then 1 else 0 end) add_to_cart
from clique_bait.events e
join clique_bait.event_identifier ei
on ei.event_type = e.event_type
join clique_bait.page_hierarchy ph
on e.page_id = ph.page_id
where ph.product_category is not null
group by ph.product_category



-- 9. What are the top 3 products by purchases?

/*
select page_name,product_category, ei.event_name, COUNT(*) cnt
from clique_bait.events e
join  clique_bait.page_hierarchy ph
on e.page_id = ph.page_id
join clique_bait.event_identifier ei
on ei.event_type = e.event_type
where  ei.event_name = 'Add to Cart'
group by page_name,product_category,ei.event_name
order by cnt desc
*/


                                     -- 3. Product Funnel Analysis
-- Using a single SQL query - create a new output table which has the following details:
Select * from clique_bait.campaign_identifier
Select * from clique_bait.event_identifier
Select * from clique_bait.events
Select * from clique_bait.page_hierarchy
Select * from clique_bait.users

--  How many times was each product viewed?
with page_and_cart (

select page_name, product_category, sum(case when event_type = 1 then 1 else 0 end) as page_view, sum(case when event_type = 2 then 1 else 0 end) as add_to_cart
from clique_bait.page_hierarchy ph
join clique_bait.events e
on ph.page_id= e.page_id
where product_category is not null
group by page_name, product_category
)

select *
from clique_bait.events
where event_type = 3



How many times was each product added to cart?
How many times was each product added to a cart but not purchased (abandoned)?
How many times was each product purchased?


