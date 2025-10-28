
-- Insurance Database SQL Script

-- 1. Create Tables

CREATE TABLE PERSON (
    driver_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE CAR (
    regno VARCHAR(20) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);

CREATE TABLE ACCIDENT (
    report_number INT PRIMARY KEY,
    acc_date DATE,
    location VARCHAR(100)
);

CREATE TABLE OWNS (
    driver_id VARCHAR(20),
    regno VARCHAR(20),
    PRIMARY KEY (driver_id, regno),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (regno) REFERENCES CAR(regno)
);

CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(20),
    regno VARCHAR(20),
    report_number INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, regno, report_number),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (regno) REFERENCES CAR(regno),
    FOREIGN KEY (report_number) REFERENCES ACCIDENT(report_number)
);

-- 2. Insert Sample Data

INSERT INTO PERSON VALUES
('D001', 'Ravi Kumar', 'Mysuru'),
('D002', 'Anita Sharma', 'Bengaluru'),
('D003', 'Suresh Naik', 'Hyderabad'),
('D004', 'Megha Reddy', 'Chennai'),
('D005', 'Kiran Patel', 'Pune');

INSERT INTO CAR VALUES
('KA01AB1234', 'Honda City', 2020),
('KA02CD5678', 'Hyundai i20', 2019),
('KA03EF9101', 'Maruti Swift', 2021),
('KA04GH1121', 'Tata Nexon', 2022),
('KA05IJ3141', 'Toyota Innova', 2018);

INSERT INTO ACCIDENT VALUES
(1001, '2023-01-10', 'Ring Road Mysuru'),
(1002, '2023-02-15', 'MG Road Bengaluru'),
(1003, '2023-03-20', 'Hitech City Hyderabad'),
(1004, '2023-04-25', 'T Nagar Chennai'),
(1005, '2023-05-30', 'Koregaon Park Pune');

INSERT INTO OWNS VALUES
('D001', 'KA01AB1234'),
('D002', 'KA02CD5678'),
('D003', 'KA03EF9101'),
('D004', 'KA04GH1121'),
('D005', 'KA05IJ3141');

INSERT INTO PARTICIPATED VALUES
('D001', 'KA01AB1234', 1001, 5000),
('D002', 'KA02CD5678', 1002, 10000),
('D003', 'KA03EF9101', 1003, 7000),
('D004', 'KA04GH1121', 1004, 15000),
('D005', 'KA05IJ3141', 1005, 12000);

-- 3. Alter Table - Add and Drop Columns

ALTER TABLE CAR
ADD COLUMN color VARCHAR(20);

ALTER TABLE CAR
DROP COLUMN color;

-- 4. Add and Drop Constraints

ALTER TABLE PARTICIPATED
ADD CONSTRAINT chk_damage CHECK (damage_amount > 0);

ALTER TABLE PARTICIPATED
DROP CONSTRAINT chk_damage;

-- 5. Update Operation

UPDATE PERSON
SET address = 'Whitefield, Bengaluru'
WHERE driver_id = 'D002';

UPDATE CAR
SET year = 2023
WHERE regno = 'KA03EF9101';

-- 6. Delete Operation

DELETE FROM PARTICIPATED
WHERE report_number = 1005;

DELETE FROM PERSON
WHERE driver_id = 'D005';

-- 7. Optional: Add Cascading Constraints

ALTER TABLE OWNS
ADD CONSTRAINT fk_person_cascade FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id) ON DELETE CASCADE;

ALTER TABLE PARTICIPATED
ADD CONSTRAINT fk_accident_cascade FOREIGN KEY (report_number) REFERENCES ACCIDENT(report_number) ON DELETE CASCADE;

-- End of Script
