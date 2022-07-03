-- By Olamide Emida, Google Certified Data Analyst
-- create database chandoo; This dataset is from Chandoo, A YouTuber. He answered the following questions in Excel
use chandoo; -- to use the database chandoo

 -- let's check out the table by getting all rows in table; sample
select * 
from sample;

-- to correct error in spelling
update sample
set app = 'Temple Run' where app = 'Temple Bun'; 

-- Total download for sugar rush
select app, sum(downloads) as total_downloads
from sample 
where app = 'sugar rush'; 

-- Total downloads for C apps
select sum(downloads) as total_downloads_c_apps
from sample
where app like 'c%'; 

-- Uninstalls in December 2021
select sum(uninstalls) as uninstall_dec
from sample 
where Month like 'dec%';

-- Downloads in Oct, Nov, Dec 2021
select sum(downloads) as total_downloads_last_quarter
from sample 
where month in ('october-21', 'november-21', 'december-21');

-- How many times we had more than 8000 downloads?
select count(*) as download_over_8k
from sample
where downloads >= 8000;

-- Total 5 star rating for Sugar Rush
select sum(`5 star ratings`) as 5_star_sugar_rush
from sample 
where app = 'sugar rush';

-- Total ratings for sugar rush
select app, sum(`total ratings`) as total_rating
from sample 
where app = 'sugar rush'; 

-- Average uninstalls for Subway Wafers
select app, round(avg(uninstalls),2) as avg_uninstall
from sample
where app = 'subway wafers';

-- Which month has highest uninstall ratio? using CTE
with UninstallRatioPerMonth as 
(select month, round(sum(uninstalls)/sum(downloads) * 100,3) as uninstall_ratio 
from sample
group by month 
order by uninstall_ratio desc)

select month, max(uninstall_ratio) from UninstallRatioPerMonth;

-- Average monthly downloads; average download in each month
select month, round(avg(downloads),2) as avg_downloads
from sample 
group by month;

-- Most downloaded app? 2nd and 3rd places also? Which month and app was that?
select month, app, downloads 
from sample 
order by downloads DESC 
limit 3;

-- In October 2021, which app has most 1 star ratings? Does it change by December 2021?
select s.month, s.app, s.`1 star ratings` 
from sample s join 
(select month, max(`1 star ratings`) as max_1_ratings 
from sample 
group by month) as ss 
on ss.month = s.month and ss.max_1_ratings =  s.`1 star ratings` 
where s.month in ('october-21' , 'december-21');

-- What are the best download figures for each app?
select app, max(downloads) as most_downloaded 
from sample 
group by app 
order by most_downloaded desc;