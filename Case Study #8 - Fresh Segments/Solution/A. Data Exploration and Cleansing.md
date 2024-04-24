
# 📈 Case Study #8: Fresh Segments

### A. Data Exploration and Cleansing
---

### Data Cleaning Steps:
---

UPDATE interest_metrics
```
SET _month = CASE WHEN _month = 'NULL' THEN Cast(NULL AS INTEGER) ELSE CAST(_month AS INTEGER) END;
```

UPDATE interest_metrics
```
SET _month = CASE WHEN _month = 'NULL' THEN CAST(NULL AS INTEGER) ELSE CAST(_month AS INTEGER) END;
```

UPDATE interest_metrics:
```
SET _year = CASE WHEN _year = 'NULL' THEN CAST(NULL AS INTEGER) ELSE CAST(_year AS INTEGER) END;

```
---
## 🚀 Solutions

### **Q1. Update the fresh_segments.interest_metrics table by modifying the month_year column to be a date data type with the start of the month.**

* Modify the length of column month_year so it can store 10 characters
```
ALTER TABLE dbo.interest_metrics
ALTER COLUMN month_year VARCHAR(10);
```

* Update values in month_year column
```
UPDATE interest_metrics
SET month_year =  CONVERT(DATE, '01-' + month_year, 105)
```

* Convert month_year to DATE
```
ALTER TABLE dbo.interest_metrics
ALTER COLUMN month_year DATE;
```
---

### **Q2. What is count of records in the fresh_segments.interest_metrics for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?**

```SQL
SELECT month_year, 
       COUNT(*) AS no_of_records
from interest_metrics
group by month_year
order by month_year 
```
#### Output:
| month_year | no_of_records   |
|------------|-------|
| 2018-07-01 | 729   |
| 2018-08-01 | 767   |
| 2018-09-01 | 780   |
| 2018-10-01 | 857   |
| 2018-11-01 | 928   |
| 2018-12-01 | 995   |
| 2019-01-01 | 973   |
| 2019-02-01 | 1121  |
| 2019-03-01 | 1136  |
| 2019-04-01 | 1099  |
| 2019-05-01 | 857   |
| 2019-06-01 | 824   |
| 2019-07-01 | 864   |
| 2019-08-01 | 1149  |

---
### **Q3. What do you think we should do with these null values in the fresh_segments.interest_metrics**

*--* We can delete the column which has NULL value 

---
### **Q4. How many interest_id values exist in the fresh_segments.interest_metrics table but not in the fresh_segments.interest_map table? What about the other way around?**

```
SELECT ( SELECT Count(interest_id)
from interest_metrics
where not exists (
                  SELECT id 
				  from interest_map
				  Where interest_metrics.interest_id = interest_map.id ) 
				  ) AS not_in_map ,
(
SELECT Count(id)
from interest_map
where not exists (
                  SELECT interest_id 
				  from interest_metrics
				  Where interest_metrics.interest_id = interest_map.id )  )AS not_in_metric

```
#### Output:
| not_in_map   | not not_in_metric |
|--------------|------------------ |
| 1209         | 1202              |


---

### **Q5. Summarise the id values in the fresh_segments.interest_map by its total record count in this table**

```
Select COUNT(*) As Total
from interest_map

```

#### Output:
| Total         |
|---------------|
| 1209          |

---

### **Q6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where interest_id = 21246 in your joined output and include all columns from fresh_segments.interest_metrics and all columns from fresh_segments.interest_map except from the id column.**

```
SELECT metrics.*,  map.* 
from interest_metrics AS metrics
Join interest_map AS map
on metrics.interest_id = map.id
where interest_id = 21246
```
#### Output:

| _month | _year | month_year | interest_id | composition | index_value | ranking | percentile_ranking | interest_name                    | interest_summary                                      | created_at                  | last_modified                |
|--------|-------|------------|-------------|-------------|-------------|---------|--------------------|----------------------------------|-------------------------------------------------------|-----------------------------|------------------------------|
| 7      | 2018  | 2018-07-01 | 21246       | 2.26        | 0.65        | 722     | 0.96               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 8      | 2018  | 2018-08-01 | 21246       | 2.13        | 0.59        | 765     | 0.26               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 9      | 2018  | 2018-09-01 | 21246       | 2.06        | 0.61        | 774     | 0.77               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 10     | 2018  | 2018-10-01 | 21246       | 1.74        | 0.58        | 855     | 0.23               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 11     | 2018  | 2018-11-01 | 21246       | 2.25        | 0.78        | 908     | 2.16               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 12     | 2018  | 2018-12-01 | 21246       | 1.97        | 0.7         | 983     | 1.21               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 1      | 2019  | 2019-01-01 | 21246       | 2.05        | 0.76        | 954     | 1.95               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 2      | 2019  | 2019-02-01 | 21246       | 1.84        | 0.68        | 1109    | 1.07               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 3      | 2019  | 2019-03-01 | 21246       | 1.75        | 0.67        | 1123    | 1.14               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| 4      | 2019  | 2019-04-01 | 21246       | 1.58        | 0.63        | 1092    | 0.64               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |
| NULL   | NULL  | NULL       | 21246       | 1.61        | 0.68        | 1191    | 0.25               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04.0000000 | 2018-06-11 17:50:04.0000000  |


---

### **Q7. Are there any records in your joined table where the month_year value is before the created_at value from the fresh_segments.interest_map table? Do you think these values are valid and why?**

```
SELECT COUNT(*) as cnt
from interest_metrics  metrics
join interest_map  map
on metrics.interest_id = map.id
WHERE metrics.month_year < CAST(map.created_at AS DATE);

```

#### Output:
| cnt           | 
|---------------|
| 188           |

---
