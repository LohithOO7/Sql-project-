-- Student Management System SQL Code

-- Create tables

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    EnrollmentDate DATE
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    Grade CHAR(1),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create views

CREATE VIEW StudentCourses AS
SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- Create stored procedures

DELIMITER //

CREATE PROCEDURE AddStudent (
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_DateOfBirth DATE,
    IN p_EnrollmentDate DATE
)
BEGIN
    INSERT INTO Students (FirstName, LastName, DateOfBirth, EnrollmentDate)
    VALUES (p_FirstName, p_LastName, p_DateOfBirth, p_EnrollmentDate);
END //

DELIMITER ;

-- Create triggers

CREATE TRIGGER UpdateEnrollmentDate
BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    SET NEW.EnrollmentDate = NOW();
END;

-- Analytics queries

-- Total number of students enrolled
SELECT COUNT(*) AS TotalStudents
FROM Students;

-- Average grade for each course
SELECT CourseID, AVG(CASE WHEN Grade IS NOT NULL THEN CAST(Grade AS DECIMAL(3,2)) END) AS AvgGrade
FROM Enrollments
GROUP BY CourseID;