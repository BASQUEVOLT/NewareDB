DELIMITER //

CREATE TRIGGER `testlab-db`.log_trigger 
AFTER INSERT ON `testlab-db`.log
FOR EACH ROW
BEGIN   
    INSERT INTO `testlab-db`.log_casted (
		test_id, 
        seq_id,
        computer_name,
        chl_id,
        log_time,
        barcode,
        log_code,
        log_level,
        log_event,
        upload_time
        ) 
	SELECT
		CONVERT(l.test_id, UNSIGNED) AS test_id, 
		CONVERT(seq_id, UNSIGNED) AS seq_id,
		LEFT(computer_name, 20) AS computer_name,
		LEFT(l.chl_id, 20) AS chl_id, 
		LEFT(i.barcode_corrected, 60) AS barcode, 
		UNIX_TIMESTAMP(log_time) AS log_time, 
		CONV(SUBSTRING(log_code, 3), 16,10) AS log_code,
		LEFT(log_level, 5) AS log_level,
		LEFT(log_event, 200) AS log_event,
		UNIX_TIMESTAMP(upload_time) AS upload_time
	FROM `testlab-db`.log l
	JOIN `testlab-db`.ids i 
    ON 
		i.barcode = LEFT(l.barcode, 60) AND
        i.test_id = CONVERT(l.test_id, UNSIGNED);
END;
//

DELIMITER ;
