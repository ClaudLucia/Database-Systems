--Cupcakes by Mary Bell Store Database
--Claudia Rojas

 
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS baker;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS pickUP;
DROP TABLE IF EXISTS deliverer;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS purchase;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS shiftDays;
DROP TABLE IF EXISTS shift;



--Shift--
CREATE TABLE shift(
	DID			integer not null ,
	start		time not null,
	finish			time not null,
	primary key(DID)
);


-- Shift Detail--
CREATE TABLE shiftDays(
	DID 		integer not null references shift(DID),
	day 		text 	not null check
						(day in ('Sunday', 'Monday','Tuesday',
								'Wednesday', 'Thursday','Friday',
								'Saturday','Sunday')),
	primary key (DID, day)
);


--Orders--
CREATE TABLE orders(
	OID 		integer not null,
	orderDate	date 	not null,
	layers 		integer not null,
	finishDate	date 	not null,
	occasion	text 	null,
	flavor		text 	not null,
	filling		text 	null,
	primary key (OID)
);


--Purchase--
CREATE TABLE purchase(
	RID 		integer not null,
	OID 		integer not null references orders(OID),
	totalUSD	integer not null,
	method		text 	not null,
	primary key	(RID),
	foreign key (OID) references orders(OID)
);


-- People -- 
CREATE TABLE people (
	PID			integer 	not null,
	name		text 		not null,
	phoneNUM	integer null,    
	email		text,
	primary key(PID)
);


--Pick Up--
CREATE TABLE pickUP(
	PID 		integer not null references people(PID),
	RID 		integer not null references orders(OID),
	pickUPdate	date 	not null,
	primary key (PID,RID)
);


--Delivery--
CREATE TABLE delivery(
	PID 		integer not null references people(PID),
	RID 		integer not null references orders(OID),
	deliverAdd	text	not null,
	deliveryDay	date 	not null,
	primary key(PID,RID)
);


--Customers--
CREATE TABLE customers(
	PID 		integer not null references people(PID),
	OID 		integer not null references orders(OID),
	primary key (PID,OID)
);


-- Employees --
CREATE TABLE employees(
	PID			integer not null references people(PID),
	job			text	not null,
	payUSD		integer not null,
	DID			integer	not null references shift(DID),
	primary key (PID)
);


--Deliverer--
CREATE TABLE deliverer(
	PID			integer not null references people(PID),
	primary key	(PID)
);


--Baker--
CREATE TABLE baker(
	PID 		integer not null references people(PID),
	cakesBaked	integer null,
	primary key (PID)
)


-- SQL statements for loading example data into the CAP3 database
-- Connect to your Postgres server and set the active database to CAP3. Then . . .




-- SQL statements for displaying example data into the CAP3 database
-- Connect to your Postgres server and set the active database to CAP3. Then . . .

