# NOTE :- In this context, it's important to note that the table names used in the examples include underscores and numbers, 
# which differ from the naming conventions used in the LeetCode problem.

Create table If Not Exists SalesPerson_13
(
sales_id int, 
name varchar(255), 
salary int, 
commission_rate int, 
hire_date date
);

Create table If Not Exists Company_13
(
com_id int, 
name varchar(255), 
city varchar(255)
);

Create table If Not Exists Orders_13
(
order_id int, 
order_date date, 
com_id int, 
sales_id int, 
amount int
);

Truncate table SalesPerson_13;

insert into SalesPerson_13 (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', 100000, 6, '2006-04-01');
insert into SalesPerson_13 (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '2010-5-1');
insert into SalesPerson_13 (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '2008-12-25');
insert into SalesPerson_13 (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '2005-1-1');
insert into SalesPerson_13 (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2007-2-3');

Truncate table Company_13;

insert into Company_13 (com_id, name, city) values ('1', 'RED', 'Boston');
insert into Company_13 (com_id, name, city) values ('2', 'ORANGE', 'New York');
insert into Company_13 (com_id, name, city) values ('3', 'YELLOW', 'Boston');
insert into Company_13 (com_id, name, city) values ('4', 'GREEN', 'Austin');

Truncate table Orders_13;

insert into Orders_13 (order_id, order_date, com_id, sales_id, amount) values ('1', '2014-1-1', '3', '4', '10000');
insert into Orders_13 (order_id, order_date, com_id, sales_id, amount) values ('2', '2014-2-1', '4', '5', '5000');
insert into Orders_13 (order_id, order_date, com_id, sales_id, amount) values ('3', '2014-3-1', '1', '1', '50000');
insert into Orders_13 (order_id, order_date, com_id, sales_id, amount) values ('4', '2014-4-1', '1', '4', '25000');

/*
Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".
Return the result table in any order.
The query result format is in the following example.

Example 1:

Input: 
SalesPerson table:
+----------+------+--------+-----------------+------------+
| sales_id | name | salary | commission_rate | hire_date  |
+----------+------+--------+-----------------+------------+
| 1        | John | 100000 | 6               | 4/1/2006   |
| 2        | Amy  | 12000  | 5               | 5/1/2010   |
| 3        | Mark | 65000  | 12              | 12/25/2008 |
| 4        | Pam  | 25000  | 25              | 1/1/2005   |
| 5        | Alex | 5000   | 10              | 2/3/2007   |
+----------+------+--------+-----------------+------------+
Company table:
+--------+--------+----------+
| com_id | name   | city     |
+--------+--------+----------+
| 1      | RED    | Boston   |
| 2      | ORANGE | New York |
| 3      | YELLOW | Boston   |
| 4      | GREEN  | Austin   |
+--------+--------+----------+
Orders table:
+----------+------------+--------+----------+--------+
| order_id | order_date | com_id | sales_id | amount |
+----------+------------+--------+----------+--------+
| 1        | 1/1/2014   | 3      | 4        | 10000  |
| 2        | 2/1/2014   | 4      | 5        | 5000   |
| 3        | 3/1/2014   | 1      | 1        | 50000  |
| 4        | 4/1/2014   | 1      | 4        | 25000  |
+----------+------------+--------+----------+--------+
Output: 
+------+
| name |
+------+
| Amy  |
| Mark |
| Alex |
+------+
Explanation: 
According to orders 3 and 4 in the Orders table, it is easy to tell that only salesperson John and Pam have sales to company RED, 
so we report all the other names in the table salesperson.
*/

SELECT * FROM SalesPerson_13;
SELECT * FROM Company_13;
SELECT * FROM Orders_13;

# TYPE 1 :- 
SELECT s.name
FROM SalesPerson_13 s
WHERE s.name 
NOT IN (SELECT s.name
FROM SalesPerson_13 AS s
LEFT JOIN Orders_13 AS o
ON s.sales_id = o.sales_id
LEFT JOIN Company_13 AS c
ON o.com_id = c.com_id
WHERE c.name="RED");

# TYPE 2 :- 
SELECT name
FROM SalesPerson_13
WHERE sales_id NOT IN
(SELECT sales_id FROM Orders_13 WHERE com_id = 
(SELECT com_id FROM Company_13 WHERE name = 'RED'));

