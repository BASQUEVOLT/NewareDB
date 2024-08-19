CREATE OR REPLACE VIEW `land_neware`.idxs AS
SELECT 
	DISTINCT test_id,
    barcode, 
    chl_id,
    computer_name,
    builder
FROM `land_neware`.`schedule`;