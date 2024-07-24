DELIMITER //

CREATE TRIGGER `testlab-db`.cycle_trigger 
AFTER INSERT ON `testlab-db`.cycle
FOR EACH ROW
BEGIN   
    INSERT INTO `testlab-db`.cycle_casted (
        test_id,
        seq_id, 
        computer_name,
        chl_id, 
        barcode,
        cycle_id, 
        charge_capacity,
        discharge_capacity,
        charge_energy,
        discharge_energy,
        net_discharge_capacity,
        net_discharge_energy, 
        charge_mid_voltage, 
        discharge_mid_voltage,
		batch_no,
        remark,
        soh, 
        specific_charge_capacity,
        specific_discharge_capacity,
        specific_charge_energy,
        specific_discharge_energy,
        starting_time,
        end_time,
        builder,
        active_material, 
		#active_material_unit,
        dicharge_capacity_attenuation_rate,
        discharge_energy_retention_rate, 
        charge_discharge_efficiency
        ) 
	SELECT
		CONVERT(c.test_id, UNSIGNED) AS test_id,
		CONVERT(seq_id, UNSIGNED) AS seq_id,
		LEFT(computer_name, 20) AS computer_name,
		LEFT(c.chl_id, 20) AS chl_id, 
		LEFT(i.barcode_corrected, 60) AS barcode, 
		CONVERT(cycle_id, UNSIGNED) AS cycle_id, 
		CONVERT(REPLACE(charge_capacity, ',', '.'), DOUBLE) AS charge_capacity,
		CONVERT(REPLACE(discharge_capacity, ',', '.'), DOUBLE) AS discharge_capacity,
		CONVERT(REPLACE(charge_energy, ',', '.'), DOUBLE) AS charge_energy, 
		CONVERT(REPLACE(discharge_energy, ',', '.'), DOUBLE) AS discharge_energy,
		CONVERT(REPLACE(net_discharge_capacity, ',', '.'), DOUBLE) AS net_discharge_capacity, 
		CONVERT(REPLACE(net_discharge_energy, ',', '.'), DOUBLE) AS net_discharge_energy, 
		CONVERT(REPLACE(charge_mid_voltage, ',', '.'), DOUBLE) AS charge_mid_voltage, 
		CONVERT(REPLACE(discharge_mid_voltage, ',', '.'), DOUBLE) AS discharge_mid_voltage,
		LEFT(batch_no, 60) AS batch_no,
		LEFT(c.remark, 60) AS remark,
		CONVERT(REPLACE(soh, ',', '.'), DOUBLE) AS soh, 
		CONVERT(REPLACE(specific_charge_capacity, ',', '.'), DOUBLE) AS specific_charge_capacity, 
		CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_discharge_capacity,
		CONVERT(REPLACE(specific_charge_energy, ',', '.'), DOUBLE) AS specific_charge_energy, 
		CONVERT(REPLACE(specific_discharge_energy, ',', '.'), DOUBLE) AS specific_discharge_energy,
		UNIX_TIMESTAMP(c.starting_time) AS starting_time,
		UNIX_TIMESTAMP(c.end_time) AS end_time,
		LEFT(c.builder, 25) AS builder,
		CONVERT(REPLACE(c.active_material, ',', '.'), DOUBLE) AS active_material, 
		#LEFT(active_material_unit, 10) AS active_material_unit,
		CONVERT(REPLACE(dicharge_capacity_attenuation_rate, ',', '.'), DOUBLE) AS dicharge_capacity_attenuation_rate, 
		CONVERT(REPLACE(discharge_energy_retention_rate, ',', '.'), DOUBLE) AS discharge_energy_retention_rate, 
		CONVERT(REPLACE(charge_discharge_efficiency, ',', '.'), DOUBLE) AS charge_discharge_efficiency
	FROM `testlab-db`.cycle c
	JOIN `testlab-db`.ids i ON i.barcode = LEFT(c.barcode, 60) AND i.test_id = CONVERT(c.test_id, UNSIGNED);
END;
//

DELIMITER ;
