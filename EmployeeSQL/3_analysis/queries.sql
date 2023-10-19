-- Queries to answer data analysis questions:

-- 1. List the employee number, last name, first name, sex, and salary of each employee (2 points).
SELECT
    emp_no
    , last_name
    , first_name
    , sex
    , (
        SELECT salary
        FROM salaries s
        WHERE s.emp_no = e.emp_no
    ) AS salary
FROM employees e
;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986 (2 points).
-- How to get year from date in Postgresql: https://www.prisma.io/dataguide/postgresql/date-types
SELECT
    first_name
    , last_name
    , hire_date
FROM employees
WHERE DATE_PART('year', hire_date) = 1986
;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points).
SELECT
    d.dept_no
    , d.dept_name
    , e.emp_no
    , e.last_name
    , e.first_name
FROM dept_manager dm
INNER JOIN departments d
    ON d.dept_no = dm.dept_no
INNER JOIN employees e
    ON e.emp_no = dm.emp_no
;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points).
SELECT
    d.dept_no
    , e.emp_no
    , e.last_name
    , e.first_name
    , d.dept_name
FROM dept_emp AS de
INNER JOIN departments AS d
    ON d.dept_no = de.dept_no
INNER JOIN employees AS e
    ON e.emp_no = de.emp_no
;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points).
SELECT
    first_name
    , last_name
    , sex
FROM employees
WHERE first_name = 'Hercules'
    AND last_name LIKE 'B%'
;

-- 6. List each employee in the Sales department, including their employee number, last name, and first name (2 points).
SELECT
    emp_no
    , last_name
    , first_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_emp
    WHERE dept_no IN (
        SELECT dept_no
        FROM departments
        WHERE dept_name = 'Sales'
    )
)
;

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points).
SELECT
    e.emp_no
    , e.last_name
    , e.first_name
    , d.dept_name
FROM dept_emp AS de
INNER JOIN employees AS e
    ON e.emp_no = de.emp_no
INNER JOIN departments AS d
    ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'
    OR d.dept_name = 'Development'
;

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points).
SELECT
    last_name
    , COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC
;
