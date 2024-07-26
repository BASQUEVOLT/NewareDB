SELECT 
	`testlab-db`.`step`.`test_id`,
	`testlab-db`.`step`.`barcode`,
	`testlab-db`.`step`.`Remark`,
	`testlab-db`.`step`.`cycle_id`,
	`testlab-db`.`step`.`step_id`,
	`testlab-db`.`step`.`step_type`,
	`testlab-db`.`step`.`step_time`
FROM `testlab-db`.`step` 
WHERE (`testlab-db`.`step`.`step_type` IN ('cc_chg','cv_chg','cc_dchg','cccv_chg'))