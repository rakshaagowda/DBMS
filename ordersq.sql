-- 1. Orders shipped from Warehouse #2
SELECT order_, ship_date
FROM Shipment
WHERE warehouse = 2;

-- 2. Warehouses supplying orders to customer Kumar
SELECT o.order_, s.warehouse
FROM Order_ o
JOIN Shipment s ON o.order_ = s.order_
JOIN Customer c ON o.cust = c.cust
WHERE c.cname = 'Kumar';

-- 3. Customer-wise order count and average order amount
SELECT
    c.cname,
    COUNT(*) AS no_of_orders,
    AVG(o.order_amt) AS avg_order_amt
FROM Customer c
JOIN Order_ o ON c.cust = o.cust
GROUP BY c.cname;

-- 4. Delete all orders for customer Kumar
DELETE FROM Order_
WHERE cust = (SELECT cust FROM Customer WHERE cname='Kumar');

-- 5. Item with maximum unit price
SELECT item, unitprice
FROM Item
WHERE unitprice = (SELECT MAX(unitprice) FROM Item);



DELIMITER //

CREATE TRIGGER update_order_amount
BEFORE INSERT ON OrderItem
FOR EACH ROW
BEGIN
    UPDATE Order_
    SET order_amt = NEW.qty * (SELECT unitprice FROM Item WHERE item = NEW.item)
    WHERE order_ = NEW.order_;
END;
//
DELIMITER ;

-- Trigger check
INSERT INTO Item VALUES (1006,600);
INSERT INTO Order_ VALUES (206,'2023-04-16',102,NULL);
INSERT INTO OrderItem VALUES (206,1006,5);



CREATE OR REPLACE VIEW OrdersFromWarehouse5 AS
SELECT order_, ship_date
FROM Shipment
WHERE warehouse = 5;

SELECT * FROM OrdersFromWarehouse5;