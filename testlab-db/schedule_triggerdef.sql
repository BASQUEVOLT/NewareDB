DELIMITER //

CREATE TRIGGER `testlab-db`.schedule_trigger 
AFTER INSERT ON `testlab-db`.schedule
FOR EACH ROW
BEGIN   
    INSERT INTO `testlab-db`.schedule_casted (
		test_id,
        seq_id,
        computer_name,
        chl_id, 
		barcode,
        step_id,
        step_type, 
        step_duration,
        setting_voltage,
        setting_rate,
        setting_current,
        cut_of_rate,
		cut_of_current,
		energy,
        DV,
        power, 
        IR,
        capacity,
        recording_conditions,
        aux_record_conditions,
        MaxVi, 
        MinVi,
        MaxTi, 
        MinTi, 
        record1,
        record2,
        starting_time,
        end_time,
        remark,
        dev_remark,
        builder,
        active_material,
		P,
        cutoff_voltage,
        start_step_ID,
        cycle_count,
        upload_time,
        customize_setting,
		customize_setting_2
        ) 
	SELECT
		CONVERT(s.test_id, UNSIGNED) AS test_id,
		CONVERT(seq_id, UNSIGNED) AS seq_id,
		LEFT(computer_name, 20) AS computer_name, 
		LEFT(s.chl_id, 20) AS chl_id, 
		LEFT(i.barcode_corrected, 60) AS barcode,
		CONVERT(step_id, UNSIGNED) AS step_id,
		LEFT(step_type, 15) AS step_type, 
        (SUBSTRING_INDEX(step_duration, ':', 1) * 3600000) +  -- Convert hours to milliseconds
		(SUBSTRING_INDEX(SUBSTRING_INDEX(step_duration, ':', -2), ':', 1) * 60000) +  -- Convert minutes to milliseconds
		(SUBSTRING_INDEX(step_duration, ':', -1) * 1000) AS step_duration,  -- Convert seconds to milliseconds
		#LEFT(step_time, 25) AS step_time,
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
		LEFT(s.recording_conditions, 100) AS recording_conditions ,
		LEFT(s.aux_record_conditions, 100) AS aux_record_conditions , 
		CONVERT(REPLACE(MaxVi, ',', '.'), DOUBLE) AS MaxVi, 
		CONVERT(REPLACE(MinVi, ',', '.'), DOUBLE) AS MinVi,
		CONVERT(REPLACE(MaxTi, ',', '.'), DOUBLE) AS MaxTi, 
		CONVERT(REPLACE(MinTi, ',', '.'), DOUBLE) AS MinTi,  
		LEFT(s.record1, 100) AS record1, 
		LEFT(s.record2, 100) AS record2,  
		UNIX_TIMESTAMP(s.starting_time) AS starting_time,
		UNIX_TIMESTAMP(s.end_time) AS end_time,
		LEFT(s.remark, 60) AS remark,
		LEFT(s.equipment_remarks, 100) AS equipment_remarks,
		LEFT(s.builder, 25) AS builder,
		CONVERT(REPLACE(s.active_material, ',', '.'), DOUBLE) AS active_material,
		LEFT(P, 25) AS P,
		CONVERT(REPLACE(cutoff_voltage, ',', '.'), DOUBLE) AS cutoff_voltage,
		CONVERT(start_step_ID, UNSIGNED) AS start_step_ID,
		CONVERT(cycle_count, UNSIGNED) AS cycle_count,
		UNIX_TIMESTAMP(upload_time) AS upload_time,
		LEFT(s.customize_setting, 100) AS customize_setting,
		LEFT(s.customize_setting_2, 100) AS customize_setting_2
	FROM `testlab-db`.`schedule` s
	JOIN `testlab-db`.`ids` i ON i.barcode = LEFT(s.barcode, 60) AND i.test_id = CONVERT(s.test_id, UNSIGNED);
END;
//

DELIMITER ;
