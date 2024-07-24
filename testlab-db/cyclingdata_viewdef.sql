SELECT 
	DISTINCT ids.barcode_corrected AS barcode, 
	CONVERT(c1.test_id, UNSIGNED) AS test_id, 
    c1.Remark, 
    c1.builder,
	c1.cycle_id - LAG(c1.cycle_id, 1) OVER (
		PARTITION BY c1.barcode
	) as delta_cycle,
    CONVERT(c1.cycle_id, UNSIGNED) AS cycle_id,
    CONVERT(REPLACE(c1.charge_capacity, ',', '.'), DOUBLE) AS charge_capacity, 
    CONVERT(REPLACE(c1.discharge_capacity, ',', '.'), DOUBLE) AS discharge_capacity, 
    CONVERT(REPLACE(c1.charge_energy, ',', '.'), DOUBLE) AS charge_energy, 
    CONVERT(REPLACE(c1.discharge_energy, ',', '.'), DOUBLE) AS discharge_energy, 
    CONVERT(REPLACE(c1.Net_cap_dchg, ',', '.'), DOUBLE) AS Net_cap_dchg, 
    CONVERT(REPLACE(c1.Net_eng_dchg, ',', '.'), DOUBLE) AS Net_eng_dchg, 
    CONVERT(REPLACE(c1.specific_charge_capacity, ',', '.'), DOUBLE) AS specific_charge_capacity, 
    CONVERT(REPLACE(c1.specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_discharge_capacity, 
    CONVERT(REPLACE(c1.specific_charge_energy, ',', '.'), DOUBLE) AS specific_charge_energy, 
    CONVERT(REPLACE(c1.specific_discharge_energy, ',', '.'), DOUBLE) AS specific_discharge_energy, 
    CONVERT(REPLACE(c1.active_material, ',', '.'), DOUBLE) AS active_material, 
    100*CONVERT(REPLACE(c1.specific_discharge_capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(c1.specific_charge_capacity, ',', '.'), DOUBLE) AS ce,
    100*CONVERT(REPLACE(c1.specific_discharge_energy, ',', '.'), DOUBLE)/CONVERT(REPLACE(c1.specific_charge_energy, ',', '.'), DOUBLE) AS rte,
    CONVERT(REPLACE(c1.soh, ',', '.'), DOUBLE) AS soh,
    CONVERT(REPLACE(c2.specific_discharge_capacity, ',', '.'), double) AS specific_discharge_capacity4,
    100*CONVERT(REPLACE(c1.specific_discharge_capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(c2.specific_discharge_capacity, ',', '.'), double) AS my_soh
FROM `testlab-db`.`cycle` c1
JOIN `dev-db`.`ids` ids 
JOIN `testlab-db`.`cycle` c2
ON ids.barcode = c1.barcode AND 
c1.barcode = c2.barcode AND
c1.test_id = c2.test_id
WHERE 
	c2.cycle_id = 4;