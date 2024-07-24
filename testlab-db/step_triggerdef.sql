DELIMITER //

CREATE TRIGGER `testlab-db`.step_trigger 
AFTER INSERT ON `testlab-db`.step
FOR EACH ROW
BEGIN   
    INSERT INTO `testlab-db`.step_casted (
		test_id,
        seq_id,
        computer_name,
        chl_id, 
        barcode,
        cycle_id,
        step_num,
        step_id,
        step_type, 
        step_duration_ms,
        charge_energy,
        discharge_energy,
        charge_capacity,
        discharge_capacity,
        net_discharge_capacity,
        net_discharge_energy,
        charge_time,
		discharge_time,
        start_voltage,
        end_voltage,
        end_temp,
        batch_no, 
        remark,
        step_file_name,
        starting_time,
		end_time,
		builder,
		active_material,
		start_current,
		end_current,
		capacity,
		energy,
		first_current,
		first_voltage,
		nominal_capacity
        ) 
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
		CONVERT(REPLACE(step_duration_ms,',', '.'), DOUBLE) AS step_duration_ms,
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
		LEFT(s.step_file_name, 150) AS step_file_name ,
		LEFT(s.starting_time, 25) AS starting_time, #correct name
		LEFT(s.end_time, 25) AS end_time #correct name
		LEFT(s.builder, 25) AS builder, 
		CONVERT(REPLACE(active_material, ',', '.'), DOUBLE) AS active_material,
		CONVERT(REPLACE(start_current, ',', '.'), DOUBLE) AS start_current,
		CONVERT(REPLACE(end_current, ',', '.'), DOUBLE) AS end_current,
		CONVERT(REPLACE(capacity, ',', '.'), DOUBLE) AS capacity,
		CONVERT(REPLACE(energy, ',', '.'), DOUBLE) AS energy,
		CONVERT(REPLACE(first_current, ',', '.'), DOUBLE) AS first_current,
		CONVERT(REPLACE(first_voltage, ',', '.'), DOUBLE) AS first_voltage,
		CONVERT(REPLACE(nominal_capacity, ',', '.'), DOUBLE) AS nominal_capacity
	FROM `testlab-db`.step s
	JOIN `testlab-db`.ids i ON i.barcode = LEFT(s.barcode, 60) AND i.test_id = CONVERT(s.test_id, UNSIGNED);
END;
//

DELIMITER ;
