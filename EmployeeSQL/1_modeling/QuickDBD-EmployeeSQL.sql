-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/gHsfjL
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- DB Schema for the EmployeeSQL project

-- Table for storing unique department names, with department number as primary key.
CREATE TABLE "departments" (
    -- Primary key. Always starts with 'd' and contains 3 digits afterwards.
    "dept_no" varchar(4)   NOT NULL,
    -- Unique department name
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
    ),
    CONSTRAINT "uc_departments_dept_name" UNIQUE (
        "dept_name"
    )
);

-- Table for storing to what department employees belong. One employee can belong to more than one department.
CREATE TABLE "dept_emp" (
    -- Part of the composite key. Employee number, from the employees table
    "emp_no" int(5)   NOT NULL,
    -- Part of the composite key. Department number, from the departments table
    "dept_no" varchar(4)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
    )
);

-- Table for storing the managers for each department. One employee can be manager of more than one department, and one department can have more than one manager.
CREATE TABLE "dept_manager" (
    -- Part of the composite key. Department number, from the departments table
    "dept_no" varchar(4)   NOT NULL,
    -- Part of the composite key. Employee number, from the employees table
    "emp_no" int(5)   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
    )
);

-- Table for storing the basic information of employees. Includes an employee number as primary key.
CREATE TABLE "employees" (
    -- Primary key. Five digit unique code to identify employees
    "emp_no" int(5)   NOT NULL,
    -- Title id from the titles table, corresponding to the employee's title
    "emp_title_id" varchar(5)   NOT NULL,
    -- Date of birth
    "birth_date" dateTime   NOT NULL,
    -- First name
    "first_name" varchar(200)   NOT NULL,
    -- Last name
    "last_name" varchar(200)   NOT NULL,
    -- Sex as a single character
    "sex" varchar(1)   NOT NULL,
    -- Date that the employee was hired
    "hire_date" dateTime   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
    )
);

-- Table for storing the salary of each employee
CREATE TABLE "salaries" (
    -- Primary key. Employee number from the employees table.
    "emp_no" int(5)   NOT NULL,
    -- The employee's salary
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
    )
);

-- Table for storing all job titles, includes a title id to uniquely identify each title
CREATE TABLE "titles" (
    -- Primary key. ID that identifies the job title, it starts with a lowercase letter followed by 4 digits
    "title_id" varchar(5)   NOT NULL,
    -- Unique name for the job title
    "title" varchar(50)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
    ),
    CONSTRAINT "uc_titles_title" UNIQUE (
        "title"
    )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
