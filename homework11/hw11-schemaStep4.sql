/*
 * Name: David Hanany
 * Date: 12/07/17
 * CPSC 321
 * HW #11
 * Description: Part 4 of the homework assignment
*/

-- to enforce various constraints
SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
   employee_id INT NOT NULL,
   salary INT,
   title VARCHAR(30) NOT NULL,
   PRIMARY KEY (employee_id)
) ENGINE = InnoDB;

CREATE INDEX emp_salary_ind ON Employee (salary);