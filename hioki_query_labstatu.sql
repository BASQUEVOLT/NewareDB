-- Select records of the last 15 days
CREATE OR REPLACE VIEW `dev-db`.hk_last15d AS 
SELECT Cell_Barcode, State, Start_time, OCV, IR, DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) AS Delta FROM `testlab-db`.hioki_data
WHERE DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) < 15;

-- Select cell which did only Before wetting
SELECT t2.Cell_Barcode, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s') AS Date_meas, TIMESTAMPDIFF(HOUR, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s'), DATE_ADD(NOW(), INTERVAL 2 HOUR)) AS Delta
FROM (
SELECT Cell_Barcode
FROM `testlab-db`.hioki_data
GROUP BY Cell_Barcode
HAVING SUM(CASE WHEN State = 'Before Wetting' THEN 1 ELSE 0 END) > 0
AND SUM(CASE WHEN State IN ('After Wetting', 'After Crosslinking', 'After Formation', 'After Degassing', 'End of Life') THEN 1 ELSE 0 END) = 0) AS t1
JOIN (
    SELECT Cell_Barcode, State, Start_time, OCV, IR, DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) AS Delta 
    FROM `testlab-db`.hioki_data
    WHERE DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) < 15) t2 
ON t1.Cell_Barcode = t2.Cell_Barcode;

-- Select cell which did only After wetting
SELECT t2.Cell_Barcode, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s') AS Date_meas, TIMESTAMPDIFF(HOUR, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s'), DATE_ADD(NOW(), INTERVAL 2 HOUR)) AS Delta
FROM (
SELECT 
    cell_barcode
FROM 
    `testlab-db`.hioki_data
WHERE 
    state LIKE 'After Wetting'
    AND cell_barcode NOT IN (
        SELECT 
            cell_barcode
        FROM 
            `testlab-db`.hioki_data
        WHERE 
            state IN ('After Crosslinking', 'After Formation', 'After Degassing', 'End of Life')
    )
GROUP BY 
    cell_barcode
HAVING 
    COUNT(DISTINCT state) <= 2) AS t1
JOIN (
    SELECT Cell_Barcode, State, Start_time, OCV, IR, DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) AS Delta 
    FROM `testlab-db`.hioki_data
    WHERE DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) < 15) t2 
ON t1.Cell_Barcode = t2.Cell_Barcode
WHERE t2.State like 'After Wetting';

-- Select cell which did only After Crosslinking
SELECT t2.Cell_Barcode, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s') AS Date_meas, TIMESTAMPDIFF(HOUR, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s'), DATE_ADD(NOW(), INTERVAL 2 HOUR)) AS Delta
FROM (
SELECT 
    cell_barcode
FROM 
    `testlab-db`.hioki_data
WHERE 
    state LIKE 'After Crosslinking'
    AND cell_barcode NOT IN (
        SELECT 
            cell_barcode
        FROM 
            `testlab-db`.hioki_data
        WHERE 
            state IN ('After Formation', 'After Degassing', 'End of Life')
    )
GROUP BY 
    cell_barcode
HAVING 
    COUNT(DISTINCT state) <= 3) AS t1
JOIN (
    SELECT Cell_Barcode, State, Start_time, OCV, IR, DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) AS Delta 
    FROM `testlab-db`.hioki_data
    WHERE DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) < 15) t2 
ON t1.Cell_Barcode = t2.Cell_Barcode
WHERE t2.State like 'After Crosslinking';

-- Select cell which did only After Formation
SELECT t2.Cell_Barcode, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s') AS Date_meas, TIMESTAMPDIFF(HOUR, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s'), DATE_ADD(NOW(), INTERVAL 2 HOUR)) AS Delta
FROM (
SELECT 
    cell_barcode
FROM 
    `testlab-db`.hioki_data
WHERE 
    state LIKE 'After Formation'
    AND cell_barcode NOT IN (
        SELECT 
            cell_barcode
        FROM 
            `testlab-db`.hioki_data
        WHERE 
            state IN ('After Degassing', 'End of Life')
    )
GROUP BY 
    cell_barcode
HAVING 
    COUNT(DISTINCT state) <= 3) AS t1
JOIN (
    SELECT Cell_Barcode, State, Start_time, OCV, IR, DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) AS Delta 
    FROM `testlab-db`.hioki_data
    WHERE DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) < 15) t2 
ON t1.Cell_Barcode = t2.Cell_Barcode
WHERE t2.State like 'After Formation';

-- Select cell which did only After Degassing
SELECT t2.Cell_Barcode, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s') AS Date_meas, TIMESTAMPDIFF(HOUR, STR_TO_DATE(t2.Start_time, '%Y-%m-%d %H:%i:%s'), DATE_ADD(NOW(), INTERVAL 2 HOUR)) AS Delta
FROM (
SELECT 
    cell_barcode
FROM 
    `testlab-db`.hioki_data
WHERE 
    state LIKE 'After Degassing'
    AND cell_barcode NOT IN (
        SELECT 
            cell_barcode
        FROM 
            `testlab-db`.hioki_data
        WHERE 
            state like 'End of Life'
    )
GROUP BY 
    cell_barcode
HAVING 
    COUNT(DISTINCT state) <= 3) AS t1
JOIN (
    SELECT Cell_Barcode, State, Start_time, OCV, IR, DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) AS Delta 
    FROM `testlab-db`.hioki_data
    WHERE DATEDIFF(DATE_ADD(NOW(), INTERVAL 2 HOUR), STR_TO_DATE(Start_time, '%Y-%m-%d %H:%i:%s')) < 15) t2 
ON t1.Cell_Barcode = t2.Cell_Barcode
WHERE t2.State like 'After Degassing' AND t2.Cell_Barcode NOT IN (
	SELECT packBarCode FROM `testlab-db`.`channel_status` WHERE btsSysState LIKE 'running')