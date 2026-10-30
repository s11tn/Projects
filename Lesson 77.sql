#1. Создать процедуру, в которой мы получаем на вход два параметра p_salary, p_dept и на выходе получим
# Список сотрудников (emp_no, first_name, gender), у которых средняя зарплата больше p_salary и которые когда-то работали в департаменте p_dept.

#2. Создать функцию, которая получает на вход f_name и выдает максимальную зарплату среди сотрудников с именем f_name.




#Следующие запросы относятся к базе данных World (скачайте ее ниже, и запустите все запросы, как мы делали с employees):
#1. Посчитайте количество городов в каждой стране, где IndepYear = 1991 (Independence Year).

#2. Узнайте, какая численность населения и средняя продолжительность жизни людей в Аргентине (ARG).

#3. В какой стране самая высокая продолжительность жизни?

#4. Перечислите все языки, на которых говорят в регионе «Southeast Asia».

#5. Посчитайте сумму SurfaceArea для каждого континента.












#1. Создать процедуру, в которой мы получаем на вход два параметра p_salary, p_dept и на выходе получим
# Список сотрудников (emp_no, first_name, gender), у которых средняя зарплата больше p_salary и которые когда-то работали в департаменте p_dept.

delimiter //

create procedure employees_avg_salary (in p_salary decimal (10,2), in p_dept varchar(10))
begin
	select distinct
    e.emp_no,
    e.first_name,
    e.gender
from employees e
join (select emp_no, avg(salary) as avg_salary
from salaries
group by emp_no
having avg(salary)>p_salary) s on e.emp_no = s.emp_no
join dept_emp de on e.emp_no = de.emp_no
where de.dept_no = p_dept;
end //

delimiter ;

call employees_avg_salary (6000, 'd005');

drop procedure employees_avg_salary;


#2. Создать функцию, которая получает на вход f_name и выдает максимальную зарплату среди сотрудников с именем f_name.


delimiter //

create function f_max_salary (f_name varchar(100)) returns decimal (10,2)
deterministic reads sql data
begin
	declare max_salary decimal (10,2);
    select max(salary) into max_salary
    from salaries s
    join employees e on s.emp_no = e.emp_no
    where e.first_name = f_name;
    return max_salary;
    end//
    
delimiter ;

select f_max_salary ('Georgi');

drop function f_max_salary;





#Следующие запросы относятся к базе данных World (скачайте ее ниже, и запустите все запросы, как мы делали с employees):
#1. Посчитайте количество городов в каждой стране, где IndepYear = 1991 (Independence Year).

select c.Name as country, count(c.id) as city_quantity
from country c
join city ci on c.Code= ci.CountryCode
where c.IndepYear = 1991
group by c.Code, c.Name;




#2. Узнайте, какая численность населения и средняя продолжительность жизни людей в Аргентине (ARG).


select population, lifeexpectancy
from country
where name = 'Argentina';

#3. В какой стране самая высокая продолжительность жизни?


SELECT Name, LifeExpectancy
FROM country
ORDER BY LifeExpectancy DESC
LIMIT 1;


#4. Перечислите все языки, на которых говорят в регионе «Southeast Asia».


SELECT DISTINCT cl.Language
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
WHERE c.Region = 'Southeast Asia';


#5. Посчитайте сумму SurfaceArea для каждого континента.


SELECT Continent, SUM(SurfaceArea)
FROM country
GROUP BY Continent;













