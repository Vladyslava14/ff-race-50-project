# Race Participants Dashboard – Power BI & SQL Project

This project explores ultramarathon participant data using SQL, Python, and Power BI. The goal is to understand how age, gender, start time, and location impact race performance.

---

##  Key Insights

- The **average race completion time** is **761.87 minutes**, serving as a benchmark for comparing different age and gender groups.

- The majority of participants are **male (77.8%)**, as shown in the gender distribution pie chart.

- The **peak starting hour is 1:00 PM (13:00)**, possibly reflecting scheduling preferences or strategic performance choices.

- **Younger participants** generally have **slightly faster average finish times**, based on the line chart visualizing Average Time by Age.

- Participants came from **32 different U.S. states**, showing broad national representation.

- The **fastest participant** finished in **473 minutes**, while the **slowest** took **1220 minutes**, highlighting wide performance variability.

- The **top 3 fastest males and females** significantly outperformed their peers and are highlighted in the leaderboard table.
---

**Data Source**: [UltraSignup - FF Race 50](https://ultrasignup.com/results_event.aspx?did=102259)  
**Data Origin**: SQL Server (`FF_Race50DB.dbo.ff_race_2.0`)  
**Data Cleaning**: [`MyCleanedData.ipynb`](MyCleanedData.ipynb)

---

## Dashboard Features (Power BI)

The Power BI report includes:

- **Pie Chart**: Gender distribution  
- **KPI Card**: Average finish time
- **Line Chart**: Average finish time by age  
- **Histogram**: Age distribution (using age bins)  
- **Line Area Chart**: Count of participants by hour  
- **Bar Chart**: Participant count by age group  
- **Interactive Slicers**: Gender, City, Age

---

##  Data Cleaning 

The Jupyter Notebook `MyCleanedData.ipynb` was used to:

- Remove missing or inconsistent entries  
- Convert time formats to minutes  
- Standardize column names  
- Create derived columns (e.g., `Time_minutes`, `Age group`)  
- Export cleaned data for Power BI and SQL

---

##  SQL Data Exploration

### Sample queries:

- **Total number of U.S. states represented:**
SELECT COUNT(DISTINCT State) AS distinct_count
FROM ff_race_2.0;

- **Participant distribution by state:**
SELECT State, COUNT(*) AS participants
FROM ff_race_2.0
GROUP BY State
ORDER BY participants DESC;

- **Average race time by state:**
SELECT State, AVG(Time_minutes) AS avg_time
FROM ff_race_2.0
GROUP BY State
ORDER BY avg_time;

- **Average time by gender:**
SELECT Gender, AVG(Time_minutes) AS avg_time
FROM ff_race_2.0
GROUP BY Gender;

- **Youngest and oldest participants by gender:**
SELECT Gender, MIN(Age) AS youngest, MAX(Age) AS oldest
FROM ff_race_2.0
GROUP BY Gender;

- **Average time by age group:**
WITH ageBuckets AS (
  SELECT Time_minutes,
    CASE 
      WHEN Age < 30 THEN 'age_20-29'
      WHEN Age < 40 THEN 'age_30-39'
      WHEN Age < 50 THEN 'age_40-49'
      WHEN Age < 60 THEN 'age_50-59'
      ELSE 'age_60+' 
    END AS age_group
  FROM ff_race_2.0
)
SELECT age_group, AVG(Time_minutes) AS avg_race_time
FROM ageBuckets
GROUP BY age_group;

- **Gender distribution by state:**
SELECT State, Gender, COUNT(*) AS participants
FROM ff_race_2.0
GROUP BY State, Gender
ORDER BY State, Gender;

- **Top 3 fastest males and females:**
WITH gender_rank AS (
  SELECT RANK() OVER (PARTITION BY Gender ORDER BY Time_minutes ASC) AS gender_rank,
         Name, Gender, Time_minutes
  FROM ff_race_2.0
)
SELECT * FROM gender_rank
WHERE gender_rank < 4
ORDER BY Time_minutes;

- **Time statistics: Min, Max, Avg, StdDev:**
SELECT 
  MIN(Time_minutes) AS min_time,
  MAX(Time_minutes) AS max_time,
  AVG(Time_minutes) AS avg_time,
  STDEV(Time_minutes) AS stddev_time
FROM ff_race_2.0;

---

##  Tools Used

- Microsoft Power BI  
- SQL Server (T-SQL)  
- Jupyter notebook (Python, Pandas)  
- Power Query Editor  
- DAX (for time measures)

---

## Objective

To analyze race performance across demographic groups, identify the fastest participants, and gain insights into how age and gender impact finish times.

---
