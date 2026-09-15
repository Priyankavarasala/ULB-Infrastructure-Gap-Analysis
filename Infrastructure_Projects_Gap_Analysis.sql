create database infrastructure_analysis;
use infrastructure_analysis;
describe infrastructure_projects;
select * from infrastructure_projects;
select count(*) as Total_Rows from infrastructure_projects;
select District, Contractor,
round(avg('Cost_Variance%'),1) as avg_cost_overrun,
count(*) as project_count,
rank() over (partition by district order by avg('Cost_Variance%') desc) as Contractor_Rank
from infrastructure_projects
where
contractor is not null
group by District, Contractor
having count(*)>= 5
order by District, Contractor_Rank;
describe infrastructure_projects;

Alter table infrastructure_projects
modify Project_ID int primary key not null,
modify Planned_Cost double,
modify Planned_Progress double,
modify Actual_Progress double,
modify Gap_Progress double;

update infrastructure_projects set Actual_Cost= null where Actual_Cost=-1;
select District, Contractor,
round(avg(`Cost_Variance%`),1) as avg_cost_overrun,
count(*) as project_count,
rank() over (partition by district order by avg(`Cost_Variance%`) desc) as Contractor_Rank
from infrastructure_projects
where
contractor is not null
group by District, Contractor
having count(*)>= 5
order by District, Contractor_Rank;

with budget_delay as (
    select
        Budget_Source,
        avg(Delay_Days) as Avg_Delay_Days
    from infrastructure_projects
    where Actual_End_Date is NOT NULL
    GROUP BY Budget_Source
)
select *
from budget_delay
ORDER BY Avg_Delay_Days desc;




