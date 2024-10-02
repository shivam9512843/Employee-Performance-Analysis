create database EmployeePerformanceDB;
Use EmployeePerformanceDB;

-- This table will store information about employees

CREATE TABLE Employees(
employee_id INT PRIMARY KEY auto_increment,
name VARCHAR(255),
department VARCHAR(255),
role VARCHAR(255),
join_date DATE
)
;

-- Add Employees:
INSERT INTO Employees (name, department, role, join_date)
VALUES ('Shivam Rajput', 'Software Development', 'Software Engineer', '2022-01-10'),
       ('Madhur Mahajan', 'Marketing', 'Marketing Manager', '2020-07-05'),
       ('Varad Mahajan', 'Sales', 'Sales Executive', '2019-03-12'),
       ('Alay Patel', 'Marketing', 'Marketing Manager', '2020-09-01'),
       ('Dipesh', 'Sales', 'Sales Executive', '2019-08-23'),
       ('Kartik', 'Marketing', 'Marketing Manager', '2020-07-01'),
       ('zafar', 'Sales', 'Sales Executive', '2019-04-18'),
       ('Anchal', 'Marketing', 'Marketing Manager', '2020-09-03'),
       ('Ratan', 'Sales', 'Sales Executive', '2019-02-26'),
       ('Karan', 'Marketing', 'Marketing Manager', '2020-01-09'),
       ('Daksh', 'Sales', 'Sales Executive', '2019-03-12'),
       ('Dhaval', 'Marketing', 'Marketing Manager', '2020-07-03'),
       ('Ibhrahim', 'Sales', 'Sales Executive', '2019-03-19')
       ;

DELETE FROM Employees
LIMIT 3;


SELECT * from  Employees;

-- This table will track the projects assigned to each employee, including completion and deadline status.

CREATE TABLE Projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(255),
    employee_id INT,
    completion_date DATE,
    deadline DATE,
    status ENUM('Completed', 'In Progress', 'Pending'),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Add Projects:
INSERT INTO Projects (project_name, employee_id, completion_date, deadline, status)
VALUES ('Project A', 1, '2023-08-10', '2023-08-15', 'Completed'),
       ('Project B', 2, NULL, '2023-09-15', 'In Progress'),
       ('Project C', 3, '2023-09-01', '2023-09-05', 'Pending'),
       ('Project A', 4, NULL, '2023-09-15', 'In Progress'),
       ('Project B', 5, '2023-09-01', '2023-09-05', 'Pending'),
       ('Project C', 6, NULL, '2023-09-15', 'In Progress'),
       ('Project A', 7, '2023-09-01', '2023-09-05', 'Completed'),
       ('Project B', 8, '2023-08-10', '2023-08-15', 'Completed'),
       ('Project C', 9, NULL, '2023-09-15', 'In Progress'),
       ('Project A', 10, '2023-09-01', '2023-09-05', 'Pending'),
       ('Project B', 11, '2023-08-10', '2023-08-15', 'Completed'),
       ('Project C', 12, NULL, '2023-09-15', 'In Progress'),
       ('Project A', 13, '2023-09-01', '2023-09-05', 'Pending')
       ;

SELECT * FROM  projects;

-- This table will store attendance data for employees.

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    date DATE,
    status ENUM('Present', 'Absent', 'Leave'),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Add Attendance Records:
INSERT INTO Attendance (employee_id, date, status)
VALUES (1, '2023-09-20', 'Present'),
       (2, '2023-09-21', 'Absent'),
       (3, '2023-09-20', 'Present'),
       (4, '2023-09-21', 'Present'),
       (5, '2023-09-20', 'Present'),
       (6, '2023-09-21', 'Absent'),
       (7, '2023-09-20', 'Present'),
       (8, '2023-09-21', 'Present'),
       (9, '2023-09-20', 'Present'),
       (10, '2023-09-21', 'Absent'),
       (11, '2023-09-20', 'Present'),
       (12, '2023-09-21', 'Present'),
       (13, '2023-09-20', 'Present')
     ;

SELECT * FROM  Attendance;

-- This table will store performance reviews for employees.

CREATE TABLE Performance_Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    review_date DATE,
    review_score INT,
    comments TEXT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Add Performance Reviews:
INSERT INTO Performance_Reviews (employee_id, review_date, review_score, comments)
VALUES (1, '2023-09-15', 4, 'Great performance on Project'),
       (2, '2023-09-15', 5, 'Excellent leadership in Marketing'),
       (3, '2023-09-15', 3, 'Needs improvement in communication'),
       (4, '2023-09-15', 4, 'Great performance on Project'),
       (5, '2023-09-15', 5, 'Excellent leadership in Marketing'),
       (6, '2023-09-15', 3, 'Needs improvement in communication'),
       (7, '2023-09-15', 4, 'Great performance on Project'),
       (8, '2023-09-15', 5, 'Excellent leadership in Marketing'),
       (9, '2023-09-15', 3, 'Needs improvement in communication'),
       (10, '2023-09-15', 4, 'Great performance on Project'),
       (11, '2023-09-15', 5, 'Excellent leadership in Marketing'),
       (12, '2023-09-15', 3, 'Needs improvement in communication'),
       (13, '2023-09-15', 3, 'Needs improvement in communication')
       ;
SELECT * FROM Performance_Reviews;


-- This query will calculate how many projects each employee completed and how many were completed on time.

SELECT e.name, COUNT(p.project_id) AS total_projects,
SUM(CASE
	WHEN p.completion_date <= p.deadline THEN 1 ELSE 0 END) AS projects_completed_on_time
FROM Employees e
JOIN Projects p ON e.employee_id = p.employee_id
GROUP BY e.name;


-- This query will calculate the attendance percentage for each employee.

SELECT e.name, 
COUNT(CASE 
	WHEN a.status = 'Present' THEN 1 END) AS days_present, 
COUNT(a.date) AS total_days, 
(COUNT(CASE 
	WHEN a.status = 'Present' THEN 1 END) / COUNT(a.date)) * 100 AS attendance_percentage
FROM Employees e
JOIN Attendance a ON e.employee_id = a.employee_id
GROUP BY e.name;


-- Average Performance Review:
-- This query will calculate the average review score for each employee.

SELECT e.name, AVG(r.review_score) AS avg_review_score
FROM Employees e
JOIN Performance_Reviews r ON e.employee_id = r.employee_id
GROUP BY e.name;


SELECT e.department, 
COUNT(p.project_id) AS total_projects,
AVG(r.review_score) AS avg_department_review_score
FROM Employees e
JOIN Projects p ON e.employee_id = p.employee_id
JOIN Performance_Reviews r ON e.employee_id = r.employee_id
GROUP BY e.department;


-- query to list all employees who joined the company after January 1, 2020.

SELECT * FROM employees
WHERE join_date >= '2020-01-01'
ORDER BY join_date 
;

--  query to display the total number of projects assigned to each employee.
SELECT e.name, COUNT(project_id) AS TOTAL_Project 
FROM employees E
JOIN projects P ON E.employee_id = P.employee_id
GROUP BY e.name
;


-- Get the number of employees in each department:

SELECT department, COUNT(employee_id) AS total_emp
from employees
group by department
;

-- Find the names of employees who were absent on '2023-09-21':
SELECT e.name, a.date, a.status
From employees e
JOIN attendance a ON a.employee_id = e.employee_id
WHERE a.date = '2023-09-21' AND status = 'Absent'
;


-- Retrieve the total number of days each employee was present
SELECT e.name, a.status, count(*)
From employees e
JOIN attendance a ON a.employee_id = e.employee_id
WHERE status = 'Present'
group by e.name
;

-- List the employees who completed at least one project:

SELECT e.name 
FROM employees e
JOIN projects p ON p.employee_id = e.employee_id
WHERE status = 'Completed'
GROUP BY e.name
;

-- Find the employee with the highest average performance review score:
SELECT  e.name, AVG(r.review_score) AS avg_Score 
FROM employees e
JOIN Performance_Reviews AS r ON r.employee_id = e.employee_id
group by e.name
ORDER BY avg_Score DESC
limit 1
;
