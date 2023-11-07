DROP DATABASE IF EXISTS QuanLySinhVien;
CREATE DATABASE IF NOT EXISTS QuanLySinhVien;
USE QuanLySinhVien;

-- Create Students table
CREATE TABLE Students
(
    StudentID   INT PRIMARY KEY,
    StudentName VARCHAR(255),
    Age         INT,
    Email       VARCHAR(255)
);
-- Create Classes table
CREATE TABLE Classes
(
    ClassID   INT PRIMARY KEY,
    ClassName VARCHAR(255)
);
-- Create ClassStudent table
CREATE TABLE ClassStudent
(
    StudentID INT,
    ClassID   INT
);
-- Create Subjects table
CREATE TABLE Subjects
(
    SubjectID   INT PRIMARY KEY,
    SubjectName VARCHAR(255)
);
-- Create Marks table
CREATE TABLE Marks
(
    Mark      INT,
    SubjectID INT,
    StudentID INT
);

-- Connect the primary keys using foreign keysa
-- Create foreign keys in the ClassStudent table to connect Students and Classes
ALTER TABLE ClassStudent
    ADD CONSTRAINT FK_StudentID
        FOREIGN KEY (StudentID)
            REFERENCES Students (StudentID),
    ADD CONSTRAINT FK_ClassID
        FOREIGN KEY (ClassID)
            REFERENCES Classes (ClassID);

-- Create a foreign key in the Marks table to connect Subjects and Students
ALTER TABLE Marks
    ADD CONSTRAINT FK_SubjectID
        FOREIGN KEY (SubjectID)
            REFERENCES Subjects (SubjectID),
    ADD CONSTRAINT FK_StudentID_Marks
        FOREIGN KEY (StudentID)
            REFERENCES Students (StudentID);


-- Insert data into Students table
INSERT INTO Students (StudentID, StudentName, Age, Email)
VALUES (1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
       (2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
       (3, 'Nguyen Van Quyen', 19, 'quyen'),
       (4, 'Pham Thanh Binh', 25, 'binh@com'),
       (5, 'Nguyen Van Tai Em', 30, 'taiem@sport.vn');


-- Insert data into Classes table
INSERT INTO Classes (ClassID, ClassName)
VALUES (1, 'C0706L'),
       (2, 'C0708G');


-- Insert data into ClassStudent table
INSERT INTO ClassStudent (StudentID, ClassID)
VALUES (1, 1),
       (2, 1),
       (3, 2),
       (4, 2),
       (5, 2);


-- Insert data into Subjects table
INSERT INTO Subjects (SubjectID, SubjectName)
VALUES (1, 'SQL'),
       (2, 'Java'),
       (3, 'C'),
       (4, 'Visual Basic');

-- Insert data into Marks table
INSERT INTO Marks (Mark, SubjectID, StudentID)
VALUES (8, 1, 1), -- SubjectID 1 and StudentID 1 exist
       (4, 2, 1), -- SubjectID 2 and StudentID 1 exist
       (9, 1, 1), -- SubjectID 1 and StudentID 1 exist
       (7, 1, 3), -- SubjectID 1 and StudentID 3 exist
       (3, 3, 1), -- SubjectID 3 and StudentID 1 exist
       (4, 3, 5), -- SubjectID 3 and StudentID 5 exist
       (8, 3, 3), -- SubjectID 3 and StudentID 3 exist
       (1, 4, 5), -- SubjectID 4 and StudentID 5 exist
       (3, 4, 2), -- SubjectID 4 and StudentID 2 exist
       (2, 2, 2);
-- SubjectID 2 and StudentID 2 exist

#1
SELECT *
FROM Students;

#2
SELECT *
FROM Subjects;

#3
SELECT StudentID, AVG(Mark) AS DiemTrungBinh
FROM Marks
GROUP BY StudentID;

#4
SELECT S.SubjectName, M.MaxMark
FROM Subjects AS S
         JOIN (SELECT SubjectID, MAX(Mark) AS MaxMark
               FROM Marks
               GROUP BY SubjectID) AS M ON S.SubjectID = M.SubjectID;

#5
SELECT Mark,
       DENSE_RANK() OVER (ORDER BY Mark DESC) AS ThuTuGiam
FROM Marks
ORDER BY Mark DESC;

#6
ALTER TABLE Subjects
    MODIFY SubjectName varchar(255);

#7
UPDATE Subjects
SET SubjectName = CONCAT('Day la mon hoc ', SubjectName);

#8
ALTER TABLE Students
    ADD CONSTRAINT CHK_AgeRange CHECK (Age > 15 AND Age < 50);

#9
ALTER TABLE ClassStudent
    DROP CONSTRAINT FK_StudentID;

ALTER TABLE ClassStudent
    DROP CONSTRAINT FK_ClassID;

ALTER TABLE Marks
    DROP CONSTRAINT FK_SubjectID;

ALTER TABLE Marks
    DROP CONSTRAINT FK_StudentID_Marks;

#10
DELETE
FROM ClassStudent
WHERE StudentID = 1;
DELETE
FROM Marks
WHERE StudentID = 1;
DELETE
FROM Students
WHERE StudentID = 1;

#11
ALTER TABLE Students
    ADD Status BIT DEFAULT 1;

#12
UPDATE Students
SET Status = 0;
