CREATE 
ALGORITHM=UNDEFINED 
DEFINER=`ecalandrini`@`%`
SQL SECURITY DEFINER 
VIEW `dev-db`.`step_time` AS 
SELECT ids.barcode_corrected AS barcode, s.test_id, s.Remark, s.cycle_id, s.step_id, s.step_type, s.step_time FROM
	(SELECT CAST(`testlab-db`.`step`.`test_id` AS UNSIGNED) AS `test_id`,
	`testlab-db`.`step`.`barcode` AS `barcode`,
	`testlab-db`.`step`.`Remark` AS `Remark`,
	CAST(`testlab-db`.`step`.`cycle_id` AS UNSIGNED) AS `cycle_id`,
	CAST(`testlab-db`.`step`.`step_id` AS UNSIGNED) AS `step_id`,
	`testlab-db`.`step`.`step_type` AS `step_type`,
	CAST(REPLACE(`testlab-db`.`step`.`step_time`,',','.') AS DOUBLE) AS `step_time`
FROM `testlab-db`.`step` 
WHERE (`testlab-db`.`step`.`step_type` IN ('cc_chg','cv_chg','cc_dchg','cccv_chg'))) AS s
JOIN `dev-db`.`ids` ids ON s.barcode = ids.barcode AND s.test_id = ids.test_id