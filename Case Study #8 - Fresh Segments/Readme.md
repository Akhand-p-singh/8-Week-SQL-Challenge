#  Case Study #8 - Fresh Segments

![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/Case%20Study%208.png)
  

---
## 🛠️ Bussiness Task
Danny created Fresh Segments, a digital marketing agency that helps other businesses analyse trends in online ad click behaviour for their unique customer base.

Clients share their customer lists with the Fresh Segments team who then aggregate interest metrics and generate a single dataset worth of metrics for further analysis.

In particular - the composition and rankings for different interests are provided for each client showing the proportion of their customer list who interacted with online assets related to each interest for each month.

Danny has asked for your assistance to analyse aggregated metrics for an example client and provide some high level insights about the customer list and their interests.

---

## Dataset :-


### Table 1: Interest Metrics

![App Screenshot](Add Table image)

* This table contains information about aggregated interest metrics for a specific major client of Fresh Segments which makes up a large proportion of their customer base.

* Each record in this table represents the performance of a specific interest_id based on the client’s customer base interest measured through clicks and interactions with specific targeted advertising content.

----

### Table 2: Interest Map

![App Screenshot](Add Table image)

* This mapping table links the interest_id with their relevant interest information. You will need to join this table onto the previous interest_details table to obtain the interest_name as well as any details about the summary information.

---
## Case Study Questions

### A. Data Exploration and Cleansing

* Update the fresh_segments.interest_metrics table by modifying the month_year column to be a date data type with the start of the month

* What is count of records in the fresh_segments.interest_metrics for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?

* What do you think we should do with these null values in the fresh_segments.interest_metrics

* How many interest_id values exist in the fresh_segments.interest_metrics table but not in the fresh_segments.interest_map table? What about the other way around?

* Summarise the id values in the fresh_segments.interest_map by its total record count in this table

* What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where interest_id = 21246 in your joined output and include all columns from fresh_segments.interest_metrics and all columns from fresh_segments.interest_map except from the id column.

* Are there any records in your joined table where the month_year value is before the created_at value from the fresh_segments.interest_map table? Do you think these values are valid and why?

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%238%20-%20Fresh%20Segments/Solution/A.%20Data%20Exploration%20and%20Cleansing.md)

---