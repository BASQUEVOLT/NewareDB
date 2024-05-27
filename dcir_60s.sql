-- query to calculate the dcir 60s in discharge
CREATE OR REPLACE VIEW `dev-db`.dchg_dcir AS
SELECT 
	s.test_id,
	s.barcode, 
    r.cycle_id, 
	r.record_time,
    st.end_voltage AS rest_voltage, 
    r.voltage AS dchg_voltage, 
    r.current AS dchg_current,
    st.step_type AS step_step_type,
    r.step_type AS record_step_type,
    (convert(replace(r.voltage, ',', '.'), DOUBLE) - convert(replace(st.end_voltage, ',', '.'), DOUBLE))/convert(replace(r.current, ',', '.'), DOUBLE) AS DCIR_60s
FROM 
    `testlab-db`.schedule AS s
JOIN 
    `testlab-db`.step AS st ON s.barcode = st.barcode AND s.test_id = st.test_id AND s.step_id - 1 = st.step_id
JOIN 
    `testlab-db`.record AS r ON s.barcode = r.barcode AND s.test_id = r.test_id AND s.step_id = r.step_id AND r.cycle_id = st.cycle_id AND r.record_time = 60
WHERE 
    s.step_type = 'cc_dchg';# and s.barcode = '1003-BQV000000000000068-1' and s.test_id = '2818580519';


-- query to calculate the dcir 60s in charge
CREATE OR REPLACE VIEW `dev-db`.chg_dcir AS
SELECT 
	s.test_id,
	s.barcode, 
    convert(r.cycle_id, unsigned) AS record_cycle, 
    st.cycle_id AS step_cycle,
	r.record_time,
    st.end_voltage AS rest_voltage, 
    r.voltage AS dchg_voltage, 
    r.current AS dchg_current,
    st.step_type AS step_step_type,
    r.step_type AS record_step_type,
    (convert(replace(r.voltage, ',', '.'), DOUBLE) - convert(replace(st.end_voltage, ',', '.'), DOUBLE))/convert(replace(r.current, ',', '.'), DOUBLE) AS DCIR_60s
FROM 
    `testlab-db`.schedule AS s
JOIN 
    `testlab-db`.step AS st ON s.barcode = st.barcode AND s.test_id = st.test_id AND (s.step_id + 4 = st.step_id OR s.step_id - 2 = st.step_id)
JOIN 
    `testlab-db`.record AS r ON s.barcode = r.barcode AND s.test_id = r.test_id AND s.step_id = r.step_id AND r.cycle_id -1 = st.cycle_id AND r.record_time = 60
WHERE 
    s.step_type = 'cc_chg'# and s.barcode = '1003-BQV000000000000068-1' and s.test_id = '2818580519'
order by record_cycle asc;