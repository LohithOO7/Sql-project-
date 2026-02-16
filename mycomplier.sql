-- ============================================================================
-- STUDENT MANAGEMENT SYSTEM - FULLY COMPATIBLE VERSION
-- For mycompiler.io (No CREATE DB, No DEFAULT CURRENT_DATE, No INDEXES)
-- ============================================================================

-- TABLE DEFINITIONS
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    EnrollmentDate DATE
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    Department VARCHAR(50) NOT NULL
);

CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Department VARCHAR(50) NOT NULL,
    HireDate DATE
);

CREATE TABLE Grades (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    EnrollmentID INT NOT NULL,
    Grade CHAR(1),
    GradeDate DATE
);

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
-- VERIFICATION QUERIES - Run these to test
-- ============================================================================

-- 1. Show all tables created
SHOW TABLES;

-- 2. Count records in each table
SELECT 'Students' as TableName, COUNT(*) as RecordCount FROM Students
UNION ALL
SELECT 'Courses', COUNT(*) FROM Courses
UNION ALL
SELECT 'Enrollment', COUNT(*) FROM Enrollment
UNION ALL
SELECT 'Grades', COUNT(*) FROM Grades;

-- 3. Students with their enrolled courses
SELECT s.StudentID, CONCAT(s.FirstName, ' ', s.LastName) AS StudentName, 
       COUNT(e.CourseID) AS CoursesEnrolled
FROM Students s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
GROUP BY s.StudentID
ORDER BY s.StudentID;

-- 4. Top performing students (Grade A)
SELECT DISTINCT CONCAT(s.FirstName, ' ', s.LastName) AS StudentName, c.CourseName
FROM Students s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
WHERE g.Grade = 'A'
ORDER BY StudentName;
