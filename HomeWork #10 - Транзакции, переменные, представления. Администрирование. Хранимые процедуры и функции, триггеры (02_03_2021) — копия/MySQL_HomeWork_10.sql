/*
Курс: Основы реляционных баз данных. MySQL
Урок 10. Транзакции, переменные, представления. Администрирование. Хранимые процедуры и функции, триггеры
Выполнил: Кузнецов Сергей (Факультет Geek University Python-разработки)

===============================================================================
Домашнее задание:
1.	Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения 
	и добавить необходимые индексы.
2.	Задание на оконные функции. Построить запрос, который будет выводить следующие столбцы:
	•	имя группы;
	•	среднее количество пользователей в группах;
	•	самый молодой пользователь в группе;
	•	самый старший пользователь в группе;
	•	общее количество пользователей в группе;
	•	всего пользователей в системе;
	•	отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100.
===============================================================================
*/
/*
===============================================================================
1.	Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения 
	и добавить необходимые индексы.
===============================================================================
*/
USE lesson_06;

/*
Перечень дорполнительных индексов
–	users (last_name, first_name) – поиск человека
–	posts (head)  - просмотр/поиск постов по заголовкам
–	profiles (birthday) – частая опция поиска
–	profiles (city) – частая опция поиска
*/

CREATE INDEX users_last_name_first_name_idx ON users(last_name, first_name);
CREATE INDEX posts_head_idx ON posts(head);
CREATE INDEX profiles_birthday_idx ON profiles(birthday);
CREATE INDEX profiles_city_idx ON profiles(city);


SHOW INDEX FROM users;
SHOW INDEX FROM posts;
SHOW INDEX FROM profiles;

/*
===============================================================================
2.	Задание на оконные функции. Построить запрос, который будет выводить следующие столбцы:
	•	имя группы;
	•	среднее количество пользователей в группах;
	•	самый молодой пользователь в группе;
	•	самый старший пользователь в группе;
	•	общее количество пользователей в группе;
	•	всего пользователей в системе;
	•	отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100.
===============================================================================
*/

SELECT * FROM communities;
SELECT * FROM communities_users;
-- Добавим строку в «communities_users» для наглядности (чтобы количество членов в группе не ровнялось %%)
INSERT INTO communities_users (community_id, user_id) value (20, 77);
DELETE FROM communities_users WHERE community_id =20 AND user_id =77;

SELECT c.name AS community,
	(SELECT count(*) FROM communities_users) / (SELECT count(*) FROM communities) AS averange,
	min(p.birthday) AS youngest,
	max(p.birthday) AS oldest,
	count(p.user_id) AS total_by_group,
	(SELECT count(*) FROM communities_users) AS total,
	count(p.user_id) / (SELECT count(*) FROM communities_users) * 100 AS "%%"
	FROM communities c
	LEFT JOIN communities_users cu ON cu.community_id = c.id 
	JOIN profiles p ON p.user_id = cu.user_id
	GROUP BY c.id 
	ORDER BY c.name ; 

SELECT DISTINCT c.name AS community,
	count(cu.user_id) OVER() / (SELECT count(*) FROM communities) AS average,
  	FIRST_VALUE(concat(u.first_name, ' ', u.last_name, ' (', p.birthday, ')')) OVER w AS youngest,
  	LAST_VALUE(concat(u.first_name, ' ', u.last_name, ' (', p.birthday, ')')) OVER (PARTITION BY c.id
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS oldest,
  	count(p.user_id) OVER (PARTITION BY c.id) AS total_by_group,
  	count(c.id) OVER() AS total,
	count(p.user_id) OVER (PARTITION BY c.id) /	count(c.id) OVER() * 100 AS "%%"
  		FROM (communities c
    		LEFT JOIN communities_users cu ON cu.community_id = c.id
        	JOIN profiles p ON p.user_id = cu.user_id 
        	JOIN users u ON u.id = p.user_id 
        	)
       	WINDOW w AS (PARTITION BY c.id ORDER BY c.id, p.birthday) 
	ORDER BY community;

-- проверка
SELECT * FROM communities WHERE name = 'quas';
SELECT u.first_name , u.last_name , p.birthday  FROM communities_users  cu
	JOIN profiles p ON p.user_id = cu.user_id 
	JOIN users u ON u.id = p.user_id 
	WHERE community_id =15 ORDER BY birthday;

        