/*Claudia Rojas
  October 5, 2016
  Lab 5 SQL Queries: The Joins Three-quel*/


/*1 Select the cities of agents booking an order for a customer 
whose id is c006. 
Use joins, no subqueries*/
Select city 
from agents inner join orders
	on orders.aid = agents.aid 
    	and orders.cid='c006';


/*2 Select the pid ordered through any agent who makes at least
one order for a customer in Kyoto, sorted by pid from highest to lowest
Use joins, no subqueries*/
Select distinct pid 
from orders inner join customers
	on customers.cid = orders.cid 
    	and customers.city = 'Kyoto'
order by pid DESC;


/*3 Select the name of customers who have never placed an order. Use subqueries*/
Select distinct name 
from Customers
where cid not in(
    select cid from Orders
);


/*4 Select the name of customers who have never placed an order. 
Use an outer join*/
Select distinct name 
from Customers
left outer join Orders 
	on customers.cid =orders.cid
    	where orders.cid is null;


/*5 Select the names of customers who placed at least 
one order through an agent in their own city, along with the agents name. */
Select distinct customers.name, agents.name
from Customers, agents, orders
where customers.city = agents.city
	and orders.aid = agents.aid
	and orders.cid = customers.cid;


/*6 Select the names of customers and agents living in the same city,
along with the name of the shared city, ragrdless of whether or not
the customer has ever placed an order with that agent*/
Select distinct customers.name, agents.name, customers.city
from Customers, agents
where customers.city = agents.city


/*7 Select the names and city of customers who live in THE city 
that meakes the FEWEST different kinds of products
Hint use COUNT and GROUP BY on the Products table*/
Select distinct customers.name, customers.city
from customers
where customers.city in(
    select city 
    from products
    	group by city
    	order by count(quantity)
    	fetch first 1 row only
);
    