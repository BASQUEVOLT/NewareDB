CREATE OR REPLACE VIEW `dev-db`.bqv_maxcycles_parameters AS
SELECT pc.*, mc.max_cycle FROM `dev-db`.max_cycles mc
join `dev-db`.`pouch_cell_parameters_filtered` pc on mc.barcode = pc.Vicarli_system_ID