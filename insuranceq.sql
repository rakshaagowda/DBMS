-- 1. Total number of people owning cars involved in accidents in 2021
SELECT COUNT(*)
FROM accident
JOIN participated USING(report_no)
WHERE YEAR(accident_date)=2021;

-- 2. Number of accidents involving Smith’s cars
SELECT COUNT(*)
FROM accident
JOIN participated USING(report_no)
JOIN person USING(driver_id)
WHERE driver_name='Smith';

-- 3. Add a new accident
INSERT INTO accident VALUES (46969,'2024-04-05','Mandya');
INSERT INTO participated VALUES ('D555','KA-21-BD-4728',46969,50000);

-- 4. Delete Mazda belonging to Smith
DELETE FROM car
WHERE model='Mazda'
AND reg_no IN (
    SELECT reg_no
    FROM owns
    JOIN person USING(driver_id)
    WHERE driver_name='Smith'
);

-- 5. Update damage amount
UPDATE participated
SET damage_amount=2000
WHERE reg_no='KA-09-MA-1234'
AND report_no=65738;



CREATE OR REPLACE VIEW AccidentCars AS
SELECT DISTINCT model, c_year
FROM car
JOIN participated USING(reg_no);

SELECT * FROM AccidentCars;





--Working trigger
DELIMITER //
CREATE TRIGGER PreventParticipation
BEFORE INSERT ON participated
FOR EACH ROW
BEGIN
    IF 3<= (SELECT COUNT(*) FROM Participated JOIN Person USING(driver_id) WHERE driver_id = NEW.driver_id) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT='Driver already has participated in 3 accidents ';
    END IF;
END;
//
DELIMITER;   