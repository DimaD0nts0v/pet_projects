CREATE DATABASE shop;

CREATE TABLE productlines
(
	productLine VARCHAR(128) NOT NULL,
	textDescription text,
	htmlDescription text,
	image text
);

CREATE TABLE products
(
	productCode integer NOT NULL,
	productName VARCHAR(128),
	productLine VARCHAR(128),
	productScale text,
	productVendor VARCHAR(128),
	productDescription text,
	quantityInStock int,
	buyPrice numeric(10, 2),
	MSRP numeric(10, 2)
);

CREATE TABLE orderdetails
(
	orderNumber int8 NOT NULL,
	productCode int8 NOT NULL,
	quantityOrdered int8,
	priceEach numeric(10, 2),
	orderLineNumber VARCHAR(128)
);

CREATE TABLE orders
(
	orderNumber int8 NOT NULL,
	orderDate time,
	requiredDate time,
	shippedDate time,
	status VARCHAR(50),
	comments text,
	customerNumber int8
);

CREATE TABLE payments
(
	customerNumber int8 NOT NULL,
	checkNumber int8 NOT NULL,
	paymentDate time,
	amount int8
);

CREATE TABLE customers
(
	customerNumber int8 NOT NULL,
	customerName VARCHAR(50),
	contactLastName VARCHAR(128),
	contactFirstName VARCHAR(128),
	phone int,
	adressLine1 VARCHAR(128),
	adressLine2 VARCHAR(128),
	city VARCHAR(128),
	state VARCHAR(128),
	postalCode int,
	country VARCHAR(128),
	salesRepEmployeeNumber int8,
	creditLimit numeric(10, 2)
);

CREATE TABLE offices
(
	officeCode int8 NOT NULL,
	city VARCHAR(128),
	phone int,
	adressLine1 VARCHAR(128),
	adressLine2 VARCHAR(128),
	state VARCHAR(128),
	country VARCHAR(128),
	postalCode int,
	territory VARCHAR(128)
);

CREATE TABLE employees
(
	employeeNumber int8 NOT NULL,
	lastName VARCHAR(128),
	firstName VARCHAR(128),
	extension int8,
	email VARCHAR(50),
	officeCode int8,
	reportsTo VARCHAR(128),
	jobTittle VARCHAR(50)
);

-- primary keys

ALTER TABLE ONLY productlines
    ADD CONSTRAINT pk_productlines PRIMARY KEY (productLine);

ALTER TABLE ONLY products
    ADD CONSTRAINT pk_products PRIMARY KEY (productCode);

ALTER TABLE ONLY orderdetails
    ADD CONSTRAINT pk_orderdetails PRIMARY KEY (orderNumber, productCode);

ALTER TABLE ONLY orders
    ADD CONSTRAINT pk_orders PRIMARY KEY (orderNumber);

ALTER TABLE ONLY payments
    ADD CONSTRAINT pk_payments PRIMARY KEY (costumerNumber, checkNumber);

ALTER TABLE ONLY customers
    ADD CONSTRAINT pk_customers PRIMARY KEY (costumerNumber);

ALTER TABLE ONLY offices
    ADD CONSTRAINT pk_customers PRIMARY KEY (officeCode);

ALTER TABLE ONLY products
    ADD CONSTRAINT pk_products PRIMARY KEY (productCode);


ALTER TABLE ONLY employees
    ADD CONSTRAINT pk_employees PRIMARY KEY (employeeNumber);

-- foreign keys

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_products_productlines FOREIGN KEY (productLine) REFERENCES productlines;

ALTER TABLE ONLY orderdetails
    ADD CONSTRAINT fk_orderdetails_products FOREIGN KEY (productCode) REFERENCES products;

ALTER TABLE ONLY orderdetails
    ADD CONSTRAINT fk_orderdetails_orders FOREIGN KEY (orderNumber) REFERENCES orders;

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_orders_costumers FOREIGN KEY (costumerNumber) REFERENCES costumers;

ALTER TABLE ONLY payments
    ADD CONSTRAINT fk_payments_costumers FOREIGN KEY (costumerNumber) REFERENCES costumers;

ALTER TABLE ONLY employees
    ADD CONSTRAINT fk_employees_offices FOREIGN KEY (officeCode) REFERENCES offices;

ALTER TABLE ONLY employees
    ADD CONSTRAINT fk_employees_employees FOREIGN KEY (reportsTo) REFERENCES employees;

ALTER TABLE ONLY orders
    ADD CONSTRAINT fk_orders_shippers FOREIGN KEY (ship_via) REFERENCES shippers;

ALTER TABLE ONLY customers
    ADD CONSTRAINT fk_ocustomers_employees FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees;