CREATE TABLE `testlab-db`.step_casted (
	test_id INT UNSIGNED NOT NULL DEFAULT 0,
	seq_id INT UNSIGNED DEFAULT NULL,
	computer_name VARCHAR(20) DEFAULT NULL, 
	chl_id VARCHAR(20) DEFAULT NULL, 
	barcode VARCHAR(60) NOT NULL DEFAULT '',
	cycle_id INT UNSIGNED DEFAULT NULL,
	step_num INT UNSIGNED DEFAULT NULL,
	step_id INT UNSIGNED DEFAULT NULL,
	step_type VARCHAR(15) DEFAULT NULL, 
	step_time BIGINT UNSIGNED DEFAULT NULL,
	charge_energy DOUBLE DEFAULT NULL,
	discharge_energy DOUBLE DEFAULT NULL,
	#chg_mid_voltage varchar(255) 
	charge_capacity DOUBLE DEFAULT NULL,
	discharge_capacity DOUBLE DEFAULT NULL,
	#dc_mid_voltage varchar(255) 
	net_discharge_capacity DOUBLE DEFAULT NULL,
	net_discharge_energy DOUBLE DEFAULT NULL,
	charge_time DOUBLE DEFAULT NULL,
	discharge_time DOUBLE DEFAULT NULL,
	start_voltage DOUBLE DEFAULT NULL, 
	end_voltage DOUBLE DEFAULT NULL,
	end_temp DOUBLE DEFAULT NULL,
	batch_no VARCHAR(25) DEFAULT NULL, 
	remark VARCHAR(60) DEFAULT NULL,
	step_file_name VARCHAR(255) DEFAULT NULL,
	starting_time BIGINT DEFAULT NULL, #correct name
	end_time BIGINT DEFAULT NULL, #correct name
    PRIMARY KEY (test_id, barcode)
)