#coin cells BQV
SELECT test_id, chl_id, Builder, StartTime, EndTime, barcode, Remark, Active_material FROM `testlab-db`.schedule
WHERE barcode LIKE 'RDCC%';

#old pouch cells BQV
SELECT test_id, chl_id, Builder, StartTime, EndTime, barcode, Remark, Active_material FROM `testlab-db`.schedule
WHERE barcode LIKE 'RDML%';

#pouch cells BQV in Vicarli
SELECT test_id, chl_id, Builder, StartTime, EndTime, barcode, Remark, Active_material FROM `testlab-db`.schedule
WHERE barcode LIKE 'BQV%' or barcode LIKE '1003-%';

#pouch cells CIC
SELECT test_id, chl_id, Builder, StartTime, EndTime, barcode, Remark, Active_material FROM `testlab-db`.schedule
WHERE barcode LIKE 'CIC%' or barcode LIKE 'NMC%' or barcode LIKE 'WW%' or barcode LIKE 'GLIL%';

#pouch cells BQV 20Ah
SELECT test_id, chl_id, Builder, StartTime, EndTime, barcode, Remark, Active_material FROM `testlab-db`.schedule
WHERE barcode LIKE '1610-%';