USE facebook;

-- список ТАБЛИЦ в текущей БД
-- SHOW tables;

-- ****************************
-- таблица users (пользователи)
-- ****************************
-- описание таблицы users (DESCRIBE users;)
-- DESC users;
-- Анализируем данные (первые 10 строк)
-- SELECT * FROM users LIMIT 10;
-- Приводим в порядок временные метки
-- подправим даты изменения, которые меньше даты создания, установив их на "сейчас"
UPDATE users SET updated_at = now() WHERE updated_at < created_at;
-- SELECT * FROM users WHERE updated_at > now()- INTERVAL 1 HOUR ORDER BY updated_at DESC;

-- ****************************
-- таблица profiles (пользователи)
-- ****************************
-- DESC profiles;
-- До внесения ограничения в столбце пол, нужно все значения привести к  соответствию правила
-- UPDATE profiles SET gender = (SELECT * FROM (SELECT 'F' AS gender UNION SELECT 'M' AS gender) gender_list ORDER BY rand() LIMIT 1);
-- добавим ограниечение по значению в столбце "пол" 
-- ALTER TABLE profiles MODIFY gender enum('F','M'); 
-- SELECT * FROM profiles LIMIT 10;
-- Приводим в порядок временные метки (скопируем из users)
UPDATE profiles p 
	SET p.created_at = (SELECT u.created_at FROM users u WHERE u.id = p.user_id), 
		p.updated_at = (SELECT u.updated_at FROM users u WHERE u.id = p.user_id);

-- ****************************
-- таблица cities_live (места жительства)
-- ****************************
-- установим в таблице места жительства только один город в текущий статус
-- сначала, все места жительства в статус "переезд"
UPDATE cities_live SET type_place = 'relocate';
-- потом, каждому максимальному у пользователя - "текущее место жительства"
UPDATE cities_live 
	SET type_place = 'live_now' 
	WHERE id IN (SELECT * FROM (SELECT max(id) FROM cities_live GROUP BY user_id) t); 
-- каждому минимальному у пользователя - "место рождения"
UPDATE cities_live 
	SET type_place = 'city_born' 
	WHERE id IN (SELECT * FROM (SELECT min(id) FROM cities_live GROUP BY user_id) t); 

-- ****************************
-- таблица users_works (места работы)
-- ****************************
-- Приводим в порядок временные метки
UPDATE users_works SET date_finish = now() WHERE date_start > date_finish;
-- установим в таблице только одно место работы в текущий статус
-- сначала, всем в False
UPDATE users_works SET is_work_now = FALSE;
-- потом, каждому максимальному у пользователя - True
UPDATE users_works 
	SET is_work_now = TRUE 
	WHERE id IN (SELECT * FROM (SELECT max(id) FROM users_works GROUP BY user_id) t); 

-- ****************************
-- таблица messages (сообщения)
-- ****************************
-- Смотрим структуру таблицы сообщений
-- DESC messages ;
-- SELECT * FROM messages LIMIT 10;
-- Обновляем значения ссылок на отправителя и получателя сообщения (чтобы были разными)
UPDATE messages  SET 
	from_user_id = floor(1+rand()*100),
	to_user_id = floor(1+rand()*100)
WHERE  from_user_id = to_user_id;
SELECT * FROM messages WHERE from_user_id = to_user_id;

-- ****************************
-- таблица media (медиаконтент)
-- ****************************
-- DESC media ;
-- SELECT * FROM media LIMIT 10;
-- Обновляем размер файлов
UPDATE media SET size = floor(10000+rand()*100000) WHERE size < 1000;	
-- Заполняем метаданные JSON
-- {"owner": "Name Surname"} (для metadata) 
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

-- Создаём временную таблицу форматов медиафайлов
DROP TABLE IF EXISTS extensions;
CREATE TEMPORARY TABLE extensions (ext varchar(10));
-- Заполняем её значениями
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png'), ('wav');
-- SELECT * FROM extensions;

-- Обновляем ссылку на файл
-- https://dropbox.com/vk/soluta.avi (для filename)
-- SELECT * FROM media_types;
-- SELECT * FROM media LIMIT 10;
UPDATE media SET filename = 
	concat('https://dropbox.com/vk/', filename, '.', 
	@ext:=(SELECT ext FROM extensions ORDER by rand() LIMIT 1)),
	media_type_id = 
	CASE @ext 
	WHEN 'avi' THEN (SELECT ID FROM media_types WHERE name='video')
	WHEN 'jpeg' THEN (SELECT ID FROM media_types WHERE name='image')
	WHEN 'mpeg' THEN (SELECT ID FROM media_types WHERE name='image')
	WHEN 'png' THEN (SELECT ID FROM media_types WHERE name='image')
	WHEN 'wav' THEN (SELECT ID FROM media_types WHERE name='audio')
	ELSE 1 
	END;

-- ****************************
-- таблица friendship (дружбы)
-- ****************************
-- Заполним таблицу 
-- учитывая составной первичный ключ, проще заполнить таблицу и гнорируюя ошибки дублирования, через процедуру 
-- TRUNCATE friendship;		-- очистим таблицу
CALL insert_friendship(1000);
-- SELECT count(*) FROM friendship;

-- ****************************
-- таблица communities (Группы)
-- ****************************
-- Смотрим структуру таблицы групп
-- DESC communities;
-- Анализируем данные
-- SELECT * FROM communities;
-- подправим даты изменения, которые меньше даты создания, установив их на "сейчас"
UPDATE communities SET updated_at = now() WHERE updated_at < created_at;
-- добавим пустую группу (без пользователе)
INSERT INTO communities (owner_id, name) value (1, 'Empty_Group');
-- Пользователей группы ID=2 перенесем в группу с ID=4
UPDATE communities_users SET community_id = 4 WHERE community_id =2;

-- DESC communities ;
-- SELECT * FROM communities WHERE updated_at > now()- INTERVAL 1 HOUR ORDER BY updated_at DESC;

-- ****************************
-- таблица ratings (рейтинги)
-- ****************************
INSERT INTO ratings (table_name, table_col_name, ratio) VALUES 
	('posts','owner_id', 2),
	('media','user_id', 0.5),
	('friendship','user_id', 1),
	('friendship','friend_id', 0.5),
	('communities','owner_id', 10),
	('communities_users','user_id', 3),
	('likes','user_id', 1);

-- SELECT * FROM ratings;
