--создадим схему
create schema win_func;
--создаем таблицу и наполняем её
create table win_func."salary" (
    "id" INT,
    "first_name" TEXT,
    "department" TEXT,
    "gross_salary" INT
);
insert into win_func."salary" values
    (1,'Kolya','Sales',100000),
    (2,'Ira','Marketing',100000),
    (3,'Nina','HR',150000),
    (4,'Arkadiy','IT',300000),
    (5,'Innokentiy','IT',100000),
    (6,'Kollbek','IT',133000),
    (7,'Nastya','HR',60000),
    (8,'Lena','IT',98000),
    (9,'Masha','IT',98000),
    (10,'Masha','Marketing',98000),
    (11,'Igor','Marketing',50000),
    (12,'Masha','Sales',98000),
    (13,'Mayya','Sales',20000);

--выбрать работников с самой высокой зарплатой
select s.id, s.first_name, s.department, max_s.gross_salary
from salary as s 
join (
	select s2.department, max(s2.gross_salary) as gross_salary 
	from salary as s2
	group by s2.department) as max_s using (gross_salary, department);

--выбрать всех работников компании с указанием самой высокой з/п по отделам
select 
	s.id, 
	s.first_name, 
	s.department, 
	s.gross_salary, 
	max(s.gross_salary) over(partition by s.department) as max_gross_salary
from salary as s;

--выбрать работников с самой высокой з/п по отделам
select max_s.id, max_s.first_name, max_s.department, max_s.max_gross_salary
from (
	select s.id, s.first_name, s.department, s.gross_salary, max(s.gross_salary)
		over(partition by s.department) as max_gross_salary
	from salary as s) as max_s
where max_s.gross_salary = max_s.max_gross_salary
order by max_s.id;

--показать пропорцию зарплат в отделе относительно суммы всех зарплат в этом отделе,
--а также относительно всего фонда оплаты труда
select 
	s1.id,
	s1.first_name,
	s1.department,
	s1.gross_salary,
	round((cast(s1.gross_salary as decimal(10, 2)) / cast(sum_salary.sum_gross_salary as decimal (10, 2))) * 100, 2) as dep_percent,
	round((cast(s1.gross_salary as decimal(10, 2)) / cast(sum_salary_foundation.salary_foundation as decimal (10, 2))) * 100, 2) as foundation_percent
from salary as s1
join (
	select 
		s2.department,
		sum(s2.gross_salary) as sum_gross_salary
	from salary as s2
	group by s2.department) as sum_salary on s1.department = sum_salary.department
cross join (
	select
		sum(s3.gross_salary) as salary_foundation 
	from salary as s3) as sum_salary_foundation
order by 4 desc;

--предыдущая задача в другом виде
with gross_salary_dep as (
	select 
		s.department,
		sum(s.gross_salary) as sum_gross_salary_dep
	from salary as s
	group by s.department)
select 
	s1.id,
	s1.first_name,
	s1.department,
	s1.gross_salary,
	round(((s1.gross_salary::numeric / gsd.sum_gross_salary_dep)) * 100, 2) as dep_percent,
	round(s1.gross_salary::numeric / (select sum(gross_salary) from salary) * 100, 2) as foundation_percent
from salary as s1
join
	gross_salary_dep as gsd using(department)
order by 4 desc;

--предыдущая задача через оконную функцию
select 
	s1.id,
	s1.first_name,
	s1.department,
	s1.gross_salary,
	round(((s1.gross_salary::numeric / sum(s1.gross_salary) over (partition by s1.department)) * 100), 2) as dep_percent,
	round(((s1.gross_salary::numeric / sum(s1.gross_salary) over()) * 100), 2) as foundation_percent
from salary as s1
order by 4 desc;

--найти имя сотрудника с самой высокой з/п в департаменте с помощью оконной функции
select
	s1.id,
	s1.department,
	s1.first_name,
	s1.gross_salary,
	first_value(s1.first_name) over(partition by s1.department order by s1.gross_salary desc) as max_salary
from salary as s1;

--аналогично, но с самой низкой зарплатой в департаменте
select
	s1.id,
	s1.department,
	s1.first_name,
	s1.gross_salary,
	last_value(s1.first_name) over(partition by s1.department order by s1.gross_salary desc rows between unbounded preceding and unbounded following) as lowest_salary
from salary as s1;


drop table win_func.salary;
drop schema win_func;

