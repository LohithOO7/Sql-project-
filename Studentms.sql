-- ============================================================================
-- STUDENT MANAGEMENT SYSTEM - COMPREHENSIVE SQL PROJECT
-- ============================================================================

-- Creating a comprehensive Student Management System Database
CREATE DATABASE StudentManagementSystem;
USE StudentManagementSystem;

-- ============================================================================
-- TABLE DEFINITIONS
-- ============================================================================

-- Table to store student information
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    EnrollmentDate DATE DEFAULT CURRENT_DATE
);

-- Table for courses offered
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL CHECK (Credits > 0),
    Department VARCHAR(50) NOT NULL
);

-- Table for student enrollment in courses
CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

-- Table for instructors
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Department VARCHAR(50) NOT NULL,
    HireDate DATE DEFAULT CURRENT_DATE
);

-- Table for grades
CREATE TABLE Grades (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    EnrollmentID INT NOT NULL,
    Grade CHAR(1) CHECK (Grade IN ('A', 'B', 'C', 'D', 'F')),
    GradeDate DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollment(EnrollmentID) ON DELETE CASCADE
);

-- ============================================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- ============================================================================

CREATE INDEX idx_students_email ON Students(Email);
CREATE INDEX idx_students_lastname ON Students(LastName);
CREATE INDEX idx_courses_name ON Courses(CourseName);
CREATE INDEX idx_enrollment_student ON Enrollment(StudentID);
CREATE INDEX idx_enrollment_course ON Enrollment(CourseID);
CREATE INDEX idx_grades_enrollment ON Grades(EnrollmentID);

-- ============================================================================
-- STORED PROCEDURES
-- ============================================================================

-- Stored procedure to add a new student
DELIMITER //
CREATE PROCEDURE AddStudent(
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_DateOfBirth DATE,
    IN p_Email VARCHAR(100),
    IN p_Phone VARCHAR(15)
)
BEGIN
    INSERT INTO Students (FirstName, LastName, DateOfBirth, Email, Phone)
    VALUES (p_FirstName, p_LastName, p_DateOfBirth, p_Email, p_Phone);
    SELECT LAST_INSERT_ID() AS NewStudentID;
END //
DELIMITER ;

-- Stored procedure to enroll a student in a course
DELIMITER //
CREATE PROCEDURE EnrollStudent(
    IN p_StudentID INT,
    IN p_CourseID INT
)
BEGIN
    INSERT INTO Enrollment (StudentID, CourseID, EnrollmentDate)
    VALUES (p_StudentID, p_CourseID, CURRENT_DATE);
    SELECT LAST_INSERT_ID() AS NewEnrollmentID;
END //
DELIMITER ;

-- Stored procedure to add grades for enrollment
DELIMITER //
CREATE PROCEDURE AddGrade(
    IN p_EnrollmentID INT,
    IN p_Grade CHAR(1)
)
BEGIN
    INSERT INTO Grades (EnrollmentID, Grade, GradeDate)
    VALUES (p_EnrollmentID, p_Grade, CURRENT_DATE);
END //
DELIMITER ;

-- ============================================================================
-- SAMPLE DATA INSERTION
-- ============================================================================

-- Insert Students
INSERT INTO Students (FirstName, LastName, DateOfBirth, Email, Phone, EnrollmentDate) VALUES
('John', 'Doe', '2000-01-15', 'john.doe@university.edu', '555-0101', '2023-09-01'),
('Jane', 'Smith', '1999-05-23', 'jane.smith@university.edu', '555-0102', '2022-09-01'),
('Emily', 'Johnson', '2001-09-30', 'emily.johnson@university.edu', '555-0103', '2023-09-01'),
('Michael', 'Brown', '1998-11-12', 'michael.brown@university.edu', '555-0104', '2021-09-01'),
('Sarah', 'Williams', '2002-03-08', 'sarah.williams@university.edu', '555-0105', '2023-09-01'),
('David', 'Martinez', '2000-07-19', 'david.martinez@university.edu', '555-0106', '2023-09-01'),
('Jessica', 'Taylor', '1999-12-25', 'jessica.taylor@university.edu', '555-0107', '2022-09-01'),
('Robert', 'Anderson', '2001-06-14', 'robert.anderson@university.edu', '555-0108', '2023-09-01');

-- Insert Courses
INSERT INTO Courses (CourseName, Credits, Department) VALUES
('Introduction to Programming', 3, 'Computer Science'),
('Data Structures', 4, 'Computer Science'),
('Calculus I', 4, 'Mathematics'),
('Calculus II', 4, 'Mathematics'),
('World History', 3, 'History'),
('American History', 3, 'History'),
('General Biology', 4, 'Biology'),
('Organic Chemistry', 4, 'Chemistry'),
('Web Development', 3, 'Computer Science'),
('Database Design', 3, 'Computer Science');

-- Insert Instructors
INSERT INTO Instructors (FirstName, LastName, Email, Department, HireDate) VALUES
('Dr. James', 'Wilson', 'james.wilson@university.edu', 'Computer Science', '2018-08-15'),
('Prof. Mary', 'Thompson', 'mary.thompson@university.edu', 'Mathematics', '2019-08-20'),
('Dr. Robert', 'Lee', 'robert.lee@university.edu', 'History', '2017-08-10'),
('Dr. Patricia', 'Clark', 'patricia.clark@university.edu', 'Biology', '2020-08-01'),
('Prof. Michael', 'Harris', 'michael.harris@university.edu', 'Chemistry', '2019-09-05');

-- Insert Enrollments
INSERT INTO Enrollment (StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, '2023-09-01'),
(1, 3, '2023-09-01'),
(1, 9, '2023-09-01'),
(2, 2, '2022-09-01'),
(2, 4, '2022-09-01'),
(2, 10, '2023-09-01'),
(3, 1, '2023-09-01'),
(3, 5, '2023-09-01'),
(4, 6, '2021-09-01'),
(4, 7, '2021-09-01'),
(5, 1, '2023-09-01'),
(5, 3, '2023-09-01'),
(6, 8, '2023-09-01'),
(6, 2, '2023-09-01'),
(7, 5, '2022-09-01'),
(7, 6, '2022-09-01'),
(8, 1, '2023-09-01'),
(8, 9, '2023-09-01');

-- Insert Grades
INSERT INTO Grades (EnrollmentID, Grade, GradeDate) VALUES
(1, 'A', '2023-12-15'),
(2, 'B', '2023-12-15'),
(3, 'A', '2023-12-15'),
(4, 'A', '2022-12-15'),
(5, 'B', '2022-12-15'),
(6, 'B', '2023-12-15'),
(7, 'A', '2023-12-15'),
(8, 'B', '2023-12-15'),
(9, 'C', '2021-12-15'),
(10, 'B', '2021-12-15'),
(11, 'A', '2023-12-15'),
(12, 'A', '2023-12-15'),
(13, 'B', '2023-12-15'),
(14, 'A', '2023-12-15'),
(15, 'B', '2022-12-15'),
(16, 'A', '2022-12-15'),
(17, 'A', '2023-12-15'),
(18, 'B', '2023-12-15');

-- ============================================================================
-- USEFUL QUERIES AND REPORTS
-- ============================================================================

-- Query 1: Get all students with their enrolled courses
SELECT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName, 
       COUNT(e.CourseID) AS CoursesEnrolled
FROM Students s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
ORDER BY s.StudentID;

-- Query 2: Get student information with course and grade details
SELECT s.FirstName, s.LastName, c.CourseName, g.Grade, c.Department
FROM Students s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
LEFT JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
ORDER BY s.LastName, c.CourseName;

-- Query 3: Count enrollments per course
SELECT c.CourseName, COUNT(e.EnrollmentID) AS StudentCount, c.Credits, c.Department
FROM Courses c
LEFT JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.CourseID
ORDER BY StudentCount DESC;

-- Query 4: Find students not yet enrolled in any course
SELECT StudentID, FirstName, LastName, Email
FROM Students s
WHERE NOT EXISTS (SELECT 1 FROM Enrollment e WHERE e.StudentID = s.StudentID);

-- Query 5: Calculate average grade per student
SELECT s.FirstName, s.LastName, 
       CASE 
           WHEN AVG(ASCII(g.Grade) - ASCII('A') + 4) IS NULL THEN 'No Grades'
           ELSE CONCAT(ROUND(AVG(ASCII(g.Grade) - ASCII('A') + 4), 2), '/4.0')
       END AS AverageGPA
FROM Students s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
LEFT JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
GROUP BY s.StudentID
ORDER BY s.LastName;

-- Query 6: Get courses per department with student count
SELECT c.Department, c.CourseName, COUNT(e.EnrollmentID) AS EnrolledStudents
FROM Courses c
LEFT JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.CourseID
ORDER BY c.Department, c.CourseName;

-- Query 7: List all high achievers (Grade 'A')
SELECT DISTINCT s.FirstName, s.LastName, c.CourseName
FROM Students s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
WHERE g.Grade = 'A'
ORDER BY s.LastName;

-- Query 8: Get total credits completed per student
SELECT s.FirstName, s.LastName, SUM(c.Credits) AS TotalCreditsCompleted
FROM Students s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = e.CourseID
JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
WHERE g.Grade != 'F'
GROUP BY s.StudentID
ORDER BY TotalCreditsCompleted DESC;

-- Query 9: Get instructor and their course count
SELECT CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName, 
       i.Department,
       COUNT(DISTINCT c.CourseID) AS CourseCount
FROM Instructors i
LEFT JOIN Courses c ON i.Department = c.Department
GROUP BY i.InstructorID
ORDER BY i.Department;

-- Query 10: Student enrollment timeline
SELECT s.FirstName, s.LastName, s.EnrollmentDate, COUNT(e.EnrollmentID) AS CurrentEnrollments
FROM Students s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
ORDER BY s.EnrollmentDate DESC;
