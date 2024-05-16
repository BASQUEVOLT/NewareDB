#select end voltage
#CREATE TABLE `dev-db`.end_voltage AS 
CREATE VIEW `dev-db`.end_voltage AS
SELECT CONVERT(test_id, UNSIGNED) AS test_id, barcode, Remark, CONVERT(cycle_id, UNSIGNED) AS cycle_id, CONVERT(step_id, UNSIGNED) AS step_id, step_type, CONVERT(REPLACE(end_voltage, ',', '.'), DOUBLE) AS end_voltage 
FROM `testlab-db`.step
WHERE step_type LIKE 'rest';