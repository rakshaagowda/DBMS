

/* 1 Colors of boats reserved by Albert */
SELECT b.color
FROM boat b, sailor s, reservers r
WHERE r.sid = s.sid AND r.bid = b.bid AND s.sname LIKE '%Albert%';

/* 2 Sailors with rating >= 8 OR reserved boat 103 */
SELECT DISTINCT s.sid FROM sailor s WHERE s.rating >= 8.0
UNION
SELECT DISTINCT r.sid FROM reservers r WHERE r.bid = 103;

/* 3Sailors who did NOT reserve boats by storm */

 select distinct s.sname
 from sailors s
 left join reserves r on s.sid=r.sid
 where r.sid is null and s.sname like "%storm"
 order by s.sname asc;


/* 4 Sailors who reserved ALL boats */
SELECT s.sname
FROM sailor s JOIN reservers r ON r.sid = s.sid
GROUP BY s.sid
HAVING COUNT(DISTINCT r.bid) = (SELECT COUNT(*) FROM boat);
/* 4 Sailors who reserved ALL boats */
SELECT s.sname
 FROM sailors s
 WHERE NOT EXISTS (
    SELECT *
    FROM boats b
    WHERE NOT EXISTS (
        SELECT *
        FROM reserves r
        WHERE r.sid = s.sid
        AND r.bid = b.bid
    )
);
/*  5 Oldest sailor */
SELECT sname, age FROM sailor WHERE age = (SELECT MAX(age) FROM sailor);

/* 6 Average age per boat (age >= 40, at least 2 sailors) */
SELECT b.bid, AVG(s.age) AS average_age
FROM sailor s, boat b, reservers r
WHERE r.sid = s.sid AND r.bid = b.bid AND s.age >= 40
GROUP BY b.bid
HAVING COUNT(DISTINCT r.sid) >= 2;


CREATE VIEW rb AS
SELECT DISTINCT bname, color
FROM boat b, sailor s, reservers r
WHERE r.sid = s.sid AND r.bid = b.bid AND s.rating = 8;


DELIMITER //

CREATE TRIGGER check_delete
BEFORE DELETE ON boat
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT * FROM reservers r WHERE r.bid = OLD.bid) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'cannot delete';
    END IF;
END;
//

DELIMITER ;


 DELETE FROM boat WHERE bid = 103;
