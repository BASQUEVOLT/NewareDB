CREATE OR REPLACE VIEW `dev-db`.dchg_record15s AS 
SELECT * 
FROM (
SELECT CONVERT(test_id, UNSIGNED) AS test_id, 
	barcode, 
    CONVERT(cycle_id, UNSIGNED) AS cycle_id,
    CONVERT(step_id, UNSIGNED) AS step_id, step_type, 
    CONVERT(REPLACE(record_time, ',', '.'), DOUBLE) AS record_time, 
    CONVERT(record_id, UNSIGNED) AS record_id, CONVERT(REPLACE(current, ',', '.'), DOUBLE) AS current, 
    CONVERT(REPLACE(voltage, ',', '.'), DOUBLE) AS voltage,
    CONVERT(REPLACE(capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(active_material, ',', '.'), DOUBLE) AS specific_discharge_capacity 
FROM `testlab-db`.record
) AS X
WHERE X.record_time < 15 AND X.step_type LIKE 'cc_dchg';

CREATE OR REPLACE VIEW `dev-db`.chg_record15s AS 
SELECT * 
FROM (
SELECT CONVERT(test_id, UNSIGNED) AS test_id, 
	barcode, 
    CONVERT(cycle_id, UNSIGNED) AS cycle_id,
    CONVERT(step_id, UNSIGNED) AS step_id, 
    step_type, 
    CONVERT(REPLACE(record_time, ',', '.'), DOUBLE) AS record_time, 
    CONVERT(record_id, UNSIGNED) AS record_id, 
    CONVERT(REPLACE(current, ',', '.'), DOUBLE) AS current, 
    CONVERT(REPLACE(voltage, ',', '.'), DOUBLE) AS voltage, 
    CONVERT(REPLACE(capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(active_material, ',', '.'), DOUBLE) AS specific_charge_capacity 
FROM `testlab-db`.record
) AS X
where X.record_time < 15 AND X.step_type like 'cc_chg';

CREATE OR REPLACE VIEW `dev-db`.record60s AS 
SELECT * 
FROM (
SELECT CONVERT(test_id, UNSIGNED) AS test_id, 
	barcode, 
    CONVERT(cycle_id, UNSIGNED) AS cycle_id,
    CONVERT(step_id, UNSIGNED) AS step_id, step_type, 
    CONVERT(REPLACE(record_time, ',', '.'), DOUBLE) AS record_time, 
	abs_time, 
    TotalTime,
    CONVERT(record_id, UNSIGNED) AS record_id, CONVERT(REPLACE(current, ',', '.'), DOUBLE) AS current, 
    CONVERT(REPLACE(voltage, ',', '.'), DOUBLE) AS voltage,
    CONVERT(REPLACE(capacity, ',', '.'), DOUBLE)/CONVERT(REPLACE(active_material, ',', '.'), DOUBLE) AS specific_capacity
FROM `testlab-db`.record
) AS X
WHERE X.record_time MOD 60 = 0;