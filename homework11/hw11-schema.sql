/*
 * Name: Brandon Kelly
 * Date: 12/13/17
 * HW #11
 * Description: Employee table with three attributes
*/
SET sql_mode = STRICT_ALL_TABLES;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
   employee_id INT NOT NULL,
   salary INT,
   title VARCHAR(30) NOT NULL,
   PRIMARY KEY (employee_id)
) ENGINE = InnoDB;