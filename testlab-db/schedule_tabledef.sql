CREATE TABLE `testlab-db`.schedule_casted (
	test_id INT UNSIGNED NOT NULL DEFAULT 0,
	seq_id INT UNSIGNED DEFAULT NULL,
	computer_name VARCHAR(20) DEFAULT NULL, 
	chl_id VARCHAR(20) DEFAULT NULL, 
	barcode VARCHAR(60) NOT NULL DEFAULT '',
	step_id INT UNSIGNED DEFAULT NULL,
	step_type VARCHAR(15) DEFAULT NULL, 
	step_duration BIGINT UNSIGNED DEFAULT NULL COMMENT 'unit ms',
	setting_voltage DOUBLE DEFAULT NULL COMMENT 'unit V',
	setting_rate DOUBLE DEFAULT NULL COMMENT 'unit C-unit',
	setting_current DOUBLE DEFAULT NULL COMMENT 'unit A', 
	cut_of_rate DOUBLE DEFAULT NULL COMMENT 'unit C-unit',
	cut_of_current DOUBLE DEFAULT NULL COMMENT 'unit A',
	energy DOUBLE DEFAULT NULL COMMENT 'unit Wh',
	DV DOUBLE DEFAULT NULL COMMENT 'unit V',
	power DOUBLE DEFAULT NULL COMMENT 'unit W', 
	IR DOUBLE DEFAULT NULL COMMENT 'unit mOhm',
	capacity DOUBLE DEFAULT NULL COMMENT 'unit Ah', 
	recording_conditions VARCHAR(255) DEFAULT NULL COMMENT 'unit s,V,A',
	aux_record_conditions VARCHAR(255) DEFAULT NULL COMMENT 'unit s,V,A', 
	MaxVi DOUBLE DEFAULT NULL COMMENT 'unit V', 
	MinVi DOUBLE DEFAULT NULL COMMENT 'unit V',
	MaxTi DOUBLE DEFAULT NULL COMMENT 'unit ºC', 
	MinTi DOUBLE DEFAULT NULL COMMENT 'unit ºC',  
	record1 VARCHAR(255) DEFAULT NULL, 
	record2 VARCHAR(255) DEFAULT NULL,  
	starting_time BIGINT UNSIGNED DEFAULT NULL COMMENT 'unit unix timestamp',
	end_time BIGINT UNSIGNED DEFAULT NULL COMMENT 'unit unix timestamp',
	remark VARCHAR(60) DEFAULT NULL,
	dev_remark VARCHAR(255) DEFAULT NULL,
	builder VARCHAR(25) DEFAULT NULL,
	active_material DOUBLE DEFAULT NULL COMMENT 'unit mg',
	P VARCHAR(25) DEFAULT NULL,
	curoff_voltage DOUBLE DEFAULT NULL,
	start_step_ID INT UNSIGNED DEFAULT NULL,
	cycle_count INT UNSIGNED DEFAULT NULL,
	upload_time BIGINT UNSIGNED DEFAULT NULL COMMENT 'unit unix timestamp',
	customize_setting VARCHAR(255) DEFAULT NULL,
	customize_setting_2 VARCHAR(255) DEFAULT NULL,
	PRIMARY KEY (test_id, barcode)
);