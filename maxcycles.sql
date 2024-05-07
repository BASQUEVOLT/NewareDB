#CREATE TABLE `dev-db`.max_cycles AS
CREATE VIEW `dev-db`.max_cycles AS
SELECT 
	barcode,
    test_id,
    MAX(CAST(cycle_id AS UNSIGNED)) AS max_cycle
FROM
    `dev-db`.cycle_data 
    GROUP BY barcode, test_id 
	ORDER BY max_cycle DESC