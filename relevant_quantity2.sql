#CREATE OR REPLACE VIEW `dev-db`.cycle_data_view AS
#CREATE TABLE `dev-db`.cycle_data_view AS
#SELECT 
#    ids.barcode_corrected AS barcode, 
#    c1.Remark, 
#    c1.test_id, 
#    c1.cycle_id, 
#    c1.specific_dchg_capa, 
#    c1.specific_chg_capa, 
#    c1.ce, 
#    c1.rte, 
#    c1.Net_eng_dchg, 
#    c1.soh, 
#    100 * c1.specific_dchg_capa / c2.specific_dchg_capa4 AS my_soh
    #CASE 
        #WHEN c2.specific_dchg_capa4 <> 0 THEN 100 * c1.specific_dchg_capa / c2.specific_dchg_capa4
        #ELSE NULL
    #END AS my_soh 
#FROM 
#    (
#        SELECT 
#            t1.barcode,
#            t1.Remark,
#            CONVERT(t1.test_id, UNSIGNED) AS test_id,
#            CONVERT(t1.cycle_id, UNSIGNED) AS cycle_id, 
#            CONVERT(REPLACE(t1.specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_dchg_capa,
#            CONVERT(REPLACE(t1.specific_charge_capacity, ',', '.'), DOUBLE) AS specific_chg_capa,
#			100 * CONVERT(REPLACE(t1.discharge_capacity, ',', '.'), DOUBLE) / CONVERT(REPLACE(t1.charge_capacity, ',', '.'), DOUBLE) AS ce, 
#            100 * CONVERT(REPLACE(t1.discharge_energy, ',', '.'), DOUBLE) / CONVERT(REPLACE(t1.charge_energy, ',', '.'), DOUBLE) AS rte,
            #100 * CONVERT(REPLACE(t1.discharge_capacity, ',', '.'), DOUBLE) / NULLIF(CONVERT(REPLACE(t1.charge_capacity, ',', '.'), DOUBLE), 0) AS ce, 
            #100 * CONVERT(REPLACE(t1.discharge_energy, ',', '.'), DOUBLE) / NULLIF(CONVERT(REPLACE(t1.charge_energy, ',', '.'), DOUBLE), 0) AS rte,
#            CONVERT(REPLACE(t1.Net_eng_dchg, ',', '.'), DOUBLE) AS Net_eng_dchg, 
#            CONVERT(REPLACE(t1.soh, ',', '.'), DOUBLE) AS soh
#        FROM 
#            `testlab-db`.cycle t1
#        JOIN 
#            `dev-db`.ids t2 
#        ON 
#            t1.barcode = t2.barcode# AND t1.test_id = t2.test_id
#    ) AS c1
#JOIN 
#    (
#        SELECT 
#            barcode,
#            Remark,
#            CONVERT(test_id, UNSIGNED) AS test_id,
#            CONVERT(cycle_id, UNSIGNED) AS cycle_id, 
#            CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_dchg_capa4
#        FROM 
#            `testlab-db`.cycle
#        WHERE 
#            CONVERT(cycle_id, UNSIGNED) = 4 AND CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE) > 0
#    ) AS c2 
#ON 
#    c1.barcode = c2.barcode# AND c1.test_id = c2.test_id
#JOIN `dev-db`.`ids` ids ON ids.barcode = c1.barcode# AND ids.test_id = c1.test_id 
#WHERE 
#    c1.ce > 90;# AND (c2.specific_dchg_capa4 IS NULL OR c2.specific_dchg_capa4 <> 0);

CREATE OR REPLACE VIEW `dev-db`.cycle_data_raw AS
WITH soh_test AS (SELECT barcode, CONVERT(test_id, UNSIGNED) AS test_id, MAX(CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE)) specific_discharge_capacity4
					FROM `testlab-db`.`cycle`
                    WHERE CONVERT(cycle_id, UNSIGNED)=4
                    GROUP BY barcode, test_id)
SELECT 
	DISTINCT ids.barcode_corrected AS barcode, 
	CONVERT(c1.test_id, UNSIGNED) AS test_id, 
    c1.Remark, 
    c1.builder,
    CONVERT(c1.cycle_id, UNSIGNED) AS cycle_id,
    CONVERT(REPLACE(c1.charge_capacity, ',', '.'), DOUBLE) AS charge_capacity, 
    CONVERT(REPLACE(c1.discharge_capacity, ',', '.'), DOUBLE) AS discharge_capacity, 
    CONVERT(REPLACE(c1.charge_energy, ',', '.'), DOUBLE) AS charge_energy, 
    CONVERT(REPLACE(c1.discharge_energy, ',', '.'), DOUBLE) AS discharge_energy, 
    CONVERT(REPLACE(c1.Net_cap_dchg, ',', '.'), DOUBLE) AS Net_cap_dchg, 
    CONVERT(REPLACE(c1.Net_eng_dchg, ',', '.'), DOUBLE) AS Net_eng_dchg, 
    CONVERT(REPLACE(c1.specific_charge_capacity, ',', '.'), DOUBLE) AS specific_charge_capacity, 
    CONVERT(REPLACE(c1.specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_discharge_capacity, 
    CONVERT(REPLACE(c1.specific_charge_energy, ',', '.'), DOUBLE) AS specific_charge_energy, 
    CONVERT(REPLACE(c1.specific_discharge_energy, ',', '.'), DOUBLE) AS specific_discharge_energy, 
    CONVERT(REPLACE(c1.active_material, ',', '.'), DOUBLE) AS active_material, 
    100*CONVERT(REPLACE(c1.specific_discharge_capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(c1.specific_charge_capacity, ',', '.'), DOUBLE) AS ce,
    #100*CONVERT(REPLACE(c1.discharge_capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(c1.charge_capacity, ',', '.'), DOUBLE) AS ce1, #Same as the one calculated with specific quantities
    #100*CONVERT(REPLACE(c1.discharge_energy, ',', '.'), DOUBLE)/CONVERT(REPLACE(c1.charge_energy, ',', '.'), DOUBLE) AS rte1,
    100*CONVERT(REPLACE(c1.specific_discharge_energy, ',', '.'), DOUBLE)/CONVERT(REPLACE(c1.specific_charge_energy, ',', '.'), DOUBLE) AS rte,
    CONVERT(REPLACE(c1.soh, ',', '.'), DOUBLE) AS soh,
    soh_test.specific_discharge_capacity4 AS specific_discharge_capacity4,
    100*CONVERT(REPLACE(c1.specific_discharge_capacity, ',', '.'), DOUBLE)/soh_test.specific_discharge_capacity4 AS my_soh
FROM `testlab-db`.`cycle` c1
INNER JOIN soh_test ON soh_test.barcode = c1.barcode AND soh_test.test_id = c1.test_id
JOIN `dev-db`.`ids` ids ON ids.barcode = c1.barcode;
    
CREATE OR REPLACE VIEW `dev-db`.cycle_data AS
SELECT * FROM `dev-db`.cycle_data_raw
WHERE my_soh > 79 AND ce > 90;

