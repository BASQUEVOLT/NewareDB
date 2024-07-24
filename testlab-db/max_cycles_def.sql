SELECT distinct t.*, c.discharge_capacity*1000 AS first_discharge_capacity FROM (
SELECT 
	DISTINCT c1.barcode,
    c1.test_id,
    c1.builder,
    MAX(c1.cycle_id) AS max_cycle,
    SUM(c1.specific_discharge_energy) AS total_specific_discharge_energy
FROM `dev-db`.`test_cycling_data` c1
WHERE c1.my_soh > 79 AND c1.delta_cycle = 1 AND c1.builder LIKE 'CY%' OR c1.builder LIKE 'FMCY%'
GROUP BY c1.barcode, c1.test_id, c1.builder) AS t
JOIN `dev-db`.`test_cycling_data` c
ON t.barcode = c.barcode AND t.test_id = c.test_id AND t.builder = c.builder
WHERE c.cycle_id = 1
ORDER BY t.barcode ASC