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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Заказы';

INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('1', 3, '2017-06-28 10:42:56', '2021-01-27 10:42:08');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('2', 5, '2021-01-22 13:38:21', '2020-08-05 08:18:19');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('3', 2, '2012-07-03 01:27:54', '2021-01-30 05:06:20');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('4', 6, '2014-06-14 09:09:00', '2020-09-23 02:28:40');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('5', 3, '2018-06-04 17:07:52', '2020-11-03 00:57:06');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('6', 1, '2013-07-25 07:15:17', '2020-09-25 17:39:17');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('7', 6, '2020-02-17 10:21:10', '2021-01-20 17:38:01');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('8', 3, '2011-10-11 09:07:52', '2020-12-12 08:05:14');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('9', 3, '2016-03-02 07:50:39', '2020-12-21 16:15:41');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('10', 1, '2017-02-13 21:02:05', '2021-01-27 14:18:25');


