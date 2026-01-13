-- 1.
INSERT INTO textbook VALUES
(678901234, 'Advanced Database Systems', 'Pearson', 'Elmasri');

INSERT INTO book_adoption VALUES
(1, 2, 678901234);

-- 2.
SELECT
    C.course_no,
    T.book_ISBN,
    T.book_title
FROM course C
JOIN book_adoption B ON C.course_no = B.course_no
JOIN textbook T ON B.book_ISBN = T.book_ISBN
WHERE C.dept = 'CS'
  AND C.course_no IN (
        SELECT course_no
        FROM book_adoption
        GROUP BY course_no
        HAVING COUNT(book_ISBN) > 2
  )
ORDER BY T.book_title;

-- 3.
SELECT DISTINCT c.dept
FROM course c
WHERE c.dept IN (
        SELECT c1.dept
        FROM COURSE c1
        JOIN book_adoption b1 ON c1.course_no = b1.course_no
        JOIN textbook t1 ON b1.book_ISBN = t1.book_ISBN
        WHERE t1.publisher = 'Pearson'
)
AND c.dept NOT IN (
        SELECT c2.dept
        FROM course c2
        JOIN book_adoption b2 ON c2.course_no = b2.course_no
        JOIN textbook t2 ON b2.book_ISBN = t2.book_ISBN
        WHERE t2.publisher != 'Pearson'
);

-- 4.
SELECT s.regno, s.name
FROM COURSE c
JOIN enroll e ON c.course_no = e.course_no
JOIN student s ON s.regno = e.regno
WHERE c.cname = 'Database Management Systems'
  AND e.marks = (
        SELECT MAX(e2.marks)
        FROM ENROLL e2
        JOIN COURSE c2 ON e2.course_no = c2.course_no
        WHERE c2.cname = 'Database Management Systems'
  );


-- 5.
SELECT
    s.regno,
    s.name,
    c.cname,
    e.marks
FROM student  s
JOIN ENROLL e ON s.regno = e.regno
JOIN COURSE c ON e.course_no = c.course_no;


-- 6.
DELIMITER $$

CREATE TRIGGER prevent_low_marks_enrollment
BEFORE INSERT ON enroll
FOR EACH ROW
BEGIN
    IF NEW.marks < 40 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Enrollment not allowed: marks less than 40';
    END IF;
END$$

DELIMITER ;
INSERT INTO enroll VALUES ('S001', 2, 1, 35);



/* trial*/

delimiter //

create trigger stutrigger
before insert on enroll
for each row
begin
 if (new.marks<40) then
        signal sqlstate '45000'
        set message_text="marks less";
 end if;
end;//

delimiter ;
