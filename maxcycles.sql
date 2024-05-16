CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `ecalandrini`@`%` 
    SQL SECURITY DEFINER
VIEW `dev-db`.`max_cycles` AS
	SELECT barcode, test_id, Remark, cycle_id AS max_cycle
	FROM `dev-db`.`cycle_data`
	WHERE (barcode, cycle_id) IN (
		SELECT barcode, MAX(cycle_id) AS max_cycle_id
		FROM `dev-db`.`cycle_data`
		GROUP BY barcode
	)
	ORDER BY max_cycle DESC;
	
CREATE OR REPLACE VIEW `dev-db`.max_cycles AS
SELECT  t1.*, 
		t2.total_specific_discharge_energy, 
		t2.total_specific_discharge_energy/t1.max_cycle AS specific_discharge_energy_avg 
FROM (
	SELECT DISTINCT
        `dev-db`.`cycle_data`.`barcode` AS `barcode`,
        `dev-db`.`cycle_data`.`test_id` AS `test_id`,
        `dev-db`.`cycle_data`.`Remark` AS `Remark`,
        `dev-db`.`cycle_data`.`cycle_id` AS `max_cycle`
    FROM
        `dev-db`.`cycle_data`
    WHERE
        (`dev-db`.`cycle_data`.`barcode` , `dev-db`.`cycle_data`.`cycle_id`) IN (
			SELECT 
                `dev-db`.`cycle_data`.`barcode`,
                 MAX(`dev-db`.`cycle_data`.`cycle_id`) AS `max_cycle_id`
            FROM
                `dev-db`.`cycle_data`
            GROUP BY `dev-db`.`cycle_data`.`barcode`)
    ORDER BY `dev-db`.`cycle_data`.`cycle_id` DESC) t1
JOIN (
    SELECT 
		barcode, 
		SUM(specific_discharge_energy) AS total_specific_discharge_energy
	FROM 
		`dev-db`.`cycle_data`
	GROUP BY barcode) t2
ON t1.barcode = t2.barcode