-- 1.
SELECT w.PNO
FROM EMPLOYEE e
JOIN WORKS_ON w ON e.SSN = w.SSN
WHERE e.Name LIKE '%Scott'

UNION

SELECT p.PNO
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.SSN = d.MgrSSN
JOIN PROJECT p ON d.DNO = p.DNO
WHERE e.Name LIKE '%Scott';

-- 2.
SELECT
    e.Name,
    e.Salary AS Current_Salary,
    e.Salary * 1.10 AS Increased_Salary
FROM EMPLOYEE e
JOIN WORKS_ON w ON e.SSN = w.SSN
JOIN PROJECT p ON w.PNO = p.PNO
WHERE p.PName = 'IoT';

-- 3.
SELECT
    SUM(e.Salary) AS Total_Salary,
    MAX(e.Salary) AS Max_Salary,
    MIN(e.Salary) AS Min_Salary,
    AVG(e.Salary) AS Avg_Salary
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.DNO = d.DNO
WHERE d.DName = 'Accounts';

-- 4.
SELECT E.Name
FROM EMPLOYEE E
WHERE NOT EXISTS (
    SELECT P.PNO
    FROM PROJECT P
    WHERE P.DNO = 5
      AND P.PNO NOT IN (
          SELECT W.PNO
          FROM WORKS_ON W
          WHERE W.SSN = E.SSN
      )
);


-- 5.
SELECT
    E.DNO AS DepartmentNumber,
    COUNT(E.SSN) AS EmployeesAbove600000
FROM EMPLOYEE E
WHERE
    E.Salary > 600000
    AND E.DNO IN (
        SELECT DNO
        FROM EMPLOYEE
        GROUP BY DNO
        HAVING COUNT(*) >5
    )
GROUP BY E.DNO;



-- 6.
CREATE VIEW Employee_Department_Location AS
SELECT
    E.Name AS EmployeeName,
    D.DName AS DepartmentName,
    L.DLoc AS Location
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNO = D.DNO
JOIN DLOCATION L ON D.DNO = L.DNO;


SELECT * FROM Employee_Department_Location;

-- 7.
DELIMITER //

CREATE TRIGGER PREVENT_DELETE
BEFORE DELETE ON PROJECT
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT *
        FROM WORKS_ON
        WHERE PNo = OLD.PNo
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The project cannot be deleted as it has an assigned employee';
    END IF;
END;
//

DELIMITER ;


DELETE FROM PROJECT WHERE PNo = 278345;
