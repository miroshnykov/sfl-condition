CREATE TABLE `sfl_dimension` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	`displayed_name` VARCHAR(45) NOT NULL,
	`date_added` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name`),
	UNIQUE INDEX `displayed_name_UNIQUE` (`displayed_name`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO `sfl_dimension` (`id`, `name`, `displayed_name` ) VALUES (1, 'affiliate', 'Affiliate');
INSERT INTO `sfl_dimension` (`id`, `name`, `displayed_name` ) VALUES (2, 'country', 'Country');
INSERT INTO `sfl_dimension` (`id`, `name`, `displayed_name` ) VALUES (3, 'affiliate_country', 'Affileate / Country');
INSERT INTO `sfl_dimension` (`id`, `name`, `displayed_name` ) VALUES (4, 'prod', 'Prod');
INSERT INTO `sfl_dimension` (`id`, `name`, `displayed_name` ) VALUES (5, 'affiliate_campaign', 'Affiliate / Campaign');
INSERT INTO `sfl_dimension` (`id`, `name`, `displayed_name` ) VALUES (6, 'website', 'Website');



CREATE TABLE `sfl_segment` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(128) NOT NULL,
	`status` ENUM('active','inactive') NOT NULL DEFAULT 'inactive',
	`type` ENUM('standard','block') NULL DEFAULT 'standard',
	`position` INT(10) NOT NULL,
	`user` VARCHAR(50) NOT NULL DEFAULT '0',
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_UNIQUE` (`name`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `sfl_segment_dimension` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`sfl_segment_id` INT(10) UNSIGNED NOT NULL,
	`sfl_dimension_id` INT(10) UNSIGNED NOT NULL,
	`value` VARCHAR(45) NOT NULL,
	`position` INT(10) NOT NULL DEFAULT '0',
	`user` VARCHAR(50) NOT NULL DEFAULT '0',
	`filter_type_id` TINYINT(3) UNSIGNED NOT NULL,
	`match_type_id` TINYINT(3) UNSIGNED NOT NULL,
	`segment_rule_index` INT(10) NOT NULL DEFAULT '0',
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `sfl_conditions` (`sfl_dimension_id`, `sfl_segment_id`, `value`),
	INDEX `sfl_segment_id` (`sfl_segment_id`),
	CONSTRAINT `fk_v_sfl_dimension1` FOREIGN KEY (`sfl_dimension_id`) REFERENCES `sfl_dimension` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk_v_sfl_segment1` FOREIGN KEY (`sfl_segment_id`) REFERENCES `sfl_segment` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;


