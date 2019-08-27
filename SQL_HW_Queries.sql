-- creating tables
-- tables were created through query editor and then imported through the import function
-- tables display and run in PgAdmin4
CREATE TABLE dept_emp (
	emp_no     INT         NOT NULL,
    dept_no     VARCHAR(4)         NOT NULL,
    from_date   DATE     NOT NULL,
	to_date   DATE     NOT NULL
);

select * from dept_emp;

CREATE TABLE dept_manager (
	dept_no     VARCHAR(4)         NOT NULL,
	emp_no     INT         NOT NULL,
    from_date   DATE     NOT NULL,
	to_date   DATE     NOT NULL
);

select * from dept_manager;

CREATE TABLE employees (
	emp_no     INT         NOT NULL,
    birth_date   DATE     NOT NULL,
	first_name	VARCHAR(20)	NOT NULL,
	last_name	VARCHAR(20)	NOT NULL,
	gender	VARCHAR(4)	NOT NULL,
	hire_date   DATE     NOT NULL,
	PRIMARY KEY (emp_no)
);

select * from employees;

CREATE TABLE salaries (
	emp_no     INT         NOT NULL,
	salary	INT	NOT NULL,
    from_date   DATE     NOT NULL,
	to_date   DATE     NOT NULL
);

SELECT * FROM salaries;

CREATE TABLE titles (
	emp_no     INT         NOT NULL,
	title	VARCHAR(20)	NOT NULL,
    from_date   DATE     NOT NULL,
	to_date   DATE     NOT NULL
);

select * from titles;

-- end of create table statements

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
select employees.last_name, employees.first_name, employees.gender, salaries.salary
from employees join salaries on employees.emp_no = salaries.emp_no;

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
 SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;