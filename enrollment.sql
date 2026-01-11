DROP DATABASE IF EXISTS Student_enrollment;
CREATE DATABASE Student_enrollment;
USE Student_enrollment;



CREATE TABLE STUDENT (
    regno VARCHAR(40) PRIMARY KEY,
    name VARCHAR(100),
    major VARCHAR(100),
    bdate DATE
);

CREATE TABLE COURSE (
    course INT PRIMARY KEY,
    cname VARCHAR(100),
    dept VARCHAR(100)
);

CREATE TABLE ENROLL (
    regno VARCHAR(40),
    course INT,
    sem INT,
    marks INT,
    FOREIGN KEY (regno) REFERENCES STUDENT(regno) ON DELETE CASCADE,
    FOREIGN KEY (course) REFERENCES COURSE(course) ON DELETE CASCADE
);

CREATE TABLE TEXT (
    book_ISBN INT PRIMARY KEY,
    title VARCHAR(100),
    publisher VARCHAR(100),
    author VARCHAR(100)
);

CREATE TABLE BOOK_ADOPTION (
    course INT,
    sem INT,
    book_ISBN INT,
    FOREIGN KEY (course) REFERENCES COURSE(course) ON DELETE CASCADE,
    FOREIGN KEY (book_ISBN) REFERENCES TEXT(book_ISBN) ON DELETE CASCADE
);



INSERT INTO STUDENT VALUES
('01HF235','Student_1','CSE','2001-05-15'),
('01HF354','Student_2','Literature','2002-06-10'),
('01HF254','Student_3','Philosophy','2000-04-04'),
('01HF653','Student_4','History','2003-10-12'),
('01HF234','Student_5','Computer Economics','2001-10-10'),
('01HF699','Student_6','Computer Economics','2001-10-10');

INSERT INTO COURSE VALUES
(1,'DBMS','CS'),
(2,'Literature','English'),
(3,'Philosophy','Philosophy'),
(4,'History','Social Science'),
(5,'Computer Economics','CS');

INSERT INTO ENROLL VALUES
('01HF235',1,5,85),
('01HF354',2,6,87),
('01HF254',3,3,95),
('01HF653',4,3,80),
('01HF234',5,5,75),
('01HF699',1,6,90);

INSERT INTO TEXT VALUES
(241563,'Operating Systems','Pearson','Silberschatz'),
(532678,'Complete Works of Shakespeare','Oxford','Shakespeare'),
(453723,'Immanuel Kant','Delphi Classics','Immanuel Kant'),
(278345,'History of the World','The Times','Richard Overy'),
(426784,'Behavioural Economics','Pearson','David Orrel'),
(469691,'Code with Fun','Tim David','David Warner'),
(767676,'Fun & Philosophy','Delphi Classics','Immanuel Kant');

INSERT INTO BOOK_ADOPTION VALUES
(1,5,241563),
(2,6,532678),
(3,3,453723),
(4,3,278345),
(1,6,426784),
(1,5,469691),
(3,6,767676);