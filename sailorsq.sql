-- 1. Colours of boats reserved by Albert
SELECT DISTINCT b.color
FROM BOAT b
JOIN RESERVES r ON b.bid = r.bid
JOIN SAILORS s ON r.sid = s.sid
WHERE s.sname = 'Albert';

-- 2. Sailor IDs with rating >= 8 or reserved boat 103
SELECT DISTINCT s.sid
FROM SAILORS s
LEFT JOIN RESERVES r ON s.sid = r.sid
WHERE s.rating >= 8 OR r.bid = 103;

-- 3. Sailors who have not reserved boats containing 'storm'
SELECT s.sname
FROM SAILORS s
WHERE s.sid NOT IN (
    SELECT r.sid
    FROM RESERVES r
    JOIN BOAT b ON r.bid = b.bid
    WHERE b.bname LIKE '%storm%'
)
ORDER BY s.sname ASC;

-- 4. Sailors who have reserved all boats
SELECT s.sname
FROM SAILORS s
WHERE NOT EXISTS (
    SELECT b.bid
    FROM BOAT b
    WHERE NOT EXISTS (
        SELECT r.bid
        FROM RESERVES r
        WHERE r.sid = s.sid AND r.bid = b.bid
    )
);

-- 5. Oldest sailor
SELECT sname, age
FROM SAILORS
WHERE age = (SELECT MAX(age) FROM SAILORS);

-- 6. Boats reserved by at least 5 sailors aged >= 40
SELECT r.bid AS boat_id, AVG(s.age) AS avg_age
FROM RESERVES r
JOIN SAILORS s ON r.sid = s.sid
WHERE s.age >= 40
GROUP BY r.bid
HAVING COUNT(DISTINCT r.sid) >= 5;

-- ===============================
-- VIEW
-- ===============================

CREATE OR REPLACE VIEW ReservedBoatsByRating AS
SELECT DISTINCT
    s.sname AS sailor_name,
    b.bname AS boat_name,
    b.color
FROM SAILORS s
JOIN RESERVES r ON s.sid = r.sid
JOIN BOAT b ON r.bid = b.bid
WHERE s.rating = 8;

SELECT * FROM ReservedBoatsByRating;

-- ===============================
-- TRIGGER
-- ===============================

DELIMITER //

CREATE TRIGGER prevent_delete_active_reservations
BEFORE DELETE ON BOAT
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM RESERVES WHERE bid = OLD.bid) > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a boat with active reservations';
    END IF;
END;
//
DELIMITER ;

-- Trigger check
DELETE FROM BOAT WHERE bid = 103;