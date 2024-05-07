#select step time
#CREATE TABLE `dev-db`.step_time AS 
CREATE VIEW `dev-db`.step_time AS 
SELECT CONVERT(test_id, UNSIGNED) AS test_id, barcode, Remark, CONVERT(cycle_id, UNSIGNED) AS cycle_id, CONVERT(step_id, UNSIGNED) AS step_id, step_type, CONVERT(REPLACE(step_time , ',', '.'), DOUBLE) AS step_time 
FROM `testlab-db`.step
WHERE step_type IN ('cc_chg', 'cv_chg', 'cc_dchg');