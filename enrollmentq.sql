-- 1. Add a new textbook and adopt it
INSERT INTO TEXT VALUES (987654,'New Textbook','New Publisher','New Author');
INSERT INTO BOOK_ADOPTION VALUES (1,5,987654);

-- 2. Textbooks used by CS courses with more than two books
SELECT BA.course, BA.book_ISBN, T.title
FROM BOOK_ADOPTION BA
JOIN COURSE C ON BA.course = C.course
JOIN TEXT T ON BA.book_ISBN = T.book_ISBN
WHERE C.dept='CS'
AND BA.course IN (
    SELECT course FROM BOOK_ADOPTION
    GROUP BY course
    HAVING COUNT(book_ISBN) > 2
)
ORDER BY T.title;

-- 3. Departments whose adopted books are all from a specific publisher
SELECT DISTINCT dept
FROM COURSE
WHERE dept IN (
    SELECT dept FROM COURSE
    JOIN BOOK_ADOPTION USING(course)
    JOIN TEXT USING(book_ISBN)
    WHERE publisher='Delphi Classics'
)
AND dept NOT IN (
    SELECT dept FROM COURSE
    JOIN BOOK_ADOPTION USING(course)
    JOIN TEXT USING(book_ISBN)
    WHERE publisher <> 'Delphi Classics'
);

-- 4. Students with maximum marks in DBMS
SELECT S.regno, S.name, E.marks
FROM STUDENT S
JOIN ENROLL E ON S.regno=E.regno
JOIN COURSE C ON E.course=C.course
WHERE C.cname='DBMS'
ORDER BY E.marks DESC
LIMIT 1;



CREATE OR REPLACE VIEW StudentCourses AS
SELECT regno, course, cname, marks
FROM ENROLL
JOIN COURSE USING(course);

SELECT * FROM StudentCourses;



DELIMITER //

CREATE TRIGGER PreventEnrollment
BEFORE INSERT ON ENROLL
FOR EACH ROW
BEGIN
    IF NEW.marks < 40 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Marks prerequisite not met for enrollment';
    END IF;
END;
//

DELIMITER ;

-- Trigger test
INSERT INTO STUDENT VALUES ('01HF999','John Doe','Computer Science','2000-01-01');
INSERT INTO ENROLL VALUES ('01HF999',1,7,32);