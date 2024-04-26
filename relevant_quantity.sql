#relevant quantity for quick comparison
SELECT barcode,
	Remark,
    test_id,
	cycle_id, 
    CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_dchg_capa,
    100*CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(specific_charge_capacity, ',', '.'), DOUBLE) AS ce, 
    100*CONVERT(REPLACE(specific_discharge_energy, ',', '.'), DOUBLE)/CONVERT(REPLACE(specific_charge_energy, ',', '.'), DOUBLE) AS rte,
    Net_eng_dchg, 
    soh
FROM `testlab-db`.cycle c;

#4th cycle specific discharge capacity
SELECT barcode,
	Remark,
    test_id,
	cycle_id, 
    CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_dchg_capa
FROM `testlab-db`.cycle c
WHERE CONVERT(cycle_id, UNSIGNED) = 4;    