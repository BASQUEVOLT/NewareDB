CREATE VIEW `testlab-db`.`schedule2` AS
SELECT
	CONVERT(s.test_id, UNSIGNED) AS test_id,
	CONVERT(seq_id, UNSIGNED) AS seq_id,
	LEFT(computer_name, 20) AS computer_name, 
	LEFT(s.chl_id, 20) AS chl_id, 
	LEFT(i.barcode_corrected, 60) AS barcode,
	CONVERT(step_id, UNSIGNED) AS step_id,
	LEFT(step_type, 15) AS step_type, 
	LEFT(step_time, 25) AS step_time,
	CONVERT(REPLACE(setting_voltage, ',', '.'), DOUBLE) AS setting_voltage,
	CONVERT(REPLACE(setting_rate, ',', '.'), DOUBLE) AS setting_rate,
	CONVERT(REPLACE(setting_current, ',', '.'), DOUBLE) AS setting_current, 
	CONVERT(REPLACE(cut_of_rate, ',', '.'), DOUBLE) AS cut_of_rate,
	CONVERT(REPLACE(cut_of_current, ',', '.'), DOUBLE) AS cut_of_current,
	CONVERT(REPLACE(energy, ',', '.'), DOUBLE) AS energy,
	CONVERT(REPLACE(DV, ',', '.'), DOUBLE) AS DV,
	CONVERT(REPLACE(power, ',', '.'), DOUBLE) AS power, 
	CONVERT(REPLACE(IR, ',', '.'), DOUBLE) AS IR,
	CONVERT(REPLACE(capacity, ',', '.'), DOUBLE) AS capacity, 
	recording_conditions,
	aux_record_conditions, 
	CONVERT(REPLACE(MaxVi, ',', '.'), DOUBLE) AS MaxVi, 
	CONVERT(REPLACE(MinVi, ',', '.'), DOUBLE) AS MinVi,
	CONVERT(REPLACE(MaxTi, ',', '.'), DOUBLE) AS MaxTi, 
	CONVERT(REPLACE(MinTi, ',', '.'), DOUBLE) AS MinTi,  
	record1, 
	record2,  
	LEFT(s.starting_time, 25) AS starting_time,
	LEFT(s.end_time, 25) AS end_time,
	LEFT(s.remark, 60) AS remark,
	dev_remark,
	LEFT(s.builder, 25) AS builder,
	CONVERT(REPLACE(s.active_material, ',', '.'), DOUBLE) AS active_material,
	LEFT(P, 25) AS P,
	CONVERT(REPLACE(cutoff_voltage, ',', '.'), DOUBLE) AS cutoff_voltage,
	CONVERT(start_step_ID, UNSIGNED) AS start_step_ID,
	CONVERT(cycle_count, UNSIGNED) AS cycle_count,
	LEFT(upload_time, 25) AS upload_time,
	customize_setting,
	customize_setting_2
FROM `testlab-db`.`schedule` s
JOIN `testlab-db`.`ids` i ON i.barcode = LEFT(s.barcode, 60) AND i.test_id = CONVERT(s.test_id, UNSIGNED);