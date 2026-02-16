-- Create the database
CREATE DATABASE StudentManagementSystem;
USE StudentManagementSystem;

-- Create the Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Other'),
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    EnrollmentDate DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Create the Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    CourseDescription TEXT,
    Credits INT NOT NULL
);

-- Create the Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE NOT NULL DEFAULT CURRENT_DATE,
    Grade VARCHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create the Instructors table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    HireDate DATE NOT NULL
);

-- Create the CourseInstructors table
CREATE TABLE CourseInstructors (
    CourseInstructorID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    InstructorID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- Insert sample data into Students table
INSERT INTO Students (FirstName, LastName, DateOfBirth, Gender, Email, PhoneNumber, EnrollmentDate) VALUES
('John', 'Doe', '2000-01-01', 'Male', 'john.doe@example.com', '1234567890', '2021-09-01'),
('Jane', 'Doe', '2001-02-02', 'Female', 'jane.doe@example.com', '0987654321', '2021-09-01'),
('Sam', 'Smith', '2000-03-03', 'Male', 'sam.smith@example.com', '1231231234', '2021-09-01'),
('Emily', 'Jones', '2002-04-04', 'Female', 'emily.jones@example.com', '4321432143', '2021-09-01'),
('Michael', 'Brown', '2001-05-05', 'Male', 'michael.brown@example.com', '5678567856', '2021-09-01');

-- Insert sample data into Courses table
INSERT INTO Courses (CourseName, CourseDescription, Credits) VALUES
('Mathematics', 'Introduction to Mathematics', 3),
('Physics', 'Fundamentals of Physics', 4),
('Chemistry', 'Basics of Chemistry', 4),
('Biology', 'Fundamentals of Biology', 3),
('Computer Science', 'Introduction to Computer Science', 4);

-- Insert sample data into Instructors table
INSERT INTO Instructors (FirstName, LastName, Email, HireDate) VALUES
('Dr. Alice', 'Johnson', 'alice.johnson@example.com', '2019-01-15'),
('Dr. Bob', 'Williams', 'bob.williams@example.com', '2018-03-22'),
('Prof. Charlie', 'Davis', 'charlie.davis@example.com', '2020-06-30');

-- Insert sample data into CourseInstructors table
INSERT INTO CourseInstructors (CourseID, InstructorID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 2);

-- Insert sample data into Enrollments table
INSERT INTO Enrollments (StudentID, CourseID, Grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'A'),
(3, 3, 'C'),
(4, 4, 'B'),
(5, 5, 'A');

-- Query to get all students along with their enrollments
SELECT s.FirstName, s.LastName, c.CourseName, e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- Query to get all courses and their instructors
SELECT c.CourseName, CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName
FROM Courses c
JOIN CourseInstructors ci ON c.CourseID = ci.CourseID
JOIN Instructors i ON ci.InstructorID = i.InstructorID;

-- Query to get the average grade for each course
SELECT c.CourseName, AVG(CASE WHEN e.Grade IS NOT NULL THEN CHAR_LENGTH(e.Grade) ELSE 0 END) AS AverageGrade
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID;

-- Query to list students who have not enrolled in any course
SELECT * FROM Students WHERE StudentID NOT IN (SELECT DISTINCT StudentID FROM Enrollments);

-- Query to get the number of students enrolled in each course
SELECT c.CourseName, COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID;

-- Query to list all instructors along with the courses they teach
SELECT CONCAT(i.FirstName, ' ', i.LastName) AS InstructorName, c.CourseName
FROM Instructors i
JOIN CourseInstructors ci ON i.InstructorID = ci.InstructorID
JOIN Courses c ON ci.CourseID = c.CourseID;