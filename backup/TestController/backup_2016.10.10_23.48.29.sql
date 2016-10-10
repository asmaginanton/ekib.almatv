-- -------------------------------------------
SET AUTOCOMMIT=0;
START TRANSACTION;
SET SQL_QUOTE_SHOW_CREATE = 1;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- -------------------------------------------
-- -------------------------------------------
-- START BACKUP
-- -------------------------------------------
-- -------------------------------------------
-- TABLE `abonent`
-- -------------------------------------------
DROP TABLE IF EXISTS `abonent`;
CREATE TABLE IF NOT EXISTS `abonent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp866;

-- -------------------------------------------
-- TABLE `address`
-- -------------------------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `home_id` int(11) NOT NULL,
  `apartment` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp866;

-- -------------------------------------------
-- TABLE `agent`
-- -------------------------------------------
DROP TABLE IF EXISTS `agent`;
CREATE TABLE IF NOT EXISTS `agent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp1251;

-- -------------------------------------------
-- TABLE `auth_assignment`
-- -------------------------------------------
DROP TABLE IF EXISTS `auth_assignment`;
CREATE TABLE IF NOT EXISTS `auth_assignment` (
  `item_name` varchar(64) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=cp866;

-- -------------------------------------------
-- TABLE `auth_item`
-- -------------------------------------------
DROP TABLE IF EXISTS `auth_item`;
CREATE TABLE IF NOT EXISTS `auth_item` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `rule_name` varchar(64) DEFAULT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=cp866;

-- -------------------------------------------
-- TABLE `auth_item_child`
-- -------------------------------------------
DROP TABLE IF EXISTS `auth_item_child`;
CREATE TABLE IF NOT EXISTS `auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=cp866;

-- -------------------------------------------
-- TABLE `auth_rule`
-- -------------------------------------------
DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE IF NOT EXISTS `auth_rule` (
  `name` varchar(64) NOT NULL,
  `data` text,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=cp866;

-- -------------------------------------------
-- TABLE `auth_users`
-- -------------------------------------------
DROP TABLE IF EXISTS `auth_users`;
CREATE TABLE IF NOT EXISTS `auth_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `auth_key` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `access_token` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `comment`
-- -------------------------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref_type` varchar(10) NOT NULL,
  `ref_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `author` varchar(100) NOT NULL,
  `comment` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp866;

-- -------------------------------------------
-- TABLE `contract`
-- -------------------------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE IF NOT EXISTS `contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(9) NOT NULL,
  `category` varchar(3) NOT NULL,
  `status` varchar(1) NOT NULL,
  `balance` decimal(10,0) NOT NULL,
  `type` varchar(30) NOT NULL,
  `abonent_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp866;

-- -------------------------------------------
-- TABLE `district`
-- -------------------------------------------
DROP TABLE IF EXISTS `district`;
CREATE TABLE IF NOT EXISTS `district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp1251;

-- -------------------------------------------
-- TABLE `home`
-- -------------------------------------------
DROP TABLE IF EXISTS `home`;
CREATE TABLE IF NOT EXISTS `home` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `korpus` varchar(3) CHARACTER SET utf8 DEFAULT NULL,
  `agent_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `apartments` int(11) NOT NULL,
  `number_of_storeys` int(11) DEFAULT NULL,
  `number_of_entrances` int(11) DEFAULT NULL,
  `apartments_pattern` varchar(255) CHARACTER SET utf16 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp1251;

-- -------------------------------------------
-- TABLE `import_result`
-- -------------------------------------------
DROP TABLE IF EXISTS `import_result`;
CREATE TABLE IF NOT EXISTS `import_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  `date` datetime NOT NULL,
  `status` varchar(10) NOT NULL,
  `executor` varchar(100) NOT NULL,
  `descr` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- -------------------------------------------
-- TABLE `street`
-- -------------------------------------------
DROP TABLE IF EXISTS `street`;
CREATE TABLE IF NOT EXISTS `street` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=cp1251;

-- -------------------------------------------
-- TABLE DATA abonent
-- -------------------------------------------
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('1','ИШКАЧЕВ ЛЕОНИД САФРОНОВИЧ','','775201');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('2','ИВШИН МАКСИМ АЛЕКСАНДРОВИЧ','','774568');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('3','КАЖИБЕКОВ БАКЫТЖАН БАГАДАТУЛЫ','','374346');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('4','БЕКАХМЕТОВ ЖАНАЙДАР КЕНЖЕБЕКОВИЧ','','371794 д/м');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('5','АФОНИНА ОКСАНА ВАСИЛЬЕВНА','','776940');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('6','ОЛЬШЕВСКАЯ ОЛЬГА ФЕДОРОВНА','','756269');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('7','ЛЯСКОВСКАЯ ЛАРИСА МИХАЙЛОВНА','','372954');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('8','АХМЕТЗЯНОВ ГАЗИНУР ШАКИРОВИЧ','','');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('9','НОВИКОВА ВАЛЕНТИНА НИКОЛАЕВНА','87054056752','221528');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('10','АЛИМХАНОВ СЕРИК ЕРЕЖЕПОВИЧ','','');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('11','ЗЕЙНУЛИНА САУЛЕ МУХАМЕТБЕКОВНА','87024174977','336962');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('12','БАТУ ШОЛПАН АЛМАЗОВНА','87057082793','');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('13','АХМЕДЬЯНОВА ОЛЬГА АНАТОЛЬЕВНА','','330648');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('14','ДЖАНСЫБЕРГЕНОВ ГАЛЫМ СОВЕТОВИЧ','','773351 от');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('15','ЖАКАНОВ МЕЙРАМ БАЛТАШЕВИЧ','87019170638','');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('16','ШАРИПОВА СТЕПАНИДА СТЕПАНОВНА','','333200 д/м');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('17','ЗЕНКОВА ОЛЬГА ПЕТРОВНА','87056141392','772831');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('18','ЗАРОДЫШЕВ ВЯЧЕСЛАВ ЮРЬЕВИЧ','87056409517','775058');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('19','ЖЕКИБАЕВ СЕРИК ШАРИПКАНОВИЧ','','87055639250 д/м');;;
INSERT INTO `abonent` (`id`,`fullname`,`mobile`,`phone`) VALUES
('20','АМИРХАНОВА АСЕМ ЖЕКСЕНБАЕВНА','','');;;
-- -------------------------------------------
-- TABLE DATA abonent
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA address
-- -------------------------------------------
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('11','6','38');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('12','507','24');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('13','21','62');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('14','349','27');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('15','112','124');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('16','369','12');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('17','285','115');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('18','82','37');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('19','65','66');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('20','260','6');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('21','61','28');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('22','94','33');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('23','184','16');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('24','494','81');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('25','472','3');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('26','213','27');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('30','320','83');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('31','488','20');;;
INSERT INTO `address` (`id`,`home_id`,`apartment`) VALUES
('32','343','16');;;
-- -------------------------------------------
-- TABLE DATA address
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA agent
-- -------------------------------------------
INSERT INTO `agent` (`id`,`name`) VALUES
('1','Базилова Ж.');;;
INSERT INTO `agent` (`id`,`name`) VALUES
('2','Иванова Н.');;;
INSERT INTO `agent` (`id`,`name`) VALUES
('3','Коробовская О.');;;
INSERT INTO `agent` (`id`,`name`) VALUES
('4','Постольник С.');;;
INSERT INTO `agent` (`id`,`name`) VALUES
('5','Севергина В.');;;
INSERT INTO `agent` (`id`,`name`) VALUES
('6','Тютькова Н.');;;
INSERT INTO `agent` (`id`,`name`) VALUES
('7','Цибизова М.');;;
-- -------------------------------------------
-- TABLE DATA agent
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA auth_assignment
-- -------------------------------------------
INSERT INTO `auth_assignment` (`item_name`,`user_id`,`created_at`) VALUES
('admin','17','1474301365');;;
INSERT INTO `auth_assignment` (`item_name`,`user_id`,`created_at`) VALUES
('admin','2','1474292538');;;
INSERT INTO `auth_assignment` (`item_name`,`user_id`,`created_at`) VALUES
('operator','16','1474219899');;;
INSERT INTO `auth_assignment` (`item_name`,`user_id`,`created_at`) VALUES
('operator','18','1474292607');;;
INSERT INTO `auth_assignment` (`item_name`,`user_id`,`created_at`) VALUES
('operator','2','1474292538');;;
-- -------------------------------------------
-- TABLE DATA auth_assignment
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA auth_item
-- -------------------------------------------
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('admin','1','администратор','','','1472833899','1474963858');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('agent','2','Справочник \"Агенты\" (полный доступ)','','','1474558440','1474558440');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('agent/index','2','Справочник \"Агенты\" (просмотр)','','','1474558919','1474558919');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('district','2','Справочник \"Районы\" (полный доступ)','','','1474803445','1474803445');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('gii','2','Gii','','','1474550505','1474550505');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('home','2','Справочник \"Дома\" (полный доступ)','','','1474736826','1474736826');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('import/extend-abonents-report','2','Импорт расширенного отчета по абонентам','','','1474963847','1474963847');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('operator','1','Оператор','','','1474219881','1474558945');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('permit','2','Управление правами доступа','','','1474297441','1474297441');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('street','2','Справочник \"Улицы\" (полный доступ)','','','1474551677','1474551677');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('street/index','2','Справочник \"Улицы\" (просмотр)','','','1474558859','1474558871');;;
INSERT INTO `auth_item` (`name`,`type`,`description`,`rule_name`,`data`,`created_at`,`updated_at`) VALUES
('user','2','Редактирование пользователей','','','1474297329','1474297329');;;
-- -------------------------------------------
-- TABLE DATA auth_item
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA auth_item_child
-- -------------------------------------------
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('admin','agent');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('operator','agent/index');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('admin','district');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('admin','gii');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('admin','home');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('admin','import/extend-abonents-report');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('admin','permit');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('admin','street');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('operator','street/index');;;
INSERT INTO `auth_item_child` (`parent`,`child`) VALUES
('admin','user');;;
-- -------------------------------------------
-- TABLE DATA auth_item_child
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA auth_rule
-- -------------------------------------------
-- -------------------------------------------
-- TABLE DATA auth_rule
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA auth_users
-- -------------------------------------------
INSERT INTO `auth_users` (`id`,`login`,`username`,`auth_key`,`password`,`access_token`) VALUES
('2','admin','Администратор','','$2y$13$E59WBP238ALhsPynWNOy0e8enE0nLddNnbZBtB0oAEWCEmZF3yT3K','');;;
INSERT INTO `auth_users` (`id`,`login`,`username`,`auth_key`,`password`,`access_token`) VALUES
('16','user','Пользователь','XoQmJLn7yYF0epsjpKBCGfJAsSv_hkYx','$2y$13$g/JLTO7QAXNlsTU2k/r7GOcAaHTw952feZ782s9lso5XeE..8Yuaq','');;;
INSERT INTO `auth_users` (`id`,`login`,`username`,`auth_key`,`password`,`access_token`) VALUES
('17','anton.smagin','Смагин Антон','cjGoDbV8ClFdfwRDq6630NJWmRelH9nP','$2y$13$Nu3SlKQfi8IwfdZXQSvStewqEYTUGk7RNj1nargjT4Uko/IlTEAeS','');;;
INSERT INTO `auth_users` (`id`,`login`,`username`,`auth_key`,`password`,`access_token`) VALUES
('18','user22','Еще пользователь','L0wIbsXklXlsXqxr1bIe8FB0Z9sbIGCn','$2y$13$a1eEvz8ajvu4Gc26bIZ9weCTAENRGMoUXBNHhRS9FLYtY7eqe3EN.','');;;
-- -------------------------------------------
-- TABLE DATA auth_users
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA comment
-- -------------------------------------------
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('7','address','11','2016-10-01 15:59:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('8','address','12','2016-10-01 19:17:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('9','address','13','2016-10-01 19:17:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('10','address','14','2016-10-01 19:17:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('11','address','15','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('12','address','16','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('13','address','17','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('14','address','18','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('15','address','19','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('16','address','20','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('17','address','21','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('18','address','22','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('19','address','23','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('20','address','24','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('21','address','25','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('22','address','26','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('23','address','27','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('24','address','28','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('25','address','29','2016-10-01 19:18:00','Администратор','Внесен в базу данных');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('26','abonent','1','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('27','contract','1','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('28','abonent','2','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('29','contract','2','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('30','abonent','3','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('31','contract','3','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('32','abonent','4','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('33','contract','4','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('34','abonent','5','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('35','contract','5','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('36','abonent','6','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('37','contract','6','2016-10-01 22:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('38','abonent','7','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('39','contract','7','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('40','abonent','8','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('41','contract','8','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('42','abonent','9','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('43','contract','9','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('44','abonent','10','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('45','contract','10','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('46','abonent','11','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('47','contract','11','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('48','abonent','12','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('49','contract','12','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('50','abonent','13','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('51','contract','13','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('52','abonent','14','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('53','contract','14','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('54','abonent','15','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('55','contract','15','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('56','abonent','16','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('57','contract','16','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('58','abonent','17','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('59','contract','17','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('60','abonent','18','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('61','contract','18','2016-10-01 22:26:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('62','abonent','19','2016-10-01 22:41:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('63','contract','19','2016-10-01 22:41:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('64','address','30','2016-10-02 22:08:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('65','abonent','20','2016-10-02 22:08:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('66','contract','20','2016-10-03 18:56:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('67','contract','21','2016-10-03 19:18:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('68','contract','22','2016-10-03 19:22:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('69','contract','23','2016-10-03 19:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('70','contract','24','2016-10-03 19:25:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('71','contract','25','2016-10-03 19:29:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('72','contract','26','2016-10-03 19:29:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('73','contract','27','2016-10-03 19:29:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('74','contract','28','2016-10-03 19:32:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('75','contract','29','2016-10-03 19:32:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('76','contract','30','2016-10-03 19:32:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('77','contract','31','2016-10-03 19:35:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('78','contract','32','2016-10-03 19:35:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('79','contract','33','2016-10-03 19:35:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('80','contract','34','2016-10-03 19:37:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('81','contract','35','2016-10-03 19:37:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('82','contract','36','2016-10-03 19:37:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('83','contract','37','2016-10-03 19:49:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('84','contract','38','2016-10-03 19:49:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('85','contract','39','2016-10-03 19:49:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('86','contract','40','2016-10-03 19:49:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('87','contract','41','2016-10-03 19:49:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('88','contract','42','2016-10-03 19:49:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('89','contract','43','2016-10-03 19:50:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('90','contract','44','2016-10-03 19:50:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('91','contract','45','2016-10-03 19:50:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('92','contract','46','2016-10-03 20:09:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('93','contract','47','2016-10-03 20:09:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('94','contract','48','2016-10-03 20:09:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('95','contract','49','2016-10-03 20:11:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('96','contract','50','2016-10-03 20:12:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('97','contract','51','2016-10-03 20:12:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('98','address','31','2016-10-03 20:16:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('99','contract','52','2016-10-03 20:16:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('100','address','32','2016-10-03 20:16:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('101','contract','53','2016-10-03 20:16:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('102','contract','54','2016-10-03 20:22:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('103','contract','55','2016-10-03 20:22:00','Администратор','Добавлен в базу');;;
INSERT INTO `comment` (`id`,`ref_type`,`ref_id`,`date`,`author`,`comment`) VALUES
('104','contract','56','2016-10-03 20:22:00','Администратор','Добавлен в базу');;;
-- -------------------------------------------
-- TABLE DATA comment
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA contract
-- -------------------------------------------
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('1','290000039','АТВ','A','214','Обычный/NOR','1','11');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('2','290000439','АТВ','C','-1458','Обычный/NOR','2','12');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('3','290002039','АТВ','A','174','Обычный/NOR','3','13');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('4','290002339','АТВ','C','0','Обычный/NOR','4','15');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('5','290002539','АТВ','B','0','Обычный/NOR','5','16');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('6','290002939','АТВ','C','-1901','Обычный/NOR','6','17');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('7','290003539','АТВ','C','0','Обычный/NOR','7','18');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('8','290003739','АТВ','C','-431','Обычный/NOR','8','19');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('9','290051733','АТВ','A','3731','Обычный/NOR','9','20');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('11','290006139','АТВ','C','1','Обычный/NOR','11','22');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('12','290050302','АТВ','B','-666','Квартирант/LEA','12','23');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('13','290006939','АТВ','A','1875','Обычный/NOR','13','24');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('14','290008839','АТВ','C','0','Обычный/NOR','14','25');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('15','290009139','АТВ','C','-2014','Обычный/NOR','15','26');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('49','290002139','АТВ','C','0','Обычный/NOR','19','14');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('50','290004539','АТВ','C','0','Обычный/NOR','10','21');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('54','290009539','АТВ','C','0','Обычный/NOR','16','31');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('55','290009939','АТВ','A','978','Обычный/NOR','18','32');;;
INSERT INTO `contract` (`id`,`number`,`category`,`status`,`balance`,`type`,`abonent_id`,`address_id`) VALUES
('56','290018239','АТВ','C','0','Обычный/NOR','20','30');;;
-- -------------------------------------------
-- TABLE DATA contract
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA district
-- -------------------------------------------
INSERT INTO `district` (`id`,`name`) VALUES
('1','1');;;
INSERT INTO `district` (`id`,`name`) VALUES
('2','2');;;
INSERT INTO `district` (`id`,`name`) VALUES
('3','3');;;
INSERT INTO `district` (`id`,`name`) VALUES
('4','4');;;
INSERT INTO `district` (`id`,`name`) VALUES
('5','5А');;;
INSERT INTO `district` (`id`,`name`) VALUES
('6','5Б');;;
INSERT INTO `district` (`id`,`name`) VALUES
('7','6');;;
INSERT INTO `district` (`id`,`name`) VALUES
('8','7');;;
INSERT INTO `district` (`id`,`name`) VALUES
('9','8');;;
INSERT INTO `district` (`id`,`name`) VALUES
('10','9');;;
INSERT INTO `district` (`id`,`name`) VALUES
('11','15');;;
INSERT INTO `district` (`id`,`name`) VALUES
('12','19');;;
INSERT INTO `district` (`id`,`name`) VALUES
('13','22');;;
INSERT INTO `district` (`id`,`name`) VALUES
('14','29');;;
INSERT INTO `district` (`id`,`name`) VALUES
('15','30');;;
INSERT INTO `district` (`id`,`name`) VALUES
('16','31');;;
-- -------------------------------------------
-- TABLE DATA district
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA home
-- -------------------------------------------
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('1','1','49','2','7','5','216','9','8','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('2','1','131','','3','15','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('3','1','131','А','4','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('4','3','97','','2','9','35','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('5','1','68','','2','9','135','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('6','18','12','5','7','5','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('7','1','133','А','4','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('8','1','144','','4','15','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('9','1','146','','4','16','24','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('10','1','148','','4','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('11','1','150','','4','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('12','1','150','А','4','16','33','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('13','1','1','В','1','2','50','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('14','1','29','','7','4','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('15','1','31','','7','4','70','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('16','1','33','','7','4','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('17','1','35','','7','4','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('18','1','49','1','7','5','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('19','1','49','3','7','5','45','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('20','1','49','4','7','5','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('21','1','70','','2','9','133','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('22','1','72','','2','9','246','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('23','1','91','','6','14','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('24','1','91','А','6','14','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('25','1','93','','6','14','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('26','2','10','','1','8','31','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('27','2','128','','4','11','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('28','2','12','А','1','8','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('29','2','130','А','4','11','138','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('30','2','155','','5','12','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('31','2','157','','5','12','210','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('32','2','159','','5','12','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('33','2','161','','5','12','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('34','2','163','','5','12','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('35','2','165','','5','12','58','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('36','2','165','А','5','12','87','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('37','2','167','','5','12','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('38','2','2','','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('39','2','21','1','2','7','198','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('40','2','21','2','2','7','188','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('41','2','24','','7','4','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('42','2','26','','7','4','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('43','2','28','','7','4','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('44','2','30','','7','4','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('45','2','36','','7','4','70','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('46','2','4','','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('47','2','42','','7','4','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('48','2','47','','7','5','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('49','2','49','','7','5','63','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('50','2','49','2','7','5','24','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('51','2','49','3','7','5','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('52','2','49','4','7','5','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('53','2','49','5','7','5','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('54','2','49','7','7','5','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('55','2','49','Б','7','5','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('56','2','49','В','7','5','2','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('57','2','4','А','1','8','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('58','2','53','А/1','7','5','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('59','2','53','А/2','7','5','79','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('60','2','53','А/3','7','5','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('61','2','59','','2','9','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('62','2','6','','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('63','2','61','','2','9','140','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('64','2','61','1','2','9','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('65','2','63','2','2','9','114','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('66','2','63','3','2','9','116','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('67','2','65','','2','9','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('68','2','67','','2','9','57','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('69','2','73','','2','9','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('70','2','77','','2','9','105','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('71','2','79','','2','9','175','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('72','2','81','','2','9','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('73','2','81','А','2','9','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('74','2','83','','2','9','156','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('75','2','89','','4','10','54','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('76','2','89','А','4','10','26','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('77','2','91','','4','10','104','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('78','2','91','А','4','10','78','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('79','2','91','Б','4','10','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('80','2','93','','4','10','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('81','2','95','','4','10','58','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('82','2','97','','4','10','47','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('83','3','101','1','2','9','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('84','3','101','2','2','9','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('85','3','101','3','2','9','148','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('86','3','101','А','2','9','16','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('87','3','102','','4','10','71','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('88','3','104','','4','10','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('89','3','106','','4','10','35','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('90','3','112','','4','10','106','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('91','3','166','','3','13','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('92','3','168','','3','13','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('93','3','170','','3','13','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('94','3','174','','3','13','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('95','3','176','','3','13','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('96','3','178','','3','13','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('97','3','180','','3','13','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('98','3','182','','3','13','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('99','3','182','А','3','13','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('100','3','182','Б','3','13','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('101','3','184','','3','13','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('102','3','184','А','3','13','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('103','3','186','','3','13','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('104','3','190','','3','13','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('105','3','190','А','3','13','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('106','3','190','Б','3','13','79','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('107','3','84','','4','10','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('108','3','86','','4','10','104','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('109','3','90','','4','10','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('110','3','92','','4','10','140','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('111','3','93','','2','9','81','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('112','3','95','','2','9','248','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('113','3','96','','4','10','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('114','3','98','','4','10','92','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('115','3','99','','2','9','139','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('116','3','99','А','2','9','8','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('117','4','250','','3','16','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('118','4','269','','4','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('119','4','271','','4','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('120','4','274','А','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('121','4','276','А','7','16','12','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('122','4','278','','7','16','24','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('123','4','278','А','7','16','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('124','4','280','','7','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('125','4','282','','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('126','4','284','','7','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('127','5','10','','4','16','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('128','5','17','','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('129','5','19','','7','16','12','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('130','5','19','А','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('131','5','21','А','7','16','12','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('132','5','23','А','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('133','5','25','','7','16','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('134','5','27','','7','16','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('135','5','27','А','7','16','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('136','5','4','','4','16','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('137','5','8','','4','16','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('138','6','1','','1','8','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('139','6','119','А','4','11','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('140','6','12','','1','3','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('141','6','121','','4','11','40','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('142','6','12','А','1','3','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('143','6','12','Б','1','3','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('144','6','12','Г','1','3','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('145','6','13','','6','4','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('146','6','14','','1','3','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('147','6','15','','6','4','149','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('148','6','15','А','6','4','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('149','6','15','Б','6','4','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('150','6','15','В','6','4','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('151','6','16','А','1','3','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('152','6','16','Б','1','3','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('153','6','17','','6','4','45','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('154','6','19','','6','4','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('155','6','23','','7','4','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('156','6','25','','7','4','32','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('157','6','27','','7','4','32','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('158','6','3','','1','8','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('159','6','5','','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('160','6','7','','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('161','7','26','','7','4','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('162','7','28','','7','4','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('163','7','30','','7','4','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('164','7','32','','7','4','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('165','7','34','','7','4','51','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('166','8','54','','4','11','107','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('167','8','54','А','4','11','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('168','8','56','А','4','11','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('169','8','58','','4','11','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('170','8','60','','4','11','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('171','8','60','А','4','11','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('172','8','62','','4','11','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('173','8','62','А','4','11','2','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('174','8','64','А','4','11','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('175','8','64','Б','4','11','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('176','8','64','В','4','11','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('177','8','66','','4','11','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('178','9','1','','6','14','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('179','9','3','','6','14','69','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('180','9','5','','6','14','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('181','10','100','','5','12','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('182','10','70','','5','12','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('183','10','70','А','5','12','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('184','10','72','','5','12','40','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('185','10','72','1','5','12','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('186','10','74','','5','12','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('187','10','74','А','5','12','55','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('188','10','74','Б','5','12','55','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('189','10','76','А','5','12','14','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('190','10','76','Б','5','12','29','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('191','10','78','','5','12','79','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('192','10','80','','5','12','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('193','10','82','','5','12','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('194','10','82','А','5','12','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('195','10','84','','5','12','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('196','10','86','','5','12','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('197','10','88','','5','12','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('198','10','92','','5','12','227','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('199','10','94','','5','12','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('200','10','96','','5','12','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('201','10','98','','5','12','139','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('202','11','36','1','1','8','50','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('203','11','36','2','1','8','40','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('204','12','11','','1','2','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('205','12','11','2','1','2','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('206','12','11','А','1','2','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('207','12','13','','1','2','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('208','12','13','А','1','2','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('209','12','17','2','1','2','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('210','12','17','3','1','2','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('211','12','19','','1','2','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('212','12','21','А','1','2','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('213','12','23','','1','2','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('214','12','25','','1','2','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('215','12','27','','1','2','58','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('216','12','29','','1','2','46','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('217','12','31','','1','2','40','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('218','12','31','А','1','2','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('219','12','33','','1','2','40','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('220','13','105','','5','15','158','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('221','13','107','','5','15','70','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('222','13','109','','5','15','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('223','13','111','','5','15','20','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('224','13','113','','5','15','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('225','13','115','','5','15','20','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('226','13','118','','3','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('227','13','126','','3','16','116','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('228','13','128','','3','16','54','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('229','13','130','','3','16','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('230','13','131','','3','16','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('231','13','135','','3','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('232','13','147','','3','16','52','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('233','13','149','','3','16','50','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('234','13','151','','3','16','50','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('235','13','153','','3','16','76','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('236','13','155','','3','16','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('237','13','157','','3','16','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('238','13','159','','3','16','50','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('239','13','161','','3','16','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('240','13','163','','3','16','102','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('241','13','20','','1','2','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('242','13','22','','1','2','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('243','13','24','','1','2','98','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('244','13','27','','3','1','128','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('245','13','28','','1','3','68','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('246','13','28','А','1','3','34','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('247','13','29','','3','1','128','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('248','13','30','','1','3','98','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('249','13','30','А','1','3','34','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('250','13','31','','3','1','79','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('251','13','31','А','3','1','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('252','13','32','','1','3','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('253','13','33','','1','8','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('254','13','33','А','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('255','13','33','Б','1','8','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('256','13','34','','1','3','70','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('257','13','34','А','1','3','34','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('258','13','35','','1','8','128','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('259','13','35','А','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('260','13','36','','6','4','96','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('261','13','36','А','6','4','34','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('262','13','36','Б','6','4','34','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('263','13','37','','1','8','128','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('264','13','37','А','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('265','13','37','Б','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('266','13','38','','6','4','113','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('267','13','38','А','6','4','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('268','13','38','Б','6','4','45','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('269','13','39','','1','8','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('270','13','40','','6','4','69','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('271','13','40','А','6','4','105','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('272','13','40','Б','6','4','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('273','13','40','Г','6','4','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('274','13','42','А','6','4','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('275','13','42','Б','6','4','143','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('276','13','42','В','6','4','45','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('277','13','46','','7','5','139','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('278','13','46','А','7','5','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('279','13','47','','2','7','198','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('280','13','48','','7','5','128','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('281','13','50','','7','5','40','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('282','13','52','','7','5','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('283','13','52','1','7','5','50','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('284','13','52','2','7','5','62','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('285','13','52','3','7','5','160','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('286','13','52','4','7','5','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('287','13','52','5','7','5','118','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('288','13','52','6','7','5','96','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('289','13','55','','2','7','120','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('290','13','55','А','2','7','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('291','13','58','1','6','6','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('292','13','58','А','6','6','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('293','13','59','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('294','13','60','','6','6','98','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('295','13','61','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('296','13','63','','2','7','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('297','13','63','А','2','7','0','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('298','13','64','','6','6','144','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('299','13','64','А','6','6','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('300','13','64','Б','6','6','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('301','13','65','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('302','13','68','','6','6','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('303','13','69','','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('304','13','69','А','2','7','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('305','13','70','','6','6','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('306','13','71','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('307','13','72','','6','6','144','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('308','13','72','А','6','6','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('309','13','73','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('310','13','75','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('311','13','76','','6','6','72','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('312','13','77','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('313','13','79','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('314','13','80','','6','6','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('315','13','82','','6','6','108','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('316','13','83','','3','7','107','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('317','13','84','','6','6','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('318','13','85','','3','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('319','13','86','','6','6','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('320','13','87','','3','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('321','13','89','','3','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('322','13','91','','3','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('323','13','93','','3','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('324','14','67','','5','12','179','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('325','14','69','','5','12','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('326','14','71','','5','12','118','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('327','14','73','','5','12','118','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('328','15','7','','1','8','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('329','16','11','','3','13','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('330','17','12','','1','2','56','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('331','17','14','','1','2','56','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('332','17','16','','1','2','70','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('333','17','18','','1','2','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('334','17','22','','1','2','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('335','17','25','','1','3','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('336','17','26','','1','2','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('337','17','27','','1','3','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('338','17','28','','1','2','88','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('339','17','29','','1','3','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('340','17','29','А','1','3','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('341','18','1','','6','6','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('342','18','12','1','7','5','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('343','18','12','2','7','5','63','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('344','18','12','3','7','5','160','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('345','18','12','4','7','5','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('346','18','12','6','7','5','96','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('347','18','13','','6','5','84','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('348','18','22','1','2','9','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('349','18','22','2','2','9','28','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('350','18','22','3','2','9','28','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('351','18','22','4','2','9','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('352','18','24','','2','9','16','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('353','18','28','','2','9','54','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('354','18','3','','6','6','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('355','18','30','','2','9','54','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('356','18','38','','4','10','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('357','18','38','А','4','10','71','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('358','18','46','','4','10','77','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('359','18','48','','4','10','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('360','18','5','','6','6','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('361','18','50','','4','10','71','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('362','18','67','','2','9','79','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('363','18','7','','6','6','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('364','18','8','1','7','5','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('365','18','8','2','7','5','63','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('366','18','8','3','7','5','160','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('367','18','8','4','7','5','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('368','18','8','5','7','5','118','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('369','18','8','6','7','5','96','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('370','18','9','','6','6','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('371','19','111','','3','15','78','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('372','19','113','','3','15','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('373','19','115','','3','15','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('374','19','117','','3','15','69','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('375','19','119','','3','15','45','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('376','19','121','','3','15','32','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('377','19','123','','3','15','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('378','19','125','','5','15','1','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('379','19','129','','4','16','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('380','19','133','','4','16','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('381','19','135','','4','16','12','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('382','19','138','','4','16','24','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('383','19','22','','1','8','61','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('384','19','24','','1','8','64','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('385','19','26','','1','8','64','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('386','19','26','А','1','8','64','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('387','19','28','','1','8','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('388','19','30','','1','8','64','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('389','19','30','А','1','8','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('390','19','30','Б','1','8','48','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('391','19','31','','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('392','19','32','','1','8','64','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('393','19','33','','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('394','19','34','','1','8','64','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('395','19','35','','1','8','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('396','19','36','','2','7','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('397','19','38','','2','7','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('398','19','40','','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('399','19','40','А','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('400','19','42','','2','7','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('401','19','44','','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('402','19','46','','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('403','19','48','','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('404','19','50','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('405','19','52','','2','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('406','19','54','','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('407','19','56','','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('408','19','58','','2','7','15','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('409','19','60','','2','7','44','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('410','19','62','','2','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('411','19','64','','3','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('412','19','66','','3','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('413','19','68','','3','7','88','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('414','19','70','','3','7','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('415','19','72','','3','7','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('416','19','74','','3','7','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('417','19','76','','3','7','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('418','19','78','','3','7','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('419','19','86','','5','15','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('420','19','88','','5','15','59','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('421','19','90','','5','15','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('422','19','90','А','5','15','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('423','19','92','','5','15','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('424','19','94','','5','15','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('425','19','96','','5','15','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('426','19','99','','3','15','70','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('427','20','22','','6','6','40','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('428','20','24','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('429','20','25','','5','15','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('430','21','10','','3','1','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('431','21','12','','3','1','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('432','21','2','','3','1','64','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('433','21','4','','3','1','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('434','21','6','','3','1','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('435','22','25','А','7','16','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('436','22','64','','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('437','22','66','','7','16','12','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('438','22','66','А','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('439','22','68','','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('440','22','68','А','7','16','18','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('441','22','70','','7','16','30','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('443','23','11','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('444','23','11','А','6','6','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('445','23','11','Б','6','6','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('446','23','11','В','6','6','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('447','23','11','Г','6','6','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('448','23','13','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('449','23','13','А','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('450','23','13','Б','6','6','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('451','23','15','','6','6','84','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('452','23','15','А','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('453','23','17','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('454','23','17','А','6','6','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('455','23','19','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('456','23','19','А','6','6','27','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('457','23','3','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('458','23','5','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('459','23','7','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('460','23','7','А','6','6','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('461','23','9','','6','6','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('462','23','9','А','6','6','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('463','24','101','','5','12','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('464','24','103','','5','12','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('465','24','103','А','5','12','148','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('466','24','105','','5','12','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('467','24','36','','4','11','71','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('468','24','36','А','4','11','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('469','24','38','','4','11','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('470','24','38','А','4','11','25','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('471','24','38','Б','4','11','40','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('472','24','40','','4','11','45','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('473','24','40','А','4','11','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('474','24','42','','4','11','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('475','24','42','А','4','11','25','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('476','24','44','А','4','11','45','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('477','24','46','','4','11','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('478','24','46','А','4','11','50','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('479','24','46','Б','4','11','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('480','24','46','В','4','11','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('481','24','46','Г','4','11','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('482','24','54','','4','10','70','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('483','24','56','','4','10','63','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('484','24','58','Б','4','10','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('485','24','60','','4','10','69','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('486','24','63','','5','12','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('487','24','64','','4','10','80','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('488','24','65','','5','12','89','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('489','24','67','','5','12','88','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('490','24','69','','5','12','140','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('491','24','71','','5','12','142','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('492','24','73','','5','12','100','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('493','24','75','','5','12','104','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('494','24','77','','5','12','149','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('495','24','79','','5','12','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('496','24','81','','5','12','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('497','24','83','','5','12','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('498','24','91','','5','12','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('499','24','93','','5','12','75','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('500','24','95','','5','12','84','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('501','24','97','','5','12','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('502','24','97','А','5','12','90','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('503','24','99','','5','12','36','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('504','25','11','','4','10','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('505','25','13','','4','10','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('506','25','15','','4','10','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('507','25','17','','4','10','119','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('508','25','19','','4','10','60','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('509','25','21','','4','10','56','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('510','25','21','А','4','10','15','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('511','25','23','','4','10','87','','','');;;
INSERT INTO `home` (`id`,`street_id`,`number`,`korpus`,`agent_id`,`district_id`,`apartments`,`number_of_storeys`,`number_of_entrances`,`apartments_pattern`) VALUES
('512','25','9','','4','10','118','','','');;;
-- -------------------------------------------
-- TABLE DATA home
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA import_result
-- -------------------------------------------
INSERT INTO `import_result` (`id`,`type`,`date`,`status`,`executor`,`descr`) VALUES
('1','ExtendAbonentsReport','2016-10-10 23:18:00','warning','Администратор','Success (0), Warning (2), Error (0).');;;
INSERT INTO `import_result` (`id`,`type`,`date`,`status`,`executor`,`descr`) VALUES
('2','ExtendAbonentsReport','2016-10-10 23:46:00','warning','Администратор','Success (0), Warning (2), Error (0).');;;
-- -------------------------------------------
-- TABLE DATA import_result
-- -------------------------------------------



-- -------------------------------------------
-- TABLE DATA street
-- -------------------------------------------
INSERT INTO `street` (`id`,`name`) VALUES
('1','АБАЯ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('2','АУЭЗОВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('3','БЕРКИМБАЕВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('4','БУХАР ЖИРАУ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('5','ГОГОЛЯ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('6','ГОРНЯКОВ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('7','ДУЙСЕМБАЕВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('8','ЗАПАДНАЯ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('9','КИЕВСКАЯ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('10','КОРОЛЕВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('11','КУНАЕВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('12','ЛОМОНОСОВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('13','МАШХУР ЖУСУП');;;
INSERT INTO `street` (`id`,`name`) VALUES
('14','МОСКОВСКАЯ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('15','ПАВЛОВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('16','ПЕТРЕНКО');;;
INSERT INTO `street` (`id`,`name`) VALUES
('17','ПШЕМБАЕВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('18','САТПАЕВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('19','СТРОИТЕЛЬНАЯ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('20','ТОРАЙГЫРОВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('21','ЦАРЕВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('22','ЦЕЛИННАЯ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('23','ШЕШЕМБЕКОВА');;;
INSERT INTO `street` (`id`,`name`) VALUES
('24','ЭНЕРГЕТИКОВ');;;
INSERT INTO `street` (`id`,`name`) VALUES
('25','ЭНЕРГОСТРОИТЕЛЕЙ');;;
-- -------------------------------------------
-- TABLE DATA street
-- -------------------------------------------



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------
