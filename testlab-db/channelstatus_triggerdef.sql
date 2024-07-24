DELIMITER //

CREATE TRIGGER `testlab-db`.channel_status_trigger 
AFTER INSERT ON `testlab-db`.channel_status
FOR EACH ROW
BEGIN   
    INSERT INTO `testlab-db`.channel_status_casted (
        computer_name,
        equipt_code, 
        channel_no,
        channel_code,
        pc_name,
		barcode,
        step_id,
        cycle_id,
        step_duration,
        total_duration,
        btsSysState, 
        voltage,
        current, 
        power,
        step_capacity, 
        total_capacity, 
        step_energy,
        total_energy,
        total_charge_capacity,
        total_discharge_capacity,
        total_charge_energy,
        total_discharge_energy,
        voltage_setting,
        current_setting,
        max_single_voltage,
        min_single_voltage,
        max_single_temperature,
        min_single_temperature, 
        transmit_time,
        single_voltage,
        single_temperature,
        delta_temperature,
        step_name,
        device_IP,
        upload_time,
        end_time
        ) 
	SELECT
		LEFT(computer_name, 20) AS computer_name,
		CONVERT(equipt_code, UNSIGNED) AS equipt_code, 
		CONVERT(channel_no, UNSIGNED) AS channel_no, 
		CONVERT(channel_code, UNSIGNED) AS channel_code,
		LEFT(pc_name, 20) AS pc_name, 
		LEFT(i.barcode_corrected, 60) AS barcode, 
		CONVERT(step_id, UNSIGNED) AS step_id, 
		CONVERT(cycle_id, UNSIGNED) AS cycle_id, 
        (SUBSTRING_INDEX(step_duration, ':', 1) * 3600000) +  -- Convert hours to milliseconds
		(SUBSTRING_INDEX(SUBSTRING_INDEX(step_duration, ':', -2), ':', 1) * 60000) +  -- Convert minutes to milliseconds
		(SUBSTRING_INDEX(step_duration, ':', -1) * 1000) AS step_duration,  -- Convert seconds to milliseconds
		#LEFT(step_time, 25) AS step_time,
		(SUBSTRING_INDEX(total_duration, ':', 1) * 3600000) +  -- Convert hours to milliseconds
		(SUBSTRING_INDEX(SUBSTRING_INDEX(total_duration, ':', -2), ':', 1) * 60000) +  -- Convert minutes to milliseconds
		(SUBSTRING_INDEX(total_duration, ':', -1) * 1000) AS total_duration,  -- Convert seconds to milliseconds
		#LEFT(total_time, 25) AS total_time,
		LEFT(btsSysState, 20) AS btsSysState, 
		CONVERT(REPLACE(voltage, ',', '.'), DOUBLE) AS voltage,
		CONVERT(REPLACE(current, ',', '.'), DOUBLE) AS current, 
		CONVERT(REPLACE(power, ',', '.'), DOUBLE) AS power,
		CONVERT(REPLACE(step_capacity , ',', '.'), DOUBLE) AS step_capacity, 
		CONVERT(REPLACE(total_capacity, ',', '.'), DOUBLE) AS total_capacity, 
		CONVERT(REPLACE(step_energy, ',', '.'), DOUBLE) AS step_energy,
		CONVERT(REPLACE(total_energy, ',', '.'), DOUBLE) AS total_energy,
		CONVERT(REPLACE(total_charge_capacity, ',', '.'), DOUBLE) AS total_charge_capacity,
		CONVERT(REPLACE(total_discharge_capacity, ',', '.'), DOUBLE) AS total_discharge_capacity,
		CONVERT(REPLACE(total_charge_energy, ',', '.'), DOUBLE) AS total_charge_energy,
		CONVERT(REPLACE(total_discharge_energy, ',', '.'), DOUBLE) AS total_discharge_energy,
		CONVERT(REPLACE(voltage_setting , ',', '.'), DOUBLE) AS voltage_setting,
		CONVERT(REPLACE(current_setting , ',', '.'), DOUBLE) AS current_setting,
		CONVERT(REPLACE(max_single_voltage , ',', '.'), DOUBLE) AS max_single_voltage,
		CONVERT(REPLACE(min_single_voltage , ',', '.'), DOUBLE) AS min_single_voltage, 
		CONVERT(REPLACE(max_single_temperature , ',', '.'), DOUBLE) AS max_single_temperature, 
		CONVERT(REPLACE(min_single_temperature , ',', '.'), DOUBLE) AS min_single_temperature,  
		UNIX_TIMESTAMP(transmit_time) AS transmit_time,
		CONVERT(REPLACE(single_voltage , ',', '.'), DOUBLE) AS single_voltage,
		CONVERT(REPLACE(single_temperature , ',', '.'), DOUBLE) AS single_temperature,
		CONVERT(REPLACE(delta_temperature , ',', '.'), DOUBLE) AS delta_temperature,
		LEFT(step_name, 20) AS step_name,
		LEFT(device_IP, 20) AS device_IP,
		UNIX_TIMESTAMP(upload_time) AS upload_time,
		#LEFT(end_time, 25) AS end_time
		(SUBSTRING_INDEX(end_time, ':', 1) * 3600000) +  -- Convert hours to milliseconds
		(SUBSTRING_INDEX(SUBSTRING_INDEX(end_time, ':', -2), ':', 1) * 60000) +  -- Convert minutes to milliseconds
		(SUBSTRING_INDEX(end_time, ':', -1) * 1000) AS end_time,  -- Convert seconds to milliseconds
	FROM `testlab-db`.channel_status cs
	JOIN `testlab-db`.ids i ON i.barcode = LEFT(cs.barcode, 60);
END;
//

DELIMITER ;
