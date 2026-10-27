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

-- calc column nd case







 



