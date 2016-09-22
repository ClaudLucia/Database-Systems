--Claudia Rojas
--Database Systems
--CMPT 308
--September 9, 2016

--1
select ordnum, totalUSD
from orders;

--2
Select name,city
from agents
where name = 'Smith';

--3
Select pid, name, priceUSD
from Products
where quantity >201000;

--4
select name, city
from Customers
where city = 'Duluth'; 

--5
select name
from Agents
where city != 'Duluth'
and city!='New York';

--6
Select *
from Products
where city NOT IN ('Dallas')
and city NOT IN ('Duluth')
and priceUSD >= 1.00; 

--7
Select *
from Orders
where mon = 'feb'
or mon = 'mar';

--8
select *
from orders
where mon = 'feb'
and totalusd >= 600;

--9
select *
from orders
where cid = 'c005';
