/*
Курс: Основы реляционных баз данных. MySQL
Урок 7. Сложные запросы
Выполнил: Кузнецов Сергей (Факультет Geek University Python-разработки)

Домашнее задание:
===============================================================================
Домашнее задание:
1.	Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
2.	Выведите список товаров products и разделов catalogs, который соответствует товару.
3.	(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
===============================================================================
*/

/*
===============================================================================
1.	Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
===============================================================================
*/

CREATE DATABASE lesson_07;

-- через консоль прогружаем дамп «mysql lesson_07 < shop.sql»
USE lesson_07;
-- Смотрим диаграмму отношений в DBeaver (ERDiagram)

SELECT * FROM users;
SELECT * FROM orders; 	-- нет данных
-- через консоль прогружаем дамп «mysql lesson_07 < "fulldb21-02-2021 11-48.sql"»
SELECT * FROM orders; 	-- все ок

SELECT * FROM users WHERE EXISTS (SELECT * FROM orders WHERE user_id = users.id);
SELECT DISTINCT u.* FROM users u INNER JOIN orders o ON u.id=o.user_id;
SELECT u.name, count(*) 'Количество заказов' FROM users u, orders o WHERE u.id=o.user_id GROUP BY u.id;


/*
===============================================================================
2.	Выведите список товаров products и разделов catalogs, который соответствует товару.
===============================================================================
*/

SELECT * FROM products;
SELECT * FROM catalogs;

SELECT p.name 'товар', c.name 'раздел' FROM products p INNER JOIN catalogs c ON catalog_id=c.id;
SELECT name 'товар', (SELECT name FROM catalogs c WHERE c.id=catalog_id) 'раздел' FROM products;
SELECT p.name 'товар', c.name 'раздел' FROM products p, catalogs c WHERE catalog_id=c.id;

/*
===============================================================================
3.	(по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
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
