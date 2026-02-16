-- Improved SQL for Student Management System

-- Table for Students
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    EnrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_age CHECK (DATEDIFF(CURRENT_DATE, DateOfBirth) / 365 >= 18) -- Students must be at least 18 years old
);

-- Index on LastName for faster search queries
CREATE INDEX idx_lastname ON Students (LastName);

-- Table for Courses
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT CHECK (Credits > 0)
);

-- Table for Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);