CREATE ALGORITHM=UNDEFINED 
DEFINER=`ecalandrini`@`%` 
SQL SECURITY DEFINER 
VIEW `testlab-db`.`ids` AS 

#CORRECT BARCODES
SELECT 
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material` 
FROM `testlab-db`.`schedule` 
WHERE 
	(
		#old pouch
        `testlab-db`.`schedule`.`barcode` like 'RDML%' or 
        #cic cells
        `testlab-db`.`schedule`.`barcode` like 'CIC%'
	)
    
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material` 
FROM `testlab-db`.`schedule` 
WHERE 
	(
        #coin
        `testlab-db`.`schedule`.`barcode` like 'RDCC%'
	)

UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1003-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli 1Ah
        `testlab-db`.`schedule`.`barcode` like '1003-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1004-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli 5Ah
        `testlab-db`.`schedule`.`barcode` like '1004-BQV%'

UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1011-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli monolayer nmc
        `testlab-db`.`schedule`.`barcode` like '1011-BQV%'

UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1012-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli monolayer lfp
        `testlab-db`.`schedule`.`barcode` like '1012-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1021-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli nmc double cathode
        `testlab-db`.`schedule`.`barcode` like '1021-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1022-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double cathode
        `testlab-db`.`schedule`.`barcode` like '1022-BQV%'   
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1031-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli nmc double anode
        `testlab-db`.`schedule`.`barcode` like '1031-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1032-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1032-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1600-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1600-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1610-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1610-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1620-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1620-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1630-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1630-BQV%'

UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1802-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1802-BQV%'

UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1812-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1812-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1822-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1822-BQV%'
        
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1832-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - LOCATE('-', barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
        #vicarli lfp double anode
        `testlab-db`.`schedule`.`barcode` like '1832-BQV%'
        
#EXCEPTION 1: 
#Vicarli cells with missing product code (probably a 1Ah cell)
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    CONCAT(
		'1003-BQV',
		LPAD(CAST(RIGHT(barcode, LENGTH(barcode) - 3 ) AS UNSIGNED), 15, '0'),
        '-1'
	) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
	`testlab-db`.`schedule`.`barcode` like 'BQV%' 

#EXCEPTION 3: 
#CIC cells without the CIC_ prefix
UNION ALL
SELECT
	DISTINCT LEFT(`testlab-db`.`schedule`.`barcode`, 60) AS `barcode`,
    concat('CIC_',`testlab-db`.`schedule`.`barcode`) AS `barcode_corrected`,
    LEFT(`testlab-db`.`schedule`.`remark`, 60) AS `remark`,
    cast(`testlab-db`.`schedule`.`test_id` AS UNSIGNED ) AS `test_id`,
    LEFT(`testlab-db`.`schedule`.`chl_id`, 60) AS `chl_id`,
    LEFT(`testlab-db`.`schedule`.`builder`, 25) AS `builder`,
    LEFT(`testlab-db`.`schedule`.`starting_time`, 25) AS `starting_time`,
    LEFT(`testlab-db`.`schedule`.`end_time`, 25) AS `end_time`,
    CAST(REPLACE(`testlab-db`.`schedule`.`active_material`,',','.') AS DOUBLE) AS `active_material`  
FROM `testlab-db`.`schedule` 
WHERE 
	`testlab-db`.`schedule`.`barcode` like 'NMC%' or 
    `testlab-db`.`schedule`.`barcode` like 'WW%' or 
    `testlab-db`.`schedule`.`barcode` like 'GLIL%'