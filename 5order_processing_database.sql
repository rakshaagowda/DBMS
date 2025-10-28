
-- Order Processing Database SQL Script

-- 1. Create Tables
CREATE TABLE CUSTOMER (
    cust_id INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE ORDERS (
    order_id INT PRIMARY KEY,
    odate DATE,
    cust_id INT,
    order_amt INT,
    FOREIGN KEY (cust_id) REFERENCES CUSTOMER(cust_id)
);

CREATE TABLE ITEM (
    item_id INT PRIMARY KEY,
    unitprice INT
);

CREATE TABLE ORDER_ITEM (
    order_id INT,
    item_id INT,
    qty INT,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (item_id) REFERENCES ITEM(item_id)
);

CREATE TABLE WAREHOUSE (
    warehouse_id INT PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE SHIPMENT (
    order_id INT,
    warehouse_id INT,
    ship_date DATE,
    PRIMARY KEY (order_id, warehouse_id),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (warehouse_id) REFERENCES WAREHOUSE(warehouse_id)
);

-- 2. Insert Data

-- CUSTOMER
INSERT INTO CUSTOMER VALUES
(1, 'Ravi Kumar', 'Mysuru'),
(2, 'Anita Sharma', 'Bengaluru'),
(3, 'Kiran Patel', 'Mysuru'),
(4, 'Megha Reddy', 'Chennai'),
(5, 'Suresh Naik', 'Hyderabad');

-- ORDERS
INSERT INTO ORDERS VALUES
(101, '2025-02-10', 1, 5000),
(102, '2025-03-05', 2, 12000),
(103, '2025-03-18', 3, 8000),
(104, '2025-04-01', 4, 6000),
(105, '2025-04-15', 5, 15000);

-- ITEM
INSERT INTO ITEM VALUES
(501, 500),
(502, 1200),
(503, 800),
(504, 1500),
(505, 2000);

-- ORDER_ITEM
INSERT INTO ORDER_ITEM VALUES
(101, 501, 5),
(102, 502, 10),
(103, 503, 8),
(104, 504, 4),
(105, 505, 6);

-- WAREHOUSE
INSERT INTO WAREHOUSE VALUES
(301, 'Mysuru'),
(302, 'Bengaluru'),
(303, 'Chennai'),
(304, 'Hyderabad'),
(305, 'Pune');

-- SHIPMENT
INSERT INTO SHIPMENT VALUES
(101, 301, '2025-02-12'),
(102, 302, '2025-03-07'),
(103, 301, '2025-03-20'),
(104, 303, '2025-04-03'),
(105, 304, '2025-04-17');

-- 3. Alter Table - Add and Drop Columns
ALTER TABLE CUSTOMER
ADD COLUMN phone VARCHAR(15);

ALTER TABLE CUSTOMER
DROP COLUMN phone;

-- 4. Add and Drop Constraints
ALTER TABLE ORDERS
ADD CONSTRAINT chk_order_amt CHECK (order_amt > 0);

ALTER TABLE ORDERS
DROP CONSTRAINT chk_order_amt;

-- 5. Update Operation
UPDATE ORDERS
SET order_amt = 13000
WHERE order_id = 102;

-- 6. Delete Operations
DELETE FROM ORDER_ITEM
WHERE order_id = 105 AND item_id = 505;

DELETE FROM CUSTOMER
WHERE cust_id = 5;

-- 7. Optional: Add Cascade Deletion
ALTER TABLE ORDER_ITEM
ADD CONSTRAINT fk_order_cascade FOREIGN KEY (order_id) REFERENCES ORDERS(order_id) ON DELETE CASCADE;

ALTER TABLE SHIPMENT
ADD CONSTRAINT fk_order_ship FOREIGN KEY (order_id) REFERENCES ORDERS(order_id) ON DELETE CASCADE;

-- End of Script
