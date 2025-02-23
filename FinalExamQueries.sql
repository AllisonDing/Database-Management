use finalexam;

create table customers
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(38), 
ContactName VARCHAR(38),
Country VARCHAR(38)
); 

create table products
(
productID INT PRIMARY KEY,
productName VARCHAR(100),
supplierID INT,
price DECIMAL(4, 2)
); 

create table orders
(
orderID INT PRIMARY KEY,
customerID INT,
productID INT,
quantity INT,
FOREIGN KEY (productID) REFERENCES PRODUCTS (productID),
FOREIGN KEY (customerID) REFERENCES CUSTOMERS (customerID)
);

insert into customers
values
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Germany'),
(2, 'Ana Trujillo Emparedados', 'Ana Trujillo', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', 'UK'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Sweden'); 


insert into products
values
(1, 'Chai', 1, 18.00),
(2, 'Chang', 1, 19.00),
(3, 'Aniseed Syrup', 2, 10.00),
(4, 'Chef Anton\'s Cajun Seasoning', 2, 22.00), 
(5, 'Chef Anton\'s Gumbo Mix', 2, 21.35),
(6, 'Grandma\'s Boysenberry Spread', 3, 25.00),
(7, 'Uncle Bob\'s Organic Dried Pears', 3, 30.00),
(8, 'Northwoods Cranberry Sauce', 3, 40.00),
(9, 'Mishi Kobe Niku', 4, 97.00),
(10, 'Ikura', 4, 31.00);

insert into orders
values
(1, 1, 1, 10),
(2, 1, 2, 20),
(3, 2, 3, 5),
(4, 2, 4, 10),
(5, 2, 5, 15),
(6, 3, 6, 20),
(7, 3, 7, 25),
(8, 3, 8, 15),
(9, 4, 9, 12),
(10, 5, 10, 8);

/*3*/
select customerID, sum(quantity) as number_units
from orders
group by customerID; 

/*4*/
select * 
from orders
where productID in (1, 3, 5);

/*5*/
select avg(price) from products;

/*6*/
select c.customerName, c.contactName, c.country
from customers c
join orders o on c.customerID = o.customerID
join products p on o.productID = p.productID
where p.price > 50; 

/*7*/
select p.productName, p.price
from products p
left join orders o on p.productID = o.productID
where o.orderID IS NULL; 

/*8*/
update orders
set quantity = 10; 

/*9*/
select c.customerName, p.productName, o.quantity
from orders o
join customers c on o.customerID = c.customerID
join products p on o.productID = p.productID;

/*10*/
select c.customerName, 
count(distinct o.orderID) as number_of_orders
from orders o
join customers c on o.customerID = c.customerID
group by c.customerName;

/*11*/
select o.*
from orders o
join products p on o.productID = p.productID
where p.price in (10, 15, 20); 

/*12*/
select c.customerName, 
count(distinct o.orderID) as number_of_orders
from orders o
join customers c on o.customerID = c.customerID
group by c.customerName
having count(distinct o.orderID) > 3;

/*13*/
select avg(price)
from products; 

/*14*/
select productName
from products
where price = 
(select max(price) from products);

/*15*/ 
/* it is in 2NF */
/* 1NF: it meets criteria for 1NF as all cell have atomic value*/
/* 2NF: it meets criteria for 2NF as it meets criteria for 1NF and non-prime attributes (customerName, contactName, and Country) are functional dependent on all candidate keys (CustomerID, CustomerName) */
/* 3NF: it does not meet criteria for 3NF because there is transitive dependency. CustomerName is functional dependent on CustomerID; ContactName is functional dependent on ContactID and ContactName; Country is functional dependent on ContactName. */

/*16*/
/* CustomerID -> CustomerName, ContactName, Country */
/* CustomerName -> ContactName, Country */
/* ContactName -> Country*/

/*17*/
CREATE TABLE NORM_COUNTRY 
(
CONTACTNAME VARCHAR(38),
COUNTRY VARCHAR(38)
); 

CREATE TABLE NORM_CUSTOMER
(
CUSTOMER_ID INT,
CustomerName VARCHAR(38),
ContactName VARCHAR(38)
);

/*18*/
/*NORM_COUNTRY is 3NF as all cells are atomic and country is functional dependent on contactName. */
/*NORM_CUSTOMER is 2NF as all cells are atomic, customerName and ContactName are functional depdent on customerID, and ContactName is functional dependent on CustomerName too. */
/*Since there is transitive depedency in NORM_CUSTOMER, it does not meet 3NF criteria, however it meets 2NF criteria as non-prime attributes (contactName) are functional dependent on all candidate keys (customerID, customerName)*/





