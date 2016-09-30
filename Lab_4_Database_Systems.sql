/*Claudia Rojas
September 28, 2016
Lab 4 SQL Queries: The Subqueries Sequel*/


/*Get the cities of agents booking an order from a customer whose cis id ‘c006’*/
select distinct city
from agents
where aid in(
        select aid
        from orders
        where cid = 'c006');

/*Get the ids of products ordered though any agents who takes at least one order from a customer in Kyoto, sorted by pid from highest to lowest*/
Select distinct pid
from orders
where cid in(
    select cid
    from customers
    where city = 'Kyoto')
order by pid DESC;

/*Get the ids and names of customers who did not place an order though agent a03*/
Select distinct cid, name
from customers
where cid not in(
    select cid
    from orders
    where aid ='a03');

/*Get the ids of customers who ordered both products p01 and p07*/
select distinct cid
from orders
where pid = ('p01')
	Intersect
select distinct cid
from orders
where pid = ('p07');


/*Get the ids of products NOT ordered by any customers who placed any order though agent 108 in pid order from highest to lowest*/
select distinct pid 
from orders
where cid not in(
    select cid
    from orders
    where aid = 'a08')
order by pid DESC;

/*Get the name, discounts, and city for all customers who place orders though agents in Dallas or New York*/
select distinct name, discount, city
from customers
where cid in(
    select cid
    from orders
    where aid in(
        select aid
        from agents
        where city ='Dallas' or city ='New York'));

/*Get all customers who have the same discount as that of any customers in Dallas or London*/
select distinct *
from customers
where not city ='Dallas' and not city ='London' and discount in(
    select discount
    from customers
    where city ='Dallas' or city ='London');


/*Check constraints is an integrity constraint that has requirements for each row that must be fulfilled.  
It allows for certain values to be pulled from a column.  
They are beneficial because they can limit the values in columns based on other columns.  
A good check constraint would be giving the id value of school officials any number except a combination of only zeroes. 
For example, fID >0 would be a good check constraint.  
This way it will not confuse the database if an employee had the id with only zeroes. 
A bad check constraint would be to limit the amount of family members in a health plan.  
For example, if someone wanted to add their twin children to their healthcare plan 
but were not allowed because the birthdays were the same then it would be a bad check constraint.*/
