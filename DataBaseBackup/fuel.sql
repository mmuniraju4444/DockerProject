-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `fuel`;
CREATE DATABASE `fuel` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `fuel`;

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `symbol` varchar(50) NOT NULL,
  `html_symbol` varchar(10) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `html_symbol` (`html_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

TRUNCATE `currencies`;
INSERT INTO `currencies` (`id`, `name`, `symbol`, `html_symbol`, `status`, `created_at`, `updated_at`) VALUES
(1,	'INR',	'₹',	'&#8377;',	1,	'2018-01-15 16:39:59',	'2018-01-15 16:39:59');

DROP TABLE IF EXISTS `fuel_prices`;
CREATE TABLE `fuel_prices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `price` decimal(13,4) NOT NULL,
  `currency_id` int(50) NOT NULL,
  `fuel_type_id` int(50) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fuel_prices_fk0` (`currency_id`),
  KEY `fuel_prices_fk1` (`fuel_type_id`),
  CONSTRAINT `fuel_prices_fk0` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `fuel_prices_fk1` FOREIGN KEY (`fuel_type_id`) REFERENCES `fuel_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `fuel_types`;
CREATE TABLE `fuel_types` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2018-01-15 17:35:19
