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
SELECT xl.Vicarli_system_ID, xl.Cathode_type, xl.Cathode_material, xl.Anode_Type, xl.Electrolyte_Gen, xl.Number_Cathode_Layers, xl.Cathode_Area, Active_mass Rated_Capacity, cycle_id, specific_chg_capa, specific_dchg_capa, ce, rte, Net_eng_dchg, soh
FROM `dev-db`.running r
JOIN `dev-db`.CellXL xl ON r.packBarCode = xl.Vicarli_system_ID
JOIN `dev-db`.cycle_data cd ON r.packBarCode = cd.barcode


