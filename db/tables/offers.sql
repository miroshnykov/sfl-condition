CREATE TABLE `sfl_offer_landing_pages` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`sfl_offer_id` INT(10) UNSIGNED NOT NULL,
	`name` VARCHAR(150) NOT NULL DEFAULT '',
	`url` TEXT NOT NULL,
	`params` VARCHAR(128) NOT NULL,
	`status` ENUM('active','inactive') NOT NULL DEFAULT 'inactive',
	`user` VARCHAR(50) NOT NULL DEFAULT '0',
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	INDEX `fk_v_sfl_lp` (`sfl_offer_id`),
	CONSTRAINT `fk_v_sfl_lp` FOREIGN KEY (`sfl_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `sfl_offers` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(128) NOT NULL,
	`advertiser` VARCHAR(128) NOT NULL,
	`status` ENUM('public','private','apply_to_run','inactive') NOT NULL DEFAULT 'inactive',
	`conversion_type` ENUM('cpi','cpa','cpl','cpc','cpm','hybrid/multistep') NOT NULL DEFAULT 'cpi',
	`user` VARCHAR(50) NOT NULL DEFAULT '0',
	`sfl_offer_landing_page_id` INT(11) NULL DEFAULT '0',
	`sfl_offer_geo_id` INT(11) NULL DEFAULT '0',
	`offer_id_redirect` INT(11) NULL DEFAULT '0',
	`payin` DECIMAL(16,8) NOT NULL DEFAULT '0.00000000',
	`payout` DECIMAL(16,8) NOT NULL DEFAULT '0.00000000',
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	INDEX `fk_v_sfl_offer_lp` (`sfl_offer_landing_page_id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `sfl_offer_campaigns` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`sfl_offer_id` INT(10) UNSIGNED NOT NULL,
	`affiliate_id` INT(11) NOT NULL,
	`status` ENUM('active','inactive') NOT NULL DEFAULT 'inactive',
	`user` VARCHAR(50) NOT NULL DEFAULT '0',
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	INDEX `fk_v_sfl_offer` (`sfl_offer_id`),
	INDEX `fk_v_sfl_offer_aff` (`affiliate_id`),
	CONSTRAINT `fk_v_sfl_offer` FOREIGN KEY (`sfl_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk_v_sfl_offer_aff` FOREIGN KEY (`affiliate_id`) REFERENCES `affiliates` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `sfl_offers_cap` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`sfl_offer_id` INT(10) UNSIGNED NOT NULL,
	`clicks_day` INT(11) NOT NULL DEFAULT '0',
	`clicks_week` INT(11) NOT NULL DEFAULT '0',
	`clicks_month` INT(11) NOT NULL DEFAULT '0',
	`clicks_redirect_status` ENUM('default','custom') NOT NULL DEFAULT 'default',
	`clicks_redirect_offer_id` INT(10) UNSIGNED NOT NULL,
	`sales_day` INT(11) NOT NULL DEFAULT '0',
	`sales_week` INT(11) NOT NULL DEFAULT '0',
	`sales_month` INT(11) NOT NULL DEFAULT '0',
	`sales_redirect_status` ENUM('default','custom') NOT NULL DEFAULT 'default',
	`sales_redirect_offer_id` INT(10) UNSIGNED NOT NULL,
	`start_date` INT(11) NOT NULL,
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `Index_sfl_offer_id` (`sfl_offer_id`),
	INDEX `fk_redirect_offer_id` (`clicks_redirect_offer_id`),
	INDEX `fk_sales_redirect_offer_id` (`sales_redirect_offer_id`),
	CONSTRAINT `fk_clicks_redirect_offer_id` FOREIGN KEY (`clicks_redirect_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk_sales_redirect_offer_id` FOREIGN KEY (`sales_redirect_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk_sfl_offer_id` FOREIGN KEY (`sfl_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `sfl_offer_campaign_cap` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`sfl_offer_campaign_id` INT(10) UNSIGNED NOT NULL,
	`clicks_day` INT(11) NOT NULL DEFAULT '0',
	`clicks_week` INT(11) NOT NULL DEFAULT '0',
	`clicks_month` INT(11) NOT NULL DEFAULT '0',
	`clicks_redirect_status` ENUM('default','custom') NOT NULL DEFAULT 'default',
	`clicks_redirect_offer_id` INT(10) UNSIGNED NOT NULL,
	`sales_day` INT(11) NOT NULL DEFAULT '0',
	`sales_week` INT(11) NOT NULL DEFAULT '0',
	`sales_month` INT(11) NOT NULL DEFAULT '0',
	`sales_redirect_status` ENUM('default','custom') NOT NULL DEFAULT 'default',
	`sales_redirect_offer_id` INT(10) UNSIGNED NOT NULL,
	`start_date` INT(11) NOT NULL,
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `Index_sfl_offer_campaign_id` (`sfl_offer_campaign_id`),
	INDEX `fk1_clicks_redirect_offer_id` (`clicks_redirect_offer_id`),
	INDEX `fk1_sales_redirect_offer_id` (`sales_redirect_offer_id`),
	CONSTRAINT `fk1_clicks_redirect_offer_id` FOREIGN KEY (`clicks_redirect_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk1_sales_redirect_offer_id` FOREIGN KEY (`sales_redirect_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `fk1_sfl_offer_id` FOREIGN KEY (`sfl_offer_campaign_id`) REFERENCES `sfl_offer_campaigns` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;


CREATE TABLE `sfl_offer_geo` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`rules` TEXT NOT NULL,
	`sfl_offer_id` INT(10) UNSIGNED NOT NULL,
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `offer_id_UNIQUE` (`sfl_offer_id`),
	INDEX `fk_v_sfl_offer_geo` (`sfl_offer_id`),
	CONSTRAINT `fk_v_sfl_offer_geo` FOREIGN KEY (`sfl_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `sfl_offer_campaign_rules` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`rules` TEXT NOT NULL,
	`position` INT(10) NOT NULL DEFAULT '0',
	`sfl_offer_campaign_id` INT(10) UNSIGNED NOT NULL,
	`status` ENUM('active','inactive') NOT NULL DEFAULT 'inactive',
	`user` VARCHAR(50) NOT NULL DEFAULT '0',
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	INDEX `fk_v_sfl_offer_rules` (`sfl_offer_campaign_id`),
	CONSTRAINT `fk_v_sfl_offer_rules` FOREIGN KEY (`sfl_offer_campaign_id`) REFERENCES `sfl_offer_campaigns` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `sfl_offer_custom_landing_pages` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`rules` TEXT NOT NULL,
	`sfl_offer_id` INT(10) UNSIGNED NOT NULL,
	`date_added` INT(11) NOT NULL,
	`date_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `lp_offer_id_UNIQUE` (`sfl_offer_id`),
	INDEX `fk_v_sfl_custom_lp` (`sfl_offer_id`),
	CONSTRAINT `fk_v_sfl_custom_lp` FOREIGN KEY (`sfl_offer_id`) REFERENCES `sfl_offers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO `sfl_offer_custom_landing_pages`
            (`rules`,
             `sfl_offer_id`)
VALUES      (
'{"sflOfferCustomLandingPages":[{"url":"testLP1.com","country":"CA"},{"url":"testLP2.com","country":"US"},{"url":"testLP3.com","country":"FR"}]}'
,
'25'
);



INSERT INTO `sfl_offer_geo` (`rules`, `sfl_offer_id`, `date_added`) VALUES ('{"geo":[{"include":true,"country":"CA"},{"include":false,"country":"US"},{"include":false,"country":"US"}]}', '17','1606753419');
