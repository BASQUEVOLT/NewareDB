#relevant parameter from cell manufactoring request XL
SELECT Number, Vicarli_system_ID, Cathode_batch as Cathode_type, Active_material AS Cathode_material, Anode_Type, Electrolyte_Gen, Number_Cathode_Layers, Cathode_Area, Active_mass, Rated_Capacity FROM `testlab-db`.pouch_cell_parameters
WHERE Vicarli_system_ID not like 'nan'
ORDER BY CONVERT(Number, UNSIGNED) ASC;