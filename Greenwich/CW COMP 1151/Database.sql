use Person
CREATE TABLE Person (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Telephone VARCHAR(15) NOT NULL, -- Adjust length as necessary
    Email VARCHAR(100) NOT NULL,
	Role VARCHAR(10) NOT NULL,
    CONSTRAINT chk_Role CHECK (Role IN ('teacher', 'admin', 'student')),
);
--Teacher Staff
CREATE TABLE TeacherStaff(
	StaffID INT PRIMARY KEY IDENTITY(1,1),
	UserID INT,
	Salary DECIMAL(10,2) NOT NULL,
	First_Subject VARCHAR(255) NOT NULL,
	Second_Subject VARCHAR(255) NOT NULL,
	CONSTRAINT fk_teaching_staff FOREIGN KEY (UserID) REFERENCES Person(UserID),
);
-- Student
use Person
CREATE TABLE Student(
	StudentID INT PRIMARY KEY IDENTITY(1,1),
	UserID INT,
	FirstCurrentSubject VARCHAR(255) NOT NULL,
	SecondCurrentSubject VARCHAR(255) NOT NULL,
	FirstPreviousStudiedSubject VARCHAR(255) NOT NULL,
	SecondPreviousStudiedSubject VARCHAR(255) NOT NULL,
	CONSTRAINT fk_student FOREIGN KEY (UserID) REFERENCES Person(UserID),
);
-- Administration
CREATE TABLE Administration (
	AdminID INT PRIMARY KEY IDENTITY(1,1),
	UserID INT,
	Salary DECIMAL(10,2) NOT NULL,
	EmploymentStatus VARCHAR(10) NOT NULL CHECK (EmploymentStatus IN ('Full-time', 'Part-time')),
	WorkedHours INT NOT NULL,
	CONSTRAINT fk_Administration_User FOREIGN KEY (UserID) REFERENCES Person(UserID),
);

