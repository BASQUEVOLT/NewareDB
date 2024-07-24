CREATE VIEW `testlab-db`.log2 AS
SELECT
	CONVERT(l.test_id, UNSIGNED) AS test_id, 
	CONVERT(seq_id, UNSIGNED) AS seq_id,
	LEFT(computer_name, 20) AS computer_name,
	LEFT(l.chl_id, 20) AS chl_id, 
	LEFT(i.barcode_corrected, 60) AS barcode, 
	LEFT(log_time, 25) AS log_time, 
	LEFT(log_code, 25) AS log_code,
	LEFT(log_level, 5) AS log_level,
	LEFT(log_event, 200) AS log_event,
	LEFT(upload_time, 25) AS upload_time
FROM `testlab-db`.log l
JOIN `testlab-db`.ids i ON i.barcode = l.barcode AND i.test_id = l.test_id