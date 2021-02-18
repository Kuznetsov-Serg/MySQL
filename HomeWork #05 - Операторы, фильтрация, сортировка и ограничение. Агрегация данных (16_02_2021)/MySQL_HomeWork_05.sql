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

-- SELECT name, timestampdiff(YEAR, birthday_at, now()) , date_format(birthday_at, "%d.%m.%Y") FROM users;
SELECT name, DATE_FORMAT(created_at, '%d.%m.%Y %k:%i'), DATE_FORMAT(updated_at, '%d.%m.%Y %k:%i') FROM users;
UPDATE users SET created_at = DATE_FORMAT(created_at, '%d.%m.%Y %k:%i'), updated_at = DATE_FORMAT(updated_at, '%d.%m.%Y %k:%i');


SELECT name,created_at, STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i') FROM users;
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users MODIFY COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users MODIFY COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- прогружаем из терминала БД (SOURCE fulldb17-02-2021 13-58.sql)
-- вы
SELECT * FROM (SELECT * FROM storehouses_products WHERE value <> 0 ORDER BY value LIMIT 1000) AS a UNION SELECT * FROM storehouses_products WHERE value = 0;

-- то-же самое , но чуть элегантнее (2147483647 - максимальное значение INT)
SELECT *, IF(value>0, value, 2147483647)  AS value_2 FROM storehouses_products  ORDER BY value_2;
SELECT *, IF(value>0, value, (SELECT max(value)+1 FROM storehouses_products))  AS value_2 FROM storehouses_products  ORDER BY value_2;

-- нормальный вид запроса со связанными таблицами
SELECT p.name 'Продукт', s.name 'Склад', sp.value 'Запас', DATE_FORMAT(sp.updated_at, GET_FORMAT(DATE, 'EUR')) 'Дата', IF(value>0, value, 2147483647) AS value_2 FROM storehouses_products sp, storehouses s, products p WHERE sp.storehouse_id = s.id AND sp.product_id = p.id ORDER BY value_2;

SELECT name, birthday_at, date_format(birthday_at, "%M") AS birthday_month FROM users;
SELECT * FROM (SELECT name, date_format(birthday_at, "%M") AS birthday_month FROM users) AS u WHERE birthday_month IN ('may', 'august');

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIND_IN_SET(id, '5,1,2');
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);
SELECT * FROM catalogs WHERE id IN (5, 1, 2) 
	ORDER BY	CASE ID	WHEN 5 THEN 0 
						WHEN 1 THEN 1
						WHEN 2 THEN 2
				END;
