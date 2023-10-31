DROP DATABASE IF EXISTS testingSql;
create database testingSql;
USE testingSql;

# CREATE TABLE employees (
#     employee_id INT PRIMARY KEY,
#     first_name VARCHAR(50),
#     last_name VARCHAR(50),
#     hire_date DATE,
#     salary DECIMAL(10, 2)
# );
#
# -- Inserting data for two employees
# INSERT INTO employees (employee_id, first_name, last_name, hire_date, salary)
# VALUES (1, 'John', 'Doe', '2023-01-15', 55000.00);
#
# INSERT INTO employees (employee_id, first_name, last_name, hire_date, salary)
# VALUES (2, 'Jane', 'Smith', '2023-02-20', 60000.00);
#
# -- Retrieve all employees
# SELECT * FROM employees;
#
# -- Retrieve employees with a specific condition (e.g., where salary is greater than 55000)
# SELECT * FROM employees
# WHERE salary > 55000;
#
# -- Update Jane Smith's salary
# UPDATE employees
# SET salary = 62000.00
# WHERE employee_id = 2;

create table Account
(
    id          INT,
    phone       varchar(15),
    gender      ENUM ('Male', 'Female', 'Other') NOT NULL,
    role        ENUM ('Admin', 'User', 'Other')  NOT NULL,
    firstName   varchar(255),
    lastName    varchar(255),
    password    varchar(255),
    email       varchar(255),
    address     varchar(255),
    avatar      mediumblob,
    status      boolean,
    createdDate date

);
-- Inserting sample data into the "Account" table
INSERT INTO Account (id, phone, gender, role, firstName, lastName, password, email, address, avatar, status)
VALUES (1, '123-456-7890', 'Male', 'Admin', 'John', 'Doe', 'mysecretpassword1', 'john.doe@email.com', '123 Main St',
        NULL, true),
       (2, '987-654-3210', 'Female', 'User', 'Jane', 'Smith', 'securepass123', 'jane.smith@email.com', '456 Elm St',
        NULL, true),
       (3, '555-123-7777', 'Other', 'User', 'Chris', 'Johnson', '1234password', 'chris.johnson@email.com', '789 Oak St',
        NULL, false);
