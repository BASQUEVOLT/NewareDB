-- Select the record data with the barcode for cycling
SELECT  convert(replace(r.voltage, ',', '.'), DOUBLE) AS voltage, 
		convert(replace(r.current, ',', '.'), DOUBLE) AS current, 
        CASE 
			WHEN convert(replace(ids.active_material, ',', '.'), DOUBLE) > 0 THEN convert(replace(r.capacity, ',', '.'), DOUBLE)/convert(replace(ids.active_material, ',', '.'), DOUBLE)
            ELSE convert(replace(r.capacity, ',', '.'), DOUBLE) 
		END AS specific_capacity,
        CONVERT(r.cycle_id, UNSIGNED) AS cycle_id
FROM (
	SELECT  current, 
			capacity, 
			voltage, 
            barcode,
            test_id,
            cycle_id,
            step_id,
            step_type,
            record_time
	FROM `testlab-db`.`record`) r
JOIN (
	SELECT barcode, test_id, active_material FROM `dev-db`.`ids` 
    WHERE barcode_corrected = '1003-BQV000000000000124-1' AND builder LIKE '%CY%'
    ) ids
ON ids.barcode = r.barcode AND ids.test_id = r.test_id;

-- Select the record data with the barcode for formation
SELECT  convert(replace(r.voltage, ',', '.'), DOUBLE) AS voltage, 
		convert(replace(r.current, ',', '.'), DOUBLE) AS current, 
        CASE
			WHEN convert(replace(ids.active_material, ',', '.'), DOUBLE) > 0 THEN convert(replace(r.capacity, ',', '.'), DOUBLE)/convert(replace(ids.active_material, ',', '.'), DOUBLE)
            ELSE convert(replace(r.capacity, ',', '.'), DOUBLE) 
		END AS specific_capacity, 
        CONVERT(r.cycle_id, UNSIGNED) AS cycle_id
FROM (
	SELECT  current, 
			capacity, 
			voltage, 
            barcode,
            test_id,
            cycle_id,
            step_id,
            step_type,
            record_time
	FROM `testlab-db`.`record`) r
JOIN (
	SELECT barcode, test_id, active_material FROM `dev-db`.`ids` 
    WHERE barcode_corrected = '1003-BQV000000000000124-1' AND builder LIKE '%FM%'
    ) ids
ON ids.barcode = r.barcode AND ids.test_id = r.test_id;