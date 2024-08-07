CREATE VIEW `testlab-db`.step2 AS
SELECT
	CONVERT(s.test_id, UNSIGNED) AS test_id,
	CONVERT(seq_id, UNSIGNED) AS seq_id,
	LEFT(computer_name, 20) AS computer_name, 
	LEFT(s.chl_id, 20) AS chl_id, 
	LEFT(i.barcode_corrected, 60) AS barcode,
	CONVERT(cycle_id, UNSIGNED) AS cycle_id,
	CONVERT(step_num, UNSIGNED) AS step_num,
	CONVERT(step_id, UNSIGNED) AS step_id,
	LEFT(step_type, 15) AS step_type, 
	LEFT(step_time, 25) AS step_time,
	CONVERT(REPLACE(charge_energy, ',', '.'), DOUBLE) AS charge_energy,
	CONVERT(REPLACE(discharge_energy, ',', '.'), DOUBLE) AS discharge_energy,
	#chg_mid_voltage varchar(255) 
	CONVERT(REPLACE(charge_capacity, ',', '.'), DOUBLE) AS charge_capacity,
	CONVERT(REPLACE(discharge_capacity, ',', '.'), DOUBLE) AS discharge_capacity,
	#dc_mid_voltage varchar(255) 
	CONVERT(REPLACE(net_discharge_capacity, ',', '.'), DOUBLE) AS net_discharge_capacity,
	CONVERT(REPLACE(net_discharge_energy, ',', '.'), DOUBLE) AS net_discharge_energy,
	CONVERT(REPLACE(charge_time, ',', '.'), DOUBLE) AS charge_time,
	CONVERT(REPLACE(discharge_time, ',', '.'), DOUBLE) AS discharge_time,
	CONVERT(REPLACE(start_voltage, ',', '.'), DOUBLE) AS start_voltage, 
	CONVERT(REPLACE(end_voltage, ',', '.'), DOUBLE) AS end_voltage,
	CONVERT(REPLACE(end_temp, ',', '.'), DOUBLE) AS end_temp,
	LEFT(batch_no, 25) AS batch_no, 
	LEFT(s.remark, 60) AS remark,
	step_file_name,
	LEFT(s.starting_time, 25) AS starting_time, #correct name
	LEFT(s.end_time, 25) AS end_time #correct name
FROM `testlab-db`.step s
JOIN `testlab-db`.ids i ON i.barcode = LEFT(s.barcode, 60) AND i.test_id = CONVERT(s.test_id, UNSIGNED);