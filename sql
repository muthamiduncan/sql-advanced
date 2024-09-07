# CTE common table expressions

-- Using 2 CTEs, show employees who were born past 1985 and salary is more than 50k

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

WITH qn_cte AS
(
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
),
qn_cte2 AS
(
SELECT first_name, last_name, employee_id
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM qn_cte
JOIN qn_cte2
	ON qn_cte.employee_id = qn_cte2.employee_id
;


# Temp Tables

CREATE TEMPORARY TABLE salo_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salo_over_50k;


# Stored Procedure

DELIMITER $$
CREATE PROCEDURE large_salaries(employee_id_param INT)
BEGIN
	SELECT salary
    FROM employee_salary
    WHERE employee_id = employee_id_param;
END $$
DELIMITER ;

CALL large_salaries(1);


# Triggers

DELIMITER $$
CREATE TRIGGER new_employees
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics 
    ( employee_id, first_name, last_name ) 
    VALUES (
    NEW.employee_id, NEW.first_name, NEW.last_name
    );
END $$
DELIMITER ;


# Events

DELIMITER $$
CREATE EVENT retired
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 55;
END $$
DELIMITER ;















