
-- Student Enrollment and Book Adoption Database SQL Script

-- 1. Create Tables

CREATE TABLE STUDENT (
    regno VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50),
    major VARCHAR(50),
    bdate DATE
);

CREATE TABLE COURSE (
    course_id INT PRIMARY KEY,
    cname VARCHAR(50),
    dept VARCHAR(50)
);

CREATE TABLE ENROLL (
    regno VARCHAR(20),
    course_id INT,
    sem INT,
    marks INT,
    PRIMARY KEY (regno, course_id, sem),
    FOREIGN KEY (regno) REFERENCES STUDENT(regno),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);

CREATE TABLE TEXT (
    book_ISBN INT PRIMARY KEY,
    book_title VARCHAR(100),
    publisher VARCHAR(50),
    author VARCHAR(50)
);

CREATE TABLE BOOK_ADOPTION (
    course_id INT,
    sem INT,
    book_ISBN INT,
    PRIMARY KEY (course_id, sem, book_ISBN),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id),
    FOREIGN KEY (book_ISBN) REFERENCES TEXT(book_ISBN)
);

-- 2. Insert Data

-- STUDENT
INSERT INTO STUDENT VALUES
('S001', 'Ravi Kumar', 'CSE', '2004-02-10'),
('S002', 'Anita Sharma', 'ECE', '2003-06-25'),
('S003', 'Kiran Patel', 'ISE', '2004-01-15'),
('S004', 'Megha Reddy', 'ME', '2002-09-20'),
('S005', 'Suresh Naik', 'CIVIL', '2003-11-30');

-- COURSE
INSERT INTO COURSE VALUES
(101, 'Data Structures', 'CSE'),
(102, 'Digital Circuits', 'ECE'),
(103, 'Thermodynamics', 'ME'),
(104, 'Database Systems', 'CSE'),
(105, 'Fluid Mechanics', 'CIVIL');

-- ENROLL
INSERT INTO ENROLL VALUES
('S001', 101, 4, 88),
('S002', 102, 4, 79),
('S003', 104, 5, 92),
('S004', 103, 6, 84),
('S005', 105, 4, 75);

-- TEXT (Books)
INSERT INTO TEXT VALUES
(97801, 'Data Structures Using C', 'McGraw Hill', 'Reema Thareja'),
(97802, 'Digital Logic Design', 'Pearson', 'M. Morris Mano'),
(97803, 'Database Management Systems', 'McGraw Hill', 'Raghu Ramakrishnan'),
(97804, 'Engineering Thermodynamics', 'Oxford', 'P.K. Nag'),
(97805, 'Fluid Mechanics', 'S Chand', 'R.K. Rajput');

-- BOOK_ADOPTION
INSERT INTO BOOK_ADOPTION VALUES
(101, 4, 97801),
(102, 4, 97802),
(104, 5, 97803),
(103, 6, 97804),
(105, 4, 97805);

-- 3. Alter Table - Add and Drop Columns
ALTER TABLE STUDENT
ADD COLUMN phone VARCHAR(15);

ALTER TABLE STUDENT
DROP COLUMN phone;

-- 4. Add and Drop Constraints
ALTER TABLE ENROLL
ADD CONSTRAINT chk_marks CHECK (marks BETWEEN 0 AND 100);

ALTER TABLE ENROLL
DROP CONSTRAINT chk_marks;

-- 5. Update Operation
UPDATE ENROLL
SET marks = 95
WHERE regno = 'S003' AND course_id = 104;

-- 6. Delete Operations
DELETE FROM BOOK_ADOPTION
WHERE course_id = 105 AND book_ISBN = 97805;

DELETE FROM STUDENT
WHERE regno = 'S005';

-- 7. Optional: Add Cascade Deletion
ALTER TABLE ENROLL
ADD CONSTRAINT fk_reg_cascade FOREIGN KEY (regno) REFERENCES STUDENT(regno) ON DELETE CASCADE;

ALTER TABLE BOOK_ADOPTION
ADD CONSTRAINT fk_course_cascade FOREIGN KEY (course_id) REFERENCES COURSE(course_id) ON DELETE CASCADE;

-- End of Script
