CREATE VIEW `lab-db`.`all_merged` AS
SELECT pc.*,
	hk.IR_BWT, hk.IR_AWT, hk.IR_AXL, hk.IR_AFM, hk.IR_ADG, hk.IR_EOL, hk.OCV_BWT, hk.OCV_AWT, hk.OCV_AXL, hk.OCV_AFM, hk.hk.OCV_ADG, hk.OVC_EOL, hk.Date_BWT, hk.Date_AWT, hk.Date_AXL, hk.Date_AFM, hk.Date_ADG, hk.Date_EOL, 
    qc.*, 
    mx.max_cycle, mx.total_specific_discharge_energy, mx.specific_discharge_energy_avg 
    FROM
(SELECT * FROM `dev-db`.`pouch_cell_parameters_filtered`) AS pc
left JOIN
(SELECT * FROM `lab-db`.`max_cycles`) AS mx
ON pc.Vicarli_system_ID = mx.barcode
left JOIN
(SELECT * FROM `lab-db`.`quality_measures`) AS qc
ON pc.Vicarli_system_ID = qc.Cell_ID_Vicarli
left JOIN
(SELECT * FROM `lab-db`.`hioki_pivot`) AS hk
ON pc.Vicarli_system_ID = hk.barcode