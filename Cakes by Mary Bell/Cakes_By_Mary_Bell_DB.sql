--Cupcakes by Mary Bell Store Database
--Claudia Rojas

 
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS agents;
DROP TABLE IF EXISTS products;




-- Store --
CREATE TABLE store(
	SID			integer not null,
	StoreAdd	text not null,
	




);


-- People -- 
CREATE TABLE people (
	PID			integer not null,
	Name		text not null,
	PhoneNUM	integer(10) null,    
	Email		text(4),
	primary key(PID)
);

-- Employees --
CREATE TABLE employees(
	PID		integer not null references people(PID),
	SID		integer not null references store(SID),



);


-- Agents --
      

-- Products --







-- SQL statements for loading example data into the CAP3 database
-- Connect to your Postgres server and set the active database to CAP3. Then . . .

-- People --


-- Customers --


-- Agents --


-- Products --





-- SQL statements for displaying example data into the CAP3 database
-- Connect to your Postgres server and set the active database to CAP3. Then . . .

select *
from customers;

select *
from agents;

select *
from products;

select *
from people;