DROP DATABASE IF EXISTS sailors;
CREATE DATABASE sailors;
USE sailors;



CREATE TABLE SAILORS (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    rating INT,
    age INT
);

CREATE TABLE BOAT (
    bid INT PRIMARY KEY,
    bname VARCHAR(50),
    color VARCHAR(50)
);

CREATE TABLE RESERVES (
    sid INT,
    bid INT,
    date DATE,
    FOREIGN KEY (sid) REFERENCES SAILORS(sid),
    FOREIGN KEY (bid) REFERENCES BOAT(bid)
);



INSERT INTO SAILORS VALUES
(1,'Albert',8,41),
(2,'Bob',9,45),
(3,'Charlie',9,49),
(4,'David',8,54),
(5,'Eve',7,59);

INSERT INTO BOAT VALUES
(101,'Boat1','Red'),
(102,'Boat2','Blue'),
(103,'Boat3','Green'),
(104,'Boat4','Yellow'),
(105,'Boat5','White');

INSERT INTO RESERVES VALUES
(1,101,'2023-01-01'),
(1,102,'2023-02-01'),
(1,103,'2023-03-01'),
(1,104,'2023-04-01'),
(1,105,'2023-05-01'),
(2,101,'2023-02-01'),
(3,101,'2023-03-01'),
(4,101,'2023-04-01'),
(5,101,'2023-05-01'),
(2,102,'2023-02-01'),
(3,103,'2023-03-01'),
(4,104,'2023-04-01'),
(5,105,'2023-05-01');
