/*
Курс: Основы реляционных баз данных. MySQL
Урок 8. Сложные запросы
Выполнил: Кузнецов Сергей (Факультет Geek University Python-разработки)

===============================================================================
Домашнее задание (все запросы на JOIN):
1.	Определить кто больше поставил лайков (всего) - мужчины или женщины?
2.	Подсчитать общее количество лайков десяти самым молодым пользователям 
	(сколько лайков получили 10 самых молодых пользователей).
3.	Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
	(критерии активности необходимо определить самостоятельно).
4.	Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
5.	Выведите список товаров products и разделов catalogs, который соответствует товару.
6.	(по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
	и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, 
	поле name — русское. Выведите список рейсов flights с русскими названиями городов.
===============================================================================
*/
/*
===============================================================================
1.	Определить кто больше поставил лайков (всего) - мужчины или женщины?
===============================================================================
*/
USE lesson_06;

-- "старый" Запрос с подзапросами
SELECT concat(if(men_>all_/2, 'Мужчины', 'Женщины'),' поставили больше Лайков') AS ansver FROM 
(SELECT 
	(SELECT count(*) FROM likes WHERE 
		user_id IN (SELECT user_id FROM profiles WHERE gender = 'M')) AS men_,
	(SELECT count(*) FROM likes) AS all_) AS total;	

-- Соединим две таблицы «likes» и «profiles» для получения тип поставившего Лайк
SELECT * FROM likes;
SELECT * FROM profiles;
SELECT p.gender FROM likes l
	LEFT JOIN profiles p 
	ON l.user_id = p.user_id;

-- Произведем группировку и получим количество Лайков по каждому из полов
SELECT p.gender, count(l.id) AS amount_likes FROM likes l
	LEFT JOIN profiles p 
	ON l.user_id = p.user_id
	GROUP BY p.gender;

SELECT concat(IF(p.gender='M','Мужчины','Женщины'),' поставили больше Лайков') AS answer, count(l.id) AS amount_likes 
	FROM likes l
	LEFT JOIN profiles p 
	ON l.user_id = p.user_id
	GROUP BY p.gender ORDER BY amount_likes DESC LIMIT 1;

/*
===============================================================================
 2.	Подсчитать общее количество лайков десяти самым молодым пользователям 
	(сколько лайков получили 10 самых молодых пользователей).
===============================================================================
*/

-- "старый" Запрос с подзапросами
SELECT count(*) FROM 
(SELECT * FROM likes WHERE 
	target_type_id = (SELECT id FROM target_types WHERE name = 'users')) AS ll
WHERE
	target_id IN (SELECT user_id FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) ttt);

-- Выберем 10 самых молодых
SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;

-- добавим объединение с likes и target_types (порядок имеет значение)
-- Сначала соберем все лайки для таблицы "users", потом уже объединим с profiles
-- по правилу "взять все что есть справа" в profiles и дополнить Лайками, если есть
SELECT p.user_id , count(l.id)
	FROM likes l
	INNER JOIN target_types t ON l.target_type_id = t.id and t.name = 'users'
	RIGHT JOIN profiles p ON p.user_id = l.target_id
	GROUP BY p.user_id 
	ORDER BY p.birthday DESC LIMIT 10;

-- напрашивается простое решение с одним подзапросом	
SELECT count(l.id)
	FROM likes l
	INNER JOIN target_types t ON l.target_type_id = t.id and t.name = 'users'
	RIGHT JOIN (SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10) p ON p.user_id = l.target_id;

/* мысли про номера строк в запросе
SET @num_row = 0;
SELECT user_id, @num_row:=@num_row+1 AS num_row FROM profiles ORDER BY birthday ;

SELECT user_id, ROW_NUMBER() OVER w AS row_num 
	FROM profiles p WINDOW w AS (ORDER BY p.birthday DESC);
*/

/*
===============================================================================
3.	Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
	(критерии активности необходимо определить самостоятельно).
===============================================================================
*/
-- "старый" Запрос с подзапросами
SELECT u.id, u.first_name, u.last_name, 
	(SELECT count(*) FROM posts WHERE user_id = u.id) *
	(SELECT ratio FROM ratings WHERE table_name = 'posts') + 
	(SELECT count(*) FROM media WHERE user_id = u.id) *
	(SELECT ratio FROM ratings WHERE table_name = 'media') + 
	(SELECT count(*) FROM friendship WHERE user_id = u.id) *
	(SELECT ratio FROM ratings WHERE table_name = 'friendship' AND table_col_name = 'user_id') + 
	(SELECT count(*) FROM friendship WHERE friend_id = u.id) *
	(SELECT ratio FROM ratings WHERE table_name = 'friendship' AND table_col_name = 'friend_id') + 
	(SELECT count(*) FROM communities WHERE owner_id = u.id) *
	(SELECT ratio FROM ratings WHERE table_name = 'communities') + 
	(SELECT count(*) FROM communities_users WHERE user_id = u.id) *
	(SELECT ratio FROM ratings WHERE table_name = 'communities_users') + 
	(SELECT count(*) FROM likes WHERE user_id = u.id) *
	(SELECT ratio FROM ratings WHERE table_name = 'likes') 
	AS rating
FROM users u ORDER BY rating, first_name, last_name LIMIT 10;

-- избавляемся от подзапросов
SELECT u.id, u.first_name, u.last_name, 
	count(v1.user_id)*r1.ratio + 
	count(v2.user_id)*r2.ratio + 
	count(v3.user_id)*r3.ratio + 
	count(v4.user_id)*r4.ratio + 
	count(v5.owner_id)*r5.ratio + 
	count(v6.user_id)*r6.ratio + 
	count(v7.user_id)*r7.ratio 
		AS `rating` 
	FROM users u
	LEFT JOIN posts v1 ON v1.user_id = u.id
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
	GROUP BY u.id
	ORDER BY rating, first_name, last_name LIMIT 10;


/*
===============================================================================
4.	Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
===============================================================================
*/

CREATE DATABASE lesson_08;

-- через консоль прогружаем дамп «mysql lesson_07 < shop.sql»

USE lesson_08;
-- Смотрим диаграмму отношений в DBeaver (ERDiagram)

SELECT * FROM users;
SELECT * FROM orders; 	-- нет данных
-- скопируем таблицу "orders" из lesson_07
-- DROP TABLE IF EXISTS orders;
-- CREATE TABLE orders AS SELECT * FROM lesson_07.orders;
INSERT INTO orders SELECT * FROM lesson_07.orders;
SELECT * FROM orders; 	-- все ок

SELECT DISTINCT u.name, count(o.created_at) AS amount_orders FROM users u INNER JOIN orders o ON u.id=o.user_id GROUP BY u.id ORDER BY amount_orders DESC;

/*
===============================================================================
5.	Выведите список товаров products и разделов catalogs, который соответствует товару.
===============================================================================
*/

SELECT * FROM products;
SELECT * FROM catalogs;

SELECT p.name 'товар', c.name 'раздел' FROM products p INNER JOIN catalogs c ON catalog_id=c.id;
SELECT name 'товар', (SELECT name FROM catalogs c WHERE c.id=catalog_id) 'раздел' FROM products;
SELECT p.name 'товар', c.name 'раздел' FROM products p, catalogs c WHERE catalog_id=c.id;

/*
===============================================================================
6.	(по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
	и таблица городов cities (label, name). 
	Поля from, to и label содержат английские названия городов, поле name — русское. 
	Выведите список рейсов flights с русскими названиями городов
===============================================================================
*/

-- Создаем и заполняем таблицы

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(50) COMMENT 'Откуда',
  `to` VARCHAR(50) COMMENT 'Куда'
) COMMENT = 'Таблица рейсов';

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(50) COMMENT 'Английское название',
  name VARCHAR(50) COMMENT 'Русское название'
) COMMENT = 'Таблица городов';

INSERT INTO flights 
  (`from`, `to`)
VALUES
  ('Chita','Alexandrov'),
  ('Moscow','Saint-Petersburg'),
  ('Achinsk','Chita'),
  ('Novosibirsk','Sochi'),
  ('Alexandrov','Moscow'),
  ('Saint-Petersburg','Novosibirsk'),
  ('Chita','Sochi'),
  ('Achinsk','Saint-Petersburg'),
  ('Novosibirsk','Alexandrov'),
  ('Moscow','Magadan'),
  ('Saint-Petersburg','Sochi'),
  ('Kozulka','Sochi'),
  ('Saint-Petersburg','Muhosransk');

INSERT INTO cities 
  (label, name)
VALUES
  ('Alexandrov','Александров'),
  ('Krasnoyarsk','Красноярск'),
  ('Moscow','Москва'),
  ('Saint-Petersburg','Санкт-Петербург'),
  ('Achinsk','Ачинск'),
  ('Novosibirsk','Новосибирск'),
  ('Sochi','Сочи'),
  ('Magadan','Магадан'),
  ('Chita','Чита');
 
SELECT * FROM flights;
SELECT * FROM cities;

SELECT f.`from`, c_from.name, f.`to`, c_to.name FROM flights f 
	LEFT JOIN cities c_from ON f.`from` = c_from.label 
	LEFT JOIN cities c_to ON f.`to` = c_to.label; 
 
SELECT IF(NOT c_from.name, c_from.name, f.`from`) `from`, IF(NOT c_to.name, c_to.name,f.`to`) `to` FROM flights f 
	LEFT JOIN cities c_from ON f.`from` = c_from.label 
	LEFT JOIN cities c_to ON f.`to` = c_to.label; 
