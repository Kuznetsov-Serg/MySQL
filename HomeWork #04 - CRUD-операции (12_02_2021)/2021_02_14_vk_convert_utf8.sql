USE vk;

-- список ТАБЛИЦ в текущей БД
SHOW tables;

-- описание таблицы users (DESCRIBE users;)
DESC users;
-- Анализируем данные (первые 10 строк)
SELECT * FROM users LIMIT 10;
-- Приводим в порядок временные метки
-- подправим даты изменения, которые меньше даты создания, установив их на "сейчас"
UPDATE users SET updated_at = now() WHERE updated_at < created_at;
SELECT * FROM users WHERE updated_at > now()- INTERVAL 1 HOUR ORDER BY updated_at DESC;

-- Вносим изменения в таблицу профилей
DESC profiles;
-- До внесения ограничения в столбце пол, нужно все значения привести к  соответствию правила
UPDATE profiles SET gender = (SELECT * FROM (SELECT 'F' AS gender UNION SELECT 'M' AS gender) gender_list ORDER BY rand() LIMIT 1);
-- добавим ограниечение по значению в столбце "пол" 
ALTER TABLE profiles MODIFY gender enum('F','M'); 
SELECT * FROM profiles LIMIT 10;
-- Приводим в порядок временные метки
-- UPDATE profiles SET updated_at = now() WHERE updated_at < created_at;
UPDATE profiles p SET p.created_at = (SELECT u.created_at FROM users u WHERE u.id = p.user_id), p.updated_at = (SELECT u.updated_at FROM users u WHERE u.id = p.user_id);

-- Смотрим структуру таблицы сообщений
DESC messages ;
SELECT * FROM messages LIMIT 10;
-- Обновляем значения ссылок на отправителя и получателя сообщения (чтобы были разными)
-- SELECT floor(1+rand()*100);
UPDATE messages  SET 
	from_user_id = floor(1+rand()*100),
	to_user_id = floor(1+rand()*100);

DESC media_types ;
-- Анализируем типы медиаконтента
SELECT * FROM media_types;
-- Удаляем все типы с обнулением автоинкремента
-- DELETE FROM media_types;
TRUNCATE media_types;
-- Добавляем нужные типы
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

-- Смотрим структуру таблицы медиаконтента 
DESC media ;
SELECT * FROM media LIMIT 10;
-- Обновляем ссылку на пользователя - владельца
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);
-- Обновляем размер файлов
UPDATE media SET size = floor(10000+rand()*100000) WHERE size < 1000;	
-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

-- Создаём временную таблицу форматов медиафайлов
DROP TABLE extensions;
CREATE TEMPORARY TABLE extensions (ext varchar(10));
-- Заполняем её значениями
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png'), ('wav');
/*
-- Заполняем её значениями, причем сопоставим расширение типу медиаконтента
CREATE TEMPORARY TABLE extensions (id_media_type int, ext varchar(10));
INSERT INTO extensions VALUES 
	((SELECT ID FROM media_types WHERE name='photo'),'jpeg'),
	((SELECT ID FROM media_types WHERE name='video'),'avi'), 
	((SELECT ID FROM media_types WHERE name='photo'),'mpeg'), 
	((SELECT ID FROM media_types WHERE name='photo'),'png'), 
	((SELECT ID FROM media_types WHERE name='audio'),'wav');
*/
SELECT * FROM extensions;

-- Обновляем ссылку на файл
-- https://dropbox.com/vk/soluta.avi (для filrname)
-- {"owner": "Name Surname"} (для metadata) 
UPDATE media SET filename = 
	concat('https://dropbox.com/vk/', filename, '.', 
	@ext:=(SELECT ext FROM extensions ORDER by rand() LIMIT 1)),
	media_type_id = 
	CASE @ext 
	WHEN 'avi' THEN (SELECT ID FROM media_types WHERE name='video')
	WHEN 'jpeg' THEN (SELECT ID FROM media_types WHERE name='photo')
	WHEN 'mpeg' THEN (SELECT ID FROM media_types WHERE name='photo')
	WHEN 'png' THEN (SELECT ID FROM media_types WHERE name='photo')
	WHEN 'wav' THEN (SELECT ID FROM media_types WHERE name='audio')
	ELSE 1 
	END;

-- Анализируем данные 
SELECT * FROM friendship_statuses;
-- Очищаем таблицу
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name) VALUES ('Requested'), ('Confirmed'), ('Rejected');



-- Смотрим структуру таблицы дружбы
DESC friendship;
SELECT * FROM friendship_statuses fs ;
truncate friendship_statuses;
ALTER TABLE friendship DROP COLUMN requested_at;
-- Обновляем ссылки на статус 
UPDATE friendship SET friendship_status_id = floor(1+rand()*3);

UPDATE friendship SET 
	user_id = floor(1+rand()*100),
	friend_id = floor(1+rand()*100);
-- Исправляем случай когда user_id = friend_id
UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id;

-- Смотрим структуру таблицы групп
DESC communities;
-- Анализируем данные
SELECT * FROM communities;
-- Удаляем часть групп
DELETE FROM communities WHERE id > 20;
-- Добавляем владельцев групп 
ALTER TABLE communities ADD COLUMN owner_id INT UNSIGNED NOT NULL AFTER id;
UPDATE communities SET owner_id = FLOOR(1 + RAND() * 100); 

-- Анализируем таблицу связи пользователей и групп
DESC communities_users ;
SELECT * FROM communities_users;
-- Обновляем значения community_id
UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);
