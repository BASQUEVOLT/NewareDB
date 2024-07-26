-- DCIR IN DISCHARGE
SELECT
  r.barcode,
  s.cycle_id,
  (r.voltage - s.end_voltage) / r.current AS dcir
FROM
  `testlab-db`.`step` s
  JOIN `testlab-db`.`record` r 
	ON r.barcode = s.barcode
    AND r.test_id = s.test_id
    AND s.step_num = r.step_num - 1
    #AND s.cycle_id = r.cycle_id
WHERE
  r.barcode = barcode
  AND r.step_type = 'cc_dchg'
  AND r.test_id in (
    SELECT
      distinct test_id
    FROM
      `testlab-db`.schedule
    WHERE barcode = barcode
		AND builder = 'CY'
  )
  AND r.record_time = X ;
  
  -- DCIR IN CHARGE
SELECT
  r.barcode,
  s.cycle_id,
  (r.voltage - s.end_voltage) / r.current AS dcir
FROM
  `testlab-db`.`step` s
  JOIN `testlab-db`.`record` r ON r.barcode = s.barcode
    AND r.test_id = s.test_id
    AND s.step_num = r.step_num - 1
    AND s.cycle_id = r.cycle_id - 1
WHERE
  r.barcode = barcode 
  AND r.step_type = 'cc_chg'
  AND r.test_id in (
    SELECT
      distinct test_id
    FROM
      `testlab-db`.schedule
    WHERE barcode = barcode 
		AND builder = 'CY'
  )
  AND r.record_time = X ;