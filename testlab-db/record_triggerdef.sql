DELIMITER //

CREATE TRIGGER `testlab-db`.record_trigger 
AFTER INSERT ON `testlab-db`.record
FOR EACH ROW
BEGIN   
    INSERT INTO `testlab-db`.record_casted (
		test_id,
        seq_id,
        computer_name,
        chl_id,
        barcode,
        cycle_id,
        step_num,
        step_id, 
        record_id,
		step_type,
        record_time,
        voltage, 
        current,
        capacity,
        energy, 
        power,
        absolute_time, 
        temperature, 
		batch_no,
        remark,
        total_time,
        active_material,
        builder,
        active_material_unit,
        customize_settings,
        customize_settings_2,
        equipment_remarks
        ) 
	SELECT
		CONVERT(r.test_id, UNSIGNED) AS test_id,
		CONVERT(seq_id, UNSIGNED) AS seq_id,
		LEFT(computer_name, 20) AS computer_name,
		LEFT(r.chl_id, 20) AS chl_id,
		LEFT(i.barcode_corrected, 60) AS barcode,
		CONVERT(cycle_id, UNSIGNED) AS cycle_id,
		CONVERT(step_num, UNSIGNED) AS step_num, 
		CONVERT(step_id, UNSIGNED) AS step_id, 
		CONVERT(record_id, UNSIGNED) AS record_id, 
		LEFT(step_type, 20) AS step_type,
		CONVERT(REPLACE(record_time, ',', '.'), UNSIGNED) AS record_time,
		CONVERT(REPLACE(voltage, ',', '.'), DOUBLE) AS voltage, 
		CONVERT(REPLACE(current, ',', '.'), DOUBLE) AS current, 
		CONVERT(REPLACE(capacity, ',', '.'), DOUBLE) AS capacity, 
		CONVERT(REPLACE(energy, ',', '.'), DOUBLE) AS energy, 
		CONVERT(REPLACE(power, ',', '.'), DOUBLE) AS power, 
		UNIX_TIMESTAMP(absolute_time) AS absolute_time, 
		temperature, 
		LEFT(batch_no, 25) AS batch_no,
		LEFT(r.remark, 60) AS remark,
		CONVERT(REPLACE(total_time, ',', '.'), UNSIGNED) AS total_time,
		CONVERT(REPLACE(active_material, ',', '.'), DOUBLE) AS active_material,
		LEFT(r.builder, 25) AS builder,
		LEFT(r.active_material_unit, 10) AS active_material_unit,
		customize_settings,
		customize_settings_2,
		LEFT(r.equipment_remarks, 100) AS equipment_remarks 
	FROM `testlab-db`.record r
	JOIN `testlab-db`.ids i ON i.barcode = LEFT(r.barcode, 60) and i.test_id = CONVERT(r.test_id, UNSIGNED)
END;
//

DELIMITER ;
