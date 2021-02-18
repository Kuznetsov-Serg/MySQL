-- 1.	Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
-- Заполните их текущими датой и временем.

CREATE DATABASE IF NOT EXISTS lesson_05;
USE lesson_05;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(25),
  updated_at VARCHAR(25)
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

UPDATE users SET created_at = now(), updated_at = now();

/*
2.	Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, 
сохранив введённые ранее значения.
*/
-- SELECT name, timestampdiff(YEAR, birthday_at, now()) , date_format(birthday_at, "%d.%m.%Y") FROM users;
SELECT name, DATE_FORMAT(created_at, '%d.%m.%Y %k:%i'), DATE_FORMAT(updated_at, '%d.%m.%Y %k:%i') FROM users;
UPDATE users SET created_at = DATE_FORMAT(created_at, '%d.%m.%Y %k:%i'), updated_at = DATE_FORMAT(updated_at, '%d.%m.%Y %k:%i');


SELECT name,created_at, STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i') FROM users;
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users MODIFY COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

/*
3.	В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех.
*/
-- прогружаем из терминала БД (SOURCE fulldb17-02-2021 13-58.sql)
-- вы
SELECT * FROM (SELECT * FROM storehouses_products WHERE value <> 0 ORDER BY value LIMIT 1000) AS a UNION SELECT * FROM storehouses_products WHERE value = 0;

-- то-же самое , но чуть элегантнее (2147483647 - максимальное значение INT)
SELECT *, IF(value>0, value, 2147483647)  AS value_2 FROM storehouses_products  ORDER BY value_2;
SELECT *, IF(value>0, value, (SELECT max(value)+1 FROM storehouses_products))  AS value_2 FROM storehouses_products  ORDER BY value_2;

-- нормальный вид запроса со связанными таблицами
SELECT p.name 'Продукт', s.name 'Склад', sp.value 'Запас', DATE_FORMAT(sp.updated_at, GET_FORMAT(DATE, 'EUR')) 'Дата', IF(value>0, value, 2147483647) AS value_2 FROM storehouses_products sp, storehouses s, products p WHERE sp.storehouse_id = s.id AND sp.product_id = p.id ORDER BY value_2;

-- 4.	Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT name, birthday_at, date_format(birthday_at, "%M") AS birthday_month FROM users;
SELECT * FROM (SELECT name, date_format(birthday_at, "%M") AS birthday_month FROM users) AS u WHERE birthday_month IN ('may', 'august');

/*
5.	Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN
 */
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIND_IN_SET(id, '5,1,2');
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
SELECT * FROM catalogs WHERE id IN (5, 1, 2) 
	ORDER BY	CASE ID	WHEN 5 THEN 0 
						WHEN 1 THEN 1
						WHEN 2 THEN 2
				END;
-- 6.	Подсчитайте средний возраст пользователей в таблице users
-- SELECT name, timestampdiff(YEAR, birthday_at, now()) , date_format(birthday_at, "%d.%m.%Y") FROM users;
SELECT avg(timestampdiff(YEAR, birthday_at, curdate())) FROM users;		
SELECT round(avg(timestampdiff(YEAR, birthday_at, curdate()))) FROM users;			
SELECT name, DATEDIFF(curdate(), birthday_at)/365.25, timestampdiff(YEAR, birthday_at, curdate()) FROM users;
SELECT avg(DATEDIFF(curdate(), birthday_at)/365.25) FROM users;

-- 7.	Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT name, birthday_at, day(birthday_at), MONTH (birthday_at), YEAR(curdate()) FROM users;
SELECT name, birthday_at, concat(YEAR(curdate()), '-', MONTH (birthday_at), '-', day(birthday_at))	FROM users;
SELECT name, birthday_at, concat(YEAR(curdate()), substr(birthday_at,5,6))	FROM users;
SELECT name, birthday_at, DAYNAME(concat(YEAR(curdate()), substr(birthday_at,5,6)))	FROM users;
SELECT DAYNAME(concat(YEAR(curdate()), substr(birthday_at,5,6))) AS day_week, count(*) FROM users GROUP BY day_week;


-- 8.	Подсчитайте произведение чисел в столбце таблицы.
select * from generate_series(0, 100) number;

DROP TEMPORARY TABLE IF EXISTS table_tmp;
CREATE TEMPORARY TABLE IF NOT EXISTS table_tmp (value int);
-- CREATE TEMPORARY TABLE IF NOT EXISTS table_tmp (value int NOT NULL AUTO_INCREMENT, PRIMARY KEY (`value`));

-- INSERT INTO table_tmp VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9);
INSERT INTO table_tmp SELECT NULL FROM storehouses_products LIMIT 15;

UPDATE table_tmp SET value=@num:=@num+1 WHERE 0 IN (SELECT @num:=0);
SELECT * FROM table_tmp;
UPDATE table_tmp SET value=0 WHERE value = 1;

SELECT round(exp(sum(log(value)))) FROM table_tmp;

