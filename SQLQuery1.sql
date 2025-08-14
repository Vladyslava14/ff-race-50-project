use FF_Race50DB

Select*
from FF_Race50DB.dbo.[ff_race_2.0]

--How many States were represented in the race
Select COUNT(Distinct State) as distinct_count
from FF_Race50DB.dbo.[ff_race_2.0]

--Participant distribution by state
SELECT State, COUNT(*) AS participants
FROM FF_Race50DB.dbo.[ff_race_2.0]
GROUP BY State
ORDER BY participants DESC;

--Average time by state
SELECT State, AVG(Time_minutes) AS avg_time
FROM FF_Race50DB.dbo.[ff_race_2.0]
GROUP BY State
ORDER BY avg_time;

--What was the average time of Men Vs Women
Select Gender, AVG(Time_minutes) as avg_time
from FF_Race50DB.dbo.[ff_race_2.0]
group by Gender

--What were the youngest and oldest ages in the race
Select Gender, Min(age) as youngest, Max(age) as oldest
from FF_Race50DB.dbo.[ff_race_2.0]
group by Gender

--What was the average time for each age group
with ageBuckets as (
Select Time_minutes,
	case when age < 30 then 'age_20-29'
		 when age < 40 then 'age_30-39'
		 when age < 50 then 'age_40-49'
		 when age < 60 then 'age_50-59'
	else 'age 60+' end as age_group
FROM FF_Race50DB.dbo.[ff_race_2.0]
)
Select age_group, AVG(Time_minutes) avg_race_time
from ageBuckets
group by age_group

--Gender distribution by state
SELECT State, Gender, COUNT(*) AS participants
FROM FF_Race50DB.dbo.[ff_race_2.0]
GROUP BY State, Gender
ORDER BY State, Gender;

--Top 3 males and females
with gender_rank as (
Select rank() over (partition by Gender order by Time_minutes asc) as gender_rank,
name,
gender,
Time_minutes
from FF_Race50DB.dbo.[ff_race_2.0]
)
Select * from gender_rank
where gender_rank < 4
order by Time_minutes

--Time statistics: Min, Max, Avg, StdDev
SELECT 
  MIN(Time_minutes) AS min_time,
  MAX(Time_minutes) AS max_time,
  AVG(Time_minutes) AS avg_time,
  STDEV(Time_minutes) AS stddev_time
FROM FF_Race50DB.dbo.[ff_race_2.0];
