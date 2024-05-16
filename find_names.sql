CREATE 
	ALGORITHM=UNDEFINED 
    DEFINER=`ecalandrini`@`%` 
    SQL SECURITY DEFINER 
    VIEW `dev-db`.`ids` AS 
		-- Select all correct barcodes
		SELECT DISTINCT `testlab-db`.`schedule`.`barcode` AS `barcode`,
        `testlab-db`.`schedule`.`barcode` AS `barcode_corrected`,
        `testlab-db`.`schedule`.`Remark` AS `Remark`,
        CAST(`testlab-db`.`schedule`.`test_id` AS UNSIGNED) AS `test_id`,
        `testlab-db`.`schedule`.`chl_id` AS `chl_id`,
        `testlab-db`.`schedule`.`Builder` AS `Builder`,
        `testlab-db`.`schedule`.`StartTime` AS `StartTime`,
        `testlab-db`.`schedule`.`EndTime` AS `EndTime`,
        CAST(REPLACE(`testlab-db`.`schedule`.`Active_material`,',','.') AS DOUBLE) AS `Active_material`
        FROM `testlab-db`.`schedule` 
        WHERE (`testlab-db`.`schedule`.`barcode` LIKE '1003-BQV%-1') -- 1Ah Pouch in Vicarli
			OR (`testlab-db`.`schedule`.`barcode` LIKE 'RDML%') -- 1Ah Pouch with old barcode
            OR (`testlab-db`.`schedule`.`barcode` like 'RDCC%') -- Coin cell
            OR (`testlab-db`.`schedule`.`barcode` LIKE 'CIC%') -- 1Ah from CIC
            OR (`testlab-db`.`schedule`.`barcode` LIKE '1610-%') -- 20L Pouch cell
            OR (`testlab-db`.`schedule`.`barcode` LIKE '1004-%') -- 5Ah Pouch in Vicarli
	
    UNION ALL 
		-- Correct barcodes of type BQV000000000XXX -> Add prefix 1003- and subfix -1
		SELECT DISTINCT `testlab-db`.`schedule`.`barcode`,
        CONCAT('1003-', `testlab-db`.`schedule`.`barcode`, '-1') AS `barcode_corrected`,
        `testlab-db`.`schedule`.`Remark` AS `Remark`,
        CAST(`testlab-db`.`schedule`.`test_id` AS UNSIGNED) AS `test_id`,
        `testlab-db`.`schedule`.`chl_id` AS `chl_id`,
        `testlab-db`.`schedule`.`Builder` AS `Builder`,
        `testlab-db`.`schedule`.`StartTime` AS `StartTime`,
        `testlab-db`.`schedule`.`EndTime` AS `EndTime`,
        CAST(REPLACE(`testlab-db`.`schedule`.`Active_material`,',','.') AS DOUBLE) AS `Active_material`
        FROM `testlab-db`.`schedule` 
        WHERE `testlab-db`.`schedule`.`barcode` LIKE 'BQV%'
	
    UNION ALL 
		-- Correct barcodes of type 1003-BQV000000000XXX -> Add subfix -1
		SELECT DISTINCT `testlab-db`.`schedule`.`barcode`,
        CONCAT(`testlab-db`.`schedule`.`barcode`, '-1') AS `barcode_corrected`,
        `testlab-db`.`schedule`.`Remark` AS `Remark`,
        CAST(`testlab-db`.`schedule`.`test_id` AS UNSIGNED) AS `test_id`,
        `testlab-db`.`schedule`.`chl_id` AS `chl_id`,
        `testlab-db`.`schedule`.`Builder` AS `Builder`,
        `testlab-db`.`schedule`.`StartTime` AS `StartTime`,
        `testlab-db`.`schedule`.`EndTime` AS `EndTime`,
        CAST(REPLACE(`testlab-db`.`schedule`.`Active_material`,',','.') AS DOUBLE) AS `Active_material`
        FROM `testlab-db`.`schedule` 
        WHERE `testlab-db`.`schedule`.`barcode` LIKE '1003-BQV%' AND `testlab-db`.`schedule`.`barcode` NOT LIKE '%-1'
	
    UNION ALL 
		-- Correct CIC barcodes -> Add prefix CIC_
		SELECT DISTINCT `testlab-db`.`schedule`.`barcode` AS `barcode`,
        CONCAT('CIC_', `testlab-db`.`schedule`.`barcode`) AS `barcode_corrected`,
        `testlab-db`.`schedule`.`Remark` AS `Remark`,
        CAST(`testlab-db`.`schedule`.`test_id` AS UNSIGNED) AS `test_id`,
        `testlab-db`.`schedule`.`chl_id` AS `chl_id`,
        `testlab-db`.`schedule`.`Builder` AS `Builder`,
        `testlab-db`.`schedule`.`StartTime` AS `StartTime`,
        `testlab-db`.`schedule`.`EndTime` AS `EndTime`,
        CAST(REPLACE(`testlab-db`.`schedule`.`Active_material`,',','.') AS DOUBLE) AS `Active_material`
        FROM `testlab-db`.`schedule` 
        WHERE (`testlab-db`.`schedule`.`barcode` LIKE 'NMC%') OR (`testlab-db`.`schedule`.`barcode` LIKE 'WW%') OR (`testlab-db`.`schedule`.`barcode` LIKE 'GLIL%')