CREATE TABLE `dev-db`.record60s_test AS 
SELECT ids.barcode_corrected AS barcode, x.test_id, x.Remark, x.cycle_id, x.step_id, x.step_type, x.record_time, x.abs_time, x.TotalTime, x.current, x.voltage, x.specific_capacity, x.power, x.energy
FROM (
SELECT CONVERT(test_id, UNSIGNED) AS test_id, 
	barcode, 
    Remark,
    CONVERT(cycle_id, UNSIGNED) AS cycle_id,
    CONVERT(step_id, UNSIGNED) AS step_id, 
    step_type, 
    CONVERT(REPLACE(record_time, ',', '.'), DOUBLE) AS record_time, 
	abs_time, 
    TotalTime,
    CONVERT(record_id, UNSIGNED) AS record_id, CONVERT(REPLACE(current, ',', '.'), DOUBLE) AS current, 
    CONVERT(REPLACE(voltage, ',', '.'), DOUBLE) AS voltage,
	CONVERT(REPLACE(power, ',', '.'), DOUBLE) AS power, 
    CONVERT(REPLACE(energy, ',', '.'), DOUBLE) AS energy,
	CASE 
        WHEN CONVERT(REPLACE(active_material, ',', '.'), DOUBLE) = 0 THEN NULL
        ELSE CONVERT(REPLACE(capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(active_material, ',', '.'), DOUBLE) 
    END AS specific_capacity 
FROM `testlab-db`.record
) AS x
JOIN `dev-db`.`ids` ids ON ids.barcode = x.barcode
WHERE x.record_time MOD 60 = 0;