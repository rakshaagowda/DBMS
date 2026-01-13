



/* 1. Number of drivers involved in accidents in 2021 */
SELECT COUNT(DISTINCT o.driver_id)
FROM owns o, participated ptd, accident a
WHERE o.driver_id = ptd.driver_id
AND ptd.reportno = a.reportno
AND a.accd_date LIKE '%2021%';

/* 2. Number of accidents involving cars owned by Smith */
SELECT COUNT(DISTINCT a.reportno)
FROM car c, participated ptd, person p, accident a
WHERE c.regno = ptd.regno
AND ptd.driver_id = p.driver_id
AND ptd.reportno = a.reportno
AND p.name LIKE '%Smith%';
--3
 INSERT INTO accident VALUES (46969,'2024-04-05','Mandya');
INSERT INTO participated VALUES ('D555','KA-21-BD-4728',46969,50000);
/* 4. Delete Mazda cars owned by Smith */
DELETE c
FROM car c, participated ptd, person p
WHERE c.regno = ptd.regno
AND ptd.driver_id = p.driver_id
AND p.name LIKE '%Smith%'
AND c.model LIKE '%Mazda%';

/* 5. Update damage amount for car containing 1234 */
UPDATE participated ptd
JOIN car c ON c.regno = ptd.regno
JOIN accident a ON a.reportno = ptd.reportno
SET ptd.damage_amount = 52000
WHERE c.regno LIKE '%1234%';

/* 6. View of car models involved in accidents */
CREATE VIEW models AS
SELECT c.model, c.year
FROM participated ptd
JOIN accident a ON a.reportno = ptd.reportno
JOIN car c ON c.regno = ptd.regno;


DELIMITER //

CREATE TRIGGER xy
BEFORE INSERT ON participated
FOR EACH ROW
BEGIN
    IF (
        SELECT COUNT(*)
        FROM participated ptd
        WHERE ptd.driver_id = NEW.driver_id
    ) >= 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'cancel license';
    END IF;
END;
//

DELIMITER ;
