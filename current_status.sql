#relevant parameter from cell manufactoring request XL
CREATE TEMPORARY TABLE `dev-db`.running AS
SELECT cs.packBarCode 
FROM `testlab-db`.channel_status cs 
WHERE btsSysState LIKE 'running';

#CREATE TABLE `dev-db`.current_status AS
SELECT *
FROM (SELECT DISTINCT packBarCode, CONVERT(cycle_id, UNSIGNED) AS cycle_id, specific_dchg_capa, soh, ce, xl.Cathode_type, xl.Cathode_material, xl.Anode_Type, xl.Electrolyte_Gen, xl.Number_Cathode_Layers, xl.Cathode_Area, Active_mass Rated_Capacity, specific_chg_capa, rte, Net_eng_dchg
FROM `testlab-db`.channel_status
WHERE btsSysState LIKE 'running') AS r
LEFT JOIN `dev-db`.pouch_cell_parameters_filtered xl ON r.packBarCode = xl.Vicarli_system_ID
LEFT JOIN `dev-db`.cycle_data cd ON r.packBarCode = cd.barcode
JOIN `dev-db`.max_cycles mc ON mc.max_cycle = cd.cycle_id AND mc.barcode = r.packBarCode
ORDER BY cycle_id DESC;

DROP TEMPORARY TABLE `dev-db`.CellXL;
DROP TEMPORARY TABLE `dev-db`.running;