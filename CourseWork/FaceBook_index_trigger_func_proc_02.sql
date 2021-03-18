/*
 * Скрипт создания представлений, индексов, хранимых процедур, фукций и триггеров * 
 */
USE facebook;

/*
 * ПРЕДСТАВЛЕНИЯ
 */

CREATE OR REPLACE VIEW users_passwords_view AS SELECT 
	CONCAT(first_name, ' ', last_name) AS fio,
	RPAD(LEFT(p.password,3), 10, '*') AS passw_mask
	FROM users u JOIN passwords p ON u.id = p.user_id AND p.is_active = TRUE;
-- Проверим выборку из представления
SELECT * FROM users_passwords_view;

CREATE OR REPLACE VIEW users_now_view AS SELECT 
	u.id,
	CONCAT(first_name, ' ', last_name) AS fio,
	p.birthday AS birthday,
	cities.name AS live_now,
	companies.name AS company_work_now,
	jp.name AS job_positions_now 
	FROM users u 
	JOIN profiles p ON p.user_id = u.id
	LEFT JOIN cities_live c ON c.user_id = u.id AND c.type_place = 'live_now'
	LEFT JOIN cities ON cities.id = c.city_id 
	LEFT JOIN users_works uw ON uw.user_id = u.id AND uw.is_work_now = TRUE
	LEFT JOIN companies ON companies.id = uw.company_id 
	LEFT JOIN job_positions jp ON jp.id = uw.job_position_id ;
	
SELECT * FROM users_now_view;

/*
 * ИНДЕКСЫ * 
 */
/*
Перечень дорполнительных индексов
–	users (last_name, first_name) – поиск человека
–	profiles (birthday) – частая опция поиска
	...
–	posts (head)  - просмотр/поиск постов по заголовкам
*/

CREATE INDEX users_last_name_first_name_idx ON users(last_name, first_name);
CREATE INDEX profiles_birthday_idx ON profiles(birthday);
CREATE INDEX countries_name_idx ON countries(name);
CREATE INDEX cities_name_idx ON cities(name);
CREATE INDEX posts_title_idx ON posts(title);



-- SHOW INDEX FROM users;
-- SHOW INDEX FROM posts;
-- SHOW INDEX FROM profiles;


/*
 * ТРИГГЕРЫ, ХРАНИМЫЕ ФУНКЦИИ и ПРОЦЕДУРЫ
 */

-- ***********************
-- Таблица friendship
-- ***********************
-- учитывая составной первичный ключ, проще заполнить таблицу и игнорируя ошибки дублирования, через процедуру 

DROP PROCEDURE IF EXISTS insert_friendship;
DELIMITER $$
CREATE PROCEDURE insert_friendship(IN num_str INT)
BEGIN
  DECLARE v1 INT DEFAULT 1;
  DECLARE CONTINUE HANDLER FOR 1062		-- обработчик ошибки дублирования ключа, выдается ошибка MySQL 1062
  	SELECT 'duplicate keys' AS msg;
  
  WHILE v1 <= num_str DO
  	INSERT INTO friendship (user_id, friend_id, friendship_status_id) 
  	VALUES ( 
  		floor(1+rand()*100),
  		floor(1+rand()*100),
		(SELECT id FROM friendship_statuses ORDER by rand() LIMIT 1));
    SET v1 = v1 + 1;
  END WHILE;
  DELETE FROM friendship WHERE	user_id = friend_id;	-- Уберем варианты, когда user_id = friend_id
END$$
DELIMITER ;


-- ***********************
-- Таблица posts
-- ***********************

-- Триггер для отслеживания того, что в группе может быть только один закрепленный пост (is_fix) в активном статусе 
DROP TRIGGER IF EXISTS post_ins_check;
SHOW triggers;
DELIMITER $$
$$
CREATE TRIGGER post_ins_check BEFORE INSERT ON posts 
FOR EACH ROW BEGIN 
	IF NEW.is_fix = TRUE AND NEW.status = 'c' THEN
  		IF (SELECT count(*) FROM posts p WHERE p.id != NEW.id AND p.community_id = NEW.community_id AND p.status = 'c' AND p.is_fix = TRUE) > 0 THEN 
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
CREATE TRIGGER post_upd_check BEFORE UPDATE ON posts 
FOR EACH ROW BEGIN 
	IF NEW.is_fix = TRUE AND NEW.status = 'c' THEN
  		IF (SELECT count(*) FROM posts p WHERE p.id != NEW.id AND p.community_id = NEW.community_id AND p.status = 'c' AND p.is_fix = TRUE) > 0 THEN 
			SET NEW.is_fix = FALSE;
		END IF;
	END IF;
END;
$$
DELIMITER ;

-- ***********************
-- Таблица likes
-- ***********************

-- Создание триггера для обработки target_id

-- Создадим функцию «is_row_exists», 
-- получающую в качестве параметров имя сущности (таблицы) и ИД строки 
-- и возвращающую наличие такой записи в запрошенной таблице
 
DROP FUNCTION IF EXISTS is_row_exists;
DELIMITER //
CREATE FUNCTION is_row_exists (row_id INT, table_name VARCHAR(40))
RETURNS BOOLEAN READS SQL DATA
BEGIN
  CASE table_name
    WHEN 'messages' THEN
      RETURN EXISTS(SELECT 1 FROM messages WHERE id = row_id);
    WHEN 'users' THEN 
      RETURN EXISTS(SELECT 1 FROM users WHERE id = row_id);
    WHEN 'media' THEN
      RETURN EXISTS(SELECT 1 FROM media WHERE id = row_id);
    WHEN 'posts' THEN
      RETURN EXISTS(SELECT 1 FROM posts WHERE id = row_id);
    ELSE 
      RETURN FALSE;
  END CASE;
END//
DELIMITER ;

-- Создадим триггер для проверки отвечающий за добавление записей в таблицу лайков.
-- Если в таблице (table_name), для которой добавляем Лайк нет строки (row_id)
-- генерим сигнал для предотвращения вставки
 
DROP TRIGGER IF EXISTS likes_validation;
DELIMITER //
CREATE TRIGGER likes_validation BEFORE INSERT ON likes
FOR EACH ROW BEGIN
  IF !is_row_exists(NEW.row_id, NEW.table_name) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided!";
  END IF;
END//
DELIMITER ;

-- ***********************
-- таблица cities_live
-- ***********************

-- Триггер для отслеживания того, что у пользователя может быть только один город 'city_born' и 'live_now'
DROP TRIGGER IF EXISTS cities_live_insert_check;
DELIMITER $$
$$
CREATE TRIGGER cities_live_insert_check BEFORE INSERT ON cities_live 
FOR EACH ROW BEGIN 
	IF NEW.type_place = 'city_born' OR NEW.type_place = 'live_now' THEN
  		IF (SELECT count(*) FROM cities_live WHERE id != NEW.id AND type_place = NEW.type_place) > 0 THEN 
			SET NEW.type_place = 'relocate';
		END IF;
	END IF;
END;
$$
DELIMITER ;

-- Триггер для отслеживания того, что у пользователя может быть только один город 'city_born' и 'live_now'
DROP TRIGGER IF EXISTS cities_live_update_check;
DELIMITER $$
$$
CREATE TRIGGER cities_live_update_check BEFORE UPDATE ON cities_live 
FOR EACH ROW BEGIN 
	IF NEW.type_place = 'city_born' OR NEW.type_place = 'live_now' THEN
  		IF (SELECT count(*) FROM cities_live WHERE id != NEW.id AND type_place = NEW.type_place) > 0 THEN 
			SET NEW.type_place = 'relocate';
		END IF;
	END IF;
END;
$$
DELIMITER ;

-- ***********************
-- таблица ratings
-- ***********************

/*
Процедура вычисления рейтинга пользователя на основе построения динамического SQL-запроса
Процедура просматривает все оцениваемые сущности из таблицы ratings (posts, media,friendship,...)
В общем, любые таблицы по любому полю связи с user_id и произвольному весовому коэффициенту
(разные активности оцениваюится индивидуально) 
Входные параметры: 
	- user_id 
На выходе итоговый рейтинг пользователя с учетом весовых коэффициентов.
*/
DROP PROCEDURE IF EXISTS get_rating_user;
DELIMITER $$
CREATE PROCEDURE get_rating_user (IN user_id INT, OUT user_rating_out FLOAT)
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
END;
$$
DELIMITER ;

/*
Процедура заполнения временной таблицы с рейтингами всех пользователей
Процедура последовательно перебирает всех пользователей и рассчитывает по каждому его 
рейтинг путем запуска процедуры "get_rating_user".
Результат записывается во временную таблицу "ratings_tmp".
*/
DROP PROCEDURE IF EXISTS fill_ratings_all;
DELIMITER $$
CREATE PROCEDURE fill_ratings_all ()
   COMMENT 'Процедура заполнения временной таблицы рейтингов пользователей'
BEGIN
	DECLARE user_id, done INT DEFAULT 0;
	DECLARE users_cursor CURSOR FOR SELECT id FROM users;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

 	DROP TABLE IF EXISTS  ratings_tmp;
	CREATE TEMPORARY TABLE ratings_tmp (user_id int, rating float);
	
	OPEN users_cursor;
REPEAT 
	FETCH users_cursor INTO user_id;
	IF NOT done THEN
		CALL get_rating_user(user_id, @rating);
		INSERT INTO ratings_tmp values (user_id, @rating);
	END IF;
UNTIL done END REPEAT;
	CLOSE users_cursor;
END;
$$
DELIMITER ;

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ТРАНЗАКЦИИ
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- *******************************
-- таблица messages и messages_arh
-- *******************************
-- перенести "старые" данные из таблицы messages в предназначенную для архивных сообщений
-- таблицу messages_arh, оставив только 100 самых "свежих" строк с использованием транзакции.
DROP PROCEDURE IF EXISTS messages_move_in_arh;

DELIMITER //
CREATE PROCEDURE messages_move_in_arh()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;
  START TRANSACTION;	-- старт транзакции
-- вставим в messages_arh "старые" строки из messages
	INSERT INTO messages_arh
		SELECT * FROM messages 
		WHERE id NOT IN (SELECT * FROM (SELECT id FROM messages ORDER BY created_at DESC LIMIT 100) t);
-- удалим все строки из messages, которые уже перенесли в messages_arh
	DELETE FROM messages 
		WHERE id NOT IN (SELECT * FROM (SELECT id FROM messages ORDER BY created_at DESC LIMIT 100) t);
  COMMIT;				-- закроем транзакцию
END//
DELIMITER ;

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ЛОГГИРОВАНИЕ
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- Создаем основную процедуру логгирования работы с таблицами users, profiles и passwords
DROP PROCEDURE IF EXISTS log_insert;

DELIMITER //
CREATE PROCEDURE log_insert (IN name_table VARCHAR(20), IN type_operation VARCHAR(10), IN row_id BIGINT, IN description VARCHAR(255))
BEGIN
	SET @cur_user:=CURRENT_USER();
	INSERT INTO logs(`user`, type_operation, name_table, row_id, description) VALUES (@cur_user, type_operation, name_table, row_id,description);		
END//
DELIMITER ;

-- Активируем триггерs на вставку/изменение/удаление строк в таблицы users

DROP TRIGGER IF EXISTS users_insert;
DELIMITER //
CREATE TRIGGER users_insert AFTER INSERT ON users 
FOR EACH ROW BEGIN
  	CALL log_insert('users', 'insert', NEW.id, concat(NEW.first_name, ' ', NEW.last_name, ' (Email: ', NEW.email, ', Phone: ', NEW.phone, ')'));
END//
DELIMITER ;

DROP TRIGGER IF EXISTS users_update;
DELIMITER //
CREATE TRIGGER users_update AFTER UPDATE ON users 
FOR EACH ROW BEGIN
  	CALL log_insert('users', 'update', NEW.id, 
  		concat('(', OLD.first_name, '-->', NEW.first_name, ') (',
  			OLD.last_name, '-->', NEW.last_name, ')',
  			') (Email: ', OLD.email, '-->', NEW.email, 
  			') (Phone: ', OLD.phone, '-->', NEW.phone, ')'));
END//
DELIMITER ;

DROP TRIGGER IF EXISTS users_delete;
DELIMITER //
CREATE TRIGGER users_delete AFTER DELETE ON users 
FOR EACH ROW BEGIN
  	CALL log_insert('users', 'delete', OLD.id, concat(OLD.first_name, ' ', OLD.last_name, ' (Email: ', OLD.email, ', Phone: ', OLD.phone, ')'));
END//
DELIMITER ;

-- Активируем триггерs на вставку/изменение/удаление строк в таблицы profiles
DROP TRIGGER IF EXISTS profiles_insert;
DELIMITER //
CREATE TRIGGER profiles_insert AFTER INSERT ON profiles 
FOR EACH ROW BEGIN
  	CALL log_insert('profiles', 'insert', NEW.user_id, concat('Пол: ', NEW.gender, ', Дата рождения: ', NEW.birthday, ', о себе: ', NEW.about_user));
END//
DELIMITER ;

DROP TRIGGER IF EXISTS profiles_update;
DELIMITER //
CREATE TRIGGER profiles_update AFTER UPDATE ON profiles 
FOR EACH ROW BEGIN
  	CALL log_insert('profiles', 'update', NEW.user_id, concat('Пол: ', NEW.gender, ', Дата рождения: ', NEW.birthday, ', о себе: ', NEW.about_user));
END//
DELIMITER ;

DROP TRIGGER IF EXISTS profiles_delete;
DELIMITER //
CREATE TRIGGER profiles_delete AFTER DELETE ON profiles 
FOR EACH ROW BEGIN
  	CALL log_insert('profiles', 'delete', OLD.user_id, concat('Пол: ', OLD.gender, ', Дата рождения: ', OLD.birthday, ', о себе: ', OLD.about_user));
END//
DELIMITER ;

-- Активируем триггерs на вставку/изменение/удаление строк в таблицы passwords
DROP TRIGGER IF EXISTS passwords;
DELIMITER //
CREATE TRIGGER passwords_insert AFTER INSERT ON passwords 
FOR EACH ROW BEGIN
  	CALL log_insert('passwords', 'insert', NEW.user_id, concat('Пароль: ', RPAD(LEFT(NEW.password,3), 10, '*'), ', Активен: ', NEW.is_active));
END//
DELIMITER ;

DROP TRIGGER IF EXISTS passwords_update;
DELIMITER //
CREATE TRIGGER passwords_update AFTER UPDATE ON passwords 
FOR EACH ROW BEGIN
  	CALL log_insert('passwords', 'update', NEW.user_id, concat('Пароль: ', RPAD(LEFT(NEW.password,3), 10, '*'), ', Активен: ', NEW.is_active));
END//
DELIMITER ;

DROP TRIGGER IF EXISTS passwords_delete;
DELIMITER //
CREATE TRIGGER passwords_delete AFTER DELETE ON passwords 
FOR EACH ROW BEGIN
  	CALL log_insert('passwords', 'delete', OLD.user_id, concat('Пароль: ', RPAD(LEFT(OLD.password,3), 10, '*'), ', Активен: ', OLD.is_active));
END//
DELIMITER ;

