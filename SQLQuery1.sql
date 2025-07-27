use FF_Race50DB

Select*
from FF_Race50DB.dbo.[ff_race_2.0]

--How many States were represented in the race
Select COUNT(Distinct State) as distinct_count
from FF_Race50DB.dbo.[ff_race_2.0]

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