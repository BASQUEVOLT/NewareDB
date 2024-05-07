#coin cells BQV
#CREATE TABLE `dev-db`.ids AS 
CREATE VIEW `dev-db`.ids AS

SELECT DISTINCT barcode, Remark, CONVERT(test_id, UNSIGNED) AS test_id, chl_id, Builder, StartTime, EndTime, CONVERT(REPLACE(Active_material, ',', '.'), DOUBLE)AS Active_material, 'Coin' AS ID FROM `testlab-db`.schedule
WHERE barcode LIKE 'RDCC%'

UNION ALL

#old pouch cells BQV
SELECT DISTINCT barcode, Remark, CONVERT(test_id, UNSIGNED) AS test_id, chl_id, Builder, StartTime, EndTime, CONVERT(REPLACE(Active_material, ',', '.'), DOUBLE)AS Active_material, '1003Old' AS ID FROM `testlab-db`.schedule
WHERE barcode LIKE 'RDML%'

UNION ALL

#pouch cells BQV in Vicarli
SELECT DISTINCT barcode, Remark, CONVERT(test_id, UNSIGNED) AS test_id, chl_id, Builder, StartTime, EndTime, CONVERT(REPLACE(Active_material, ',', '.'), DOUBLE)AS Active_material, '1003' AS ID FROM `testlab-db`.schedule
WHERE barcode LIKE 'BQV%' or barcode LIKE '1003-%'

UNION ALL

#pouch cells CIC
SELECT DISTINCT barcode, Remark, CONVERT(test_id, UNSIGNED) AS test_id, chl_id, Builder, StartTime, EndTime, CONVERT(REPLACE(Active_material, ',', '.'), DOUBLE)AS Active_material, '1003CIC' AS ID FROM `testlab-db`.schedule
WHERE barcode LIKE 'CIC%' or barcode LIKE 'NMC%' or barcode LIKE 'WW%' or barcode LIKE 'GLIL%'

UNION ALL

#pouch cells BQV 20Ah
SELECT DISTINCT barcode, Remark, CONVERT(test_id, UNSIGNED) AS test_id, chl_id, Builder, StartTime, EndTime, CONVERT(REPLACE(Active_material, ',', '.'), DOUBLE)AS Active_material, '1610' AS ID FROM `testlab-db`.schedule
WHERE barcode LIKE '1610-%'

UNION ALL

#pouch cells BQV 5Ah
SELECT DISTINCT barcode, Remark, CONVERT(test_id, UNSIGNED) AS test_id, chl_id, Builder, StartTime, EndTime, CONVERT(REPLACE(Active_material, ',', '.'), DOUBLE)AS Active_material, '1004' AS ID FROM `testlab-db`.schedule
WHERE barcode LIKE '1004-%';
