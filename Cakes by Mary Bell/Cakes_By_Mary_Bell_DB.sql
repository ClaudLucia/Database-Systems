--Cupcakes by Mary Bell Store Database
--Claudia Rojas


DROP VIEW DelivererJobs;
DROP VIEW BakerJobs;
DROP VIEW LocationofCustomerOrders;
DROP TABLE IF EXISTS baker;
DROP TABLE IF EXISTS deliverer;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS store;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS recipeingredients;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS recipe;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS people;


-- Suppliers--
CREATE TABLE suppliers(
	UID 		char(4) not null,
	comName 	text	not null,
	phoneNUM	char(10)not null,
	primary key (UID)
);


-- Inventory Items--
CREATE TABLE inventory(
	ITID		char(4) not null,
	name		text 	not null,
	instock		integer	not null,
	UID			char(4) not null references suppliers(UID),
	primary key (ITID)
);

--Recipe--
CREATE TABLE recipe(
	RECID 		char(4) not null,
	name		text 	not null,
	primary key (RECID)
);


-- Recipe Ingredients--
CREATE TABLE recipeIngredients(
	RECID 		char(4) not null references recipe(RECID),
	ITID 		char(4) not null references inventory(ITID),
	quantity	integer not null,
	primary key (RECID,ITID)
);


-- Store--
CREATE TABLE store(
	SID 		char(4) not null,
	address		text	not null,
	proUSD		integer	not null,
	primary key (SID)
);


-- Orders--
CREATE TABLE orders(
	OID 		char(4) not null,
	orderDate	date 	not null,
	finishDate	date 	not null,
	occasion	text 	null,
	layers 		integer not null,
	flavor		text 	not null,
	filling		text 	null,
	totalUSD	integer	not null,
	RECID 		char(4) not null references recipe(RECID),
	primary key (OID)
);


-- People -- 
CREATE TABLE people(
	PID			char(4) 	not null,
	name		text 		not null,
	phoneNUM	char(10) 	null,    
	email		text 		null,
	primary key(PID)
);


-- Customers--
CREATE TABLE customers(
	PID 		char(4) not null references people(PID),
	OID 		char(4) not null references orders(OID),
	address 	text null,
	pickUPdate	date not null,
	primary key (PID, OID)
);


-- Employees --
CREATE TABLE employees(
	EID			char(4) not null,
	PID			char(4) not null references people(PID),
	role		text	not null,
	payUSD		integer not null,
	SID			char(4) not null references store(SID),
	primary key (EID)
);


-- Deliverer--
CREATE TABLE deliverer(
	EID			char(4) not null references employees(EID),
	OID 		char(4) not null references orders(OID),
	deliverAdd	text	not null,
	deliveryDay	date 	not null,
	primary key	(OID,EID)
);

-- Baker--
CREATE TABLE baker(
	EID 		char(4) not null references employees(EID),
	OID 		char(4) not null references orders(OID),
	primary key (OID, EID)
);


-- SQL statements for loading example data into the CAP3 database
-- Connect to your Postgres server and set the active database to CAP3. Then . . .


-- Suppliers--
INSERT INTO suppliers(UID,comName,phoneNUM)
	VALUES ('u001','Green Farms','845786231');

INSERT INTO suppliers(UID,comName,phoneNUM)
	VALUES ('u002','Party Planet','7854192565');


-- Inventory--
INSERT INTO inventory(ITID,name,instock,UID)
	VALUES ('i001','eggs','200','u001');
INSERT INTO inventory(ITID,name,instock,UID)
	VALUES ('i002','milk','100','u001');
INSERT INTO inventory(ITID,name,instock,UID)
	VALUES ('i003','flour','75','u001');
INSERT INTO inventory(ITID,name,instock,UID)
	VALUES ('i004','butter','150','u001');
INSERT INTO inventory(ITID,name,instock,UID)
	VALUES ('i005','Wedding Topper','100','u002');
INSERT INTO inventory(ITID,name,instock,UID)
	VALUES ('i006','Birthday Topper','100','u002');


-- Recipe--
INSERT INTO recipe(RECID,name)
	VALUES('r001','Chocolate Cake');

INSERT INTO recipe(RECID,name)
	VALUES('r002','Vanilla Cake');

INSERT INTO recipe(RECID,name)
	VALUES('r003','Red Velvet Cake');

INSERT INTO recipe(RECID,name)
	VALUES('r004','Ice Cream Cake');


-- Ingredients--
INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r001','i001','10');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r001','i002','3');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r001','i003','5');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r001','i004','2');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r002','i001','10');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r002','i002','3');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r002','i003','5');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r002','i004','2');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r003','i001','10');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r003','i002','3');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r003','i003','5');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r003','i004','2');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r004','i002','5');

INSERT INTO recipeingredients(RECID,ITID, quantity)
	VALUES ('r004','i004','2');


-- Orders--
INSERT INTO orders(OID, orderDate, finishDate,occasion, layers,flavor,filling, totalUSD, RECID)
	VALUES('d001','2016-06-5','2016-06-10','Birthday','2','Red Velvet','Chocolate', '30', 'r003');

INSERT INTO orders(OID, orderDate, finishDate, occasion, layers, flavor, filling, totalUSD, RECID)
	VALUES('d002','2016-04-28','2016-05-01','Retirement','3','Vanilla','Caramel', '45', 'r002');

INSERT INTO orders(OID, orderDate, finishDate, occasion, layers, flavor, filling, totalUSD, RECID)
	VALUES('d003','2016-05-05','2016-05-11','Baby Shower','1','Vanilla','Chocolate', '15', 'r002');

INSERT INTO orders(OID, orderDate, finishDate,occasion, layers, flavor, filling, totalUSD, RECID)
	VALUES('d004','2016-05-14','2016-05-22','Wedding','4','Chocolate','Caramel', '90', 'r001');

INSERT INTO orders(OID, orderDate, finishDate, occasion, layers, flavor, filling, totalUSD, RECID)
	VALUES('d005','2016-05-30','2016-06-02','Birthday','2','Chocolate','Rasberry', '30', 'r001');

INSERT INTO orders(OID, orderDate, finishDate, occasion, layers, flavor, filling, totalUSD, RECID)
	VALUES('d006','2016-05-31','2016-06-10','Wedding','5','Red Velvet','Rasberry', '105', 'r003');

INSERT INTO orders(OID, orderDate, finishDate, occasion, layers, flavor, filling, totalUSD, RECID)
	VALUES('d007','2016-06-01','2016-06-03','Baby Shower','1','Vanilla','Caramel', '15', 'r002');

INSERT INTO orders(OID, orderDate, finishDate, occasion, layers, flavor, filling, totalUSD, RECID)
	VALUES('d008','2016-06-02','2016-06-05','Birthday','1','Ice Cream','', '15', 'r004');

INSERT INTO orders(OID, orderDate, finishDate, occasion, layers, flavor, filling, totalUSD, RECID)
	VALUES('d009','2016-05-28','2016-06-02','Retirement','3','Chocolate','Caramel', '45', 'r001');



-- People--
INSERT INTO people(PID, name, phoneNUM, email)
	VALUES ('p001','Jeny','7865554741','Jeny@ilovecakes.com');

INSERT INTO people(PID, name, phoneNUM, email)
	VALUES ('p002','Rico','8452695163','Ricardo@gmail.com');

INSERT INTO people(PID, name, phoneNUM, email)
	VALUES ('p003','Beatriz','3058216492','Beatriz@bestgrandma.com');

INSERT INTO people(PID, name, phoneNUM, email)
	VALUES ('p004','Maribell','5156902289','MaryBell@cbmb.com');

INSERT INTO people(PID, name, phoneNUM, email)
	VALUES ('p005','Baldo','7863145414','Baldodelivers@cbmb.com');

INSERT INTO people(PID, name, phoneNUM, email)
	VALUES ('p006','Pamela','2025550174','Pameladelivers@cbmb.com');

INSERT INTO people(PID, name, phoneNUM, email)
	VALUES ('p007','Clay','7865963869','Claybakes@cbmb.com');

INSERT INTO people(PID, name, phoneNUM, email)
	VALUES ('p008','Denzel','7865912287','Denzelbakes@cbmb.com');


--Store--
INSERT INTO store(SID, address,proUSD)
	VALUES('s001','900 Ocean Dr Miami Beach, Florida','2500');

-- Employees--
INSERT INTO employees(PID, EID, role, payUSD, SID)
	VALUES('p004','e001','Owner', '25','s001');

INSERT INTO employees(PID, EID, role, payUSD, SID)
	VALUES('p005','e002','Deliverer', '15','s001');
	
INSERT INTO employees(PID, EID, role, payUSD, SID)
	VALUES('p006','e003','Deliverer', '15','s001');

INSERT INTO employees(PID, EID, role, payUSD, SID)
	VALUES('p007','e004','Baker', '20','s001');

INSERT INTO employees(PID, EID, role, payUSD, SID)
	VALUES('p008','e005','Baker', '20','s001');


-- Baker--
INSERT INTO baker(EID,OID)
	VALUES('e004','d002');

INSERT INTO baker(EID,OID)
	VALUES('e004','d004');

INSERT INTO baker(EID,OID)
	VALUES('e005','d001');

INSERT INTO baker(EID,OID)
	VALUES('e005','d003');

INSERT INTO baker(EID,OID)
	VALUES('e005','d005');

INSERT INTO baker(EID,OID)
	VALUES('e005','d006');

INSERT INTO baker(EID,OID)
	VALUES('e004','d007');

INSERT INTO baker(EID,OID)
	VALUES('e004','d008');

INSERT INTO baker(EID,OID)
	VALUES('e005','d009');

-- Deliverer--
INSERT INTO deliverer(EID,OID, deliverAdd, deliveryDay)
	VALUES('e002','d003','15 SE 10th St, Miami, FL 33131','2016-05-12' );

INSERT INTO deliverer(EID,OID , deliverAdd, deliveryDay)
	VALUES('e003','d004','1717 N Bayshore Dr, Miami, FL 33132', '2016-05-21');

INSERT INTO deliverer(EID,OID , deliverAdd, deliveryDay)
	VALUES('e003','d006','1717 N Bayshore Dr, Miami, FL 33132', '2016-06-07');


--Customer--
INSERT INTO customers(PID, address, pickUPdate, OID)
	VALUES('p001','4242 NW 2nd St APT 1607, Miami, FL 33126','2016-06-11','d001');

INSERT INTO customers(PID, address, pickUPdate, OID)
	VALUES('p002', '1080 Brickell Ave UNIT 3104 Miami, FL 33131', '2016-05-02', 'd002');

INSERT INTO customers(PID, address, pickUPdate, OID)
	VALUES('p003', '244 Biscayne Blvd APT 445, Miami, FL 33132', '2016-06-03', 'd005');

INSERT INTO customers(PID, address, pickUPdate, OID)
	VALUES('p001', '4242 NW 2nd St APT 1607, Miami, FL 33126', '2016-06-10', 'd007');

INSERT INTO customers(PID, address, pickUPdate, OID)
	VALUES('p002', '1080 Brickell Ave UNIT 3104 Miami, FL 33131', '2016-06-06', 'd008');

INSERT INTO customers(PID, address, pickUPdate, OID)
	VALUES('p003', '244 Biscayne Blvd APT 445, Miami, FL 33132', '2016-06-03', 'd009');


-- SQL statements for displaying example data into the CAP3 database
-- Connect to your Postgres server and set the active database to CAP3. Then . . .

SELECT *
FROM people;

SELECT *
FROM  orders;

SELECT *
FROM employees;

SELECT *
FROM  baker;

SELECT *
FROM customers;

SELECT *
FROM deliverer;

SELECT *
FROM recipeingredients;

SELECT *
FROM recipe;

SELECT *
FROM inventory;

SELECT *
FROM suppliers;

SELECT *
FROM store;




-- VIEWS--

CREATE VIEW LocationofCustomerOrders
AS
SELECT c.pid, oid, address, pickupdate, name,phonenum,email
FROM customers c, people p
WHERE address
LIKE '%33132%'
AND c.pid = p.pid;

CREATE VIEW DelivererJobs
AS
SELECT name,oid, phoneNum, email, role, payUSD, sid
FROM deliverer d, employees e, people p
WHERE d.eid = e.eid
and e.pid = p.pid;

CREATE VIEW BakerJobs
AS
SELECT name,oid, phoneNum, email, role, payUSD, sid
FROM baker b, employees e, people p
WHERE b.eid = e.eid
AND e.pid = p.pid
ORDER BY oid asc;


-- Reports--

SELECT OID
AS OrdersMade,
	avg(finishDate - orderDate)
	AS Avg_completion
FROM orders
GROUP BY OrdersMade
ORDER BY OrdersMade ASC;


SELECT RECID, SUM(quantity)
	AS IngredientsUsed
FROM recipeingredients
GROUP BY RECID
ORDER BY RECID ASC


-- Triggers--

CREATE TRIGGER AddNewOrders
AFTER INSERT OR UPDATE ON orders
	FOR EACH ROW EXECUTE PROCEDURE insertOrders();

CREATE TRIGGER AddNewInventory
AFTER INSERT OR UPDATE ON inventory
FOR EACH ROW EXECUTE PROCEDURE insertItem();

CREATE TRIGGER AddNewPerson
AFTER INSERT OR UPDATE ON people
FOR EACH ROW EXECUTE PROCEDURE insertPerson();

CREATE TRIGGER AddNewEmployee
AFTER INSERT OR UPDATE ON employees
	FOR EACH ROW EXECUTE PROCEDURE hireEmployee();



-- Stored Procedures--

CREATE OR REPLACE FUNCTION insertOrders()
RETURNS trigger AS $$
	BEGIN
        IF NEW.OID = true THEN 
            INSERT INTO Orders
            VALUES(orderDate, layers, finishDate, occasion, 
                price, layers, flavor, filling, RECID);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertItem()
RETURNS TRIGGER AS $$
	BEGIN
		 IF NEW.ITID = true THEN 
            INSERT INTO inventory
            VALUES(name, instock, UID);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION insertPerson()
RETURNS TRIGGER AS $$
DECLARE
	PID integer;
	BEGIN
		    INSERT INTO people
            VALUES(name, phoneNUM, email);
            PID = NEW.PID;
	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION hireEmployee()
RETURNS TRIGGER AS $$
DECLARE
	PID integer;
	EID integer;
	BEGIN
		    INSERT INTO employees
            VALUES(role, payUSD, SID);
            PID = NEW.PID;
            EID = NEW.EID;
	END;
$$ LANGUAGE plpgsql;

-- Security--

GRANT ALL PRIVLIGES ON ALL TABLE IN SCHEMA public to administrator;

GRANT SELECT ON employees to employees;

GRANT SELECT, INSERT ON deliverer to deliverer;

GRANT SELECT, INSERT ON baker to baker;
GRANT SELECT, ON orders to baker

GRANT SELECT, INSERT, UPDATE orders to manager;
GRANT SELECT, INSERT, UPDATE employees to manager;
GRANT SELECT, INSERT, UPDATE deliverer to manager;
GRANT SELECT, INSERT, UPDATE baker to manager;
GRANT SELECT, INSERT, UPDATE inventory to manager;