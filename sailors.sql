

CREATE DATABASE IF NOT EXISTS Sailors;
USE Sailors;


CREATE TABLE sailor (
    sid INT NOT NULL,
    age INT,
    sname VARCHAR(25),
    rating DECIMAL(3,1),
    PRIMARY KEY (sid)
);

CREATE TABLE boat (
    bid INT NOT NULL,
    bname VARCHAR(25),
    color VARCHAR(15),
    PRIMARY KEY (bid)
);

CREATE TABLE reservers (
    sid INT NOT NULL,
    bid INT NOT NULL,
    rdate DATE,
    FOREIGN KEY (sid) REFERENCES sailor(sid) ON DELETE CASCADE,
    FOREIGN KEY (bid) REFERENCES boat(bid) ON DELETE CASCADE
);


INSERT INTO sailor VALUES
(1,65,'jhon',9.8),
(2,55,'Albert',8.0),
(3,45,'James',7.0),
(4,35,'sandy',5.0),
(5,37,'patrick',4.0),
(6,45,'Dennis',8.0),
(7,35,'Alstorm',9.8);

INSERT INTO boat VALUES
(101,'blue','blue'),
(102,'red','red'),
(103,'green','green'),
(104,'white','white'),
(105,'horse','green');

INSERT INTO reservers VALUES
(1,101,'2008-01-01'),
(1,102,'2008-06-09'),
(1,103,'2008-01-01'),
(2,104,'2008-03-03'),
(2,105,'2008-09-08'),
(6,101,'2008-01-01'),
(4,105,'2008-09-09'),
(5,104,'2008-01-05'),
(1,104,'2008-01-11'),
(1,105,'2008-01-12');



