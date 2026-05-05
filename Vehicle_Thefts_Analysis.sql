use vehicle_thefts_analysis;
set sql_safe_updates =0;
select * from locn;
alter table locn rename column ï»¿location_id to location_id;

select * from vd;
alter table vd rename column ï»¿make_id to make_id;

select * from sv;
alter table sv rename column ï»¿vehicle_id to vehicle_id;

describe sv;
update sv set date_stolen = str_to_date(date_stolen,'%d-%m-%Y'); 
alter table sv modify column date_stolen date;

-- Q1: How many vehicles are stolen per year?
select year(date_stolen) as years, count(vehicle_id) as veh_stolen 
from sv
group by year(date_stolen)
order by year(date_stolen);

-- Q2: How many thefts happen per month?
select date_format(date_stolen,'%Y-%m') as YM, count(*) as veh_stolen
from sv
group by date_format(date_stolen,'%Y-%m')
order by date_format(date_stolen,'%Y-%m');

-- Q3: Which month has maximum thefts?
select YM, veh_stolen from(
select date_format(date_stolen,'%Y-%m') as YM, count(*) as veh_stolen, dense_rank() over(order by count(*) desc) as drnk
from sv
group by date_format(date_stolen,'%Y-%m'))t
where drnk=1;

-- Q4: Highest theft rateas per day of the week?
with cte as(
select dayname(date_stolen) as days, count(*) as veh_stolen, sum(count(*)) over() as TVS
from sv
group by dayname(date_stolen)
)
select *, round(veh_stolen/TVS*100.0,2) as TR from cte;

-- Q5: Are weekends more prone to theft than weekdays?
with dt as(select case when weekday(date_stolen)>=5 then 'Weekend' else 'Weekday' end Daytype
from sv)
select Daytype, count(*) as Veh_stolen
from dt
group by Daytype;

-- Q6: Is there a month-over-month growth % in thefts? 
with cte as(select date_format(date_stolen,'%Y-%m') as YM, count(*) as veh_stolen, lag(count(*)) over(order by date_format(date_stolen,'%Y-%m')) pmvs
from sv
group by date_format(date_stolen,'%Y-%m'))
select YM, veh_stolen, coalesce(round((veh_stolen-pmvs)/pmvs*100,2),0) as Monthly_growth
from cte
order by YM;

-- Q7: Any sudden spikes or anomalies in specific dates?
select date_stolen, count(*) as Veh_stolen
from sv
group by date_stolen
order by Veh_stolen desc; 

-- Q8: Which vehicle category is stolen the most?
select vd.make_type as Category, count(sv.vehicle_id) as veh_stolen
from vd join sv on vd.make_id=sv.make_id
group by vd.make_type
order by count(*) desc;

-- Q9: Top 10 most stolen vehicle names?
select vehicle_type, count(*) as veh_stolen 
from sv
group by vehicle_type
order by count(*) desc;

-- Q10: Which company (com_name) has the highest theft rate?
with cte as(select vd.make_name, count(sv.vehicle_id) as veh_stolen, sum(count(sv.vehicle_id)) over() as TVS
from vd join sv on vd.make_id=sv.make_id
group by vd.make_name)

select make_name as Company, round(veh_stolen/TVS*100,2) ThefthRate
from cte 
order by ThefthRate desc;

-- Q11: Which color vehicles are stolen the most?
select color, count(*) as veh_stolen
from sv
group by color
order by count(*) desc;

-- Q12: Which model year vehicles are most targeted?
select model_year, count(*) as veh_stolen 
from sv
group by model_year
order by count(*) desc;

-- Q13: Theft distribution by vehicle category vs model year
with cte as (select vd.make_type, sv.model_year, count(sv.vehicle_id) as veh_stolen, sum(count(sv.vehicle_id)) over()as TVS
from vd join sv on vd.make_id=sv.make_id
group by vd.make_type,sv.model_year)

select make_type as Category, model_year, round(veh_stolen/TVS*100,2) as TheftRate
from cte
order by category,TheftRate desc;

-- Q14: Which vehicle category + color combination is most stolen?
select vd.make_type, sv.color, count(sv.vehicle_id) as veh_stolen
from vd join sv on vd.make_id=sv.make_id
group by vd.make_type,sv.color
order by count(*) desc;

-- Q15: Which company’s vehicles are most vulnerable per population?
with cte as(select vd.make_name, count(sv.vehicle_id) as veh_stolen, sum(locn.population) as TP
from vd left join sv on vd.make_id=sv.make_id
left join locn on locn.location_id=sv.location_id
group by vd.make_name)

select make_name as Company, round(veh_stolen/TP*100,5) as TR
from cte
order by TR desc;

-- Q16: Which region has the highest thefts?
select region, veh_stolen from(
select locn.region, count(sv.vehicle_id) as veh_stolen, dense_rank() over(order by count(*) desc) drnk
from locn left join sv on locn.location_id=sv.location_id
group by locn.region) t
where drnk=1;

-- Q17: Top 10 locations (loc_id) with highest thefts
select region, veh_stolen from(
select locn.region, count(sv.vehicle_id) as veh_stolen, dense_rank() over(order by count(*) desc) drnk
from locn left join sv on locn.location_id=sv.location_id
group by locn.region) t
where drnk<=10;

-- Q18: Which region has the lowest theft?
select region, veh_stolen from(
select locn.region, count(sv.vehicle_id) as veh_stolen, dense_rank() over(order by count(*)) drnk
from locn left join sv on locn.location_id=sv.location_id
group by locn.region) t
where drnk<=10;

-- Q19: Overall theft rate  (important KPI)
select round(count(sv.vehicle_id)/sum(locn.population)*100,5) as Overall_TheftRate
from sv right join locn
on sv.location_id=locn.location_id;

-- Q20: Which region has the highest growth in thefts over time?
with pd as (select locn.region, date_format(sv.date_stolen,'%Y-%m') as YM, count(sv.vehicle_id) as veh_stolen, 
lag(count(sv.vehicle_id)) over(partition by locn.region order by date_format(sv.date_stolen,'%Y-%m'))as pvs 
from locn join sv on locn.location_id=sv.location_id
group by locn.region,date_format(sv.date_stolen,'%Y-%m')),

rc as(select *,case when pvs is null or veh_stolen>=pvs then 0 else 1 end as 'gp'
from pd
),

vc as(select region
from rc
group by region
having sum(gp)=0)

select vc.region, pd.YM, pd.veh_stolen
from vc join pd
on vc.region=pd.region
order by vc.region,pd.YM;

-- Q21: Which region has the highest thefts per month?
select YM,region,veh_stolen from(
select date_format(sv.date_stolen,'%Y-%m') as YM, locn.region, count(sv.vehicle_id) as veh_stolen, 
dense_rank() over(partition by date_format(sv.date_stolen,'%Y-%m') order by count(sv.vehicle_id) desc) as drnk
from sv join locn on sv.location_id=locn.location_id
group by date_format(sv.date_stolen,'%Y-%m'),locn.region)t
where drnk=1;

-- Q22: Highest stolen month for each region.
select region,YM,veh_stolen from(
select locn.region, date_format(sv.date_stolen,'%Y-%b') as YM, count(sv.vehicle_id) as veh_stolen,
dense_rank() over(partition by locn.region order by count(sv.vehicle_id) desc) as drnk
from  locn join sv on locn.location_id=sv.location_id
group by locn.region,date_format(sv.date_stolen,'%Y-%b'))t
where drnk=1;

-- Q23: Which vehicle category is most stolen in each region?
select region,make_type,veh_stolen from
(select locn.region, vd.make_type, count(sv.vehicle_id) as veh_stolen, dense_rank() over(partition by locn.region order by count(sv.vehicle_id) desc) as drnk
from locn join sv on locn.location_id=sv.location_id
join vd on vd.make_id=sv.make_id
group by locn.region,vd.make_type)t
where drnk=1;

-- Q24: Top 3 stolen vehicle per region
with cte as(select locn.region, sv.vehicle_type, count(sv.vehicle_id) as veh_stolen, dense_rank() over(partition by locn.region order by count(sv.vehicle_id) desc) as drnk
from locn join sv on locn.location_id=sv.location_id
group by locn.region,sv.vehicle_type)

select region, vehicle_type as veh_name, veh_stolen
from cte 
where drnk<=3;

-- Q25: Which top 3 company dominates thefts in specific regions?
select region,make_name as company,veh_stolen from
(select locn.region, vd.make_name, count(sv.vehicle_id) as veh_stolen, dense_rank() over(partition by locn.region order by count(sv.vehicle_id) desc) as drnk
from locn join sv on locn.location_id=sv.location_id
join vd on vd.make_id=sv.make_id
group by locn.region,vd.make_name)t
where drnk<=3;

-- Q26: Which company's vehicle dominates thefts in specific regions?
with cte as(select locn.region, vd.make_name,sv.vehicle_type,sv.color, count(sv.vehicle_id) as veh_stolen, dense_rank() over(partition by locn.region order by count(sv.vehicle_id) desc) as drnk
from locn join sv on locn.location_id=sv.location_id
join vd on vd.make_id=sv.make_id
group by locn.region,vd.make_name,sv.vehicle_type,sv.color)

select region, make_name as Company,vehicle_type as veh_name, color, veh_stolen
from cte 
where drnk<=3;

-- Q27: Are certain vehicles stolen more in specific months?
select YM,vehicle_type,veh_stolen from(
select date_format(date_stolen,'%Y-%m') as YM, vehicle_type, count(vehicle_id) as veh_stolen, 
dense_rank() over(partition by date_format(date_stolen,'%Y-%m') order by count(vehicle_id) desc) as drnk
from sv
group by date_format(date_stolen,'%Y-%m'), vehicle_type)t
where drnk=1
order by YM;

-- Q28: Are newer vehicles being stolen more in recent years? (Top 3 model_year veh stolen for each years)
select years, model_year, veh_stolen from(
select year(date_stolen) as years, model_year, count(vehicle_id) as veh_stolen, 
dense_rank() over(partition by year(date_stolen) order by count(vehicle_id) desc) as drnk
from sv
group by year(date_stolen), model_year)t
where drnk<=3
order by years;


