-- SQL Script for Student Management System

-- Creating database
CREATE DATABASE StudentManagementSystem;
USE StudentManagementSystem;

-- Creating tables

-- Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    EnrollmentDate DATE NOT NULL,
    Major VARCHAR(50)
);

-- Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL
);

-- Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Creating sample data

-- Inserting sample students
INSERT INTO Students (FirstName, LastName, DateOfBirth, EnrollmentDate, Major) VALUES
('John', 'Doe', '2000-01-15', '2022-09-01', 'Computer Science'),
('Jane', 'Smith', '1999-05-23', '2021-09-01', 'Mathematics'),
('Emily', 'Johnson', '2001-09-30', '2022-09-01', 'Biology'),
('Michael', 'Brown', '1998-11-12', '2020-09-01', 'History');

-- Inserting sample courses
INSERT INTO Courses (CourseName, Credits) VALUES
('Intro to Programming', 3),
('Data Structures', 4),
('Calculus', 3),
('World History', 3);

-- Enrolling students in courses
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, '2022-09-01'),
(1, 2, '2022-09-01'),
(2, 2, '2021-09-01'),
(2, 3, '2021-09-01'),
(3, 1, '2022-09-01'),
(4, 4, '2020-09-01');

-- Sample queries

-- 1. Retrieve all students enrolled in a specific course
SELECT s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID = 1;

-- 2. Count how many students are enrolled in each major
SELECT Major, COUNT(*) AS NumberOfStudents
FROM Students
GROUP BY Major;

-- 3. Get the average age of enrolled students
SELECT AVG(YEAR(CURDATE()) - YEAR(DateOfBirth)) AS AverageAge
FROM Students;

-- 4. List all courses with the number of students enrolled
SELECT c.CourseName, COUNT(e.StudentID) AS EnrollmentCount
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID;

-- 5. Find students who are not enrolled in any course
SELECT s.FirstName, s.LastName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

-- 6. Get details of all enrollments
dSELECT s.FirstName, s.LastName, c.CourseName, e.EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- 7. List all students with their major and enrollment status
SELECT s.FirstName, s.LastName, s.Major,
       CASE WHEN e.EnrollmentID IS NOT NULL THEN 'Enrolled' ELSE 'Not Enrolled' END AS EnrollmentStatus
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID;

-- 8. Update a student's major
UPDATE Students
SET Major = 'Mathematics'
WHERE StudentID = 1;

-- 9. Delete a student
DELETE FROM Students
WHERE StudentID = 4;

-- 10. Get list of all courses with their credits
SELECT CourseName, Credits FROM Courses;

-- 11. Find all students born after a certain date
SELECT FirstName, LastName
FROM Students
WHERE DateOfBirth > '2000-01-01';

-- 12. Display all enrollments sorted by enrollment date
SELECT s.FirstName, s.LastName, c.CourseName, e.EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY e.EnrollmentDate;

-- 13. Get total number of courses
SELECT COUNT(*) AS TotalCourses FROM Courses;

-- 14. Check enrollments per student
SELECT s.FirstName, s.LastName, COUNT(e.CourseID) AS CoursesEnrolled
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID;

-- 15. Rename a course
UPDATE Courses
SET CourseName = 'Advanced Programming'
WHERE CourseID = 1;
