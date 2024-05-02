#relevant parameter from cell manufactoring request XL
CREATE TEMPORARY TABLE `dev-db`.CellXL AS 
SELECT Number, Vicarli_system_ID, Cathode_batch as Cathode_type, Active_material AS Cathode_material, Anode_Type, Electrolyte_Gen, Number_Cathode_Layers, Cathode_Area, Active_mass, Rated_Capacity FROM `testlab-db`.pouch_cell_parameters
WHERE Vicarli_system_ID not like 'nan'
ORDER BY CONVERT(Number, UNSIGNED) ASC;

CREATE TEMPORARY TABLE `dev-db`.running AS
SELECT cs.packBarCode 
FROM `testlab-db`.channel_status cs 
WHERE btsSysState LIKE 'running';

CREATE TABLE `dev-db`.current_status AS
SELECT DISTINCT xl.Vicarli_system_ID, CONVERT(cycle_id, UNSIGNED) AS cycle_id, specific_dchg_capa, soh, ce, xl.Cathode_type, xl.Cathode_material, xl.Anode_Type, xl.Electrolyte_Gen, xl.Number_Cathode_Layers, xl.Cathode_Area, Active_mass Rated_Capacity, specific_chg_capa, rte, Net_eng_dchg
FROM `dev-db`.running r
JOIN `dev-db`.CellXL xl ON r.packBarCode = xl.Vicarli_system_ID
JOIN `dev-db`.cycle_data cd ON r.packBarCode = cd.barcode
JOIN `dev-db`.max_cycles mc ON mc.max_cycle = cd.cycle_id AND mc.barcode = r.packBarCode


