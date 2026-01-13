
CREATE DATABASE IF NOT EXISTS insurance;
USE insurance;


CREATE TABLE person (
    driver_id INT NOT NULL,
    name VARCHAR(25),
    address TEXT,
    PRIMARY KEY (driver_id)
);

CREATE TABLE car (
    regno VARCHAR(15) NOT NULL,
    model VARCHAR(20),
    year INT,
    PRIMARY KEY (regno)
);

CREATE TABLE accident (
    reportno INT NOT NULL,
    accd_date DATE,
    location VARCHAR(25),
    PRIMARY KEY (reportno)
);

CREATE TABLE owns (
    driver_id INT NOT NULL,
    regno VARCHAR(15) NOT NULL,
    FOREIGN KEY (driver_id) REFERENCES person(driver_id) ON DELETE CASCADE,
    FOREIGN KEY (regno) REFERENCES car(regno) ON DELETE CASCADE
);

CREATE TABLE participated (
    driver_id INT NOT NULL,
    regno VARCHAR(15) NOT NULL,
    reportno INT NOT NULL,
    damage_amount INT,
    FOREIGN KEY (driver_id) REFERENCES person(driver_id) ON DELETE CASCADE,
    FOREIGN KEY (regno) REFERENCES car(regno) ON DELETE CASCADE,
    FOREIGN KEY (reportno) REFERENCES accident(reportno) ON DELETE CASCADE
);


INSERT INTO person VALUES
(111,'Driver_1','Kuvempunagar, Mysuru'),
(222,'Smith','JP Nagar, Mysuru'),
(333,'Driver_3','Udaygiri, Mysuru'),
(444,'Driver_4','Rajivnagar, Mysuru'),
(555,'Driver_5','Vijayanagar, Mysuru');

INSERT INTO car VALUES
('KA-20-AB-4223','Swift',2020),
('KA-20-BC-5674','Mazda',2017),
('KA-21-AC-5473','Alto',2015),
('KA-21-BD-4728','Triber',2019),
('KA-09-MA-1234','Tiago',2018);

INSERT INTO accident VALUES
(43627,'2020-04-05','Nazarbad, Mysuru'),
(56345,'2019-12-16','Gokulam, Mysuru'),
(63744,'2020-05-14','Vijaynagar, Mysuru'),
(54634,'2019-08-30','Kuvempunagar, Mysuru'),
(65738,'2021-01-21','JSS Layout, Mysuru'),
(66666,'2021-01-21','JSS Layout, Mysuru');

INSERT INTO owns VALUES
(111,'KA-20-AB-4223'),
(222,'KA-20-BC-5674'),
(333,'KA-21-AC-5473'),
(444,'KA-21-BD-4728'),
(222,'KA-09-MA-1234');

INSERT INTO participated VALUES
(111,'KA-20-AB-4223',43627,20000),
(222,'KA-20-BC-5674',56345,49500),
(333,'KA-21-AC-5473',63744,15000),
(444,'KA-21-BD-4728',54634,5000),
(222,'KA-09-MA-1234',65738,25000);