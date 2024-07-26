CREATE OR REPLACE VIEW `dev-db`.end_voltage AS
SELECT 
    distinct current.step_id,
    current.test_id,
    current.barcode,
    current.remark,
    current.cycle_id,
    current.step_type,
    previous.step_type AS previous_step_type,
    current.end_voltage
FROM 
    `testlab-db`.`step` AS current
JOIN 
    `testlab-db`.`step` AS previous 
    ON previous.step_num = current.step_num - 1 
	AND current.cycle_id = previous.cycle_id 
    AND current.barcode = previous.barcode 
    AND current.test_id = previous.test_id
  #  AND convert(current.step_num, unsigned) > 1 -- Assuming step_id 1 marks the beginning of a new cycle
WHERE 
    current.step_type = 'rest';

    # and ids.barcode like '%BQV%075%';
#and current.barcode like '%BQV%075%' and current.test_id like '2818580510'
#ORDER BY convert(current.cycle_id, unsigned) ASC