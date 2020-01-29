CREATE USER IF NOT EXISTS 'joy'@'localhost' IDENTIFIED BY 'joy';
GRANT ALL PRIVILEGES ON *.* To 'joy'@'localhost';
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS Strings;

CREATE TABLE IF NOT EXISTS `Strings`.`Store` (
  `id` BIGINT AUTO_INCREMENT,
  `string_key` VARCHAR(45) NULL,
  `string_value` VARCHAR(45) NULL,
  `string_meta` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));
