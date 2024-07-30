CREATE TABLE IF NOT EXISTS `log` (
`test_id` INT UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Test ID',
`seq_id` INT UNSIGNED NOT NULL DEFAULT '0' COMMENT 'DataPoint',
`computer_name` varchar(255) NOT NULL DEFAULT '' COMMENT '',
`chl_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'CH ID',
`log_time` varchar(255) DEFAULT NULL COMMENT 'Time',
`barcode` varchar(255) DEFAULT NULL COMMENT 'Cell bar code',
`log_code` varchar(255) DEFAULT NULL COMMENT 'Log code',
`log_level` varchar(255) DEFAULT NULL COMMENT 'Class',
`log_event` varchar(255) DEFAULT NULL COMMENT 'Event',
`upload_time` varchar(255) DEFAULT NULL COMMENT 'Upload time',
PRIMARY KEY ( `test_id`,`seq_id`,`computer_name`,`chl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8