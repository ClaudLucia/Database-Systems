/*Claudia Rojas
  October 11, 2016
  Lab 6 Interesting and Painful Queries*/


/*1 Display the name and city of customers who live in any city that makes 
the most different kinds of products. (There are two cities that make the most 
different products. Return the name and city of customers from either one of those.)
*/

Select distinct customers.name, customers.city
From customers
where customers.city in(
    select city 
    from products
    	group by city
    	order by count(quantity)
    	fetch first 1 row only
);



/*2 Display the names of products 
whose priceUSD is strictly below the average priceUSD, 
in reverse-alphabetical order.*/

Select name
from products
where priceUSD <(
	Select AVG(priceUSD)
	from products)
Order by name DESC;


/*3 Display the customer name, pid ordered, and the total for all orders, 
sorted by total from low to high.*/

Select distinct customers.name, orders.pid, orders.totalUSD
from customers
left join orders on orders.cid = customers.cid
Order by totalUSD ASC;


/*4 Display all customer names (in alphabetical order) 
and their total ordered, 
and nothing more. Use coalesce to avoid showing NULLs.*/

Select customers.name, coalesce(sum(totalUSD))totalUSD
from orders
right outer join customers on orders.cid = customers.cid
group by name
order by name ASC;


/*5 Display the names of all customers who bought products 
from agents based in New York along with the names of 
the products they ordered, 
and the names of the agents who sold it to them.*/

Select customers.name, products.name, agents.name
from orders
	right outer join customers on orders.cid = customers.cid
	right outer join products on orders.pid = products.pid
	right outer join agents on orders.aid = agents.aid
where agents.aid in (
    select aid
    from agents
    where city = 'New York'
    )
group by customers.name, products.name, agents.name;


/*6 Write a query to check the accuracy of the dollars column in 
the Orders table. This means calculating Orders.totalUSD from data in 
other tables and comparing those values to the values in Orders.totalUSD. 
Display all rows in Orders where Orders.totalUSD is incorrect, if any.*/

Select *
From (Select orders.*, orders.qty*products.priceUSD*(1-(customers.discount/100)) as trueUSD
	  from orders
	  inner join products on orders.pid = products.pid
	  inner join customers on orders.cid = customers.cid
	  group by products.pid, orders.qty, orders.ordnum, customers.discount
	  order by orders.ordnum ASC) as ordering
where totalUSD != trueUSD;


/*7 What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? 
Give example queries in SQL to demonstrate. 
(Feel free to use the CAP database to make your points here.)


Left outer join prioritzes what is on the left side of the sql query,
while the right outer join prioritizes the right side of the query.
For example in #5 the query compares the customer table rather than the order table
such as in #3 where the query prioritizes the customer table rather than the order table.
*/