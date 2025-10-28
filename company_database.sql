
-- Company Database SQL Script

-- 1. Create Tables

CREATE TABLE DEPARTMENT (
    DNo INT PRIMARY KEY,
    DName VARCHAR(50),
    MgrSSN VARCHAR(20),
    MgrStartDate DATE
);

CREATE TABLE EMPLOYEE (
    SSN VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary INT,
    SuperSSN VARCHAR(20),
    DNo INT,
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

CREATE TABLE DLOCATION (
    DNo INT,
    DLoc VARCHAR(50),
    PRIMARY KEY (DNo, DLoc),
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

CREATE TABLE PROJECT (
    PNo INT PRIMARY KEY,
    PName VARCHAR(50),
    PLocation VARCHAR(50),
    DNo INT,
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

CREATE TABLE WORKS_ON (
    SSN VARCHAR(20),
    PNo INT,
    Hours FLOAT,
    PRIMARY KEY (SSN, PNo),
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (PNo) REFERENCES PROJECT(PNo)
);

-- 2. Insert Data

-- DEPARTMENT
INSERT INTO DEPARTMENT VALUES
(1, 'HR', 'E001', '2020-01-15'),
(2, 'Finance', 'E002', '2019-06-10'),
(3, 'Engineering', 'E003', '2018-03-25'),
(4, 'Sales', 'E004', '2021-09-12'),
(5, 'Marketing', 'E005', '2022-02-05');

-- EMPLOYEE
INSERT INTO EMPLOYEE VALUES
('E001', 'Ravi Kumar', 'Mysuru', 'M', 50000, NULL, 1),
('E002', 'Anita Sharma', 'Bengaluru', 'F', 60000, 'E001', 2),
('E003', 'Kiran Patel', 'Hyderabad', 'M', 75000, 'E001', 3),
('E004', 'Megha Reddy', 'Chennai', 'F', 55000, 'E003', 4),
('E005', 'Suresh Naik', 'Pune', 'M', 65000, 'E002', 5);

-- DLOCATION
INSERT INTO DLOCATION VALUES
(1, 'Mysuru'),
(2, 'Bengaluru'),
(3, 'Hyderabad'),
(4, 'Chennai'),
(5, 'Pune');

-- PROJECT
INSERT INTO PROJECT VALUES
(101, 'Recruitment System', 'Mysuru', 1),
(102, 'Payroll Management', 'Bengaluru', 2),
(103, 'AI Automation', 'Hyderabad', 3),
(104, 'Sales Tracker', 'Chennai', 4),
(105, 'Ad Campaign', 'Pune', 5);

-- WORKS_ON
INSERT INTO WORKS_ON VALUES
('E001', 101, 10),
('E002', 102, 15),
('E003', 103, 20),
('E004', 104, 12),
('E005', 105, 18);

-- 3. Alter Table - Add and Drop Columns
ALTER TABLE EMPLOYEE
ADD COLUMN Phone VARCHAR(15);

ALTER TABLE EMPLOYEE
DROP COLUMN Phone;

-- 4. Add and Drop Constraints
ALTER TABLE EMPLOYEE
ADD CONSTRAINT chk_salary CHECK (Salary > 0);

ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_salary;

-- 5. Update Operation
UPDATE EMPLOYEE
SET Salary = 70000
WHERE SSN = 'E004';

-- 6. Delete Operations
DELETE FROM WORKS_ON
WHERE SSN = 'E005' AND PNo = 105;

DELETE FROM EMPLOYEE
WHERE SSN = 'E005';

-- 7. Optional: Add Cascade Deletion
ALTER TABLE WORKS_ON
ADD CONSTRAINT fk_emp_cascade FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE;

ALTER TABLE PROJECT
ADD CONSTRAINT fk_dept_cascade FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo) ON DELETE CASCADE;

-- End of Script
