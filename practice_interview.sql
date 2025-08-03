CREATE TABLE Employee (
EmpID int NOT NULL,
EmpName Varchar,
Gender Char,
Salary int,
City Char(20) )

INSERT INTO Employee
VALUES (1, 'Arjun', 'M', 75000, 'Pune'),
(2, 'Ekadanta', 'M', 125000, 'Bangalore'),
(3, 'Lalita', 'F', 150000 , 'Mathura'),
(4, 'Madhav', 'M', 250000 , 'Delhi'),
(5, 'Visakha', 'F', 120000 , 'Mathura')


SELECT * FROM employee



CREATE TABLE  EmployeeDetail (
 EmpID int NOT NULL,
 Project Varchar,
 EmpPosition Char(20),
 DOJ date  )


INSERT INTO EmployeeDetail (EmpID, Project, EmpPosition, DOJ)
VALUES
  (1, 'P1', 'Executive', '2019-01-26'),
  (2, 'P2', 'Executive', '2020-05-04'),
  (3, 'P1', 'Lead',      '2021-10-21'),
  (4, 'P3', 'Manager',   '2019-11-29'),
  (5, 'P2', 'Manager',   '2020-08-01');

SELECT * FROM EmployeeDetail

Q1(a): Find the list of employees whose salary ranges between 2L to 3L

SELECT empname, salary FROM employee
WHERE salary > 200000 AND  salary < 300000

*******************************************************************************

Q1(b): Write a query to retrieve the list of employees from the same city

SELECT E1.empid, E1.empname, E1.city
FROM Employee E1, Employee E2
WHERE E1.empid != E2.empid AND E1.city = E2.city

***************************************************************************************


SELECT * FROM employee

Q2(a): Query to find the cumulative sum of employee’s salary.

SELECT empid, salary,  SUM (salary) OVER (Order BY empid) AS cumulativesum
FROM employee 

*****************************************************************************************

Q2(b): What’s the male and female employees ratio

SELECT 
(COUNT (*) FILTER (WHERE gender = 'M') * 100.0 / COUNT (*)) AS MaleRatio,
(COUNT (*) FILTER (WHERE gender = 'F') * 100.0 / COUNT (*)) AS FemaleRatio
FROM employee

*****************************************************************************************

Q2(c): Write a query to fetch 50% records from the Employee table.

SELECT * FROM employee
WHERE empid <= (SELECT(count(empid)/2) FROM Employee)

*******************************************************************************************

Q3: Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’  
i.e12345 will be 123XX

SELECT * FROM employee

SELECT empid, empname , salary
FROM employee

SELECT salary,
CONCAT(SUBSTRING(salary :: text,1,LENGTH(salary :: text)-2),'XX') AS masked_number
FROM employee


------OR------------

SELECT Salary, CONCAT(LEFT(CAST(Salary AS text), LENGTH(CAST(Salary AS text))-2), 'XX') 
AS masked_number
FROM Employee


*****************************************************************************************

Q4: Write a query to fetch even and odd rows from Employee table.

---Fetch Even rows

SELECT * FROM
	(SELECT *, ROW_NUMBER() OVER(ORDER BY empid) AS RowNumber FROM employee) AS Emp
WHERE Emp.Rownumber % 2 =0


---Fetch Odd rows
SELECT * FROM
	(SELECT *, ROW_NUMBER() OVER (ORDER BY empid) AS rownumber FROM employee) AS Emp
WHERE Emp.rownumber % 2 = 1

*************************************************************************************

Q5(a): Write a query to find all the Employee names whose name:
• Begin with ‘A’
• Contains ‘A’ alphabet at second place
• Contains ‘Y’ alphabet at second last place
• Ends with ‘L’ and contains 4 alphabets
• Begins with ‘V’ and ends with ‘A’


SELECT * FROM employee


SELECT * FROM employee WHERE empname LIKE 'A%';
SELECT * FROM employee WHERE empname LIKE '_a%';
SELECT * FROM employee WHERE empname LIKE '%y_';
SELECT * FROM employee WHERE empname LIKE '____l';
SELECT * FROM employee WHERE empname LIKE 'V%a';


***************************************************************************************



Q5(b): Write a query to find the list of Employee names which is:
• starting with vowels (a, e, i, o, or u), without duplicates
• ending with vowels (a, e, i, o, or u), without duplicates
• starting & ending with vowels (a, e, i, o, or u), without duplicates


SELECT DISTINCT empname FROM employee WHERE LOWER (empname) SIMILAR TO'[aeiou]%'
SELECT DISTINCT empname FROM employee WHERE LOWER (empname) SIMILAR TO '%[aeiou]'
SELECT DISTINCT empname FROM employee WHERE LOWER (empname) SIMILAR TO '[aeiou]%[aeiou]'




******************************************************************************************


Q6: Find Nth highest salary from employee table with and without using the
TOP/LIMIT keywords.


SELECT * FROM employee ------------------------------- just to see all the table values
SELECT salary FROM employee ORDER BY salary DESC ----- just to see salary in Descending order

-------------------------------------------

SELECT E1.salary FROM employee E1
--WHERE N-1---
WHERE 2-1 = (SELECT COUNT (DISTINCT (E2.salary)) FROM employee E2 WHERE E2.salary > E1.salary);

--------------------------------------------

--OR--


SELECT E1.salary FROM employee E1
WHERE 2 = (SELECT COUNT (DISTINCT (E2.salary)) FROM employee E2 WHERE E2.salary >= E1.salary);

-------------------------------------------------
--OR--

--Using LIMIT

SELECT salary FROM employee
ORDER BY salary  DESC
LIMIT 2 OFFSET 1  -------OFFET is use to skip the values from top


-------------------------------------------------


--OR--


SELECT TOP 1 Salary 
FROM Employee
 WHERE Salary < (
 SELECT MAX(Salary) FROM Employee)
 AND Salary NOT IN (
 SELECT TOP 2 Salary
 FROM Employee
 ORDER BY Salary DESC)
 ORDER BY Salary DESC;


 




******************************************************************************************************

SELECT * FROM employee

Q7(a): Write a query to find and remove duplicate records from a table.


SELECT empid, empname, gender, salary , city, 
COUNT (*) AS Dupicate_count FROM employee 
GROUP BY empid, empname, gender, salary , city 
HAVING COUNT(*) > 1;

--OR---

DELETE FROM employee WHERE empid IN 
(SELECT empid FROM employee
GROUP BY empid
HAVING COUNT (*)>1)

**************************************************************************************************


 Q7(b): Query to retrieve the list of employees working in same project.

SELECT * FROM employee

SELECT * FROM employeedetail


WITH CTE AS
	(SELECT e.empID, e.empname, ed.project
	FROM Employee AS e
	JOIN employeedetail AS ed
	ON e.empid = ed.empid)

SELECT c1.empname,c2.empname , c1.project
FROM CTE c1, CTE c2
WHERE c1.project = c2.project AND c1.empid != c2.empid AND c1.empid < c2.empid


Q8: Show the employee with the highest salary for each project












