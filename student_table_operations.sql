
-- SQL Script: STUDENT Table Operations

-- 1. Create Table
CREATE TABLE STUDENT (
    SID INT PRIMARY KEY,
    NAME VARCHAR(50),
    BRANCH VARCHAR(10),
    SEMESTER INT,
    ADDRESS VARCHAR(100),
    PHONE VARCHAR(15),
    EMAIL VARCHAR(50)
);

-- 2. Insert 10 Tuples
INSERT INTO STUDENT (SID, NAME, BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL)
VALUES
(101, 'Ananya Rao', 'CSE', 5, 'Kuvempunagar', '9876543210', 'ananya.cse@gmail.com'),
(102, 'Rahul Kumar', 'ECE', 5, 'Vijayanagar', '9898989898', 'rahul.ece@gmail.com'),
(103, 'Sneha Patil', 'CSE', 3, 'Jayalakshmipuram', '9123456789', 'sneha.patil@gmail.com'),
(104, 'Arjun Shetty', 'ME', 7, 'Kuvempunagar', '9988776655', 'arjun.me@gmail.com'),
(105, 'Meera Nair', 'ISE', 5, 'Gokulam', '9000011111', 'meera.ise@gmail.com'),
(106, 'Rohan Das', 'CSE', 7, 'Kuvempunagar', '9876501234', 'rohan.cse@gmail.com'),
(107, 'Priya Singh', 'EEE', 5, 'Vivekananda Nagar', '9812345678', 'priya.eee@gmail.com'),
(108, 'Vikram Hegde', 'CSE', 3, 'Sharadadevi Nagar', '9786543210', 'vikram.cse@gmail.com'),
(109, 'Nisha Gowda', 'CIVIL', 7, 'Bogadi', '9654321098', 'nisha.civil@gmail.com'),
(110, 'Karthik Joshi', 'CSE', 5, 'Kuvempunagar', '9345678901', 'karthik.cse@gmail.com');

-- 3. a. Insert a New Student
INSERT INTO STUDENT (SID, NAME, BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL)
VALUES (111, 'Raksha B R', 'CSE', 3, 'Saraswathipuram', '9823456789', 'raksha.cse@gmail.com');

-- 4. b. Modify Address based on SID
UPDATE STUDENT
SET ADDRESS = 'Hebbal'
WHERE SID = 103;

-- 5. c. Delete a Student
DELETE FROM STUDENT
WHERE SID = 109;

-- 6. d. List All Students
SELECT * FROM STUDENT;

-- 7. e. List All Students of CSE Branch
SELECT * FROM STUDENT
WHERE BRANCH = 'CSE';

-- 8. f. List All Students of CSE Branch residing in Kuvempunagar
SELECT * FROM STUDENT
WHERE BRANCH = 'CSE' AND ADDRESS = 'Kuvempunagar';
