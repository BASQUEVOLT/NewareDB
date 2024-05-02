#select end voltage
CREATE TABLE `dev-db`.end_voltage AS 
SELECT test_id, barcode, Remark, cycle_id, step_id, step_type, end_voltage FROM `testlab-db`.step
WHERE step_type LIKE 'rest';