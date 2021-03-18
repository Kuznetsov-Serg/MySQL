-- Создаём БД
DROP DATABASE IF EXISTS facebook;
CREATE DATABASE facebook;
USE facebook;

#
# TABLE STRUCTURE FOR: users (таблица пользователей)
#
DROP TABLE IF EXISTS `users`;
CREATE TABLE users (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(50) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

#
# TABLE STRUCTURE FOR: profiles (Таблица профилей)
#
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender ENUM('M', 'F') COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  photo_profile VARCHAR(255) NOT NULL COMMENT "ФОТО профиля (путь к файлу)",
  photo_cover VARCHAR(255) COMMENT "ФОТО обложки (путь к файлу)",
  about_user VARCHAR(100) COMMENT "о себе",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE RESTRICT ON DELETE CASCADE
) COMMENT "Профили"; 

#
# TABLE STRUCTURE FOR: passwords (Таблица паролей)
#
DROP TABLE IF EXISTS passwords;
CREATE TABLE passwords (
  user_id BIGINT UNSIGNED NOT NULL  COMMENT "Ссылка на пользователя",
  `password` VARCHAR(40) COMMENT "Пароль",
  is_active BOOLEAN DEFAULT FALSE COMMENT "Активен",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE RESTRICT ON DELETE CASCADE
) COMMENT "Пароли"; 

#
# TABLE STRUCTURE FOR: countries (Таблица стран)
#
DROP TABLE IF EXISTS `countries`;
CREATE TABLE countries (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(130) NOT NULL COMMENT "Страна",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Страны"; 

#
# TABLE STRUCTURE FOR: coordinates (Таблица географических координат)
#
DROP TABLE IF EXISTS coordinates;
CREATE TABLE coordinates (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  `x` int(10) NOT NULL DEFAULT '0',
  `y` int(10) NOT NULL DEFAULT '0'
) COMMENT "Географические координаты";

#
# TABLE STRUCTURE FOR: cities (Таблица городов)
#
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(130) NOT NULL COMMENT "Город",
  country_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на страну", 
  coordinate_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на географические координаты", 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  FOREIGN KEY (country_id) REFERENCES countries (id), 
  FOREIGN KEY (coordinate_id) REFERENCES coordinates (id) 
) COMMENT "Города"; 

#
# TABLE STRUCTURE FOR: cities_live (Места (города) проживания)
#
DROP TABLE IF EXISTS cities_live;
CREATE TABLE cities_live (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя", 
  city_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на город", 
  type_place ENUM('city_born', 'live_now', 'relocate') COMMENT "родной город/живу сейчас/переезд",
  date_relocate DATETIME COMMENT "Дата переезда",  
  FOREIGN KEY (user_id) REFERENCES users (id), 
  FOREIGN KEY (city_id) REFERENCES cities (id)
) COMMENT "Места проживания"; 

#
# TABLE STRUCTURE FOR: companies (Таблица компаний - для работы)
#
DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(130) COMMENT "Компания"
) COMMENT "Компании"; 

#
# TABLE STRUCTURE FOR: job_positions (Таблица должностей)
#
DROP TABLE IF EXISTS job_positions;
CREATE TABLE job_positions (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(130) COMMENT "Должность"
) COMMENT "Должности"; 

#
# TABLE STRUCTURE FOR: users_works (Места работы)
#
DROP TABLE IF EXISTS users_works;
CREATE TABLE users_works (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя", 
  company_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на организацию", 
  job_position_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на должность", 
  city_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на город", 
  date_start DATETIME COMMENT "Дата начала",  
  date_finish DATETIME COMMENT "Дата завершения",  
  is_work_now BOOLEAN DEFAULT FALSE COMMENT "работает сейчас",
  flag_access ENUM('all', 'friends', 'nobody') COMMENT "доступно всем/друзьям/никому",
  FOREIGN KEY (user_id) REFERENCES users (id), 
  FOREIGN KEY (company_id) REFERENCES companies (id),
  FOREIGN KEY (job_position_id) REFERENCES job_positions (id),
  FOREIGN KEY (city_id) REFERENCES cities (id)
) COMMENT "Места работы"; 

#
# TABLE STRUCTURE FOR: media_types (Таблица типов медиафайлов)
#
DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

#
# TABLE STRUCTURE FOR: media (Таблица медиаконтента - содержимое в файлах)
#
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (media_type_id) REFERENCES media_types (id)
) COMMENT "Медиафайлы";

#
# TABLE STRUCTURE FOR: favorites (Избранное)
#
DROP TABLE IF EXISTS favorites;
CREATE TABLE favorites (
  user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  media_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на медиаконтент",
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (media_id) REFERENCES media (id)
) COMMENT "Избранное"; 

#
# TABLE STRUCTURE FOR: friendship_statuses (статусы дружеских отношений)
#
DROP TABLE IF EXISTS friendship_statuses;
CREATE TABLE friendship_statuses (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Статусы дружбы";

#
# TABLE STRUCTURE FOR: friendship (Друзья)
#
DROP TABLE IF EXISTS friendship;
CREATE TABLE friendship (
  user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  friendship_status_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на статус (текущее состояние) отношений",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время отправления приглашения дружить",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ",
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (friend_id) REFERENCES users (id),
  FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses (id)
) COMMENT "Таблица дружбы";

#
# TABLE STRUCTURE FOR: communities (Группы)
#
DROP TABLE IF EXISTS communities;
CREATE TABLE communities (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  owner_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на владельца (организатора) группы",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки", 
  FOREIGN KEY (owner_id) REFERENCES users (id)
) COMMENT "Группы";

#
# TABLE STRUCTURE FOR: communities_users (Таблица связи пользователей и групп)
#
DROP TABLE IF EXISTS communities_users;
CREATE TABLE communities_users (
  community_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ",
  FOREIGN KEY (community_id) REFERENCES communities (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
) COMMENT "Участники групп, связь между пользователями и группами";

#
# TABLE STRUCTURE FOR: messages (Сообщения)
#
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  from_user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  FOREIGN KEY (from_user_id) REFERENCES users (id),
  FOREIGN KEY (to_user_id) REFERENCES users (id)
) COMMENT "Сообщения";

#
# TABLE STRUCTURE FOR: messages (Сообщения)
#
DROP TABLE IF EXISTS messages_arh;
CREATE TABLE messages_arh (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  from_user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  FOREIGN KEY (from_user_id) REFERENCES users (id),
  FOREIGN KEY (to_user_id) REFERENCES users (id)
) COMMENT "Сообщения";

#
# TABLE STRUCTURE FOR: posts (Посты)
#
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  owner_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя-владельца",
  community_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  title VARCHAR(130) NOT NULL COMMENT "Зоголовок поста - тема",
  is_fix BOOLEAN DEFAULT FALSE COMMENT "Закреплен - всегда вверху группы",
  is_sign BOOLEAN DEFAULT FALSE COMMENT "с подписью",
  body TEXT NOT NULL COMMENT "Текст поста",
  status ENUM('current','arhive','delay') NOT NULL COMMENT "статус current- текущий, arhive - архивный, delay (с отложенной публикацией)", 
  activate_at DATETIME DEFAULT NULL COMMENT "Таймер активации поста",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания поста",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления поста",
  FOREIGN KEY (owner_id) REFERENCES users (id) ON UPDATE RESTRICT ON DELETE CASCADE,
  FOREIGN KEY (community_id) REFERENCES communities (id)
) COMMENT "Посты"; 

#
# TABLE STRUCTURE FOR: posts_media (связь Поста с медиаконтентом)
#
DROP TABLE IF EXISTS posts_media;
CREATE TABLE posts_media (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  post_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  media_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на медиафайл",
  FOREIGN KEY (post_id) REFERENCES posts (id) ON UPDATE RESTRICT ON DELETE CASCADE,
  FOREIGN KEY (media_id) REFERENCES media (id)
) COMMENT "Таблица связей Поста с медиаконтентом"; 

#
# TABLE STRUCTURE FOR: posts_questions (связь Поста с опросом)
#
DROP TABLE IF EXISTS posts_questions;
CREATE TABLE posts_questions (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  post_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  title VARCHAR(130) NOT NULL COMMENT "Зоголовок опроса",
  is_anonymous BOOLEAN DEFAULT FALSE COMMENT "анонимность",
  FOREIGN KEY (post_id) REFERENCES posts (id) ON UPDATE RESTRICT ON DELETE CASCADE
) COMMENT "Таблица связей Поста с опросом"; 

#
# TABLE STRUCTURE FOR: questions_answers (ответы на опросы)
#
DROP TABLE IF EXISTS questions_answers;
CREATE TABLE question_answer (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  question_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на опрос",
  name VARCHAR(130) NOT NULL COMMENT "Вариант ответа",
  FOREIGN KEY (question_id) REFERENCES posts_questions (id) ON UPDATE RESTRICT ON DELETE CASCADE
) COMMENT "Таблица ответов на опросы"; 


#
# TABLE STRUCTURE FOR: likes (Лайки)
#
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  table_name VARCHAR(130) NOT NULL COMMENT "Имя таблицы, кому поставлен Лайк",
  row_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на запись в таблице, кому поставили Лайк",
  user_id BIGINT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя", 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания Лайка",  
  FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE RESTRICT ON DELETE CASCADE
) COMMENT "Таблица лайков";

#
# TABLE STRUCTURE FOR: ratings (правила расчета рейтинга)
#
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  table_name VARCHAR(130) NOT NULL COMMENT "Имя таблицы, для которой имеется рейтинг",
  table_col_name VARCHAR(130) NOT NULL COMMENT "Имя столбца для users(id) в таблице, для которой имеется рейтинг",
  ratio FLOAT UNSIGNED NOT NULL COMMENT "Весовой коэффициент (множитель) при расчете рейтинга",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания"  
) COMMENT "Таблица рейтингов";

#
# TABLE STRUCTURE FOR: logs (логгирование добавления/изменения/удаления записей в таблицы БД)
#
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  `user` VARCHAR(40) COMMENT "Пользователь", 
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  type_operation ENUM('insert', 'update', 'delete') COMMENT "тип операции",
  name_table varchar(20) NOT NULL COMMENT "название таблицы",
  row_id bigint unsigned NOT NULL COMMENT "идентификатор первичного ключа в таблице",
  description varchar(255) DEFAULT NULL COMMENT "описание действия"
) COMMENT="Таблица логгирования добавления/изменения/удаления записей в таблицы БД" ENGINE=ARCHIVE;





