-- Creating a comprehensive Student Management System Database

CREATE DATABASE StudentManagementSystem;
USE StudentManagementSystem;

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
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

-- Table for instructors
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    HireDate DATE DEFAULT CURRENT_DATE
);

-- Table for grades
CREATE TABLE Grades (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    EnrollmentID INT NOT NULL,
    Grade CHAR(2) CHECK (Grade IN ('A', 'B', 'C', 'D', 'F')),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollment(EnrollmentID) ON DELETE CASCADE
);

-- Creating indexes to improve performance
CREATE INDEX idx_students_email ON Students(Email);
CREATE INDEX idx_courses_name ON Courses(CourseName);

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
END //
DELIMITER ;

-- Trigger to update enrollment date automatically
DELIMITER //
CREATE TRIGGER trg_EnrollmentDate
AFTER INSERT ON Enrollment
FOR EACH ROW
BEGIN
    UPDATE Enrollment SET EnrollmentDate = CURRENT_DATE WHERE EnrollmentID = NEW.EnrollmentID;
END //
DELIMITER ;

-- More advanced queries can be added here for reporting and analytics

-- Sample query to get student information along with their course and grades
SELECT s.FirstName, s.LastName, c.CourseName, g.Grade
FROM Students s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Grades g ON e.EnrollmentID = g.EnrollmentID;
