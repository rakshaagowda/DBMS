
-- Sailors Database SQL Script

-- 1. Create Tables
CREATE TABLE SAILORS (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    rating INT,
    age FLOAT
);

CREATE TABLE BOAT (
    bid INT PRIMARY KEY,
    bname VARCHAR(50),
    color VARCHAR(20)
);

CREATE TABLE RSERVERS (
    sid INT,
    bid INT,
    date DATE,
    PRIMARY KEY (sid, bid, date),
    FOREIGN KEY (sid) REFERENCES SAILORS(sid),
    FOREIGN KEY (bid) REFERENCES BOAT(bid)
);

-- 2. Insert Data
INSERT INTO SAILORS VALUES
(1, 'Ravi', 7, 25.5),
(2, 'Anita', 8, 30.0),
(3, 'Kiran', 6, 22.8),
(4, 'Megha', 9, 28.3),
(5, 'Suresh', 5, 24.1);

INSERT INTO BOAT VALUES
(101, 'Sea King', 'Red'),
(102, 'Blue Wave', 'Blue'),
(103, 'Aqua Spirit', 'Green'),
(104, 'Sun Rider', 'Yellow'),
(105, 'Ocean Pearl', 'White');

INSERT INTO RSERVERS VALUES
(1, 101, '2025-01-12'),
(2, 102, '2025-01-14'),
(3, 103, '2025-02-01'),
(4, 101, '2025-02-10'),
(5, 105, '2025-03-05');

-- 3. Alter Table - Add and Drop Columns
ALTER TABLE SAILORS
ADD COLUMN phone VARCHAR(15);

ALTER TABLE SAILORS
DROP COLUMN phone;

-- 4. Add and Drop Constraints
ALTER TABLE SAILORS
ADD CONSTRAINT chk_rating CHECK (rating BETWEEN 1 AND 10);

ALTER TABLE SAILORS
DROP CONSTRAINT chk_rating;

-- 5. Update Operation
UPDATE SAILORS
SET rating = 9
WHERE sid = 3;

-- 6. Delete Operations
DELETE FROM RSERVERS
WHERE sid = 5 AND bid = 105;

DELETE FROM SAILORS
WHERE sid = 4;

-- 7. Optional: Add Cascade Deletion
ALTER TABLE RSERVERS
ADD CONSTRAINT fk_sid FOREIGN KEY (sid) REFERENCES SAILORS(sid) ON DELETE CASCADE;

ALTER TABLE RSERVERS
ADD CONSTRAINT fk_bid FOREIGN KEY (bid) REFERENCES BOAT(bid) ON DELETE CASCADE;

-- End of Script
