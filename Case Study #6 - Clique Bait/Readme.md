#  Case Study #6 - Clique Bait

![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/Case%20Study%206.png)
  

---
## 🛠️ Bussiness Task
Clique Bait is not like your regular online seafood store - the founder and CEO Danny, was also a part of a digital data analytics team and wanted to expand his knowledge into the seafood industry!

In this case study - you are required to support Danny’s vision and analyse his dataset and come up with creative solutions to calculate funnel fallout rates for the Clique Bait online store.
questions.

----

## Dataset :-


### Table 1: Users

![App Screenshot](Add Table image)

* Customers who visit the Clique Bait website are tagged via their cookie_id.

----

### Table 2: Events

![App Screenshot](Add Table image)

* Customer visits are logged in this events table at a cookie_id level and the event_type and page_id values can be used to join onto relevant satellite tables to obtain further information about each event.

* The sequence_number is used to order the events within each visit.
----

### Table 3: Event Identifier

![App Screenshot](Add Table image)

* The event_identifier table shows the types of events which are captured by Clique Bait’s digital data systems.

----

### Table 4: Campaign Identifier

![App Screenshot](Add Table image)

* This table shows information for the 3 campaigns that Clique Bait has ran on their website so far in 2020.
----

### Table 5: Page Hierarchy

![App Screenshot](Add Table image)

* This table lists all of the pages on the Clique Bait website which are tagged and have data passing through from user interaction events.

---
## Case Study Questions
### A. Enterprise Relationship Diagram

* Using the following DDL schema details to create an ERD for all the Clique Bait datasets.

```
CREATE TABLE event_identifier {
  event_type INTEGER
  event_name VARCHAR
}

CREATE TABLE campaign_identifier {
  campaign_id INTEGER
  products VARCHAR
  campaign_name VARCHAR
  start_date TIMESTAMP
  end_date TIMESTAMP
}

CREATE TABLE page_hierarchy {
  page_id INTEGER
  page_name VARCHAR
  product_category VARCHAR
  product_id INTEGER
}

CREATE TABLE users {
  user_id INTEGER
  cookie_id VARCHAR
  start_date TIMESTAMP
}

CREATE TABLE events {
  visit_id VARCHAR
  cookie_id VARCHAR
  page_id INTEGER
  event_type INTEGER
  sequence_number INTEGER
  event_time TIMESTAMP
}

```

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%236%20-%20Clique%20Bait/Solution/1.%20Enterprise%20Relationship%20Diagram.md)

---
### B. Digital Analysis

1. How many users are there?

2. How many cookies does each user have on average?

3. What is the unique number of visits by all users per month?

4. What is the number of events for each event type?

5. What is the percentage of visits which have a purchase event?

6. What is the percentage of visits which view the checkout page but do not have a purchase event?

7. What are the top 3 pages by number of views?

8. What is the number of views and cart adds for each product category?

9. What are the top 3 products by purchases?

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%236%20-%20Clique%20Bait/Solution/2.%20Digital%20Analysis.md)

---
