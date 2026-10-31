create database reliancee;
use reliancee;
SELECT * FROM reliancee.reliancee;

-- classify each day volume as 'high' > 2 cr, medium (1 to 2 cr,'low' < 1 cr
 select ï»¿date,volume, case when
 volume>2000000 then 'high'
 when volume >= 1000000 then 'medium'
 else 'low'
 end as volume_cate from reliancee order by ï»¿date;

 
 select max(volume) from reliancee;
 
 -- select v.ï»¿date,v.prev_close,v.volume_category,
-- d.ï»¿date,d.close,d.prev_close
 
 -- show the avg volume on days with a gain vs days with a loss
 
 select case
 when close>prev_close then 'gain'
 when close<prev_close then 'loss'
 else 'flat' end as day_type,
 
 count(*) as  days, 
 round(avg(volume),0) as avg_volume from reliancee group by day_type;
 


-- find the avg closing price for each month
select date_format(ï»¿date,'%y-%m') as ym,round(avg(close),2) as avg_close from reliancee group by ym order by ym ;

-- find the total volume for each month 
select date_format(ï»¿date,'%y-%m')as ym,sum(volume) as totalvolume from reliancee group by ym order by totalvolume desc ;

-- find the avg closing price for each quarter 
select concat(year(ï»¿date),'-q',quarter(ï»¿date)) as qtr ,
round(avg(close),2) as avg_close from reliancee group by year(ï»¿date),qtr,quarter(ï»¿date) order by year(ï»¿date),quarter(ï»¿date);

-- find the avg volume from each of the week mon to fri
select dayname(ï»¿date) as weekday,round(avg(volume),0)as avg_volume from 
reliancee group by weekday(ï»¿date),dayname(ï»¿date) order by weekday(ï»¿date);


-- find whch wekday has the highest avg closing price
select dayname(ï»¿date)as weekday,round(avg(close),2) as avg_close from reliancee
group by weekday(ï»¿date), dayname(ï»¿date)
order by avg_close desc limit 1;

-- find highest price nd lowest price each mnth
select date_format(ï»¿date,'%y-%d')as ym ,max(high) as day_high,
min(low)as month_low,round(max(high)- min(low),2) as diff from reliancee group by ym order by ym ;

-- day wise high low
select date_format(ï»¿date,'%y-%d')as yd ,max(high) as day_high,
min(low)as day_low,round(max(high)- min(low),2) as diff from reliancee group by yd order by yd ;

select date_format(ï»¿date,'%y-%m')as ym ,round(avg(volume),0) as avg_volume from reliancee
group by ym having avg(volume)<(select avg(volume) from reliancee);

-- calc column nd case

-- count the no of gain , loss and flat using case with group by
select day_type,count(*)as days 

from(select case
when close>prev_close then 'gain'
when close<prev_close then 'loss' else 
'flat'
end as day_type from reliancee) as t group by day_type;

-- showthe gap(open-rev_close) foreach day and flag gap greate than 1%
select ï»¿date,prev_close,open,
round(open-prev_close)  as gap,
round((open-prev_close)/prev_close*100,2)as gap_percentage,
case when (open-prev_close)/prev_close*100>1

then 'gap up >2%' else '' end as flag from reliancee
order by ï»¿date ;

-- windw function

-- add a row no to each day order by trade date 
select row_number() over(order by  ï»¿date) as rn,
 ï»¿date,close from reliancee;

-- rank days by volume using dense_rank
select  ï»¿date,volume,
dense_rank() over (order by  volume desc) as volume_rank
from reliancee;

-- show each days close along side te nxt days close using 

select  ï»¿date,close,
lead(close) over(order by  ï»¿date) as next_day_close
from reliancee ;


select  ï»¿date,close,
lag(close) over(order by  ï»¿date) as next_day_close
from reliancee ;

-- calc moving avg of 5 day of closing price
select  ï»¿date,close,round(avg(close)over( order by  ï»¿date rows between 4 preceding and
current row),2) as moving_avg from reliancee;

-- calc the running total of vume order by data
select  ï»¿date,volume
,sum(volume) over(order by   ï»¿date) as running_volume from reliancee;

-- calc the draw down from the range max close for each days
select  ï»¿date,close,max(close)over(order by   ï»¿date) as running_max,
round((close-max(close) over(order by   ï»¿date))/max(close) over( order by   ï»¿date)/
max(close) over(order by   ï»¿date)*100,2) as drawdown_pct from reliancee;





 



