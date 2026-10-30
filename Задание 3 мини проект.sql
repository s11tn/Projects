select * from audio_cards;

select * from audiobooks;

select * from listenings;

#Выведите сколько пользователей добавили книгу 'Coraline', 
#сколько пользователей прослушало больше 10%. 

select count(distinct ac.user_id) as users_added
from audio_cards ac
join audiobooks a
on ac.audiobook_uuid = a.uuid
where a.title = 'Coraline';


select count(distinct l.user_id) as users_listened
from listenings l
join audiobooks a on l.audiobook_uuid = a.uuid
where a.title = 'Coraline'
and (l.position_to - l.position_from)>a.duration * 0.10;



select
(select count(distinct ac.user_id)
from audio_cards ac
join audiobooks a
on ac.audiobook_uuid = a.uuid
where a.title = 'Coraline') as users_added,

(select count(distinct l.user_id)
from listenings l
join audiobooks a on l.audiobook_uuid = a.uuid
where a.title = 'Coraline'
and (l.position_to - l.position_from)>a.duration * 0.10) as users_listened;


#первые два запроса по отдельности, второй объединенный через вложеннные запросы





#По каждой операционной системе и названию книги выведите количество пользователей, 
#сумму прослушивания в часах, не учитывая тестовые прослушивания. 

select l.os_name, a.title, count(distinct l.user_id) as users, sum(l.position_to - l.position_from)/3600 as listening_hours
from listenings l
join audiobooks a on l.audiobook_uuid = a.uuid
where l.is_test = 0
group by l.os_name,a.title;






#Найдите книгу, которую слушает больше всего людей. 

select a.title, count(distinct l.user_id) as users_quantity
from listenings l
join audiobooks a on l.audiobook_uuid = a.uuid
group by a.title
order by users_quantity desc
limit 1
;





#Найдите книгу, которую чаще всего дослушивают до конца.

select a.title, count(*) as finished_quantity
from listenings l
join audiobooks a on l.audiobook_uuid = a.uuid
where l.position_to>=a.duration
group by a.title
order by finished_quantity desc
limit 1
;






