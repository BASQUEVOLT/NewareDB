CREATE OR REPLACE VIEW `dev-db`.quality_measures_corrected AS
SELECT CONCAT(Cell_ID_Vicarli, '-1') AS barcode, t1.* FROM `testlab-db`.quality_measures t1
WHERE Cell_ID_Vicarli NOT LIKE '%-1';