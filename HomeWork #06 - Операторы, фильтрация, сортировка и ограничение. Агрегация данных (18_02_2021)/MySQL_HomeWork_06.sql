/*
Курс: Основы реляционных баз данных. MySQL
Урок 6. Операторы, фильтрация, сортировка и ограничение. Агрегация данных
Выполнил: Кузнецов Сергей (Факультет Geek University Python-разработки)

Домашнее задание:
===============================================================================
Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:
1.	Создать и заполнить таблицы лайков и постов.
2.	Создать все необходимые внешние ключи и диаграмму отношений.
3.	Определить кто больше поставил лайков (всего) - мужчины или женщины?
4.	Подсчитать общее количество лайков десяти самым молодым пользователям 
	(сколько лайков получили 10 самых молодых пользователей).
5.	Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
	(критерии активности необходимо определить самостоятельно).
===============================================================================
*/

/*
===============================================================================
1.	Создать и заполнить таблицы лайков и постов.
===============================================================================
*/

CREATE DATABASE lesson_06;
-- через консоль прогружаем дамп «mysql lesson_06 < vk1.20210219.dump.sql»
USE lesson_06;
-- Смотрим диаграмму отношений в DBeaver (ERDiagram)


-- Таблица лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

-- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;

-- Проверим
SELECT * FROM likes LIMIT 10;

-- Создадим таблицу постов
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Заполним при помощи http://filldb.info/ (см. файл fulldb21-02-2021 09-48.sql)

/*
===============================================================================
2.	Создать все необходимые внешние ключи и диаграмму отношений.
===============================================================================
*/
-- генерим внешние ключи

-- таблица ПРОФИЛИ
-- Смотрим структуру таблицы
DESC profiles;
-- удалим ключ, если создан ранее
ALTER TABLE profiles DROP FOREIGN KEY profiles_user_id_fk;
-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

-- таблица СООБЩЕНИЯ
DESC messages;
ALTER TABLE messages DROP FOREIGN KEY messages_from_user_id_fk;
ALTER TABLE messages DROP FOREIGN KEY messages_to_user_id_fk;
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);

-- таблица Группы
DESC communities;
ALTER TABLE communities 
  ADD CONSTRAINT communities_owner_id_fk 
    FOREIGN KEY (owner_id) REFERENCES users(id);   
   
-- таблица Участники групп
DESC communities_users;
ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
-- Таблица дружбы
DESC friendship;
ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_status_id_fk 
    FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses(id);
   
-- Таблица Лайков
DESC likes;
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);
   
-- Таблица Медиафайлы
DESC media;
ALTER TABLE media 
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id);
   
-- Таблица ПОСТЫ
DESC posts;
ALTER TABLE posts 
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT posts_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id);

-- Для получения списка всех сформированных ключей 
SELECT * FROM information_schema.KEY_COLUMN_USAGE 
	WHERE TABLE_SCHEMA ='lesson_06'AND CONSTRAINT_NAME <>'PRIMARY' AND REFERENCED_TABLE_NAME is not null;

-- Смотрим диаграмму отношений в DBeaver (ERDiagram)

/*
===============================================================================
3.	Определить кто больше поставил лайков (всего) - мужчины или женщины?
===============================================================================
*/
-- список ИД пользователей мужского пола
SELECT user_id FROM profiles WHERE gender = 'M';

-- общее количество Лайков
SELECT count(*) FROM likes;

-- Лайков от мужчин
SELECT count(*) FROM likes WHERE 
	user_id IN (SELECT user_id FROM profiles WHERE gender = 'M');

-- Лайков от мужчин и всех
SELECT 
	(SELECT count(*) FROM likes WHERE 
		user_id IN (SELECT user_id FROM profiles WHERE gender = 'M')) AS men_,
	(SELECT count(*) FROM likes) AS all_;	

-- выводим, кто больше через IF
SELECT concat(if(10>20, 'Мужчины', 'Женщины'),' поставили больше Лайков') AS ansver;

SELECT concat(if(men_>all_/2, 'Мужчины', 'Женщины'),' поставили больше Лайков') AS ansver FROM 
(SELECT 
	(SELECT count(*) FROM likes WHERE 
		user_id IN (SELECT user_id FROM profiles WHERE gender = 'M')) AS men_,
	(SELECT count(*) FROM likes) AS all_) AS total;	

/*
===============================================================================
4.	Подсчитать общее количество лайков десяти самым молодым пользователям 
(сколько лайков получили 10 самых молодых пользователей).
===============================================================================
*/

-- список 10-ти ИД самых молодых пользователей 
SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;

-- ИД типа Лайков для таблицы users 
SELECT id FROM target_types WHERE name = 'users';

-- Лайки для таблицы users
SELECT * FROM likes WHERE 
	target_type_id = (SELECT id FROM target_types WHERE name = 'users'); 

-- Лайки, поставленные 10-ти самых молодых пользователям
SELECT count(*) FROM 
	(SELECT * FROM likes WHERE 
		target_type_id = (SELECT id FROM target_types WHERE name = 'users')) AS ll
	WHERE
		target_id IN (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10);
-- выше-стоящий запрос не работат, выдает ошибку:
-- SQL Error [1235] [42000]: This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'
	SELECT count(*) FROM 
	(SELECT * FROM likes WHERE 
		target_type_id = (SELECT id FROM target_types WHERE name = 'users')) AS ll
	WHERE
		target_id IN (SELECT user_id FROM (SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10) ttt);
	
/*
===============================================================================
5.	Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
	(критерии активности необходимо определить самостоятельно)
===============================================================================
*/
	
-- Таблица Рейтингов
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  table_name VARCHAR(130) NOT NULL COMMENT "Имя таблицы, для которой имеется рейтинг",
  table_col_name VARCHAR(130) NOT NULL COMMENT "Имя столбца для users(id) в таблице, для которой имеется рейтинг",
  ratio FLOAT UNSIGNED NOT NULL COMMENT "Весовой коэффициент (множитель) при расчете рейтинга",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания"  
) COMMENT "Таблица рейтингов";

INSERT INTO ratings VALUES (NULL, 'posts','user_id', 2, NULL);
INSERT INTO ratings VALUES (NULL, 'media','user_id', 0.5, NULL);
INSERT INTO ratings VALUES (NULL, 'friendship','user_id', 1, NULL);
INSERT INTO ratings VALUES (NULL, 'friendship','friend_id', 0.5, NULL);
INSERT INTO ratings VALUES (NULL, 'communities','owner_id', 10, NULL);
INSERT INTO ratings VALUES (NULL, 'communities_users','user_id', 3, NULL);
INSERT INTO ratings VALUES (NULL, 'likes','user_id', 1, NULL);

SELECT * FROM ratings;

/*
Процедура вычисления рейтинга пользователя на основе построения динамического SQL-запроса
Процедура просматривает все оцениваемые сущности из таблицы ratings (posts, media,friendship,...)
В общем, любые таблицы по любому полю связи с user_id и произвольному весовому коэффициенту
(разные активности оцениваюится индивидуально) 
Входные параметры: 
	- user_id 
На выходе итоговый рейтинг пользователя с учетом весовых коэффициентов.
*/
DROP PROCEDURE IF EXISTS getRating;

DELIMITER $$
CREATE PROCEDURE getRating (IN user_id INT, OUT user_rating_out FLOAT)
#   LANGUAGE SQL
#   NOT DETERMINISTIC
#   CONTAINS SQL
#   SQL SECURITY DEFINER
   COMMENT 'Процедура вычисления рейтинга пользователя'
BEGIN
	DECLARE tab_ratio FLOAT;
	DECLARE tab_name, tab_col_name VARCHAR(130);
	DECLARE done INT DEFAULT 0;
	DECLARE ratings_cursor CURSOR FOR SELECT table_name, table_col_name, ratio FROM ratings;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

	OPEN ratings_cursor;
	SET user_rating_out = 0;
REPEAT 
	FETCH ratings_cursor INTO tab_name, tab_col_name, tab_ratio;
	IF NOT done THEN
	   	SET @sql = CONCAT('SELECT count(*) into @amount FROM ', tab_name, ' WHERE ', tab_col_name, ' = ', user_id, ';');
	   	PREPARE getTableSql FROM @sql;
   		EXECUTE getTableSql;
		DEALLOCATE PREPARE getTableSql;
		SET user_rating_out = user_rating_out + tab_ratio * @amount;
	END IF;
UNTIL done END REPEAT;
	CLOSE ratings_cursor;
#	SELECT user_id, user_rating_out;
END;
$$
DELIMITER ;

CALL getRating(10, @rating); 
SELECT @rating;

/*
Процедура заполнения временной таблицы с рейтингами всех пользователей
Процедура последовательно перебирает всех пользователей и рассчитывает по каждому его 
рейтинг путем запуска процедуры "getRating".
Результат записывается во временную таблицу "rating_tmp".
*/
DROP PROCEDURE IF EXISTS fillRating;

DELIMITER $$
CREATE PROCEDURE fillRating ()
   COMMENT 'Процедура заполнения временной таблицы рейтингов пользователей'
BEGIN
	DECLARE user_id, done INT DEFAULT 0;
	DECLARE users_cursor CURSOR FOR SELECT id FROM users;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

 	DROP TABLE IF EXISTS  rating_tmp;
	CREATE TEMPORARY TABLE rating_tmp (user_id int, rating float);
	
	OPEN users_cursor;
REPEAT 
	FETCH users_cursor INTO user_id;
	IF NOT done THEN
		CALL getRating(user_id, @rating);
		INSERT INTO rating_tmp values (user_id, @rating);
	END IF;
UNTIL done END REPEAT;
	CLOSE users_cursor;
END;
$$
DELIMITER ;

CALL fillRating; 
SELECT u.first_name, u.last_name, r.rating, id FROM users u, rating_tmp r WHERE u.id = r.user_id ORDER BY r.rating LIMIT 10;

		