CREATE VIEW `testlab-db`.channel_status2 AS
SELECT
	LEFT(computer_name, 20) AS computer_name,
	CONVERT(equipt_code, UNSIGNED) AS equipt_code, 
	CONVERT(channel_no, UNSIGNED) AS channel_no, 
	CONVERT(channel_code, UNSIGNED) AS channel_code,
	LEFT(pc_name, 20) AS pc_name, 
	LEFT(i.barcode_corrected, 60) AS barcode, #correct to barcode
	CONVERT(step_id, UNSIGNED) AS step_id, #correct to step_id
	CONVERT(cycle_id, UNSIGNED) AS cycle_id, #correct to cycle_id
	LEFT(step_time, 25) AS step_time,
	LEFT(total_time, 25) AS total_time,
	LEFT(btsSysState, 25) AS btsSysState, 
	CONVERT(REPLACE(voltage, ',', '.'), DOUBLE) AS voltage,
	CONVERT(REPLACE(current, ',', '.'), DOUBLE) AS current, 
	CONVERT(REPLACE(power, ',', '.'), DOUBLE) AS power,
	CONVERT(REPLACE(step_Ah , ',', '.'), DOUBLE) AS step_Ah, 
	CONVERT(REPLACE(total_Ah , ',', '.'), DOUBLE) AS total_Ah, 
	CONVERT(REPLACE(step_kWh , ',', '.'), DOUBLE) AS step_kWh,
	CONVERT(REPLACE(total_kWh , ',', '.'), DOUBLE) AS total_kWh,
	CONVERT(REPLACE(total_charge_Ah , ',', '.'), DOUBLE) AS total_charge_Ah,
	CONVERT(REPLACE(total_discharge_Ah , ',', '.'), DOUBLE) AS total_discharge_Ah,
	CONVERT(REPLACE(total_charge_kWh , ',', '.'), DOUBLE) AS total_charge_kWh,
	CONVERT(REPLACE(total_discharge_kWh , ',', '.'), DOUBLE) AS total_discharge_kWh,
	CONVERT(REPLACE(voltage_setting , ',', '.'), DOUBLE) AS voltage_setting,
	CONVERT(REPLACE(current_setting , ',', '.'), DOUBLE) AS current_setting,
	CONVERT(REPLACE(max_single_voltage , ',', '.'), DOUBLE) AS max_single_voltage,
	CONVERT(REPLACE(min_single_voltage , ',', '.'), DOUBLE) AS min_single_voltage, 
	CONVERT(REPLACE(max_single_temperature , ',', '.'), DOUBLE) AS max_single_temperature, 
	CONVERT(REPLACE(min_single_temperature , ',', '.'), DOUBLE) AS min_single_temperature,  
	LEFT(transmit_time, 25) AS transmit_time,
	CONVERT(REPLACE(single_voltage , ',', '.'), DOUBLE) AS single_voltage,
	CONVERT(REPLACE(single_temperature , ',', '.'), DOUBLE) AS single_temperature,
	CONVERT(REPLACE(delta_temperature , ',', '.'), DOUBLE) AS delta_temperature,
	LEFT(step_name, 20) AS step_name,
	LEFT(device_IP, 30) AS device_IP,
	LEFT(upload_time, 25) AS upload_time,
	LEFT(end_time, 25) AS end_time
FROM `testlab-db`.channel_status cs
JOIN `testlab-db`.ids i ON i.barcode = LEFT(cs.barcode, 60);