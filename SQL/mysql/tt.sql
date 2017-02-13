select * from mysql.departments;
select * from  mysql.employees;
select lastname from mysql.employees;
select distinct lastname from mysql.employees;
select * from mysql.employees where lastname = "Smith";
select * from mysql.employees where lastname = "Smith" or lastname = "Doe";
select * from mysql.employees where lastname in ("Smith","Doe");
select * from mysql.employees where department = 14;
select * from mysql.employees where department in (37,77);
select * from mysql.employees where lastname like "S%";
select sum(budget) from mysql.departments;
select count(1),department from mysql.employees group by department;
SELECT SSN, E.Name AS Name_E, LastName, D.Name AS Name_D, Department, Code, Budget
 FROM Employees E INNER JOIN Departments D
 ON E.Department = D.Code;
select e.name,e.lastname,d.Name,d.budget from mysql.employees e inner join mysql.departments d on e.Department=d.Code;
select e.name,e.lastname from mysql.employees e  inner join mysql.departments d on e.Department=d.Code where d.budget >60000;
SELECT Employees.Name, LastName
  FROM Employees INNER JOIN Departments
  ON Employees.Department = Departments.Code
    AND Departments.Budget > 60000;
select * from departments where budget > (select avg(budget) from departments );
select d.name from mysql.departments d inner join mysql.employees e on d.Code = e.Department group by e.department having count(d.name)>2;
SELECT e.name, e.lastname FROM employees e WHERE e.department =
        ( SELECT sub.code FROM (SELECT * FROM departments d ORDER BY d.budget LIMIT 2) sub ORDER BY budget DESC LIMIT 1);
select e.name,e.lastname from employees e where e.department =
        (select d.code from departments d order by d.budget limit 1 offset 1);
insert into departments(name,budget,code) values("Quality Assurance",40000,11);
insert into employees(name,lastname,ssn,department) values("Mary","Moore",847-21-9811,11);
update employees set SSN="847219811" where name = "Mary";
update departments set budget=budget*0.9;
update employees set department=14 where department=77;
delete from employees where department=14;
delete from employees where department in (select code from departments group by code having avg(budget)>=60000);
select code from departments group by code having avg(budget)>=60000;
delete from mysql.employees;
DELETE FROM Employees;
DELETE FROM departments;
