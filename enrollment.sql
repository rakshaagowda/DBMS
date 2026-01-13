CREATE DATABASE Student_Course_DB;
USE Student_Course_DB;


CREATE TABLE student (
    regno VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255),
    major VARCHAR(255),
    bdate DATE
);


CREATE TABLE course (
    course_no INT PRIMARY KEY,
    cname VARCHAR(255),
    dept VARCHAR(255)
);


CREATE TABLE textbook (
    book_ISBN INT PRIMARY KEY,
    book_title VARCHAR(255),
    publisher VARCHAR(255),
    author VARCHAR(255)
);

CREATE TABLE enroll (
    regno VARCHAR(50),
    course_no INT,
    sem INT,
    marks INT,
    FOREIGN KEY (regno) REFERENCES student(regno)
        ON DELETE CASCADE,
    FOREIGN KEY (course_no) REFERENCES  course(course_no)
        ON DELETE CASCADE
);


CREATE TABLE book_adoption (
    course_no INT,
    sem INT,
    book_ISBN INT,
    PRIMARY KEY (course_no, sem, book_ISBN),
    FOREIGN KEY (course_no) REFERENCES course (course_no)
        ON DELETE CASCADE,
    FOREIGN KEY (book_ISBN) REFERENCES textbook(book_ISBN)
        ON DELETE CASCADE
);

INSERT INTO student VALUES
('S001', 'John Doe', 'Computer Science', '1990-01-01'),
('S002', 'Jane Smith', 'Electrical Engineering', '1992-05-15'),
('S003', 'Bob Johnson', 'Mechanical Engineering', '1991-08-20'),
('S004', 'Alice Brown', 'Computer Science', '1993-03-10'),
('S005', 'Charlie Davis', 'Physics', '1992-11-25');

INSERT INTO course VALUES
(1, 'Database Management Systems', 'CS'),
(2, 'Computer Networks', 'CS'),
(3, 'Introduction to Physics', 'Physics'),
(4, 'Mechanics of Materials', 'Mechanical Engineering'),
(5, 'Digital Signal Processing', 'Electrical Engineering');

INSERT INTO enroll VALUES
('S001', 1, 1, 85),
('S002', 1, 1, 72),
('S003', 2, 1, 68),
('S004', 1, 1, 90),
('S005', 3, 1, 75);

INSERT INTO textbook VALUES
(123456789, 'Database Management Systems', 'Pearson', 'Author1'),
(234567890, 'Computer Networks', 'McGraw Hill', 'Author2'),
(345678901, 'Introduction to Physics', 'Wiley', 'Author3'),
(456789012, 'Mechanics of Materials', 'Springer', 'Author4'),
(567890123, 'Digital Signal Processing', 'Pearson', 'Author5');

INSERT INTO book_adoption VALUES
(1, 1, 123456789),
(1, 2, 234567890),
(3, 8, 345678901),
(4, 4, 123456789),
(5, 3, 234567890);

