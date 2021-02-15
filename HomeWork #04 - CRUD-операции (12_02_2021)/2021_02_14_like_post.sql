use vk;

-- Таблица постов
DROP TABLE IF EXISTS post;
CREATE TABLE post (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  owner_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя-владельца",
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  title VARCHAR(130) NOT NULL COMMENT "Зоголовок поста - тема",
  is_fix BOOLEAN DEFAULT FALSE COMMENT "Закреплен - всегда вверху группы",
  is_sign BOOLEAN DEFAULT FALSE COMMENT "с подписью",
  body TEXT NOT NULL COMMENT "Текст поста",
  status enum('c','a','d') NOT NULL COMMENT "статус 'c'-current, 'a'-arhive, 'd'-delay (с отложенной публикацией)", 
  activate_at DATETIME DEFAULT NULL COMMENT "Таймер активации поста",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания поста",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления поста",
  FOREIGN KEY (owner_id) REFERENCES users (id) ON UPDATE RESTRICT ON DELETE CASCADE,
  FOREIGN KEY (community_id) REFERENCES communities (id)
) COMMENT "Посты"; 

-- Для последующей проверки триггеров
INSERT INTO post (owner_id, community_id, title , is_fix, body) VALUES (1, 1, 'Тестовый пост №1', TRUE, 'Просто какой то текст 1');
INSERT INTO post (owner_id, community_id, title , is_fix, body) VALUES (1, 1, 'Тестовый пост №2', TRUE, 'Просто какой то текст 2');
INSERT INTO post (owner_id, community_id, title , is_fix, body) VALUES (1, 1, 'Тестовый пост №3', TRUE, 'Просто какой то текст 3');
INSERT INTO post (owner_id, community_id, title , is_fix, body) VALUES (1, 1, 'Тестовый пост №4', TRUE, 'Просто какой то текст 4');


DROP TABLE extensions;
CREATE TEMPORARY TABLE extensions (ext varchar(10));
-- Заполняем её значениями
	IF NEW.is_fix = TRUE AND OLD.is_fix = FALSE 
	BEGIN 
		IF NEW.is_fix = TRUE AND OLD.is_fix = FALSE THEN 
		BEGIN 

			INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png'), ('wav');
	-- закрепляем пост (такой в группе может быть только один)
--		UPDATE post p SET p.is_fix = FALSE WHERE p.id != NEW.id AND p.community_id = NEW.community_id; 
			SET NEW.title = UPPER(SUBSTRING(NEW.title, 1, 1));	
		INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png'), ('wav');
		SET NEW.title = UPPER(SUBSTRING(NEW.title, 1, 1));	

-- Триггер для отслеживания того, что в группе может быть только один закрепленный пост (is_fix) в активном статусе 
DROP TRIGGER IF EXISTS post_ins_check;
SHOW triggers;
DELIMITER $$
$$
CREATE TRIGGER post_ins_check BEFORE INSERT ON post 
FOR EACH ROW BEGIN 
	IF NEW.is_fix = TRUE AND NEW.status = 'c' THEN
  		IF (SELECT count(*) FROM post p WHERE p.id != NEW.id AND p.community_id = NEW.community_id AND p.status = 'c' AND p.is_fix = TRUE) > 0 THEN 
			SET NEW.is_fix = FALSE;
		END IF;
	END IF;
END;
$$
DELIMITER ;

-- Триггер для отслеживания того, что в группе может быть только один закрепленный пост (is_fix) в активном статусе 
DROP TRIGGER IF EXISTS post_upd_check;
SHOW triggers;
DELIMITER $$
$$
CREATE TRIGGER post_upd_check BEFORE UPDATE ON post 
FOR EACH ROW BEGIN 
	IF NEW.is_fix = TRUE AND NEW.status = 'c' THEN
  		IF (SELECT count(*) FROM post p WHERE p.id != NEW.id AND p.community_id = NEW.community_id AND p.status = 'c' AND p.is_fix = TRUE) > 0 THEN 
			SET NEW.is_fix = FALSE;
		END IF;
	END IF;
END;
$$
DELIMITER ;

-- Таблица связей с медиаконтентом Поста
DROP TABLE IF EXISTS post_media;
CREATE TABLE post_media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиафайл",
  FOREIGN KEY (post_id) REFERENCES post (id) ON UPDATE RESTRICT ON DELETE CASCADE,
  FOREIGN KEY (media_id) REFERENCES media (id)
) COMMENT "Таблица связей Поста с медиаконтентом"; 

-- Таблица связей Поста с опросом
DROP TABLE IF EXISTS guestion;
CREATE TABLE question (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  title VARCHAR(130) NOT NULL COMMENT "Зоголовок опроса",
  is_anonymous BOOLEAN DEFAULT FALSE COMMENT "анонимность",
  FOREIGN KEY (post_id) REFERENCES post (id) ON UPDATE RESTRICT ON DELETE CASCADE
) COMMENT "Таблица связей Поста с опросом"; 

-- Таблица ответов на опросы
DROP TABLE IF EXISTS question_answer;
CREATE TABLE question_answer (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  question_id INT UNSIGNED NOT NULL COMMENT "Ссылка на опрос",
  name VARCHAR(130) NOT NULL COMMENT "Вариант ответа",
  FOREIGN KEY (question_id) REFERENCES question (id) ON UPDATE RESTRICT ON DELETE CASCADE
) COMMENT "Таблица ответов на опросы"; 


-- Таблица лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  table_name VARCHAR(130) NOT NULL COMMENT "Имя таблицы, кому поставлен Лайк",
  table_id INT UNSIGNED NOT NULL COMMENT "Ссылка на запись в таблице, кому поставили Лайк",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя", 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания Лайка",  
  FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE RESTRICT ON DELETE CASCADE
) COMMENT "Таблица лайков";

INSERT INTO likes (table_name, table_id, user_id) VALUES ('users', 1, 2);
INSERT INTO likes (table_name, table_id, user_id) VALUES ('users', 2, 1);
INSERT INTO likes (table_name, table_id, user_id) VALUES ('users', 3, 2);
INSERT INTO likes (table_name, table_id, user_id) VALUES ('users', 1, 4);
INSERT INTO likes (table_name, table_id, user_id) VALUES ('post', 3, 3);
INSERT INTO likes (table_name, table_id, user_id) VALUES ('post', 1, 5);
INSERT INTO likes (table_name, table_id, user_id) VALUES ('post', 1, 7);

SELECT t.first_name AS whom, concat(u.first_name, ' ', u.last_name) AS who, l.created_at AS 'when' FROM likes l, users u, users t WHERE l.table_name = 'users' AND l.table_id = t.id AND u.id = l.user_id;  

/*
Процедура получения всех лайков по выбранной сущности на основе построения динамического SQL-запроса
Входные параметры: 
	- имя таблицы, кому поставлены Лайки (users, post, messages, friendship, communities..., в общем - любая
	- имя столбца в этой таблице, чтобы было можно идентифицировать (кому поставлен Лайк)
На выходе итоги запроса с указанием:
	- Кому поставили Лайк
	- Кто поставил 
	- Когда поставил
*/
DROP PROCEDURE IF EXISTS getLike;
DELIMITER $$
CREATE PROCEDURE `getLike`(IN `table_name` varchar(130), `field_name` varchar(130))
   LANGUAGE SQL
   NOT DETERMINISTIC
   CONTAINS SQL
   SQL SECURITY DEFINER
   COMMENT ''
BEGIN
   SET @sql = CONCAT('SELECT t.', field_name, 
   					' AS whom, concat(u.first_name, " ", u.last_name) AS who, l.created_at AS "when" FROM likes l, users u, ',
   					table_name, ' t WHERE l.table_name = "', table_name, '" AND l.table_id = t.id AND u.id = l.user_id;'); 
   PREPARE getCountrySql FROM @sql;
   EXECUTE getCountrySql;
   DEALLOCATE PREPARE getCountrySql;
END
DELIMITER ;

-- Примеры вызова процедуры для различных сущностей (таблиц) 
CALL getLike('users', 'first_name'); 
CALL getLike('post', 'title'); 




