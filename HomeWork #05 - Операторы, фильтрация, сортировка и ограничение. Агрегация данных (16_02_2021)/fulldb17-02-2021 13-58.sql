#
# TABLE STRUCTURE FOR: catalogs
#

DROP TABLE IF EXISTS `catalogs`;

CREATE TABLE `catalogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Разделы интернет-магазина';

INSERT INTO `catalogs` (`id`, `name`) VALUES ('1', 'Процессоры');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('2', 'Материнские платы');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('3', 'Видеокарты');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('4', 'Жесткие диски');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('5', 'Оперативная память');


#
# TABLE STRUCTURE FOR: discounts
#

DROP TABLE IF EXISTS `discounts`;

CREATE TABLE `discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `discount` float unsigned DEFAULT NULL COMMENT 'Величина скидки от 0.0 до 1.0',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`),
  KEY `index_of_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Скидки';

#
# TABLE STRUCTURE FOR: orders
#

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Заказы';

#
# TABLE STRUCTURE FOR: orders_products
#

DROP TABLE IF EXISTS `orders_products`;

CREATE TABLE `orders_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `total` int(10) unsigned DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Состав заказа';

#
# TABLE STRUCTURE FOR: products
#

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_catalog_id` (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Товарные позиции';

INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('1', 'Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', '7890.00', 1, '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('2', 'Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', '12700.00', 1, '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('3', 'AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', '4780.00', 1, '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('4', 'AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', '7120.00', 1, '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('5', 'ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', '19310.00', 2, '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('6', 'Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', '4790.00', 2, '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('7', 'MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', '5060.00', 2, '2021-02-17 13:43:25', '2021-02-17 13:43:25');


#
# TABLE STRUCTURE FOR: storehouses
#

DROP TABLE IF EXISTS `storehouses`;

CREATE TABLE `storehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Склады';

INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'Greenfelder and Sons', '2017-05-07 19:43:17', '2019-04-04 17:48:11');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('2', 'Satterfield-Donnelly', '2020-05-15 13:34:58', '2019-10-28 15:39:09');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('3', 'Lebsack-Reinger', '2017-09-18 22:27:14', '2020-10-04 08:53:53');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('4', 'Emard-Bradtke', '2011-11-28 03:06:25', '2011-11-22 01:56:40');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('5', 'Schneider PLC', '2014-08-16 18:03:32', '2018-02-10 07:10:13');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('6', 'McClure Inc', '2013-09-24 14:39:33', '2011-03-10 21:37:30');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('7', 'Hessel-Greenfelder', '2012-07-08 05:33:58', '2019-06-03 05:17:37');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('8', 'Marquardt, Terry and Ortiz', '2011-12-06 08:34:20', '2016-05-03 21:43:52');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('9', 'Schiller, Hagenes and Bashirian', '2012-04-10 04:36:44', '2019-03-02 22:35:47');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('10', 'Feest-Fisher', '2020-06-14 20:38:17', '2014-10-19 12:47:34');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('11', 'Botsford and Sons', '2018-05-29 01:55:20', '2017-12-22 22:24:08');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('12', 'VonRueden, Hauck and Sporer', '2012-05-26 19:01:39', '2012-12-05 04:24:16');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('13', 'Denesik, Romaguera and Hintz', '2017-07-03 12:30:20', '2019-05-25 23:18:37');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('14', 'Fadel-Stehr', '2016-11-18 22:36:30', '2019-03-20 08:22:08');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('15', 'Schiller PLC', '2013-06-15 21:40:15', '2014-06-04 04:46:39');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('16', 'Ziemann LLC', '2015-03-22 18:51:27', '2019-03-14 05:39:22');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('17', 'Miller, Treutel and Jaskolski', '2020-01-19 09:29:22', '2017-11-28 22:26:07');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('18', 'Smith, Schmeler and Jones', '2012-06-10 11:56:29', '2017-03-25 01:08:30');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('19', 'Mante, O\'Keefe and Jenkins', '2013-10-25 07:31:22', '2019-04-02 18:36:55');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('20', 'Bradtke-Gusikowski', '2017-12-13 15:57:39', '2016-08-22 15:04:19');


#
# TABLE STRUCTURE FOR: storehouses_products
#

DROP TABLE IF EXISTS `storehouses_products`;

CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Запасы на складе';

INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('1', 1, 1, 76, '2019-06-10 18:06:02', '2012-01-14 14:30:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('2', 2, 2, 16, '2020-08-19 19:11:40', '2013-06-02 21:00:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('3', 3, 3, 59, '2015-10-16 03:56:12', '2011-07-12 14:04:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('4', 4, 4, 97, '2017-07-15 06:07:19', '2020-06-18 20:17:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('5', 5, 5, 82, '2018-06-05 06:56:49', '2020-08-25 14:46:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('6', 6, 6, 51, '2013-02-28 10:10:28', '2015-03-01 20:51:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('7', 7, 7, 90, '2017-08-19 08:36:42', '2015-04-13 04:08:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('8', 8, 1, 47, '2017-01-10 11:07:43', '2016-10-04 08:37:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('9', 9, 2, 8, '2017-07-18 14:23:36', '2014-05-07 00:58:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('10', 10, 3, 76, '2019-03-01 12:55:36', '2013-12-06 10:09:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('11', 11, 4, 20, '2018-07-13 16:57:57', '2018-12-10 09:57:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('12', 12, 5, 72, '2015-02-01 13:30:33', '2014-06-25 01:23:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('13', 13, 6, 53, '2014-01-29 15:28:11', '2011-12-05 03:17:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('14', 14, 7, 81, '2018-04-04 01:10:31', '2020-04-10 18:02:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('15', 15, 1, 20, '2013-01-15 22:51:58', '2014-05-09 09:41:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('16', 16, 2, 17, '2015-10-15 07:20:08', '2013-10-23 01:12:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('17', 17, 3, 39, '2017-03-10 08:41:37', '2020-03-17 04:25:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('18', 18, 4, 89, '2011-10-20 15:39:14', '2012-08-02 19:05:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('19', 19, 5, 92, '2016-01-14 06:00:14', '2015-03-22 05:38:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('20', 20, 6, 12, '2011-11-26 19:18:16', '2018-10-18 02:00:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('21', 1, 7, 71, '2011-04-14 23:51:58', '2014-05-14 19:57:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('22', 2, 1, 77, '2015-05-12 05:11:56', '2018-08-02 11:29:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('23', 3, 2, 30, '2013-06-22 19:17:55', '2021-02-13 17:07:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('24', 4, 3, 0, '2015-08-27 04:49:37', '2019-03-24 15:33:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('25', 5, 4, 33, '2018-05-27 06:09:34', '2011-11-25 06:27:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('26', 6, 5, 39, '2018-06-30 13:55:49', '2015-07-06 15:19:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('27', 7, 6, 69, '2018-05-02 14:16:02', '2016-09-12 06:21:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('28', 8, 7, 44, '2012-01-17 12:47:19', '2020-07-20 11:57:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('29', 9, 1, 42, '2012-11-28 07:39:38', '2018-04-05 12:08:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('30', 10, 2, 17, '2011-04-29 02:16:21', '2016-05-17 15:18:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('31', 11, 3, 10, '2015-11-13 23:44:06', '2015-11-22 16:34:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('32', 12, 4, 59, '2020-03-22 23:03:46', '2016-11-28 21:33:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('33', 13, 5, 88, '2016-03-28 05:23:14', '2018-12-24 00:22:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('34', 14, 6, 46, '2013-05-04 16:14:37', '2013-02-12 14:45:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('35', 15, 7, 82, '2020-02-11 11:27:36', '2017-08-19 02:09:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('36', 16, 1, 1, '2018-09-19 14:21:26', '2020-12-03 04:12:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('37', 17, 2, 98, '2019-03-11 17:42:18', '2013-04-30 12:39:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('38', 18, 3, 42, '2018-08-11 13:25:16', '2015-01-17 12:09:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('39', 19, 4, 81, '2015-09-01 06:53:49', '2015-09-27 02:44:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('40', 20, 5, 12, '2016-10-14 04:24:12', '2013-11-14 11:04:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('41', 1, 6, 0, '2019-11-13 08:11:54', '2017-07-11 23:45:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('42', 2, 7, 61, '2016-10-15 01:53:57', '2015-12-14 15:05:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('43', 3, 1, 63, '2020-10-26 08:12:57', '2017-05-23 10:55:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('44', 4, 2, 14, '2015-01-03 13:20:57', '2015-02-16 18:11:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('45', 5, 3, 27, '2014-10-03 05:00:24', '2018-08-29 01:42:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('46', 6, 4, 85, '2019-10-16 03:01:55', '2021-02-06 08:08:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('47', 7, 5, 95, '2012-08-01 07:27:30', '2015-10-01 17:42:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('48', 8, 6, 6, '2017-04-14 03:14:14', '2020-05-25 02:35:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('49', 9, 7, 43, '2015-10-18 07:15:15', '2016-09-02 07:22:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('50', 10, 1, 0, '2012-05-08 16:17:45', '2016-02-19 14:28:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('51', 11, 2, 72, '2014-02-05 20:25:00', '2015-06-26 16:31:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('52', 12, 3, 100, '2018-06-20 21:37:46', '2017-05-18 02:35:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('53', 13, 4, 78, '2013-07-01 02:57:18', '2012-06-12 11:47:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('54', 14, 5, 59, '2014-10-02 14:31:11', '2020-04-13 04:32:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('55', 15, 6, 35, '2018-08-02 03:17:12', '2011-10-07 22:03:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('56', 16, 7, 20, '2014-02-05 00:43:12', '2012-08-11 15:18:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('57', 17, 1, 52, '2012-03-27 14:58:41', '2011-10-11 12:30:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('58', 18, 2, 10, '2014-04-25 10:22:37', '2012-06-07 03:13:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('59', 19, 3, 44, '2017-05-30 10:21:48', '2011-06-12 11:53:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('60', 20, 4, 88, '2017-02-06 19:22:38', '2019-05-11 20:13:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('61', 1, 5, 17, '2013-02-27 20:17:30', '2014-01-22 14:13:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('62', 2, 6, 11, '2012-04-24 17:13:51', '2015-10-22 14:58:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('63', 3, 7, 48, '2015-05-11 00:12:00', '2017-02-03 12:03:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('64', 4, 1, 36, '2018-03-18 14:16:06', '2015-09-01 09:20:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('65', 5, 2, 78, '2020-02-17 10:38:52', '2015-11-03 06:04:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('66', 6, 3, 49, '2020-10-18 00:22:15', '2012-01-02 07:25:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('67', 7, 4, 78, '2011-04-01 21:16:29', '2018-03-08 05:05:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('68', 8, 5, 86, '2014-08-10 23:56:27', '2011-08-13 13:03:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('69', 9, 6, 64, '2015-10-15 05:33:19', '2011-03-19 04:50:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('70', 10, 7, 52, '2019-04-14 20:13:27', '2016-04-21 02:17:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('71', 11, 1, 82, '2014-08-03 10:25:01', '2017-03-17 20:41:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('72', 12, 2, 31, '2016-12-22 23:06:24', '2012-05-07 06:53:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('73', 13, 3, 21, '2019-12-03 02:00:45', '2018-12-30 16:31:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('74', 14, 4, 29, '2017-07-03 22:30:07', '2016-04-16 05:38:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('75', 15, 5, 7, '2016-10-20 14:14:34', '2011-12-26 18:55:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('76', 16, 6, 71, '2020-10-31 16:54:28', '2018-05-23 00:20:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('77', 17, 7, 50, '2011-07-30 18:43:06', '2012-05-26 03:55:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('78', 18, 1, 13, '2017-02-03 19:32:45', '2015-07-12 09:31:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('79', 19, 2, 54, '2020-12-06 00:03:54', '2012-04-18 05:54:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('80', 20, 3, 26, '2014-05-01 04:22:38', '2014-05-03 22:24:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('81', 1, 4, 31, '2014-03-08 04:05:49', '2015-08-01 21:40:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('82', 2, 5, 46, '2011-03-27 22:48:50', '2018-07-02 14:08:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('83', 3, 6, 7, '2017-10-12 03:24:28', '2016-05-04 04:56:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('84', 4, 7, 28, '2016-08-09 18:55:47', '2020-09-17 23:21:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('85', 5, 1, 31, '2012-11-27 22:52:46', '2014-10-21 21:44:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('86', 6, 2, 35, '2020-04-02 08:24:49', '2011-03-25 13:20:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('87', 7, 3, 95, '2015-05-09 17:51:44', '2019-10-19 16:21:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('88', 8, 4, 76, '2016-11-06 04:12:04', '2020-05-25 22:54:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('89', 9, 5, 83, '2014-01-07 13:17:57', '2018-08-19 22:26:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('90', 10, 6, 56, '2012-08-21 02:47:32', '2013-03-26 04:14:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('91', 11, 7, 28, '2017-06-26 18:30:02', '2020-02-24 13:57:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('92', 12, 1, 18, '2018-07-22 05:41:10', '2015-12-26 21:36:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('93', 13, 2, 58, '2015-12-30 06:39:25', '2012-12-06 22:19:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('94', 14, 3, 27, '2018-06-21 04:09:34', '2014-12-10 18:16:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('95', 15, 4, 37, '2016-11-02 18:20:17', '2014-06-05 04:22:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('96', 16, 5, 45, '2015-10-19 11:56:27', '2018-11-12 22:50:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('97', 17, 6, 23, '2013-01-02 08:06:23', '2020-10-25 00:06:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('98', 18, 7, 96, '2020-01-02 08:08:24', '2019-03-27 16:14:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('99', 19, 1, 85, '2018-07-06 00:08:55', '2012-12-05 12:35:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('100', 20, 2, 67, '2013-11-14 03:37:14', '2013-09-02 07:06:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('101', 1, 3, 50, '2013-02-26 12:38:38', '2016-10-11 03:33:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('102', 2, 4, 18, '2014-06-10 03:58:01', '2013-09-28 06:39:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('103', 3, 5, 98, '2019-02-22 12:27:59', '2016-12-26 07:27:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('104', 4, 6, 38, '2020-11-04 13:11:44', '2012-05-06 14:59:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('105', 5, 7, 79, '2015-09-12 22:30:22', '2012-10-15 14:14:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('106', 6, 1, 77, '2020-10-27 05:17:00', '2012-05-22 17:43:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('107', 7, 2, 87, '2012-05-23 01:36:59', '2016-10-02 14:21:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('108', 8, 3, 1, '2015-09-04 12:49:52', '2015-01-31 14:14:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('109', 9, 4, 100, '2018-07-21 07:05:54', '2011-04-05 18:48:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('110', 10, 5, 63, '2019-03-03 00:24:46', '2020-03-30 03:41:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('111', 11, 6, 9, '2018-04-16 12:50:23', '2013-11-07 04:35:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('112', 12, 7, 28, '2014-10-30 11:13:29', '2012-01-17 07:52:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('113', 13, 1, 14, '2011-02-26 19:36:04', '2013-03-23 06:09:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('114', 14, 2, 100, '2020-12-25 22:14:18', '2012-02-23 11:14:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('115', 15, 3, 3, '2013-04-27 16:13:28', '2012-06-14 00:57:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('116', 16, 4, 23, '2015-03-20 11:38:46', '2016-02-17 05:16:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('117', 17, 5, 81, '2018-09-22 06:45:04', '2018-04-08 02:18:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('118', 18, 6, 40, '2018-01-07 23:58:14', '2012-07-25 23:42:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('119', 19, 7, 99, '2012-06-09 09:49:35', '2018-01-01 22:17:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('120', 20, 1, 100, '2015-09-04 20:10:52', '2016-10-25 00:23:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('121', 1, 2, 1, '2019-05-07 04:17:26', '2018-12-08 03:27:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('122', 2, 3, 35, '2015-04-07 01:54:48', '2016-04-18 18:21:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('123', 3, 4, 55, '2013-11-24 00:24:43', '2017-04-14 15:32:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('124', 4, 5, 93, '2011-03-02 00:31:15', '2013-03-02 12:00:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('125', 5, 6, 80, '2014-12-26 16:20:32', '2012-11-29 01:07:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('126', 6, 7, 65, '2013-07-01 11:33:25', '2020-11-28 15:43:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('127', 7, 1, 17, '2013-08-01 11:55:19', '2017-03-04 22:52:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('128', 8, 2, 52, '2020-12-06 05:25:57', '2013-10-11 08:09:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('129', 9, 3, 13, '2019-08-07 13:28:03', '2011-12-17 17:37:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('130', 10, 4, 83, '2016-09-21 01:11:00', '2011-04-10 06:01:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('131', 11, 5, 29, '2012-04-10 23:21:21', '2015-01-15 19:27:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('132', 12, 6, 86, '2018-09-15 16:27:12', '2016-10-31 22:56:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('133', 13, 7, 95, '2016-11-30 01:12:33', '2014-04-15 03:04:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('134', 14, 1, 77, '2012-04-29 16:47:59', '2014-01-16 11:26:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('135', 15, 2, 85, '2016-08-01 23:51:00', '2016-04-18 20:47:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('136', 16, 3, 46, '2018-06-13 09:22:44', '2016-04-05 20:59:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('137', 17, 4, 10, '2017-10-11 19:45:39', '2020-09-17 04:02:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('138', 18, 5, 62, '2020-02-29 03:06:02', '2019-08-04 19:29:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('139', 19, 6, 83, '2014-11-06 22:14:07', '2020-10-30 23:17:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('140', 20, 7, 14, '2013-09-04 07:45:21', '2018-09-02 22:21:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('141', 1, 1, 15, '2020-11-18 06:15:26', '2012-01-13 11:39:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('142', 2, 2, 8, '2019-10-20 04:44:01', '2020-08-20 08:58:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('143', 3, 3, 17, '2015-04-17 17:11:59', '2015-05-28 18:26:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('144', 4, 4, 51, '2018-11-08 03:25:40', '2013-12-02 06:19:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('145', 5, 5, 57, '2021-01-06 16:34:00', '2020-07-06 00:55:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('146', 6, 6, 68, '2013-04-06 17:28:34', '2016-02-23 05:12:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('147', 7, 7, 28, '2014-11-30 00:41:29', '2017-01-21 23:01:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('148', 8, 1, 56, '2012-08-29 20:41:44', '2014-02-09 01:12:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('149', 9, 2, 58, '2017-10-31 16:13:57', '2017-03-17 06:02:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('150', 10, 3, 86, '2012-05-13 19:23:33', '2011-07-11 09:54:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('151', 11, 4, 62, '2018-07-24 09:04:19', '2019-10-08 06:00:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('152', 12, 5, 31, '2011-09-11 22:40:47', '2017-10-23 07:01:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('153', 13, 6, 94, '2013-01-08 01:56:27', '2019-04-04 03:47:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('154', 14, 7, 8, '2019-12-15 08:12:38', '2019-11-20 23:03:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('155', 15, 1, 90, '2011-06-02 21:52:07', '2012-04-13 21:06:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('156', 16, 2, 89, '2017-07-16 23:19:10', '2013-05-26 01:04:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('157', 17, 3, 99, '2020-02-01 16:34:35', '2013-05-02 23:32:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('158', 18, 4, 100, '2016-09-19 06:02:40', '2014-01-21 11:55:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('159', 19, 5, 93, '2018-12-01 06:33:19', '2019-01-08 05:01:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('160', 20, 6, 82, '2019-10-07 11:27:28', '2019-05-05 19:18:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('161', 1, 7, 92, '2013-03-10 10:58:25', '2017-07-02 03:12:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('162', 2, 1, 23, '2014-07-04 12:05:33', '2011-07-12 07:04:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('163', 3, 2, 51, '2019-10-11 07:20:21', '2019-10-26 06:32:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('164', 4, 3, 76, '2013-08-15 08:07:25', '2019-03-15 01:57:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('165', 5, 4, 93, '2014-02-04 04:59:11', '2016-11-22 03:26:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('166', 6, 5, 35, '2015-12-25 16:27:16', '2020-06-22 09:39:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('167', 7, 6, 88, '2015-07-10 17:36:46', '2019-02-09 08:08:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('168', 8, 7, 22, '2020-04-11 14:55:08', '2012-03-13 18:42:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('169', 9, 1, 67, '2016-08-28 09:38:18', '2011-10-31 09:44:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('170', 10, 2, 66, '2016-01-25 02:35:12', '2020-09-03 07:10:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('171', 11, 3, 82, '2020-11-04 06:00:12', '2015-12-24 17:36:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('172', 12, 4, 3, '2015-09-05 13:50:44', '2014-04-04 18:31:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('173', 13, 5, 47, '2014-08-16 17:42:48', '2017-02-13 07:32:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('174', 14, 6, 53, '2019-07-10 03:55:01', '2015-04-14 01:35:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('175', 15, 7, 10, '2012-06-23 14:15:48', '2018-10-07 16:01:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('176', 16, 1, 78, '2018-03-14 19:22:46', '2017-07-25 05:09:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('177', 17, 2, 42, '2011-10-29 17:44:19', '2013-11-01 00:36:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('178', 18, 3, 6, '2017-07-28 15:18:20', '2015-11-09 18:49:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('179', 19, 4, 83, '2016-01-14 00:29:03', '2020-02-16 12:29:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('180', 20, 5, 97, '2015-03-24 19:25:35', '2020-07-23 23:53:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('181', 1, 6, 90, '2015-02-19 06:04:22', '2017-06-01 12:35:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('182', 2, 7, 82, '2011-03-13 06:07:49', '2014-10-19 22:19:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('183', 3, 1, 93, '2014-05-01 21:14:24', '2020-07-23 04:59:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('184', 4, 2, 69, '2016-05-02 01:52:18', '2013-01-28 13:58:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('185', 5, 3, 8, '2015-02-13 13:22:50', '2011-08-18 05:08:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('186', 6, 4, 94, '2020-03-11 15:21:18', '2011-04-27 08:43:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('187', 7, 5, 85, '2018-12-10 21:06:40', '2011-06-15 10:03:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('188', 8, 6, 37, '2013-02-18 02:00:21', '2020-12-20 13:18:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('189', 9, 7, 0, '2017-09-25 06:41:15', '2020-02-04 11:13:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('190', 10, 1, 87, '2020-04-16 18:36:32', '2015-03-16 09:03:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('191', 11, 2, 72, '2018-09-01 09:46:27', '2013-05-21 02:48:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('192', 12, 3, 82, '2015-09-22 16:29:00', '2013-06-12 10:42:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('193', 13, 4, 100, '2012-02-11 11:32:57', '2015-11-06 18:29:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('194', 14, 5, 0, '2018-12-19 07:16:52', '2017-07-31 02:19:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('195', 15, 6, 53, '2015-08-20 05:33:19', '2014-06-06 00:40:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('196', 16, 7, 46, '2014-03-29 01:12:43', '2015-10-04 16:38:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('197', 17, 1, 45, '2019-10-22 06:09:32', '2018-11-03 05:15:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('198', 18, 2, 11, '2011-04-08 09:18:55', '2011-07-24 06:03:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('199', 19, 3, 60, '2014-05-18 03:23:02', '2015-03-09 07:13:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('200', 20, 4, 79, '2013-03-31 13:36:22', '2018-09-27 06:52:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('201', 1, 5, 56, '2015-09-23 05:57:07', '2017-12-22 05:28:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('202', 2, 6, 63, '2017-05-06 09:50:17', '2019-12-14 17:11:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('203', 3, 7, 73, '2011-09-01 16:48:20', '2020-02-14 07:23:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('204', 4, 1, 88, '2014-12-15 09:33:58', '2018-11-04 21:56:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('205', 5, 2, 89, '2012-12-24 18:26:56', '2017-07-01 19:21:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('206', 6, 3, 78, '2019-11-08 10:28:31', '2018-08-12 08:48:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('207', 7, 4, 90, '2019-07-16 10:01:41', '2011-08-22 12:10:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('208', 8, 5, 98, '2020-09-10 22:32:07', '2016-12-12 15:31:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('209', 9, 6, 25, '2013-08-09 20:00:29', '2015-06-13 21:43:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('210', 10, 7, 2, '2019-05-20 16:34:02', '2020-11-04 21:59:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('211', 11, 1, 62, '2012-06-19 22:39:30', '2013-11-20 17:13:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('212', 12, 2, 18, '2014-02-23 11:01:36', '2017-03-19 22:00:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('213', 13, 3, 55, '2017-06-23 04:59:29', '2019-12-19 03:18:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('214', 14, 4, 11, '2015-03-12 18:31:20', '2013-08-15 14:44:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('215', 15, 5, 37, '2015-01-21 05:49:01', '2017-05-17 23:55:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('216', 16, 6, 84, '2013-04-10 21:10:40', '2020-09-25 12:35:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('217', 17, 7, 74, '2019-04-24 07:58:54', '2012-04-24 21:37:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('218', 18, 1, 35, '2013-08-17 11:30:09', '2014-09-21 09:55:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('219', 19, 2, 58, '2012-10-08 05:43:58', '2015-06-04 19:20:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('220', 20, 3, 35, '2016-02-16 10:19:49', '2016-01-12 11:42:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('221', 1, 4, 32, '2017-08-22 15:10:45', '2020-03-17 16:12:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('222', 2, 5, 47, '2013-07-01 06:31:00', '2013-12-08 09:14:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('223', 3, 6, 12, '2019-05-05 12:34:36', '2014-04-10 17:09:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('224', 4, 7, 43, '2018-10-30 18:00:00', '2013-06-19 02:00:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('225', 5, 1, 32, '2013-12-05 19:06:58', '2015-05-15 16:17:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('226', 6, 2, 28, '2017-07-20 10:45:46', '2015-07-25 05:47:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('227', 7, 3, 38, '2021-02-04 00:18:06', '2015-08-16 19:23:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('228', 8, 4, 23, '2018-02-21 21:06:23', '2017-09-02 22:31:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('229', 9, 5, 47, '2020-09-05 22:24:05', '2015-11-28 15:23:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('230', 10, 6, 41, '2016-11-24 13:43:59', '2014-08-27 10:24:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('231', 11, 7, 64, '2020-08-28 01:42:32', '2016-06-03 14:07:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('232', 12, 1, 79, '2018-08-03 13:47:03', '2015-07-29 18:50:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('233', 13, 2, 61, '2020-01-07 21:31:36', '2020-03-31 06:59:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('234', 14, 3, 73, '2016-12-07 21:19:15', '2013-05-20 10:10:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('235', 15, 4, 7, '2016-03-31 16:10:03', '2012-12-05 16:31:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('236', 16, 5, 40, '2016-06-23 16:32:39', '2020-03-20 16:09:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('237', 17, 6, 44, '2020-02-01 06:12:15', '2020-12-20 12:10:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('238', 18, 7, 5, '2017-10-27 02:49:31', '2012-07-19 12:37:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('239', 19, 1, 19, '2014-10-15 17:57:30', '2016-08-14 20:07:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('240', 20, 2, 17, '2012-04-18 19:01:29', '2014-02-20 07:22:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('241', 1, 3, 43, '2015-06-30 13:20:56', '2012-08-23 20:20:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('242', 2, 4, 40, '2012-11-12 01:09:14', '2013-12-28 05:41:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('243', 3, 5, 60, '2011-10-20 19:27:15', '2012-09-07 14:43:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('244', 4, 6, 1, '2012-07-23 18:31:24', '2011-05-30 08:01:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('245', 5, 7, 69, '2011-07-29 00:53:33', '2012-09-19 03:06:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('246', 6, 1, 89, '2016-05-15 13:10:56', '2018-08-20 17:30:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('247', 7, 2, 70, '2012-06-09 23:41:49', '2013-10-30 04:00:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('248', 8, 3, 11, '2013-08-04 03:53:28', '2012-12-13 00:26:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('249', 9, 4, 97, '2018-06-01 06:56:14', '2012-04-05 11:22:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('250', 10, 5, 8, '2019-04-01 00:04:25', '2015-02-01 00:18:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('251', 11, 6, 26, '2020-11-07 07:03:45', '2011-07-28 19:38:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('252', 12, 7, 89, '2016-03-25 06:22:46', '2018-03-25 17:41:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('253', 13, 1, 23, '2018-11-25 22:40:20', '2016-07-22 06:50:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('254', 14, 2, 57, '2015-09-24 19:22:20', '2015-05-25 06:10:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('255', 15, 3, 6, '2018-07-26 18:45:14', '2012-03-23 01:36:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('256', 16, 4, 40, '2011-03-28 16:31:35', '2012-02-15 18:07:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('257', 17, 5, 64, '2012-06-25 01:10:36', '2019-11-21 19:59:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('258', 18, 6, 4, '2021-01-10 18:18:52', '2011-09-06 02:06:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('259', 19, 7, 37, '2018-01-14 06:09:36', '2019-07-23 02:51:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('260', 20, 1, 19, '2021-01-24 00:54:26', '2020-10-03 12:41:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('261', 1, 2, 81, '2020-03-25 21:08:10', '2014-09-19 07:11:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('262', 2, 3, 20, '2015-04-04 21:03:52', '2014-02-10 00:44:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('263', 3, 4, 17, '2016-08-14 02:43:49', '2012-04-05 05:06:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('264', 4, 5, 92, '2018-12-02 19:47:45', '2013-10-25 16:42:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('265', 5, 6, 66, '2020-08-03 03:17:25', '2011-10-29 23:04:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('266', 6, 7, 6, '2013-12-20 13:21:35', '2017-03-07 08:12:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('267', 7, 1, 24, '2018-06-16 19:10:49', '2018-07-18 08:21:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('268', 8, 2, 15, '2011-03-29 03:17:06', '2013-11-28 10:36:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('269', 9, 3, 82, '2012-11-23 06:51:56', '2011-11-30 11:24:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('270', 10, 4, 66, '2020-06-03 09:42:02', '2016-01-18 19:02:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('271', 11, 5, 85, '2013-06-22 10:41:12', '2012-06-14 14:26:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('272', 12, 6, 63, '2013-04-26 17:40:56', '2013-03-25 00:11:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('273', 13, 7, 80, '2018-07-21 19:11:44', '2016-04-03 00:14:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('274', 14, 1, 2, '2012-03-04 23:32:04', '2018-01-20 00:05:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('275', 15, 2, 47, '2018-06-11 00:21:54', '2017-11-30 07:58:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('276', 16, 3, 95, '2016-07-02 05:21:56', '2019-07-09 08:34:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('277', 17, 4, 94, '2020-05-28 05:45:43', '2017-10-30 01:09:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('278', 18, 5, 84, '2015-10-22 05:33:55', '2019-07-06 00:52:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('279', 19, 6, 67, '2020-09-05 19:14:11', '2015-07-26 09:20:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('280', 20, 7, 72, '2013-08-31 04:10:45', '2012-06-07 01:56:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('281', 1, 1, 34, '2014-05-25 11:33:54', '2018-08-06 22:44:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('282', 2, 2, 20, '2014-12-31 02:35:26', '2015-09-06 16:12:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('283', 3, 3, 74, '2016-05-16 15:05:17', '2017-01-30 22:17:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('284', 4, 4, 12, '2014-06-27 14:47:06', '2014-01-19 07:14:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('285', 5, 5, 31, '2014-06-11 18:10:07', '2020-11-21 01:48:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('286', 6, 6, 84, '2014-03-25 07:19:14', '2012-04-13 08:46:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('287', 7, 7, 93, '2019-06-15 01:22:33', '2014-04-27 22:45:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('288', 8, 1, 60, '2019-09-28 00:24:07', '2020-09-03 06:43:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('289', 9, 2, 23, '2016-06-16 11:48:47', '2015-04-12 05:30:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('290', 10, 3, 30, '2020-12-06 13:40:29', '2019-10-28 04:20:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('291', 11, 4, 39, '2014-08-15 08:00:36', '2011-06-07 00:56:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('292', 12, 5, 21, '2011-12-01 04:56:27', '2015-07-11 12:32:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('293', 13, 6, 25, '2012-04-07 03:23:54', '2013-05-26 22:25:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('294', 14, 7, 57, '2015-06-05 00:36:33', '2015-11-22 03:14:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('295', 15, 1, 48, '2018-09-04 20:09:28', '2014-09-22 11:45:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('296', 16, 2, 21, '2011-05-24 14:04:45', '2013-05-21 20:41:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('297', 17, 3, 41, '2015-07-25 07:14:54', '2019-06-22 13:02:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('298', 18, 4, 6, '2015-12-02 16:13:02', '2019-07-08 07:01:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('299', 19, 5, 74, '2020-07-23 02:24:16', '2015-11-19 19:18:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('300', 20, 6, 42, '2017-03-20 17:17:27', '2017-03-13 02:31:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('301', 1, 7, 7, '2014-05-01 09:08:55', '2020-11-09 00:22:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('302', 2, 1, 0, '2016-07-08 22:57:44', '2019-06-08 15:01:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('303', 3, 2, 50, '2011-06-29 07:51:42', '2011-11-20 15:07:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('304', 4, 3, 90, '2015-07-08 11:36:26', '2013-10-09 09:46:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('305', 5, 4, 80, '2016-06-22 22:50:06', '2018-09-12 23:26:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('306', 6, 5, 38, '2013-09-24 09:52:04', '2017-03-16 05:30:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('307', 7, 6, 85, '2020-01-30 11:42:29', '2014-07-10 14:44:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('308', 8, 7, 0, '2013-05-12 14:29:56', '2018-02-01 14:18:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('309', 9, 1, 100, '2015-07-01 18:50:58', '2014-04-04 21:48:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('310', 10, 2, 11, '2020-08-05 03:55:22', '2021-02-13 20:15:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('311', 11, 3, 55, '2012-05-12 04:59:42', '2015-02-24 23:52:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('312', 12, 4, 12, '2015-04-09 16:18:09', '2012-06-26 06:52:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('313', 13, 5, 9, '2016-08-14 23:19:17', '2013-11-07 04:42:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('314', 14, 6, 52, '2014-10-16 14:46:54', '2019-01-20 13:14:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('315', 15, 7, 40, '2020-01-05 15:24:27', '2012-12-16 08:23:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('316', 16, 1, 3, '2019-08-15 11:39:43', '2016-12-16 03:49:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('317', 17, 2, 69, '2020-05-31 03:05:38', '2011-10-27 06:00:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('318', 18, 3, 0, '2016-07-22 03:02:47', '2015-01-01 01:08:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('319', 19, 4, 53, '2015-11-11 18:21:31', '2020-08-02 01:00:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('320', 20, 5, 29, '2017-05-02 11:24:21', '2019-12-07 14:49:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('321', 1, 6, 69, '2018-09-28 07:28:55', '2013-08-01 18:04:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('322', 2, 7, 58, '2012-03-19 08:00:18', '2016-09-06 18:33:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('323', 3, 1, 63, '2016-09-09 14:19:46', '2015-03-30 13:08:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('324', 4, 2, 75, '2017-11-07 01:48:54', '2011-08-18 10:18:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('325', 5, 3, 4, '2015-09-08 15:29:44', '2012-10-06 00:28:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('326', 6, 4, 12, '2011-05-19 12:52:29', '2019-08-02 09:59:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('327', 7, 5, 42, '2019-11-08 18:12:43', '2014-08-12 06:00:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('328', 8, 6, 47, '2013-07-25 19:44:36', '2015-05-26 00:04:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('329', 9, 7, 40, '2020-06-14 12:43:33', '2012-07-09 21:40:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('330', 10, 1, 97, '2011-09-05 12:57:54', '2011-09-19 15:15:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('331', 11, 2, 81, '2020-12-03 17:28:41', '2015-07-05 19:56:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('332', 12, 3, 4, '2015-11-04 10:40:29', '2011-09-04 19:26:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('333', 13, 4, 27, '2015-01-10 12:48:56', '2012-08-12 03:27:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('334', 14, 5, 42, '2018-09-23 15:15:29', '2020-04-25 15:04:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('335', 15, 6, 33, '2012-12-13 08:00:48', '2017-03-28 05:07:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('336', 16, 7, 32, '2015-02-06 07:57:04', '2011-05-23 03:37:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('337', 17, 1, 81, '2016-01-06 06:55:12', '2016-05-14 19:49:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('338', 18, 2, 25, '2011-11-03 23:24:09', '2016-03-19 19:31:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('339', 19, 3, 44, '2020-09-18 22:29:56', '2014-02-13 00:01:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('340', 20, 4, 92, '2018-03-09 10:40:37', '2019-10-05 12:49:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('341', 1, 5, 8, '2017-07-30 19:18:25', '2020-03-29 16:14:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('342', 2, 6, 6, '2020-12-29 21:56:57', '2016-06-27 07:51:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('343', 3, 7, 68, '2015-02-27 16:16:48', '2013-07-25 22:52:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('344', 4, 1, 50, '2014-01-24 13:34:45', '2015-09-24 03:57:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('345', 5, 2, 46, '2019-12-18 22:35:03', '2011-02-25 12:43:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('346', 6, 3, 39, '2013-08-28 04:22:01', '2011-06-03 11:34:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('347', 7, 4, 2, '2012-02-04 03:50:59', '2019-09-20 18:35:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('348', 8, 5, 9, '2018-12-21 16:04:24', '2019-01-29 05:39:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('349', 9, 6, 54, '2018-04-01 12:58:14', '2020-10-22 12:54:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('350', 10, 7, 58, '2020-05-26 14:46:14', '2020-03-23 06:01:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('351', 11, 1, 44, '2014-08-19 02:27:33', '2014-07-28 03:47:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('352', 12, 2, 49, '2013-07-17 22:25:49', '2012-12-30 06:53:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('353', 13, 3, 70, '2015-04-13 16:30:17', '2020-12-24 09:13:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('354', 14, 4, 24, '2013-04-14 06:50:23', '2018-03-20 19:38:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('355', 15, 5, 4, '2015-01-07 21:44:08', '2018-06-08 01:35:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('356', 16, 6, 4, '2014-10-02 20:24:58', '2017-06-13 23:33:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('357', 17, 7, 67, '2012-12-10 04:42:54', '2018-11-14 07:28:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('358', 18, 1, 47, '2013-03-10 15:21:09', '2016-09-04 18:22:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('359', 19, 2, 79, '2017-10-08 05:28:34', '2018-12-06 06:34:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('360', 20, 3, 26, '2014-08-11 00:46:08', '2021-01-26 15:08:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('361', 1, 4, 31, '2016-05-21 16:47:31', '2013-02-16 10:35:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('362', 2, 5, 86, '2018-01-17 17:53:08', '2013-01-26 17:26:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('363', 3, 6, 93, '2018-03-27 15:29:56', '2012-04-05 17:05:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('364', 4, 7, 35, '2018-10-09 01:59:18', '2020-07-21 18:17:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('365', 5, 1, 25, '2017-04-04 18:48:08', '2019-02-11 15:11:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('366', 6, 2, 62, '2018-12-17 11:20:53', '2015-03-23 20:29:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('367', 7, 3, 95, '2018-01-01 12:13:21', '2011-10-22 04:14:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('368', 8, 4, 50, '2014-03-12 04:22:19', '2011-05-03 18:58:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('369', 9, 5, 55, '2011-06-25 06:07:08', '2020-07-25 09:50:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('370', 10, 6, 29, '2015-11-10 01:06:25', '2020-11-16 17:55:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('371', 11, 7, 4, '2011-10-12 06:02:03', '2011-05-26 20:49:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('372', 12, 1, 13, '2014-05-21 06:20:45', '2017-04-07 08:18:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('373', 13, 2, 4, '2020-11-25 20:07:57', '2011-04-20 07:37:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('374', 14, 3, 36, '2016-12-06 06:58:23', '2011-04-24 15:25:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('375', 15, 4, 11, '2016-01-15 09:39:58', '2015-07-21 15:48:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('376', 16, 5, 60, '2017-04-06 22:48:43', '2021-02-04 18:24:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('377', 17, 6, 79, '2015-01-17 23:49:32', '2020-03-25 06:41:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('378', 18, 7, 19, '2016-09-10 00:43:45', '2017-01-12 22:15:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('379', 19, 1, 43, '2015-05-21 00:00:09', '2018-03-18 17:10:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('380', 20, 2, 66, '2020-01-27 07:26:24', '2020-02-15 08:48:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('381', 1, 3, 79, '2012-10-04 15:29:12', '2019-07-08 15:34:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('382', 2, 4, 6, '2011-12-29 15:44:28', '2012-11-04 06:57:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('383', 3, 5, 50, '2020-02-09 14:27:31', '2011-10-16 03:36:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('384', 4, 6, 81, '2011-03-27 14:09:06', '2012-07-17 00:12:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('385', 5, 7, 52, '2012-02-18 17:02:51', '2012-02-26 02:15:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('386', 6, 1, 87, '2013-07-21 05:33:33', '2019-10-25 01:41:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('387', 7, 2, 3, '2015-12-19 18:57:13', '2011-12-24 17:19:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('388', 8, 3, 76, '2019-05-11 04:03:12', '2019-03-23 23:32:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('389', 9, 4, 41, '2015-09-05 12:20:20', '2018-01-07 18:55:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('390', 10, 5, 17, '2013-02-22 11:01:41', '2016-05-12 06:51:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('391', 11, 6, 41, '2015-04-14 16:00:20', '2020-06-09 04:39:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('392', 12, 7, 22, '2016-03-18 02:29:13', '2011-03-06 06:29:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('393', 13, 1, 60, '2017-10-15 04:46:28', '2016-05-03 15:29:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('394', 14, 2, 70, '2011-11-11 10:21:15', '2017-08-17 18:24:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('395', 15, 3, 4, '2011-10-25 23:32:54', '2016-02-03 11:33:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('396', 16, 4, 97, '2015-09-19 22:36:34', '2019-11-06 21:49:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('397', 17, 5, 47, '2017-08-17 09:30:43', '2016-08-10 14:24:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('398', 18, 6, 87, '2020-01-04 22:44:04', '2015-09-15 18:49:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('399', 19, 7, 24, '2015-09-21 00:00:08', '2016-11-28 19:13:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('400', 20, 1, 4, '2014-11-21 03:08:25', '2014-06-16 08:49:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('401', 1, 2, 61, '2020-05-08 06:27:58', '2013-06-23 13:03:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('402', 2, 3, 25, '2014-01-05 05:41:03', '2012-12-23 00:36:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('403', 3, 4, 41, '2019-11-09 08:01:28', '2014-12-23 13:11:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('404', 4, 5, 45, '2016-01-12 08:56:19', '2015-01-23 04:04:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('405', 5, 6, 11, '2018-02-02 04:40:43', '2012-06-05 19:45:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('406', 6, 7, 64, '2014-07-21 23:12:31', '2021-02-08 16:01:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('407', 7, 1, 100, '2020-03-30 17:01:48', '2020-12-01 18:02:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('408', 8, 2, 4, '2016-06-08 01:12:35', '2019-01-12 09:19:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('409', 9, 3, 81, '2014-04-22 20:34:42', '2021-01-31 04:25:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('410', 10, 4, 16, '2016-12-09 12:08:04', '2011-04-19 15:46:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('411', 11, 5, 62, '2018-08-03 09:16:26', '2020-10-17 18:04:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('412', 12, 6, 88, '2018-04-11 00:34:06', '2011-11-25 03:29:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('413', 13, 7, 14, '2020-06-17 03:14:12', '2014-05-03 21:20:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('414', 14, 1, 12, '2017-05-13 02:03:27', '2011-09-12 06:27:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('415', 15, 2, 16, '2015-04-23 11:55:25', '2014-11-13 08:31:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('416', 16, 3, 33, '2016-02-01 02:17:11', '2011-10-09 03:11:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('417', 17, 4, 82, '2013-11-08 04:18:22', '2017-04-18 14:01:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('418', 18, 5, 66, '2016-07-09 02:23:27', '2011-09-08 02:28:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('419', 19, 6, 65, '2016-01-08 09:06:24', '2013-10-21 22:26:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('420', 20, 7, 63, '2018-04-28 10:36:10', '2018-01-14 10:07:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('421', 1, 1, 66, '2015-05-06 19:23:46', '2018-08-24 06:12:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('422', 2, 2, 20, '2020-08-25 01:26:51', '2014-06-01 19:49:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('423', 3, 3, 54, '2014-04-21 03:07:09', '2013-04-21 06:36:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('424', 4, 4, 9, '2012-07-15 03:06:53', '2020-08-12 13:52:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('425', 5, 5, 99, '2011-02-27 07:13:48', '2018-03-03 15:49:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('426', 6, 6, 74, '2016-08-19 22:32:40', '2012-02-03 08:19:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('427', 7, 7, 63, '2017-04-02 20:43:22', '2013-01-30 11:08:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('428', 8, 1, 19, '2016-12-03 21:35:02', '2017-04-23 16:31:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('429', 9, 2, 97, '2015-02-24 19:10:57', '2011-09-13 02:13:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('430', 10, 3, 59, '2015-10-18 23:43:21', '2017-09-02 06:21:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('431', 11, 4, 11, '2012-10-26 13:00:22', '2018-07-26 21:14:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('432', 12, 5, 6, '2019-06-03 01:05:08', '2017-12-11 01:25:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('433', 13, 6, 71, '2018-08-10 13:50:18', '2017-02-28 20:45:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('434', 14, 7, 73, '2019-07-21 07:28:32', '2012-08-24 05:11:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('435', 15, 1, 30, '2011-11-21 07:47:56', '2015-01-15 04:36:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('436', 16, 2, 1, '2013-04-23 14:04:42', '2021-02-06 05:42:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('437', 17, 3, 2, '2019-06-08 04:00:17', '2017-06-06 18:52:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('438', 18, 4, 51, '2020-02-05 23:40:13', '2018-07-20 17:37:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('439', 19, 5, 76, '2011-06-28 14:07:47', '2015-10-15 15:05:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('440', 20, 6, 45, '2014-09-11 04:21:39', '2011-06-09 07:34:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('441', 1, 7, 85, '2018-10-11 19:40:22', '2011-03-04 02:34:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('442', 2, 1, 87, '2013-05-21 22:55:34', '2020-02-22 13:23:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('443', 3, 2, 53, '2020-08-24 11:25:48', '2011-08-19 04:57:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('444', 4, 3, 22, '2013-02-19 21:03:01', '2011-02-19 20:51:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('445', 5, 4, 53, '2011-05-17 22:17:01', '2017-04-09 04:42:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('446', 6, 5, 77, '2019-05-03 14:54:26', '2017-11-23 06:46:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('447', 7, 6, 18, '2011-09-08 08:32:17', '2012-01-13 15:58:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('448', 8, 7, 38, '2019-10-02 07:57:10', '2015-08-26 13:10:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('449', 9, 1, 99, '2020-04-17 23:43:42', '2013-12-29 08:40:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('450', 10, 2, 56, '2016-08-21 08:50:53', '2016-02-03 12:32:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('451', 11, 3, 27, '2015-12-30 17:57:47', '2011-12-22 21:20:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('452', 12, 4, 50, '2011-06-17 14:24:02', '2011-11-22 21:17:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('453', 13, 5, 16, '2013-07-26 19:48:49', '2015-05-17 16:22:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('454', 14, 6, 89, '2018-01-18 21:44:58', '2016-12-06 04:51:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('455', 15, 7, 82, '2020-05-15 06:28:57', '2016-04-21 06:45:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('456', 16, 1, 17, '2013-05-26 02:29:12', '2012-05-02 13:21:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('457', 17, 2, 86, '2016-08-27 18:11:00', '2016-06-01 20:58:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('458', 18, 3, 68, '2012-03-06 23:22:19', '2020-06-19 20:32:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('459', 19, 4, 39, '2019-05-15 05:33:24', '2018-03-02 06:00:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('460', 20, 5, 26, '2018-06-04 23:40:51', '2016-01-23 00:30:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('461', 1, 6, 87, '2012-02-27 22:13:37', '2014-12-05 20:58:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('462', 2, 7, 67, '2013-06-10 17:55:29', '2014-09-13 03:37:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('463', 3, 1, 21, '2016-04-09 18:22:56', '2014-12-01 03:27:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('464', 4, 2, 18, '2020-10-05 08:08:52', '2020-01-08 15:25:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('465', 5, 3, 51, '2016-06-24 01:41:29', '2017-05-06 14:38:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('466', 6, 4, 92, '2013-09-26 15:11:52', '2011-12-06 13:00:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('467', 7, 5, 58, '2020-03-30 07:46:39', '2016-08-06 18:39:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('468', 8, 6, 17, '2011-08-05 19:29:20', '2011-08-26 08:10:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('469', 9, 7, 8, '2020-08-19 18:31:52', '2021-01-08 23:59:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('470', 10, 1, 24, '2012-10-14 08:06:29', '2015-06-05 07:11:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('471', 11, 2, 90, '2017-02-05 09:26:24', '2016-08-27 13:44:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('472', 12, 3, 2, '2016-09-01 21:19:38', '2016-12-03 12:32:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('473', 13, 4, 73, '2012-10-07 21:14:25', '2013-11-23 10:35:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('474', 14, 5, 30, '2013-04-29 03:53:39', '2015-04-23 03:23:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('475', 15, 6, 77, '2015-06-27 10:54:16', '2011-08-26 11:12:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('476', 16, 7, 16, '2013-09-11 08:32:54', '2020-05-18 10:15:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('477', 17, 1, 52, '2011-04-04 00:05:19', '2014-09-24 15:06:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('478', 18, 2, 43, '2014-05-06 07:26:44', '2021-01-30 01:01:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('479', 19, 3, 29, '2019-04-30 10:58:37', '2012-11-17 13:42:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('480', 20, 4, 0, '2019-11-21 11:09:37', '2012-12-08 16:46:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('481', 1, 5, 0, '2011-12-23 05:04:23', '2018-04-20 11:10:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('482', 2, 6, 46, '2014-01-12 19:02:02', '2011-10-30 08:29:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('483', 3, 7, 3, '2019-06-23 18:11:01', '2020-07-22 07:07:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('484', 4, 1, 78, '2016-12-03 13:36:28', '2014-01-24 11:58:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('485', 5, 2, 95, '2011-12-19 16:52:02', '2013-12-14 18:45:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('486', 6, 3, 28, '2011-02-25 14:20:44', '2015-10-14 20:24:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('487', 7, 4, 31, '2014-01-11 23:08:15', '2015-03-30 11:06:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('488', 8, 5, 47, '2016-02-24 00:39:54', '2018-10-12 05:27:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('489', 9, 6, 93, '2016-05-20 21:41:41', '2019-04-11 01:49:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('490', 10, 7, 46, '2021-01-31 01:06:57', '2015-05-11 02:32:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('491', 11, 1, 48, '2015-07-25 02:41:14', '2018-07-17 10:29:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('492', 12, 2, 35, '2020-04-18 21:51:39', '2020-04-03 21:38:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('493', 13, 3, 30, '2017-04-14 01:14:21', '2018-10-14 13:28:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('494', 14, 4, 11, '2018-07-23 16:30:37', '2019-03-01 04:13:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('495', 15, 5, 54, '2013-06-08 04:56:16', '2012-12-11 19:41:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('496', 16, 6, 65, '2017-08-20 21:50:02', '2012-12-25 02:44:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('497', 17, 7, 78, '2020-01-19 18:14:21', '2015-06-23 16:59:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('498', 18, 1, 74, '2016-08-26 18:28:03', '2017-06-03 18:09:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('499', 19, 2, 17, '2019-05-09 22:18:31', '2017-04-24 01:24:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('500', 20, 3, 89, '2016-04-23 04:17:30', '2017-10-23 07:44:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('501', 1, 4, 29, '2016-11-23 15:04:15', '2018-05-03 13:01:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('502', 2, 5, 19, '2011-05-13 20:14:54', '2014-02-08 14:12:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('503', 3, 6, 40, '2011-02-22 20:14:58', '2020-02-13 11:40:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('504', 4, 7, 73, '2011-03-25 06:05:50', '2015-05-26 12:05:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('505', 5, 1, 80, '2017-06-11 23:00:39', '2017-09-16 16:12:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('506', 6, 2, 99, '2016-11-08 20:15:17', '2014-12-11 06:00:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('507', 7, 3, 46, '2014-09-19 19:58:46', '2020-09-22 00:51:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('508', 8, 4, 20, '2021-02-10 13:23:56', '2021-01-24 08:29:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('509', 9, 5, 76, '2019-10-13 00:51:03', '2012-04-23 11:14:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('510', 10, 6, 48, '2019-02-15 00:26:47', '2017-10-09 18:36:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('511', 11, 7, 12, '2017-08-03 23:37:18', '2013-02-27 11:41:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('512', 12, 1, 97, '2016-08-21 00:43:55', '2018-04-03 08:47:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('513', 13, 2, 57, '2014-04-07 13:24:55', '2019-08-22 07:24:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('514', 14, 3, 38, '2015-06-10 23:18:52', '2018-04-09 08:18:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('515', 15, 4, 93, '2017-04-30 13:29:28', '2014-03-26 02:22:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('516', 16, 5, 35, '2020-01-15 12:14:48', '2016-05-09 07:57:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('517', 17, 6, 34, '2019-10-24 06:25:42', '2014-06-17 04:04:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('518', 18, 7, 19, '2017-10-10 01:55:54', '2017-03-09 09:51:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('519', 19, 1, 19, '2018-08-30 11:47:23', '2018-10-24 15:10:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('520', 20, 2, 29, '2019-01-31 05:46:52', '2020-12-08 09:14:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('521', 1, 3, 70, '2018-03-16 21:07:29', '2012-04-26 07:43:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('522', 2, 4, 16, '2016-03-26 14:43:50', '2014-10-08 03:27:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('523', 3, 5, 87, '2020-10-21 09:44:45', '2018-08-11 01:43:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('524', 4, 6, 58, '2015-12-14 05:47:24', '2017-02-08 12:05:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('525', 5, 7, 39, '2013-08-12 07:14:51', '2011-03-09 01:57:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('526', 6, 1, 95, '2016-05-13 16:38:00', '2014-06-08 03:42:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('527', 7, 2, 48, '2018-04-23 10:34:44', '2013-03-01 13:22:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('528', 8, 3, 63, '2018-10-04 14:37:34', '2011-04-06 12:39:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('529', 9, 4, 12, '2016-03-07 03:40:23', '2011-07-28 11:28:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('530', 10, 5, 20, '2018-12-15 19:13:10', '2018-03-27 01:04:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('531', 11, 6, 56, '2012-07-17 17:09:03', '2012-05-13 15:04:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('532', 12, 7, 85, '2015-08-13 01:05:53', '2016-08-05 09:29:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('533', 13, 1, 69, '2020-09-22 15:57:31', '2015-10-05 12:48:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('534', 14, 2, 16, '2014-10-13 06:03:03', '2011-03-22 23:40:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('535', 15, 3, 35, '2020-11-22 20:52:58', '2015-10-14 09:11:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('536', 16, 4, 4, '2013-09-02 09:02:12', '2018-09-18 05:18:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('537', 17, 5, 77, '2014-01-29 07:41:57', '2020-09-30 21:24:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('538', 18, 6, 63, '2013-07-23 10:15:13', '2013-07-03 14:32:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('539', 19, 7, 33, '2017-08-28 21:29:46', '2015-02-12 05:22:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('540', 20, 1, 0, '2020-05-18 13:59:20', '2011-07-23 10:22:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('541', 1, 2, 58, '2012-02-21 07:52:24', '2019-10-02 23:43:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('542', 2, 3, 26, '2017-05-07 21:15:15', '2016-10-10 07:29:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('543', 3, 4, 10, '2015-01-29 14:16:17', '2014-08-30 18:19:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('544', 4, 5, 63, '2018-12-17 08:22:06', '2018-12-14 00:40:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('545', 5, 6, 24, '2020-02-29 22:57:55', '2016-08-11 14:50:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('546', 6, 7, 47, '2020-06-30 14:33:07', '2019-03-21 07:34:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('547', 7, 1, 15, '2019-12-04 23:28:34', '2017-11-29 17:01:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('548', 8, 2, 92, '2020-03-24 23:41:05', '2019-09-18 22:47:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('549', 9, 3, 22, '2012-07-30 05:42:31', '2018-06-22 14:40:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('550', 10, 4, 88, '2014-02-07 09:43:56', '2012-02-20 18:46:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('551', 11, 5, 79, '2017-04-11 21:41:24', '2017-09-07 22:21:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('552', 12, 6, 14, '2012-03-08 00:35:07', '2015-06-16 21:17:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('553', 13, 7, 37, '2011-10-16 02:25:19', '2015-04-15 03:02:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('554', 14, 1, 50, '2014-12-08 19:24:21', '2012-03-11 15:50:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('555', 15, 2, 82, '2014-04-11 07:30:36', '2019-01-31 03:38:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('556', 16, 3, 25, '2019-06-27 14:14:52', '2018-01-31 21:06:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('557', 17, 4, 94, '2012-10-10 02:12:25', '2011-05-12 11:38:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('558', 18, 5, 79, '2018-07-10 09:02:51', '2013-06-19 00:59:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('559', 19, 6, 39, '2017-09-07 07:56:30', '2014-06-08 00:42:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('560', 20, 7, 4, '2014-06-28 14:24:59', '2015-10-19 09:29:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('561', 1, 1, 38, '2011-03-10 09:34:24', '2012-08-29 03:57:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('562', 2, 2, 4, '2018-10-24 17:07:37', '2017-05-01 13:06:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('563', 3, 3, 10, '2019-01-03 06:42:29', '2012-04-20 13:03:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('564', 4, 4, 1, '2013-07-23 12:34:09', '2014-06-09 23:14:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('565', 5, 5, 90, '2018-05-24 08:57:07', '2014-08-21 19:24:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('566', 6, 6, 22, '2013-08-16 19:38:17', '2013-08-07 16:32:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('567', 7, 7, 27, '2019-03-07 10:36:22', '2012-06-14 06:46:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('568', 8, 1, 63, '2013-11-21 18:37:59', '2014-09-09 10:21:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('569', 9, 2, 23, '2014-09-25 00:10:18', '2011-06-02 17:18:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('570', 10, 3, 11, '2015-02-03 08:17:14', '2016-11-03 15:16:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('571', 11, 4, 18, '2014-09-23 04:55:00', '2014-03-12 08:34:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('572', 12, 5, 33, '2017-02-27 19:54:30', '2011-07-19 07:15:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('573', 13, 6, 12, '2013-11-03 10:33:11', '2014-06-18 05:50:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('574', 14, 7, 75, '2015-12-02 07:43:48', '2012-07-17 23:34:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('575', 15, 1, 86, '2013-11-19 06:34:01', '2017-10-22 07:57:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('576', 16, 2, 19, '2017-02-16 10:14:36', '2013-05-18 17:16:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('577', 17, 3, 70, '2013-02-08 00:41:32', '2015-03-10 09:21:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('578', 18, 4, 44, '2017-01-25 07:31:58', '2019-01-31 14:50:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('579', 19, 5, 32, '2020-02-11 22:39:32', '2012-05-14 15:11:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('580', 20, 6, 74, '2012-07-16 17:45:48', '2012-04-14 16:18:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('581', 1, 7, 20, '2013-09-04 02:59:33', '2020-10-29 23:11:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('582', 2, 1, 76, '2012-10-11 13:34:31', '2017-01-31 01:33:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('583', 3, 2, 89, '2015-07-31 19:06:27', '2014-08-30 22:18:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('584', 4, 3, 99, '2016-01-27 23:51:58', '2016-03-13 08:07:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('585', 5, 4, 33, '2017-01-31 07:08:42', '2017-10-25 14:41:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('586', 6, 5, 79, '2015-07-26 04:25:10', '2015-09-04 11:29:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('587', 7, 6, 74, '2015-09-13 15:22:06', '2015-03-05 01:44:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('588', 8, 7, 89, '2019-04-05 06:35:15', '2020-02-11 03:32:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('589', 9, 1, 72, '2011-11-06 02:00:23', '2016-08-31 12:57:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('590', 10, 2, 56, '2020-05-01 17:27:31', '2018-11-23 19:00:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('591', 11, 3, 54, '2014-06-29 01:33:39', '2015-09-06 07:00:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('592', 12, 4, 33, '2015-06-02 05:23:52', '2011-09-09 07:17:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('593', 13, 5, 24, '2014-09-05 08:58:51', '2016-07-14 08:23:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('594', 14, 6, 87, '2012-03-26 01:05:21', '2014-04-27 19:01:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('595', 15, 7, 64, '2019-12-20 07:48:45', '2020-06-09 22:34:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('596', 16, 1, 61, '2013-05-21 11:56:10', '2016-05-13 06:15:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('597', 17, 2, 81, '2011-03-02 08:19:35', '2019-10-29 10:56:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('598', 18, 3, 94, '2018-01-09 08:43:57', '2017-12-03 16:29:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('599', 19, 4, 15, '2013-02-20 09:50:12', '2014-10-01 23:20:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('600', 20, 5, 27, '2020-12-06 08:52:12', '2012-08-03 01:56:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('601', 1, 6, 18, '2018-08-05 23:15:43', '2018-03-07 13:47:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('602', 2, 7, 30, '2019-08-14 02:33:04', '2015-04-03 09:35:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('603', 3, 1, 1, '2012-09-03 05:30:53', '2015-04-23 17:13:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('604', 4, 2, 57, '2013-09-26 07:13:44', '2020-07-26 08:28:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('605', 5, 3, 8, '2011-04-22 00:49:50', '2018-03-30 04:13:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('606', 6, 4, 30, '2017-01-17 15:35:44', '2016-09-22 10:30:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('607', 7, 5, 80, '2013-12-18 23:23:08', '2018-05-25 17:25:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('608', 8, 6, 7, '2016-05-16 15:52:21', '2018-11-28 20:53:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('609', 9, 7, 23, '2015-01-01 13:43:52', '2014-11-22 03:28:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('610', 10, 1, 100, '2018-11-15 14:15:50', '2014-09-07 13:07:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('611', 11, 2, 54, '2011-12-28 01:56:09', '2013-11-15 02:22:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('612', 12, 3, 31, '2014-05-09 08:32:39', '2014-12-06 04:22:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('613', 13, 4, 74, '2014-10-12 05:30:26', '2012-03-07 15:29:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('614', 14, 5, 11, '2019-01-18 19:13:35', '2011-10-12 01:54:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('615', 15, 6, 42, '2015-02-13 02:41:15', '2016-01-28 09:18:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('616', 16, 7, 68, '2016-09-27 05:33:40', '2012-10-01 04:19:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('617', 17, 1, 16, '2017-05-05 05:28:22', '2011-03-13 20:18:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('618', 18, 2, 75, '2017-05-28 09:05:27', '2020-07-23 05:16:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('619', 19, 3, 76, '2017-07-04 20:14:00', '2018-03-24 03:45:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('620', 20, 4, 4, '2017-05-18 19:37:39', '2013-05-10 01:02:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('621', 1, 5, 11, '2021-01-14 23:38:57', '2015-12-23 14:32:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('622', 2, 6, 30, '2016-03-31 11:45:40', '2017-12-16 04:48:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('623', 3, 7, 33, '2017-05-22 03:08:49', '2018-03-21 01:32:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('624', 4, 1, 40, '2012-04-13 22:21:49', '2021-02-11 18:47:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('625', 5, 2, 60, '2015-11-11 03:53:10', '2018-03-20 13:09:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('626', 6, 3, 67, '2020-07-14 22:21:24', '2021-02-03 12:44:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('627', 7, 4, 93, '2012-05-07 05:48:58', '2019-07-15 23:51:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('628', 8, 5, 92, '2012-04-13 19:54:37', '2015-11-10 12:53:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('629', 9, 6, 1, '2016-10-27 09:48:36', '2019-05-25 18:12:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('630', 10, 7, 99, '2014-05-23 05:03:11', '2011-09-21 14:51:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('631', 11, 1, 4, '2018-10-15 03:34:07', '2018-01-29 03:22:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('632', 12, 2, 38, '2012-06-05 06:16:07', '2018-09-30 03:35:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('633', 13, 3, 82, '2017-03-26 02:16:40', '2015-06-14 18:18:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('634', 14, 4, 14, '2011-11-28 12:58:14', '2012-03-17 11:05:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('635', 15, 5, 18, '2015-02-09 01:51:14', '2019-02-18 03:28:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('636', 16, 6, 52, '2020-03-06 12:34:10', '2011-08-09 15:22:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('637', 17, 7, 24, '2018-03-08 01:14:30', '2018-05-08 03:42:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('638', 18, 1, 54, '2013-04-02 22:03:44', '2016-06-18 03:20:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('639', 19, 2, 63, '2018-11-28 03:07:51', '2014-04-06 11:35:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('640', 20, 3, 44, '2012-02-15 08:38:40', '2011-03-29 13:28:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('641', 1, 4, 89, '2014-11-22 17:57:12', '2014-01-25 16:52:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('642', 2, 5, 42, '2011-03-31 23:43:13', '2016-09-28 06:43:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('643', 3, 6, 4, '2011-05-06 08:12:07', '2016-10-03 08:45:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('644', 4, 7, 4, '2020-06-19 13:59:01', '2011-05-19 20:39:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('645', 5, 1, 44, '2019-01-06 04:42:17', '2014-01-18 03:33:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('646', 6, 2, 81, '2018-12-15 06:13:59', '2014-01-18 05:03:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('647', 7, 3, 62, '2011-11-24 13:21:43', '2013-07-23 17:31:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('648', 8, 4, 32, '2016-02-28 06:46:07', '2012-03-02 22:13:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('649', 9, 5, 16, '2012-06-04 20:44:01', '2012-10-10 05:37:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('650', 10, 6, 35, '2012-11-12 20:34:20', '2014-03-02 03:19:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('651', 11, 7, 92, '2018-07-31 02:23:01', '2015-01-27 15:08:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('652', 12, 1, 29, '2015-02-24 16:12:37', '2018-04-23 23:53:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('653', 13, 2, 15, '2019-02-18 02:58:43', '2014-12-12 08:08:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('654', 14, 3, 90, '2019-02-15 02:38:45', '2013-02-19 11:47:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('655', 15, 4, 7, '2017-10-13 10:42:41', '2011-05-22 03:29:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('656', 16, 5, 68, '2014-06-13 01:53:52', '2018-11-29 21:54:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('657', 17, 6, 84, '2011-04-24 15:34:31', '2013-10-19 11:59:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('658', 18, 7, 2, '2019-01-18 23:59:46', '2020-04-28 16:42:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('659', 19, 1, 70, '2013-03-03 07:28:39', '2015-09-23 07:58:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('660', 20, 2, 80, '2012-03-09 10:31:50', '2014-07-22 20:46:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('661', 1, 3, 15, '2017-10-03 04:44:11', '2012-10-13 13:38:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('662', 2, 4, 27, '2016-04-27 14:50:18', '2017-11-29 16:25:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('663', 3, 5, 76, '2013-03-23 19:42:59', '2021-01-13 17:39:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('664', 4, 6, 23, '2017-07-09 06:13:56', '2015-06-24 23:04:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('665', 5, 7, 55, '2015-06-26 11:03:16', '2016-11-03 01:30:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('666', 6, 1, 9, '2020-06-30 23:42:23', '2018-03-14 02:52:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('667', 7, 2, 22, '2018-12-13 01:47:48', '2011-06-27 02:27:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('668', 8, 3, 10, '2015-06-19 05:23:50', '2017-09-12 13:37:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('669', 9, 4, 92, '2018-12-19 02:58:43', '2016-10-27 11:07:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('670', 10, 5, 61, '2017-12-01 12:35:05', '2019-03-23 20:26:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('671', 11, 6, 99, '2018-05-11 11:18:55', '2012-12-25 08:51:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('672', 12, 7, 31, '2013-01-21 17:24:52', '2012-06-29 13:13:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('673', 13, 1, 69, '2016-10-04 13:17:10', '2020-02-19 10:38:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('674', 14, 2, 62, '2015-05-05 12:17:15', '2015-04-03 14:46:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('675', 15, 3, 45, '2020-01-16 04:47:18', '2012-05-06 07:25:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('676', 16, 4, 3, '2019-10-27 01:56:25', '2019-06-15 07:51:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('677', 17, 5, 54, '2011-09-01 00:49:59', '2018-03-12 05:43:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('678', 18, 6, 68, '2016-01-06 22:06:21', '2018-04-17 22:54:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('679', 19, 7, 46, '2017-05-31 12:22:17', '2013-02-17 06:04:24');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('680', 20, 1, 20, '2015-05-14 01:36:54', '2020-09-08 03:49:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('681', 1, 2, 47, '2017-11-07 17:46:36', '2016-05-08 06:57:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('682', 2, 3, 38, '2016-06-10 01:37:11', '2012-02-25 17:07:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('683', 3, 4, 37, '2019-10-12 17:42:44', '2011-10-07 16:26:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('684', 4, 5, 100, '2017-03-07 15:17:22', '2012-10-27 00:23:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('685', 5, 6, 7, '2016-03-09 10:27:04', '2016-05-14 22:23:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('686', 6, 7, 0, '2018-07-28 09:23:54', '2014-07-13 19:18:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('687', 7, 1, 97, '2021-02-15 13:48:35', '2013-08-12 06:55:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('688', 8, 2, 84, '2020-05-15 20:16:46', '2015-06-10 14:49:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('689', 9, 3, 32, '2019-02-08 16:25:51', '2015-08-05 05:19:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('690', 10, 4, 98, '2017-03-23 11:40:54', '2021-01-26 22:42:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('691', 11, 5, 5, '2013-10-10 23:20:46', '2017-04-20 18:57:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('692', 12, 6, 66, '2013-02-22 16:45:36', '2019-10-23 08:59:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('693', 13, 7, 38, '2015-04-19 20:58:28', '2019-07-29 09:23:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('694', 14, 1, 12, '2019-01-31 02:33:31', '2016-06-27 10:32:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('695', 15, 2, 18, '2013-06-12 02:23:06', '2013-12-18 13:43:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('696', 16, 3, 94, '2017-04-11 11:13:16', '2016-09-30 02:59:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('697', 17, 4, 74, '2018-09-05 23:46:37', '2018-03-18 18:25:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('698', 18, 5, 39, '2012-08-25 15:28:35', '2013-10-30 15:54:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('699', 19, 6, 34, '2018-09-20 17:32:02', '2018-07-20 13:27:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('700', 20, 7, 88, '2017-05-08 23:07:18', '2019-04-12 01:43:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('701', 1, 1, 30, '2020-11-01 15:29:14', '2016-07-21 14:18:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('702', 2, 2, 40, '2012-07-08 03:58:26', '2014-10-02 14:44:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('703', 3, 3, 21, '2015-07-30 03:20:44', '2012-10-17 13:36:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('704', 4, 4, 45, '2020-10-15 16:07:36', '2011-11-26 04:18:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('705', 5, 5, 82, '2018-06-18 07:30:50', '2019-06-29 01:56:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('706', 6, 6, 39, '2018-07-23 21:23:16', '2020-02-25 16:41:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('707', 7, 7, 28, '2013-06-04 18:58:09', '2014-05-12 02:07:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('708', 8, 1, 46, '2019-12-24 11:36:09', '2011-04-07 13:45:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('709', 9, 2, 46, '2021-01-12 07:15:49', '2020-11-09 21:58:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('710', 10, 3, 66, '2019-04-09 07:48:57', '2014-12-17 09:59:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('711', 11, 4, 30, '2014-01-05 18:35:48', '2018-04-29 12:21:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('712', 12, 5, 91, '2016-03-29 22:13:39', '2014-10-02 18:10:48');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('713', 13, 6, 93, '2017-03-21 08:31:33', '2019-08-18 09:42:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('714', 14, 7, 41, '2012-11-26 07:04:56', '2016-04-16 10:12:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('715', 15, 1, 2, '2016-08-23 15:25:20', '2017-08-07 07:54:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('716', 16, 2, 69, '2016-03-01 10:21:29', '2013-10-05 08:32:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('717', 17, 3, 82, '2020-02-05 13:34:10', '2014-06-16 14:45:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('718', 18, 4, 0, '2018-05-31 03:13:45', '2012-04-28 09:19:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('719', 19, 5, 8, '2013-04-04 23:27:18', '2017-10-02 12:52:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('720', 20, 6, 65, '2016-06-25 07:25:30', '2015-10-06 18:46:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('721', 1, 7, 42, '2015-06-11 00:55:58', '2017-05-15 06:41:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('722', 2, 1, 45, '2012-06-14 17:17:24', '2021-01-02 02:52:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('723', 3, 2, 13, '2020-08-26 13:40:55', '2020-02-12 03:35:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('724', 4, 3, 72, '2013-11-03 07:56:37', '2014-02-03 14:22:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('725', 5, 4, 0, '2013-01-16 14:17:58', '2013-10-13 10:07:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('726', 6, 5, 92, '2020-06-27 07:45:48', '2017-02-01 17:49:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('727', 7, 6, 9, '2017-06-20 11:30:23', '2016-02-01 03:35:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('728', 8, 7, 57, '2016-11-16 21:06:13', '2019-03-17 13:33:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('729', 9, 1, 21, '2019-03-27 23:50:32', '2012-08-13 23:37:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('730', 10, 2, 96, '2019-08-16 05:45:27', '2019-11-21 09:03:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('731', 11, 3, 77, '2013-12-07 09:06:50', '2016-09-01 07:35:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('732', 12, 4, 93, '2019-05-26 21:28:04', '2019-11-27 19:23:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('733', 13, 5, 31, '2014-01-05 06:27:48', '2018-04-14 14:57:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('734', 14, 6, 23, '2013-11-11 08:55:44', '2020-06-02 21:21:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('735', 15, 7, 33, '2012-03-08 21:58:33', '2017-05-24 06:53:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('736', 16, 1, 32, '2017-02-15 11:17:01', '2020-03-23 13:06:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('737', 17, 2, 24, '2014-03-26 18:42:41', '2020-02-27 14:09:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('738', 18, 3, 82, '2011-08-18 05:42:05', '2013-08-29 11:49:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('739', 19, 4, 32, '2017-03-01 10:27:03', '2020-03-14 03:31:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('740', 20, 5, 66, '2014-09-30 17:06:20', '2013-12-07 19:12:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('741', 1, 6, 20, '2014-12-26 21:49:33', '2014-01-08 13:39:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('742', 2, 7, 1, '2012-06-19 00:42:38', '2018-04-13 16:23:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('743', 3, 1, 46, '2011-04-08 09:08:56', '2017-02-15 00:54:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('744', 4, 2, 36, '2011-07-31 22:59:57', '2017-03-12 13:25:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('745', 5, 3, 34, '2019-05-06 01:49:37', '2012-03-06 17:19:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('746', 6, 4, 100, '2012-07-12 06:52:55', '2013-05-12 01:13:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('747', 7, 5, 59, '2016-03-18 15:08:05', '2016-08-11 02:12:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('748', 8, 6, 49, '2012-05-07 20:14:50', '2019-02-23 05:01:31');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('749', 9, 7, 6, '2014-01-28 01:50:10', '2011-05-03 08:54:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('750', 10, 1, 89, '2015-04-26 06:37:01', '2020-12-29 15:31:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('751', 11, 2, 90, '2016-12-31 22:22:53', '2019-12-18 17:39:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('752', 12, 3, 24, '2019-12-19 01:04:57', '2013-02-13 22:20:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('753', 13, 4, 53, '2015-04-20 19:38:32', '2011-04-05 02:41:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('754', 14, 5, 0, '2018-07-19 17:01:38', '2011-08-20 07:25:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('755', 15, 6, 97, '2012-03-08 14:38:10', '2011-04-16 05:30:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('756', 16, 7, 0, '2019-10-15 04:39:40', '2015-02-05 10:30:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('757', 17, 1, 90, '2017-02-26 06:50:31', '2015-04-07 23:35:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('758', 18, 2, 70, '2019-10-18 18:58:17', '2018-07-19 23:59:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('759', 19, 3, 11, '2018-07-11 03:22:45', '2014-02-27 23:53:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('760', 20, 4, 38, '2013-10-03 10:23:33', '2016-10-09 00:23:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('761', 1, 5, 88, '2017-05-24 02:01:36', '2015-01-22 10:48:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('762', 2, 6, 93, '2012-04-28 06:30:06', '2019-05-24 09:12:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('763', 3, 7, 38, '2016-12-28 21:25:47', '2013-07-24 21:44:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('764', 4, 1, 80, '2017-01-21 10:07:50', '2017-07-20 00:15:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('765', 5, 2, 45, '2016-12-05 06:25:29', '2020-02-09 11:16:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('766', 6, 3, 68, '2012-01-30 14:12:01', '2020-06-02 23:58:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('767', 7, 4, 47, '2012-05-26 06:28:07', '2015-08-18 01:07:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('768', 8, 5, 58, '2020-05-27 12:30:06', '2015-06-17 17:14:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('769', 9, 6, 13, '2016-01-07 19:55:45', '2014-08-24 16:58:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('770', 10, 7, 56, '2014-06-04 17:51:50', '2016-02-15 17:39:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('771', 11, 1, 85, '2018-01-01 23:17:38', '2011-10-18 17:16:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('772', 12, 2, 63, '2014-11-01 18:48:36', '2018-11-18 16:40:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('773', 13, 3, 50, '2013-06-24 13:09:12', '2020-07-18 22:37:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('774', 14, 4, 34, '2016-11-27 06:40:19', '2017-12-22 06:37:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('775', 15, 5, 20, '2017-09-24 05:48:21', '2020-10-18 23:02:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('776', 16, 6, 62, '2011-09-23 18:23:31', '2011-12-26 20:47:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('777', 17, 7, 49, '2017-02-03 07:19:15', '2015-11-18 10:09:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('778', 18, 1, 55, '2013-06-15 12:22:31', '2014-09-20 12:47:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('779', 19, 2, 97, '2020-03-25 12:59:36', '2011-03-25 00:24:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('780', 20, 3, 36, '2017-03-11 02:36:17', '2011-05-10 21:48:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('781', 1, 4, 63, '2017-11-25 11:48:15', '2018-10-18 09:37:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('782', 2, 5, 23, '2018-11-11 05:21:57', '2013-04-12 17:02:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('783', 3, 6, 39, '2018-11-16 23:35:21', '2011-02-27 15:49:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('784', 4, 7, 16, '2015-05-17 11:47:00', '2011-11-29 07:40:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('785', 5, 1, 74, '2013-01-22 01:50:24', '2017-11-16 10:14:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('786', 6, 2, 77, '2014-09-19 14:07:58', '2016-01-03 15:28:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('787', 7, 3, 96, '2013-07-29 12:21:51', '2011-07-15 21:17:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('788', 8, 4, 29, '2014-05-26 01:31:28', '2018-02-06 03:00:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('789', 9, 5, 21, '2020-06-13 19:12:00', '2020-08-24 03:41:28');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('790', 10, 6, 62, '2015-02-22 19:46:16', '2019-06-01 03:26:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('791', 11, 7, 58, '2016-03-17 11:06:40', '2017-05-07 20:08:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('792', 12, 1, 51, '2014-09-16 20:10:43', '2020-11-29 14:47:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('793', 13, 2, 69, '2013-06-12 19:54:45', '2013-05-23 16:08:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('794', 14, 3, 31, '2015-12-20 16:38:22', '2013-05-10 01:27:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('795', 15, 4, 7, '2020-01-12 03:42:55', '2017-02-09 16:03:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('796', 16, 5, 2, '2013-12-09 09:41:41', '2015-02-21 20:36:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('797', 17, 6, 18, '2015-12-21 01:52:15', '2013-05-16 14:00:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('798', 18, 7, 27, '2018-01-26 04:56:19', '2011-04-30 19:25:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('799', 19, 1, 86, '2017-06-19 07:18:29', '2019-03-25 07:10:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('800', 20, 2, 29, '2015-08-14 00:54:55', '2019-07-22 20:44:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('801', 1, 3, 65, '2020-09-09 07:20:47', '2013-09-05 04:22:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('802', 2, 4, 9, '2015-12-01 20:38:16', '2020-05-16 13:57:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('803', 3, 5, 9, '2018-09-11 09:53:26', '2011-07-07 23:40:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('804', 4, 6, 17, '2020-11-15 00:47:05', '2011-03-09 18:44:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('805', 5, 7, 25, '2012-05-17 23:54:49', '2015-03-12 13:46:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('806', 6, 1, 34, '2018-10-05 03:36:44', '2013-06-24 07:01:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('807', 7, 2, 25, '2014-07-14 02:27:46', '2013-05-23 04:37:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('808', 8, 3, 48, '2020-07-11 18:44:33', '2013-06-10 21:29:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('809', 9, 4, 21, '2014-06-03 22:33:17', '2012-04-02 07:36:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('810', 10, 5, 2, '2017-07-25 02:18:23', '2014-04-21 02:41:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('811', 11, 6, 85, '2014-10-31 14:24:14', '2014-09-22 05:28:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('812', 12, 7, 41, '2018-05-09 03:39:37', '2018-06-14 17:10:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('813', 13, 1, 3, '2012-09-19 21:37:29', '2020-01-04 17:02:23');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('814', 14, 2, 49, '2017-12-13 12:48:51', '2014-03-24 15:19:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('815', 15, 3, 77, '2015-04-18 16:33:24', '2018-04-10 10:43:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('816', 16, 4, 38, '2012-04-05 08:01:49', '2013-12-02 08:49:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('817', 17, 5, 10, '2011-10-24 17:47:01', '2012-09-25 06:17:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('818', 18, 6, 95, '2012-10-16 13:57:45', '2012-08-14 18:30:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('819', 19, 7, 15, '2011-08-22 14:59:48', '2015-08-15 00:52:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('820', 20, 1, 53, '2011-12-13 10:21:47', '2017-08-17 16:52:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('821', 1, 2, 37, '2014-03-16 07:21:04', '2013-10-01 02:15:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('822', 2, 3, 57, '2015-01-16 03:43:28', '2011-11-12 03:56:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('823', 3, 4, 65, '2019-09-18 09:10:14', '2011-04-25 23:11:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('824', 4, 5, 66, '2018-01-19 14:36:10', '2020-05-06 10:14:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('825', 5, 6, 94, '2014-03-29 20:11:49', '2016-12-27 07:04:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('826', 6, 7, 46, '2017-06-18 08:55:58', '2013-10-10 00:59:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('827', 7, 1, 40, '2012-02-10 04:17:47', '2014-12-10 10:03:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('828', 8, 2, 86, '2013-04-01 18:28:44', '2014-01-16 03:23:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('829', 9, 3, 74, '2016-09-14 05:08:43', '2015-09-20 11:32:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('830', 10, 4, 32, '2019-07-21 05:22:58', '2017-02-17 10:50:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('831', 11, 5, 32, '2018-03-27 15:50:25', '2019-01-20 22:43:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('832', 12, 6, 94, '2020-03-14 12:43:08', '2016-08-03 22:32:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('833', 13, 7, 11, '2012-10-15 09:39:45', '2018-09-24 12:42:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('834', 14, 1, 9, '2019-04-19 00:11:34', '2016-04-23 01:35:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('835', 15, 2, 45, '2016-07-14 01:51:23', '2017-08-06 08:32:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('836', 16, 3, 57, '2018-11-25 09:12:33', '2014-07-23 11:58:22');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('837', 17, 4, 97, '2011-03-19 10:32:42', '2012-04-10 12:52:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('838', 18, 5, 8, '2012-10-05 01:37:53', '2016-08-07 06:43:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('839', 19, 6, 33, '2020-01-01 06:37:15', '2018-03-24 22:53:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('840', 20, 7, 75, '2011-12-02 13:25:52', '2018-04-09 04:52:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('841', 1, 1, 22, '2016-01-08 06:42:41', '2016-12-24 18:09:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('842', 2, 2, 52, '2020-02-22 06:29:06', '2016-10-13 07:03:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('843', 3, 3, 65, '2014-01-13 03:44:08', '2016-08-09 15:28:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('844', 4, 4, 51, '2012-05-18 23:49:54', '2020-09-24 13:22:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('845', 5, 5, 48, '2018-08-12 05:11:51', '2019-12-07 00:26:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('846', 6, 6, 49, '2017-07-18 09:46:57', '2021-02-06 04:37:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('847', 7, 7, 95, '2012-11-02 12:55:46', '2015-03-28 13:02:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('848', 8, 1, 71, '2012-03-10 18:45:35', '2020-07-13 10:40:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('849', 9, 2, 0, '2014-08-22 21:52:21', '2019-07-07 00:15:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('850', 10, 3, 23, '2020-02-04 07:35:39', '2011-02-28 16:12:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('851', 11, 4, 92, '2014-06-18 04:58:22', '2019-08-29 01:55:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('852', 12, 5, 21, '2011-10-02 16:35:44', '2014-01-14 04:14:51');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('853', 13, 6, 1, '2019-07-13 07:16:47', '2013-10-12 16:29:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('854', 14, 7, 47, '2011-04-10 07:59:25', '2014-11-18 20:10:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('855', 15, 1, 91, '2015-03-04 05:48:42', '2019-07-05 17:54:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('856', 16, 2, 53, '2015-07-30 21:18:24', '2019-03-27 13:14:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('857', 17, 3, 60, '2019-12-23 01:11:53', '2019-06-19 07:50:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('858', 18, 4, 21, '2014-09-23 02:57:19', '2015-09-01 07:13:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('859', 19, 5, 25, '2011-07-05 20:17:47', '2011-02-17 22:46:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('860', 20, 6, 6, '2018-09-16 02:21:35', '2013-03-20 21:45:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('861', 1, 7, 36, '2020-12-17 11:09:38', '2012-10-28 17:35:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('862', 2, 1, 65, '2014-08-20 01:41:22', '2020-06-02 05:10:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('863', 3, 2, 61, '2015-04-12 01:06:53', '2019-08-24 09:18:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('864', 4, 3, 57, '2012-02-16 16:08:55', '2017-09-27 01:11:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('865', 5, 4, 53, '2011-09-05 01:04:26', '2014-05-01 20:33:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('866', 6, 5, 73, '2018-01-20 06:46:56', '2021-02-09 13:18:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('867', 7, 6, 0, '2017-10-16 07:35:31', '2016-04-02 12:08:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('868', 8, 7, 40, '2014-05-15 03:04:52', '2020-09-04 15:46:07');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('869', 9, 1, 6, '2016-09-15 15:12:06', '2020-11-23 05:25:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('870', 10, 2, 25, '2018-03-11 09:17:59', '2020-07-02 04:29:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('871', 11, 3, 87, '2016-01-22 21:22:27', '2013-11-28 00:04:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('872', 12, 4, 58, '2016-04-28 19:46:00', '2018-10-26 10:26:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('873', 13, 5, 57, '2012-12-20 16:03:59', '2018-12-19 09:36:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('874', 14, 6, 71, '2017-05-28 21:28:09', '2020-07-16 04:03:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('875', 15, 7, 96, '2016-06-08 08:09:56', '2015-12-17 04:11:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('876', 16, 1, 28, '2014-02-19 22:01:10', '2015-09-16 22:36:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('877', 17, 2, 3, '2015-09-01 14:57:13', '2018-05-08 22:49:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('878', 18, 3, 96, '2014-02-11 20:14:51', '2015-05-25 14:42:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('879', 19, 4, 81, '2020-01-13 03:05:54', '2018-01-24 19:07:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('880', 20, 5, 30, '2012-05-20 10:16:01', '2011-09-19 09:47:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('881', 1, 6, 61, '2018-03-16 14:53:28', '2014-09-18 13:13:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('882', 2, 7, 13, '2017-09-21 03:00:08', '2018-06-17 07:02:10');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('883', 3, 1, 95, '2021-02-10 14:52:38', '2019-12-08 16:22:11');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('884', 4, 2, 43, '2017-07-25 13:34:34', '2017-02-20 16:49:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('885', 5, 3, 42, '2019-10-26 09:19:03', '2018-03-18 14:15:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('886', 6, 4, 1, '2019-07-02 14:32:52', '2019-03-09 07:47:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('887', 7, 5, 45, '2020-07-25 22:35:18', '2011-11-21 19:44:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('888', 8, 6, 15, '2011-12-06 12:09:47', '2017-08-17 14:12:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('889', 9, 7, 21, '2017-04-17 23:19:52', '2019-07-28 05:34:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('890', 10, 1, 29, '2019-03-28 01:27:46', '2013-01-01 03:26:49');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('891', 11, 2, 96, '2016-06-26 00:24:42', '2020-08-18 17:57:34');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('892', 12, 3, 54, '2015-03-10 16:31:08', '2014-08-25 04:07:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('893', 13, 4, 67, '2018-02-02 07:58:32', '2017-04-02 11:47:52');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('894', 14, 5, 86, '2018-05-03 05:54:14', '2011-04-08 00:28:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('895', 15, 6, 26, '2013-09-09 11:35:32', '2011-09-21 06:05:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('896', 16, 7, 11, '2014-06-22 17:27:02', '2017-06-18 22:21:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('897', 17, 1, 70, '2019-04-27 02:23:07', '2015-05-20 12:44:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('898', 18, 2, 14, '2015-05-22 09:26:34', '2014-07-27 12:19:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('899', 19, 3, 25, '2019-07-07 18:38:49', '2016-04-06 19:58:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('900', 20, 4, 40, '2017-01-06 04:14:26', '2017-01-09 13:27:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('901', 1, 5, 53, '2017-01-03 21:29:28', '2014-11-21 19:02:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('902', 2, 6, 81, '2019-09-03 18:00:34', '2016-12-07 10:42:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('903', 3, 7, 66, '2012-08-20 00:39:42', '2017-04-30 15:00:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('904', 4, 1, 21, '2013-01-20 11:42:26', '2014-04-10 00:27:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('905', 5, 2, 8, '2014-06-08 05:46:08', '2017-09-14 15:50:36');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('906', 6, 3, 25, '2014-02-13 23:26:53', '2013-10-02 05:27:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('907', 7, 4, 91, '2011-10-01 21:58:21', '2019-06-03 14:44:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('908', 8, 5, 14, '2014-06-23 07:56:26', '2015-01-31 08:32:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('909', 9, 6, 73, '2017-01-30 14:52:31', '2014-06-05 00:22:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('910', 10, 7, 43, '2013-08-03 18:13:46', '2020-10-29 14:35:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('911', 11, 1, 13, '2018-01-09 18:10:02', '2011-05-01 20:39:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('912', 12, 2, 1, '2014-03-17 01:05:03', '2019-08-02 22:56:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('913', 13, 3, 72, '2019-04-25 11:31:10', '2017-05-05 18:08:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('914', 14, 4, 3, '2020-01-13 05:10:15', '2016-12-07 00:38:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('915', 15, 5, 99, '2016-03-23 16:27:03', '2014-04-06 22:32:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('916', 16, 6, 99, '2012-07-17 22:04:07', '2018-01-10 11:01:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('917', 17, 7, 0, '2016-05-27 06:26:51', '2015-01-02 04:42:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('918', 18, 1, 87, '2018-05-14 06:05:53', '2012-02-17 06:44:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('919', 19, 2, 48, '2018-10-17 06:16:56', '2016-03-08 19:13:50');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('920', 20, 3, 13, '2018-07-15 17:59:30', '2014-11-27 02:54:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('921', 1, 4, 27, '2014-11-02 12:47:16', '2019-05-29 19:44:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('922', 2, 5, 49, '2019-09-03 08:15:08', '2012-10-21 12:43:32');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('923', 3, 6, 30, '2017-01-12 23:13:35', '2012-07-03 16:43:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('924', 4, 7, 8, '2015-06-23 03:34:23', '2011-12-23 01:35:53');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('925', 5, 1, 33, '2013-01-02 07:15:11', '2011-07-30 17:08:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('926', 6, 2, 44, '2012-12-26 16:50:35', '2020-04-29 13:57:13');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('927', 7, 3, 76, '2018-11-23 20:11:51', '2012-02-15 11:55:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('928', 8, 4, 71, '2019-02-07 13:22:34', '2011-05-23 08:39:27');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('929', 9, 5, 69, '2016-03-15 15:42:22', '2017-08-28 12:40:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('930', 10, 6, 100, '2011-08-01 07:41:13', '2015-04-02 07:31:16');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('931', 11, 7, 35, '2018-12-14 20:50:41', '2013-02-04 21:18:12');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('932', 12, 1, 69, '2013-01-30 07:31:05', '2017-03-15 10:31:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('933', 13, 2, 94, '2013-06-17 10:04:20', '2017-06-16 13:29:02');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('934', 14, 3, 77, '2021-02-04 14:53:15', '2013-01-11 19:55:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('935', 15, 4, 36, '2018-12-01 05:09:28', '2012-12-25 18:10:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('936', 16, 5, 90, '2017-01-17 05:50:12', '2013-01-06 18:01:30');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('937', 17, 6, 68, '2019-07-10 07:34:11', '2013-07-12 15:17:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('938', 18, 7, 81, '2012-04-11 19:46:53', '2016-04-21 16:28:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('939', 19, 1, 17, '2018-06-03 15:31:53', '2015-04-19 13:32:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('940', 20, 2, 60, '2014-07-22 16:14:46', '2012-10-21 19:01:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('941', 1, 3, 28, '2013-05-07 11:43:50', '2012-01-17 04:10:06');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('942', 2, 4, 35, '2018-03-08 09:24:55', '2017-05-10 12:03:35');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('943', 3, 5, 0, '2014-09-25 09:57:45', '2013-04-22 05:06:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('944', 4, 6, 14, '2018-05-09 14:40:21', '2012-03-21 17:17:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('945', 5, 7, 37, '2011-03-02 18:48:11', '2015-02-26 10:20:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('946', 6, 1, 55, '2015-05-25 12:57:43', '2017-05-05 19:30:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('947', 7, 2, 73, '2017-03-05 22:22:26', '2017-03-01 01:04:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('948', 8, 3, 49, '2018-02-15 05:20:21', '2020-03-23 04:31:04');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('949', 9, 4, 36, '2015-01-26 10:11:44', '2019-01-08 11:43:42');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('950', 10, 5, 23, '2012-03-16 07:24:58', '2015-11-06 18:22:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('951', 11, 6, 55, '2018-01-16 19:40:52', '2013-12-21 19:18:56');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('952', 12, 7, 5, '2018-07-15 19:59:19', '2020-03-04 07:53:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('953', 13, 1, 9, '2017-11-09 15:03:29', '2017-07-09 10:39:25');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('954', 14, 2, 16, '2017-01-13 17:37:17', '2016-03-10 11:58:05');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('955', 15, 3, 54, '2018-05-01 16:45:15', '2017-05-20 15:45:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('956', 16, 4, 67, '2015-12-17 16:10:39', '2018-07-31 04:00:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('957', 17, 5, 6, '2012-06-27 05:53:01', '2018-08-04 07:29:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('958', 18, 6, 98, '2020-09-29 07:53:14', '2013-03-20 14:18:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('959', 19, 7, 93, '2019-10-05 08:29:57', '2012-02-22 23:00:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('960', 20, 1, 16, '2013-11-18 00:20:26', '2018-02-23 04:21:03');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('961', 1, 2, 16, '2017-01-07 21:39:31', '2015-02-09 18:07:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('962', 2, 3, 47, '2012-12-11 14:13:16', '2021-01-18 23:15:00');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('963', 3, 4, 17, '2016-10-19 20:31:22', '2018-11-06 23:07:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('964', 4, 5, 93, '2012-03-30 21:03:48', '2017-02-22 22:26:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('965', 5, 6, 68, '2013-03-29 23:00:51', '2011-06-30 13:45:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('966', 6, 7, 70, '2020-10-26 17:01:35', '2019-05-30 15:03:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('967', 7, 1, 37, '2019-03-25 08:54:20', '2011-07-06 19:08:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('968', 8, 2, 82, '2013-07-26 14:06:39', '2015-05-23 16:44:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('969', 9, 3, 30, '2012-04-21 10:16:42', '2018-11-06 12:45:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('970', 10, 4, 40, '2020-10-22 00:24:48', '2011-05-01 07:07:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('971', 11, 5, 66, '2017-04-01 19:23:01', '2017-01-09 03:44:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('972', 12, 6, 39, '2013-06-20 10:46:04', '2012-07-07 04:28:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('973', 13, 7, 8, '2015-07-10 20:16:12', '2015-04-18 05:58:26');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('974', 14, 1, 49, '2013-12-01 20:25:55', '2012-06-19 08:20:19');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('975', 15, 2, 82, '2020-06-14 14:24:54', '2015-05-29 09:11:17');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('976', 16, 3, 30, '2013-01-21 10:12:32', '2011-05-08 18:58:08');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('977', 17, 4, 10, '2019-02-14 11:32:56', '2013-08-23 16:18:15');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('978', 18, 5, 69, '2014-06-23 00:43:26', '2015-10-29 05:40:45');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('979', 19, 6, 88, '2018-08-26 20:02:06', '2012-01-15 07:28:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('980', 20, 7, 42, '2017-10-16 18:08:01', '2014-11-03 23:35:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('981', 1, 1, 56, '2014-12-30 00:10:21', '2014-07-29 18:08:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('982', 2, 2, 30, '2018-03-02 14:20:19', '2020-05-12 07:33:38');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('983', 3, 3, 29, '2016-06-19 11:55:38', '2011-10-26 20:55:59');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('984', 4, 4, 21, '2014-07-06 03:11:39', '2017-12-01 00:47:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('985', 5, 5, 50, '2020-04-06 13:13:37', '2012-09-15 17:52:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('986', 6, 6, 63, '2018-09-07 21:57:42', '2019-06-14 03:49:09');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('987', 7, 7, 86, '2019-04-11 23:10:16', '2019-07-04 04:29:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('988', 8, 1, 88, '2020-05-05 15:46:17', '2015-03-08 23:20:40');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('989', 9, 2, 32, '2017-10-23 04:52:54', '2017-07-16 21:08:14');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('990', 10, 3, 79, '2018-01-31 17:21:47', '2018-04-30 08:34:41');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('991', 11, 4, 2, '2013-03-09 07:48:15', '2015-06-07 17:01:21');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('992', 12, 5, 25, '2016-11-27 10:25:16', '2015-10-11 01:00:33');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('993', 13, 6, 90, '2013-03-25 01:07:23', '2018-08-28 17:33:57');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('994', 14, 7, 54, '2016-11-16 17:31:29', '2013-07-20 05:28:37');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('995', 15, 1, 10, '2013-06-20 12:50:30', '2013-06-24 15:07:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('996', 16, 2, 16, '2018-02-05 21:24:57', '2016-02-19 11:56:29');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('997', 17, 3, 45, '2013-02-16 11:35:32', '2012-02-06 01:05:20');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('998', 18, 4, 19, '2015-03-03 08:45:51', '2015-06-26 15:16:44');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('999', 19, 5, 40, '2018-03-29 01:55:56', '2018-08-02 19:36:54');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('1000', 20, 6, 40, '2015-11-21 18:31:57', '2013-09-18 23:14:58');


#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Покупатели';

INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('1', 'Геннадий', '1990-10-05', '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('2', 'Наталья', '1984-11-12', '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('3', 'Александр', '1985-05-20', '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('4', 'Сергей', '1988-02-14', '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('5', 'Иван', '1998-01-12', '2021-02-17 13:43:25', '2021-02-17 13:43:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('6', 'Мария', '1992-08-29', '2021-02-17 13:43:25', '2021-02-17 13:43:25');


