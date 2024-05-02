#relevant quantity for quick comparison
CREATE TEMPORARY TABLE `dev-db`.cycle_filtered AS 
SELECT t1.* 
FROM `testlab-db`.cycle t1
JOIN `dev-db`.ids t2 ON t1.barcode = t2.barcode AND t1.test_id = t2.test_id;

SELECT * FROM `dev-db`.cycle_filtered c;

CREATE TEMPORARY TABLE `dev-db`.temp AS
SELECT barcode,
	Remark,
    test_id,
	cycle_id, 
    CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_dchg_capa,
    CONVERT(REPLACE(specific_charge_capacity, ',', '.'), DOUBLE) AS specific_chg_capa,
    100*CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(specific_charge_capacity, ',', '.'), DOUBLE) AS ce, 
    100*CONVERT(REPLACE(specific_discharge_energy, ',', '.'), DOUBLE)/CONVERT(REPLACE(specific_charge_energy, ',', '.'), DOUBLE) AS rte,
    Net_eng_dchg, 
    soh
FROM `dev-db`.cycle_filtered 
WHERE CONVERT(REPLACE(specific_charge_capacity, ',', '.'), DOUBLE) > 0 AND CONVERT(REPLACE(specific_charge_energy, ',', '.'), DOUBLE) > 0;

CREATE TEMPORARY TABLE `dev-db`.temp2 AS
select c1.barcode, c1.Remark, c1.test_id, c1.cycle_id, c1.specific_dchg_capa, c1.specific_chg_capa, c1.ce, c1.rte, c1.Net_eng_dchg, c2.specific_dchg_capa4, c2.cycle_id as cycle4
FROM `dev-db`.temp as c1

join 
#4th cycle specific discharge capacity
(SELECT barcode,
	Remark,
    test_id,
	cycle_id, 
    CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE) AS specific_dchg_capa4
FROM `dev-db`.cycle_filtered
WHERE CONVERT(cycle_id, UNSIGNED) = 4 AND CONVERT(REPLACE(specific_discharge_capacity, ',', '.'), DOUBLE) > 0) as c2 
on c1.barcode = c2.barcode and c1.test_id = c2.test_id;

CREATE TABLE `dev-db`.cycle_data AS
select barcode, Remark, test_id, cycle_id, specific_dchg_capa, specific_chg_capa, ce, rte, Net_eng_dchg, 100*specific_dchg_capa/specific_dchg_capa4 as soh from `dev-db`.temp2
WHERE ce > 90 and 100*specific_dchg_capa/specific_dchg_capa4 > 79;

#where c2.barcode like '%BQV%069%';