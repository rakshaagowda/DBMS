-- 1. Projects involving employee named Scott
SELECT * FROM PROJECT
WHERE DNo IN (SELECT DNo FROM EMPLOYEE WHERE EName LIKE '%Scott%')
OR DNo IN (
    SELECT DNo FROM DEPARTMENT
    WHERE MgrSSN IN (SELECT SSN FROM EMPLOYEE WHERE EName LIKE '%Scott%')
);

-- 2. 10% salary hike for employees working on IoT project
UPDATE EMPLOYEE
SET Salary = Salary * 1.1
WHERE SSN IN (
    SELECT SSN FROM WORKS_ON
    WHERE PNo = (SELECT PNo FROM PROJECT WHERE PName='IoT')
);

SELECT SSN, EName, Salary FROM EMPLOYEE
WHERE SSN IN (
    SELECT SSN FROM WORKS_ON
    WHERE PNo = (SELECT PNo FROM PROJECT WHERE PName='IoT')
);

-- 3. Salary statistics for Accounts department
SELECT
SUM(E.Salary) AS TotalSalary,
MAX(E.Salary) AS MaxSalary,
MIN(E.Salary) AS MinSalary,
AVG(E.Salary) AS AvgSalary
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNo = D.DNo
WHERE D.DName='Accounts';

-- 4. Employees working on all projects of department 5
SELECT E.EName
FROM EMPLOYEE E
WHERE NOT EXISTS (
    SELECT P.PNo FROM PROJECT P
    WHERE P.DNo=5
    AND NOT EXISTS (
        SELECT W.PNo FROM WORKS_ON W
        WHERE W.SSN=E.SSN AND W.PNo=P.PNo
    )
);

-- 5. Departments with >=5 employees earning above 6,00,000
SELECT D.DNo, COUNT(E.SSN) AS EmployeeCount
FROM DEPARTMENT D
JOIN EMPLOYEE E ON D.DNo=E.DNo
WHERE E.Salary > 600000
GROUP BY D.DNo
HAVING COUNT(E.SSN) >= 5;



CREATE OR REPLACE VIEW EmployeeView AS
SELECT E.EName, D.DName AS Department, DL.DLoc AS Location
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNo=D.DNo
JOIN DLOCATION DL ON D.DNo=DL.DNo;

SELECT * FROM EmployeeView;



DELIMITER //

CREATE TRIGGER Prevent_Project_Delete
BEFORE DELETE ON PROJECT
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM WORKS_ON WHERE PNo=OLD.PNo) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Project cannot be deleted as employees are assigned';
    END IF;
END;
//

DELIMITER ;

-- Test trigger
DELETE FROM PROJECT WHERE PNo=702;