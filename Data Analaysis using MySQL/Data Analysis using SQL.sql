SHOW tables;
DESC sales;
SELECT * FROM sales;

SELECT SaleDate, Amount, Customers from sales;

-- Calculation in queries
SELECT SaleDate, Amount, Boxes, Amount / Boxes from sales;
-- Alias or giving column a temporary name
SELECT SaleDate, Amount, Boxes, Amount / Boxes AS amount_per_box from sales;

SELECT SaleDate, Amount, Boxes, Amount / Boxes 'Amount per box' from sales;

-- Filtering using WHERE clause
select * 
FROM sales
where amount > 10000;
-- Sorting data using  ORDER BY
select * FROM sales
where amount > 10000
order by amount;

select * FROM sales
where amount > 10000
order by amount desc;

select  * from sales
where geoid = 'g1'
order by PID , Amount desc;

-- All the result from sales table  where value >10000 & year =2022

-- Working with dates in SQL

SELECT *
from sales
where amount>10000 and SaleDate >= '2022-01-01';

SELECT *
from sales
where amount>10000 and SaleDate like '2022%';

-- Using year() function to select all data in a specific year

SELECT SaleDate, Amount from sales
where Amount>10000  and year(SaleDate) = 2022 order by Amount desc;

-- All the sales where no of boxex b/w 0 to 50;
select * from sales
where Boxes > 0 and Boxes<= 50;

select * from sales
where amount between 0 and 50;

-- All thesales made on Friday
-- weekday() Returns the weekday index for date (0 = Monday, 1 = Tuesday, hellip 6 = Sunday).
select SaleDate , Amount, Boxes , weekday(SaleDate)   
from sales 
where weekday(SaleDate) = 4;

-- Using people table
select * from people;

select *  from people 
where team = 'Delish' or team = 'Jucies';
-- Using IN clause
select *  from people 
where team IN ('Yummies', 'Delish', 'Jucies');

-- Pattern matching- Using wildcard LIKE operator
select * from people
where Salesperson like 'B%';

select * from people
where Salesperson like '%B%';


-- -- Using CASE to create branching logic in SQL

select * from sales;

select SaleDate, Amount,
	case	when Amount < 1000 then 'Under 1k'
			when Amount < 5000 then 'Under 5k'
            when Amount < 10000 then 'Under 10k'
		else '10K or more'
	end as 'Amount Category'
from sales;     

select SPID, Boxes,
	case	when boxes < 1000 then 'sold under 1k'
			when boxes < 1500 then 'sold under 1.5k'
            when boxes < 2000 then 'sold under 2k'
		else 'sold 2k or more'
	end as 'Number of boxes sold'
from sales
order by Boxes desc;

-- Using JOINS

select * from sales;

select * from people;

select s.SaleDate, s.Amount , p.Salesperson, p.SPID, s.spid
from sales as s
join people as p on p.SPID = s.spid;


select s.SaleDate, s.Amount , p.Salesperson, p.SPID, s.spid
from sales s
join people p on p.SPID = s.spid;

-- LEFT JOIN

select * from sales as s
left join people as p on p.SPID=s.SPID;

select s.SaleDate, s.Amount , pr.Product
from sales s
left join products pr on pr.pid = s.pid;

-- joining multiple tables

select s.SaleDate, s.Amount , p.Salesperson, pr.Product, p.Team
from sales s
join people p on p.SPID = s.spid
join products pr on pr.pid = s.pid;


select s.SaleDate, s.Amount , p.Salesperson, pr.Product, p.Team
from sales s
join people p on p.SPID = s.spid
join products pr on pr.pid = s.pid
where s.amount<500 and p.team ='Delish';

select s.SaleDate, s.Amount , p.Salesperson, pr.Product, p.Team
from sales s
join people p on p.SPID = s.spid
join products pr on pr.pid = s.pid
where s.amount<500 and p.team = '';

 
select s.SaleDate, s.Amount , p.Salesperson, pr.Product, p.Team, g.Geo
from sales s
join people p on p.SPID = s.spid
join products pr on pr.pid = s.pid
join geo g on g.GeoID= s.GeoID
where s.amount<500 and p.team = '' and g.Geo IN ('New Zealand', 'India');

-- Using Group by to create report 

select GeoID, sum(Amount)
from sales
group by GeoID;

select GeoID, sum(Amount), avg(Amount), sum(Boxes)
from sales
group by GeoID;

-- Using join with group by
select g.Geo, sum(Amount), avg(Amount), sum(Boxes)
from sales s
join geo g on g.GeoID = s.GeoID
group by g.geo;

-- Using Join ,group by, having clause

select g.Geo, sum(Amount), avg(Amount), sum(Boxes)
from sales s
join geo g on g.GeoID = s.GeoID
group by g.geo
having Geo in ('Canada', 'USA', 'India');
-- Get data from from people ,product table

select pr.Category, p.Team, sum(Boxes), sum(Amount)
from sales s
join people p on p.spid =s.spid
join products pr on pr.pid= s.pid
group by pr.Category, p.Team;

-- using Join, group by and order by
select pr.Category, p.Team, sum(Boxes), sum(Amount)
from sales s
join people p on p.spid =s.spid
join products pr on pr.pid= s.pid
group by pr.Category, p.Team
order by pr.Category, p.Team;


-- team is not equal to blank ''
select pr.Category, p.Team, sum(Boxes), sum(Amount)
from sales s
join people p on p.spid =s.spid
join products pr on pr.pid= s.pid
where p.team != ''                -- != or <>
group by pr.Category, p.Team
order by pr.Category, p.Team;

-- Total amounts by diffrent products
select pr.Product, sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.pid = s.pid
group by pr.Product
order by 'Total Amount' desc;

-- Total amounts by top 10 products 

select pr.Product, sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.pid = s.pid
group by pr.Product
order by 'Total Amount' desc
LIMIT 10;







 














