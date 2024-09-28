# Write your MySQL query statement below
/*
use DENSE_RANK() function to give the same rank to the same  Salary 
*/
SELECT Department , name as Employee , salary as Salary 
FROM (
    SELECT  d.name AS Department, e.id, e.name, e.salary,
        DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salary_rank
    FROM Employee e
    JOIN Department d
    ON e.departmentId = d.id
) as NewTable
WHERE salary_rank <= 3;

/*

-- we can use also  Common Table Expression (CTE) 
WITH RankedSalaries AS (
    SELECT e.id, e.name, e.salary, d.name AS department_name,
           DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salary_rank
    FROM Employee e
    JOIN Department d
    ON e.departmentId = d.id
)
SELECT id, name, salary, department_name
FROM RankedSalaries
WHERE salary_rank <= 3;

*/