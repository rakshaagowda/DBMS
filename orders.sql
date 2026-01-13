

create database if not exists order_processing;
use order_processing;


create table customer (
  cust_no int primary key,
  cname varchar(25),
  city varchar(25)
);

create table orders (
  order_no int primary key,
  odate date,
  cust_no int,
  order_amt int,
  foreign key (cust_no) references customer(cust_no) on delete cascade
);

create table item (
  item_no int primary key,
  unitprice int
);

create table order_item (
  order_no int,
  item_no int,
  qty int,
  primary key (order_no, item_no),
  foreign key (order_no) references orders(order_no) on delete cascade,
  foreign key (item_no) references item(item_no) on delete cascade
);

create table warehouse (
  warehouse_no int primary key,
  city varchar(25)
);

create table shipment (
  order_no int primary key,
  warehouse_no int,
  ship_date date,
  foreign key (order_no) references orders(order_no) on delete cascade,
  foreign key (warehouse_no) references warehouse(warehouse_no) on delete cascade
);

insert into customer values
(1,'kumar','mysuru'),
(2,'arun','bengaluru'),
(3,'meena','mangaluru'),
(4,'ravi','hubli'),
(5,'sita','udupi');

insert into orders values
(101,'2024-01-10',1,0),
(102,'2024-01-12',2,0),
(103,'2024-01-15',1,0),
(104,'2024-01-18',3,0),
(105,'2024-01-20',4,0);

insert into item values
(1,50),
(2,30),
(3,40),
(4,25),
(5,60);

insert into order_item values
(101,1,2),
(101,2,3),
(102,3,2),
(103,4,4),
(104,5,1);

insert into warehouse values
(1,'w1'),
(2,'w2'),
(3,'w3'),
(4,'w4'),
(5,'w5');

insert into shipment values
(101,2,'2024-01-11'),
(102,1,'2024-01-13'),
(103,2,'2024-01-16'),
(104,3,'2024-01-19'),
(105,5,'2024-01-21');
