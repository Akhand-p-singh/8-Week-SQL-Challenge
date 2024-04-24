# 🛍️ Case Study #5 - Data Mart

![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/Case%20Study%205.png)
  

---
## 🛠️ Bussiness Task
Data Mart is Danny’s latest venture and after running international operations for his online supermarket that specialises in fresh produce - Danny is asking for your support to analyse his sales performance.

In June 2020 - large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.

Danny needs your help to quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.

The key business question he wants you to help him answer are the following:

What was the quantifiable impact of the changes introduced in June 2020?

Which platform, region, segment and customer types were the most impacted by this change?
What can we do about future introduction of similar sustainability updates to the business to minimise impact on sales?

---
## 💡 Entity Relationship Diagram

![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/er5.png)

----

## 💾  About Dataset


### Table 1: data_mart.weekly_sales

![App Screenshot](https://raw.githubusercontent.com/Akhand-p-singh/8-Week-SQL-Challenge/master/Images/Table%20image/5.png)

* Data Mart has international operations using a multi-region strategy

* Data Mart has both, a retail and online platform in the form of a Shopify store front to serve their customers

* Customer segment and customer_type data relates to personal age and demographics information that is shared with Data Mart

* transactions is the count of unique purchases made through Data Mart and sales is the actual dollar amount of purchases

---

## 🔍 Case Study Questions

### A. Data Cleansing Steps

1. Convert the week_date to a DATE format

2. Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc

3. Add a month_number with the calendar month for each week_date value as the 3rd column

4. Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values

5. Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value

6. Add a new demographic column using the following mapping for the first letter in the segment values

7. Ensure all null string values with an "unknown" string value in the original segment column as well as the new age_band and demographic columns

8. Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%235%20-%20Data%20Mart/Solution/1.%20Data%20Cleansing%20Steps.md)

---
### B. Data Analysis Questions

1. How many unique nodes are there on the Data Bank system?

2. What is the number of nodes per region?

3. How many customers are allocated to each region?

4. How many days on average are customers reallocated to a different node?

5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

<b>Solution:</b> [Click here](https://github.com/Akhand-p-singh/8-Week-SQL-Challenge/blob/master/Case%20Study%20%235%20-%20Data%20Mart/Solution/2.%20Data%20Exploration.md)

---
