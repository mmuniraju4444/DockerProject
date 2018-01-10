-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `fuel`;
CREATE DATABASE `fuel` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `fuel`;

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `state_id` bigint(20) unsigned NOT NULL,
  `name` varchar(225) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_id` (`state_id`),
  CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cities` (`id`, `state_id`, `name`) VALUES
(1,	1,	'Davanagere'),
(2,	1,	'Chikmagalur'),
(3,	1,	'Chikballapur'),
(4,	1,	'Belgaum'),
(5,	1,	'Kolar'),
(6,	1,	'Hassan'),
(7,	1,	'Koppal'),
(8,	1,	'Bidar'),
(9,	1,	'Bagalkot'),
(10,	1,	'Karwar'),
(11,	1,	'Shimoga'),
(12,	1,	'Chamarajanagar'),
(13,	1,	'Yadgir'),
(14,	1,	'Bijapur'),
(15,	1,	'Dharwad'),
(16,	1,	'Chitradurga'),
(17,	1,	'Gadag'),
(18,	1,	'Udupi'),
(19,	1,	'Tumkur'),
(20,	1,	'Raichur'),
(21,	1,	'Mangalore'),
(22,	1,	'Ramanagara'),
(23,	1,	'Bangalore '),
(24,	1,	'Mysore'),
(25,	1,	'Bellary'),
(26,	1,	'Gulbarga'),
(27,	1,	'Mandya'),
(28,	1,	'Haveri');

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(225) NOT NULL,
  `symbol` varchar(225) NOT NULL,
  `code` varchar(225) NOT NULL,
  `html_code` varchar(225) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `currencies` (`id`, `name`, `symbol`, `code`, `html_code`) VALUES
(1,	'rupee ',	'₹',	'INR',	'&#8360;');

DROP TABLE IF EXISTS `fuel_prices`;
CREATE TABLE `fuel_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `city_id` bigint(20) unsigned NOT NULL,
  `fuel_type_id` bigint(20) unsigned NOT NULL,
  `date` date NOT NULL,
  `price` double(6,2) unsigned NOT NULL,
  `currency_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `fuel_types`;
CREATE TABLE `fuel_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(225) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `fuel_types` (`id`, `name`) VALUES
(1,	'Petrol'),
(2,	'Diesel');

DROP TABLE IF EXISTS `states`;
CREATE TABLE `states` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(225) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `states` (`id`, `name`) VALUES
(1,	'Karnataka');

-- 2018-01-10 18:47:00