create database mini_project;

create table t_tab1
(
id int unique,
goods_type varchar(100),
quantity int,
amount int,
seller_name varchar(100)
);

INSERT INTO t_tab1 (id, goods_type, quantity, amount, seller_name) VALUES
(1,  'MOBILE PHONE', 2, 400000, 'MIKE'),
(2,  'KEYBOARD',     1, 10000,  'MIKE'),
(3,  'MOBILE PHONE', 1, 50000,  'JANE'),
(4,  'MONITOR',      1, 110000, 'JOE'),
(5,  'MONITOR',      2, 80000,  'JANE'),
(6,  'MOBILE PHONE', 1, 130000, 'JOE'),
(7,  'MOBILE PHONE', 1, 60000,  'ANNA'),
(8,  'PRINTER',      1, 90000,  'ANNA'),
(9,  'KEYBOARD',     2, 10000,  'ANNA'),
(10, 'PRINTER',      1, 80000,  'MIKE');


create table t_tab2
(
id int unique,
name varchar(100),
salary int,
age int);

INSERT INTO t_tab2 (id, name, salary, age) VALUES
(1, 'ANNA', 110000, 27),
(2, 'JANE', 80000,  25),
(3, 'MIKE', 120000, 25),
(4, 'JOE',  70000,  24),
(5, 'RITA', 120000, 29);



select * from t_tab1;
select * from t_tab2;


#Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). Какое количество уникальных категорий товаров вернёт запрос? 4 категории

select distinct goods_type
from t_tab1;


#Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. Какое суммарное количество и суммарную стоимость вернул запрос?

select count(goods_type) as quantity, sum(amount) as amount
from t_tab1
where goods_type = 'MOBILE PHONE';

#Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. Какое кол-во сотрудников вернул запрос?

select name
from t_tab2
where salary > 100000;

#Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, а также минимальную и максимальную заработную плату.

select min(age) as min_age, max(age) as max_age, min(salary) as min_salary, max(salary) as max_salary
from t_tab2;

#Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.

select avg(quantity) as avg_quantity_keyboard
from t_tab1
where goods_type = 'KEYBOARD';


#Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.

select seller_name, sum(amount) as amount
from t_tab1
group by seller_name;

#Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, стоимость товара, заработную плату и возраст сотрудника MIKE.

select t1.seller_name, t1.goods_type, t1.quantity, t1.amount, t2.salary, t2.age
from t_tab1 t1
join t_tab2 t2 on t1.seller_name = t2.name
where t1.seller_name = 'MIKE';

#Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. Сколько таких сотрудников?

select name, age
from t_tab2
where name not in(
select distinct seller_name
from t_tab1);

#Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? Какое количество строк вернул запрос? 3 строки

select name, salary, age
from t_tab2
where age < 26;

#Сколько строк вернёт следующий запрос: 0 строк

SELECT * 
FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';


