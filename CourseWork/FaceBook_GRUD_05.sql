USE facebook;

/*
===============================================================================
	Скрипты характерных выборок (GRUD-операции)
===============================================================================
 */

/*
===============================================================================
	Агрегирующие функции (GROUP BY)
===============================================================================
 */ 

-- количество дней рождения, которые приходятся на каждый из дней недели 
-- учесть, что необходимы дни недели текущего года, а не года рождения
SELECT DAYNAME(concat(YEAR(curdate()), substr(birthday,5,6))) AS day_week, count(*) FROM profiles GROUP BY day_week;

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT concat(if(men_>all_/2, 'Мужчины', 'Женщины'),' поставили больше Лайков') AS ansver FROM 
(SELECT 
	(SELECT count(*) FROM likes WHERE 
		user_id IN (SELECT user_id FROM profiles WHERE gender = 'M')) AS men_,
	(SELECT count(*) FROM likes) AS all_) AS total;	

-- Подсчитать общее количество лайков десяти самым молодым пользователям 
-- (сколько лайков получили 10 самых молодых пользователей).
SELECT count(*) FROM 
	(SELECT * FROM likes WHERE table_name = 'users') AS ll
WHERE
	row_id IN (SELECT user_id FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) ttt);
	
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- CALL get_rating_user(10, @rating); 		
-- SELECT @rating;
CALL fill_ratings_all;		-- заполним временную таблицу рейтингов всех пользователей (ratings_tmp) 
SELECT id, u.first_name, u.last_name, r.rating 
	FROM users u, ratings_tmp r 
	WHERE u.id = r.user_id 	ORDER BY rating, first_name, last_name LIMIT 10;

/*
===============================================================================
	Сложные запросы (JOIN)
===============================================================================
 */ 

-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT concat(IF(p.gender='M','Мужчины','Женщины'),' поставили больше Лайков') AS answer, count(l.id) AS amount_likes 
	FROM likes l
	LEFT JOIN profiles p 
	ON l.user_id = p.user_id
	GROUP BY p.gender ORDER BY amount_likes DESC LIMIT 1;

-- Подсчитать общее количество лайков десяти самым молодым пользователям 
-- (сколько лайков получили 10 самых молодых пользователей).
SELECT count(l.id)
	FROM likes l
	RIGHT JOIN (SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10) p ON p.user_id = l.row_id
	WHERE l.table_name = 'users';

-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- SET @id = 95;
SELECT u.id, u.first_name, u.last_name,
	count(DISTINCT(v1.id)) * r1.ratio + 
	count(DISTINCT(v2.id)) * r2.ratio + 
	count(DISTINCT(v3.friend_id)) * r3.ratio + 
	count(DISTINCT(v4.user_id)) * r4.ratio + 
	count(DISTINCT(v5.id)) * r5.ratio +
	count(DISTINCT(v6.created_at)) * r6.ratio +
	count(DISTINCT(v7.id)) * r7.ratio 
		AS `rating` 
	FROM users u
	LEFT JOIN posts v1 ON v1.owner_id = u.id
	JOIN ratings r1 ON r1.table_name = 'posts'
	LEFT JOIN media v2 ON v2.user_id = u.id
	JOIN ratings r2 ON r2.table_name = 'media'
	LEFT JOIN friendship v3 ON v3.user_id = u.id
	JOIN ratings r3 ON r3.table_name = 'friendship' AND r3.table_col_name = 'user_id'
	LEFT JOIN friendship v4 ON v4.friend_id = u.id
	JOIN ratings r4 ON r4.table_name = 'friendship' AND r4.table_col_name = 'friend_id'
	LEFT JOIN communities v5 ON v5.owner_id = u.id
	JOIN ratings r5 ON r5.table_name = 'communities'
	LEFT JOIN communities_users v6 ON v6.user_id = u.id
	JOIN ratings r6 ON r6.table_name = 'communities_users'
	LEFT JOIN likes v7 ON v7.user_id = u.id
	JOIN ratings r7 ON r7.table_name = 'likes'
#	WHERE u.id = @id 
	GROUP BY u.id
	ORDER BY rating, first_name, last_name LIMIT 10;

-- Вывести все дни текущего месяца.
-- Если есть именинник - указать его ФИО
-- если именинников нет - фраза "именинников нет"

SELECT `date`, IF(p.created_at, concat(u.first_name, ' ', u.last_name), 'именинников нет') birthday_man 
 	FROM (
	SELECT CONCAT(SUBSTR(CURDATE(),1,8),'01') + INTERVAL seq.num DAY `date`
		FROM (
		    SELECT @n := 0 num  
		    UNION
		    SELECT @n := @n + 1 num
		    FROM users
		  	) seq
		WHERE seq.num BETWEEN 0 AND 
			datediff(ADDDATE(concat(substr(curdate(),1,8),'01'), INTERVAL + 1 MONTH), CONCAT(SUBSTR(CURDATE(),1,8),'01'))-1) all_date
  	LEFT JOIN profiles p ON concat(YEAR(curdate()), substr(birthday,5,6)) = all_date.date
  	LEFT JOIN users u ON u.id = p.user_id;

/*
===============================================================================
	Оконные функции

Запрос выводит следующие столбцы:
	•	имя группы;
	•	среднее количество пользователей в группах;
	•	самый молодой пользователь в группе;
	•	самый старший пользователь в группе;
	•	общее количество пользователей в группе;
	•	всего пользователей в системе;
	•	отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100.
===============================================================================
 */ 

SELECT DISTINCT c.name AS community,
	count(cu.user_id) OVER() / count_c.a AS average,
  	FIRST_VALUE(concat(u.first_name, ' ', u.last_name, ' (', p.birthday, ')')) OVER w AS youngest,
  	LAST_VALUE(concat(u.first_name, ' ', u.last_name, ' (', p.birthday, ')')) OVER (PARTITION BY c.id
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS oldest,
  	count(p.user_id) OVER (PARTITION BY c.id) AS total_by_group,
  	count_u.a AS total_users,
	count(p.user_id) OVER (PARTITION BY c.id) /	count_u.a * 100 AS "%%"
		FROM (communities_users cu 
        	JOIN profiles p ON p.user_id = cu.user_id 
        	JOIN users u ON u.id = p.user_id
        	RIGHT JOIN communities c ON cu.community_id = c.id 
        	JOIN (SELECT count(*) a FROM users) AS count_u
        	JOIN (SELECT count(*) a FROM communities) AS count_c
        	)
       	WINDOW w AS (PARTITION BY c.id ORDER BY p.birthday) 
	ORDER BY community;

/*
===============================================================================
	Транзакции

перенести "старые" данные из таблицы messages в предназначенную для архивных сообщений
таблицу messages_arh, оставив только 100 самых "свежих" строк с использованием транзакции.
===============================================================================
 */ 
-- посмотрим состояние таблиц до транзакции
SELECT count(*) FROM messages;
SELECT count(*) FROM messages_arh;

CALL messages_move_in_arh();		-- Процедура чистки таблицы messages

-- проверим состояние таблиц после транзакции
SELECT count(*) FROM messages;
SELECT count(*) FROM messages_arh;


/*
===============================================================================
	АДМИНИСТИРОВАНИЕ

Создадим нескольких пользователей и предоставим различные виды доступа к БД:
–	user1_read - доступны только запросы на чтение данных 
–	user2_all - любые операции в пределах базы данных
–	user3_read_view - нет доступа к таблице passwords, однако, может извлекать 
	записи из представления users_passwords_view.
===============================================================================
*/
-- создадим пользователей (для простоты, проверки, без паролей)
CREATE USER user1_read;
CREATE USER user2_all;
CREATE USER user3_read_view;
-- CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'qazwsx';
-- CREATE USER shop_read IDENTIFIED BY 'qazwsx'; 

-- Убедимся, что пользователи созданы
SELECT Host, User FROM mysql.user;

-- Предоставим пользователю - user1_read права на чтение из любой таблицы БД
GRANT SELECT ON facebook.* TO user1_read;
-- Проверим в терминале - все верно.
USE facebook;
SELECT * FROM users;
UPDATE users SET first_name = 'Наталья' WHERE id = 2; -- выдает ошибку доступа

-- Предоставим пользователю user2_all любые операции в пределах БД
GRANT ALL ON facebook.* TO user2_all;
-- Проверим в терминале - все верно.
USE facebook;
SELECT * FROM users;
UPDATE users SET first_name = 'Мария' WHERE id = 2;

-- Предоставим пользователю user3_read_view права на чтение из представления users_passwords_view
GRANT SELECT ON facebook.users_passwords_view TO user3_read_view;
-- Проверим в терминале - все верно.
USE facebook;
SELECT * FROM users_passwords_view;
SELECT * FROM passwords; 	-- выдает ошибку доступа

