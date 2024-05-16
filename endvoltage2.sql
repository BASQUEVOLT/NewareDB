CREATE OR REPLACE VIEW `dev-db`.end_voltage AS
SELECT 
    distinct CONVERT(current.step_id, UNSIGNED) AS step_id,
    CONVERT(current.test_id, UNSIGNED) AS test_id,
    #current.barcode,
    ids.barcode_corrected AS barcode,
    current.remark,
    CONVERT(current.cycle_id, UNSIGNED) AS cycle_id,
    current.step_type,
    previous.step_type AS previous_step_type,
    CONVERT(REPLACE(current.end_voltage, ',', '.'), DOUBLE) AS end_voltage
FROM 
    `testlab-db`.`step` AS current
JOIN 
    `testlab-db`.`step` AS previous 
    ON convert(previous.step_num, unsigned) = convert(current.step_num, unsigned) - 1 
	AND convert(current.cycle_id, unsigned) = convert(previous.cycle_id, unsigned) 
    AND current.barcode = previous.barcode 
    AND current.test_id = previous.test_id
  #  AND convert(current.step_num, unsigned) > 1 -- Assuming step_id 1 marks the beginning of a new cycle

JOIN `dev-db`.`ids` ids ON ids.barcode = current.barcode AND ids.test_id = current.test_id
WHERE 
    current.step_type = 'rest';

    # and ids.barcode like '%BQV%075%';
#and current.barcode like '%BQV%075%' and current.test_id like '2818580510'
#ORDER BY convert(current.cycle_id, unsigned) ASC