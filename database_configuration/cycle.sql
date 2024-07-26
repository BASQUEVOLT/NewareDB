CREATE TABLE IF NOT EXISTS `cycle` (
`test_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Test ID',
`seq_id` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'DataPoint',
`computer_name` varchar(255) NOT NULL DEFAULT '' COMMENT '',
`chl_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'CH ID',
`barcode` varchar(255) DEFAULT NULL COMMENT 'Cell bar code',
`cycle_id` varchar(255) DEFAULT NULL COMMENT 'Cycle Index',
`charge_capacity` varchar(255) DEFAULT NULL COMMENT 'Chg. Cap.',
`discharge_capacity` varchar(255) DEFAULT NULL COMMENT 'DChg. Cap.',
`charge_energy` varchar(255) DEFAULT NULL COMMENT 'Chg. Energy',
`discharge_energy` varchar(255) DEFAULT NULL COMMENT 'DChg. Energy',
`net_discharge_capacity` varchar(255) DEFAULT NULL COMMENT 'Net DChg. Cap.',
`net_discharge_energy` varchar(255) DEFAULT NULL COMMENT 'Net DChg. Energy',
`charge_mid_voltage` varchar(255) DEFAULT NULL COMMENT 'Chg. Med. Volt.',
`discharge_mid_voltage` varchar(255) DEFAULT NULL COMMENT 'DChg. Med. Volt.',
`batch_no` varchar(255) DEFAULT NULL COMMENT 'Process name',
`remark` varchar(255) DEFAULT NULL COMMENT 'Remarks',
`staring_time` varchar(255) DEFAULT NULL COMMENT 'Starting time',
`end_time` varchar(255) DEFAULT NULL COMMENT 'End time',
`builder` varchar(255) DEFAULT NULL COMMENT 'Builder',
`active_material` varchar(255) DEFAULT NULL COMMENT 'Active material',
`dicharge_capacity_attenuation_rate` varchar(255) DEFAULT NULL COMMENT 'Discharge capacity attenuation rate (%) ',
`soh` varchar(255) DEFAULT NULL COMMENT 'Discharge capacity retention rate',
`charge_discharge_efficiency` varchar(255) DEFAULT NULL COMMENT 'Chg.-DChg. Eff',
`specific_charge_capacity` varchar(255) DEFAULT NULL COMMENT 'Charging capacity',
`specific_discharge_capacity` varchar(255) DEFAULT NULL COMMENT 'Specific discharge capacity',
`specific_charge_energy` varchar(255) DEFAULT NULL COMMENT 'Charge specific energy',
`specific_discharge_energy` varchar(255) DEFAULT NULL COMMENT 'Discharge specific energy',
PRIMARY KEY ( `test_id`,`seq_id`,`computer_name`,`chl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8