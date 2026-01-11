DROP DATABASE IF EXISTS Order_processing;
CREATE DATABASE Order_processing;
USE Order_processing;



CREATE TABLE Customer (
    cust INT PRIMARY KEY,
    cname VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE Order_ (
    order_ INT PRIMARY KEY,
    odate DATE,
    cust INT,
    order_amt INT,
    FOREIGN KEY (cust) REFERENCES Customer(cust) ON DELETE CASCADE
);

CREATE TABLE Item (
    item INT PRIMARY KEY,
    unitprice INT
);

CREATE TABLE OrderItem (
    order_ INT,
    item INT,
    qty INT,
    FOREIGN KEY (order_) REFERENCES Order_(order_) ON DELETE CASCADE,
    FOREIGN KEY (item) REFERENCES Item(item) ON DELETE CASCADE
);

CREATE TABLE Warehouse (
    warehouse INT PRIMARY KEY,
    city VARCHAR(100)
);

CREATE TABLE Shipment (
    order_ INT,
    warehouse INT,
    ship_date DATE,
    FOREIGN KEY (order_) REFERENCES Order_(order_) ON DELETE CASCADE,
    FOREIGN KEY (warehouse) REFERENCES Warehouse(warehouse) ON DELETE CASCADE
);



INSERT INTO Customer VALUES
(101,'Kumar','City1'),
(102,'Peter','City2'),
(103,'James','City3'),
(104,'Kevin','City4'),
(105,'Harry','City5');

INSERT INTO Order_ VALUES
(201,'2023-04-11',101,1567),
(202,'2023-04-12',102,2567),
(203,'2023-04-13',103,3567),
(204,'2023-04-14',104,4567),
(205,'2023-04-15',105,5567);

INSERT INTO Item VALUES
(1001,100),
(1002,200),
(1003,300),
(1004,400),
(1005,500);

INSERT INTO OrderItem VALUES
(201,1001,10),
(202,1002,11),
(203,1003,12),
(204,1004,13),
(205,1005,14);

INSERT INTO Warehouse VALUES
(1,'Wcity1'),
(2,'Wcity2'),
(3,'Wcity3'),
(4,'Wcity4'),
(5,'Wcity5');

INSERT INTO Shipment VALUES
(201,1,'2023-05-01'),
(202,2,'2023-05-02'),
(203,3,'2023-05-03'),
(204,4,'2023-05-04'),
(205,5,'2023-05-05');
