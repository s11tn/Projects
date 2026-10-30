create database users_adverts;

create table users
(
date date not null,
user_id varchar(100) not null,
view_adverts int not null
);

drop table users;

truncate table users;

select * from users;

#Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15.

select count(distinct user_id) as unique_users
from users
where date between '2023-11-07' and '2023-11-15';

#Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 

select user_id, sum(view_adverts) as total_views
from users
group by user_id
order by total_views desc
limit 1;


#Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, но учитывайте только дни с более чем 500 уникальными пользователями.

select date, sum(view_adverts)/count(distinct user_id) as avg_views_per_user
from users
group by date
having count(distinct user_id) > 500
order by avg_views_per_user desc
limit 1;



#Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. Отсортировать LT по убыванию.


select user_id, datediff(max(date), min(date)) + 1 as LT
from users
group by user_id
order by LT desc;



#Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.


select user_id, avg(view_adverts) as avg_views_per_day
from users
group by user_id
having count(distinct date) >= 5
order by avg_views_per_day desc;







