


/* 1. order_no and ship_date for orders shipped from warehouse w2 */
select order_no, ship_date
from shipment
where warehouse_no = 2;

/* 2. orders and warehouse supplying customer kumar */
select o.order_no, s.warehouse_no
from customer c, orders o, shipment s
where c.cust_no = o.cust_no
and o.order_no = s.order_no
and c.cname = 'kumar';

/* 3. cname, number of orders, average order amount */
select c.cname,
count(o.order_no) as no_of_orders,
avg(o.order_amt) as avg_order_amt
from customer c left join orders o
on c.cust_no = o.cust_no
group by c.cust_no;

/* 4. delete all orders of customer kumar */
delete o
from orders o, customer c
where o.cust_no = c.cust_no
and c.cname = 'kumar';

/* 5. item with maximum unit price */
select item_no, unitprice
from item
where unitprice = (select max(unitprice) from item);


delimiter //

create trigger update_order_amt
after insert on order_item
for each row
begin
  update orders
  set order_amt = (
    select sum(oi.qty * i.unitprice)
    from order_item oi, item i
    where oi.item_no = i.item_no
    and oi.order_no = new.order_no
  )
  where order_no = new.order_no;
end;
//

delimiter ;


create view ship_w5 as
select order_no, ship_date
from shipment
where warehouse_no = 5;
