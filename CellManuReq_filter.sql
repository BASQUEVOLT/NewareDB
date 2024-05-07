#relevant parameter from cell manufactoring request XL
CREATE VIEW `dev-db`.pouch_cell_parameters_filtered AS
SELECT CONVERT(Number, UNSIGNED) AS number, 
	Vicarli_system_ID, Cathode_batch as Cathode_type, 
    Active_material AS Cathode_material, Anode_Type, 
    Electrolyte_Gen, CONVERT(Number_Cathode_Layers, UNSIGNED) AS Number_Cathode_Layers, 
    CONVERT(REPLACE(Cathode_Area, ',', '.'), DOUBLE) AS Cathode_Area,
    CONVERT(REPLACE(Active_mass, ',', '.'), DOUBLE) AS Active_mass, 
    CONVERT(REPLACE(Rated_Capacity , ',', '.'), DOUBLE) AS Rated_Capacity 
FROM `testlab-db`.pouch_cell_parameters
WHERE Vicarli_system_ID not like 'nan'
ORDER BY CONVERT(Number, UNSIGNED) ASC;