#select step time
SELECT test_id, barcode, Remark, cycle_id, step_id, step_type, step_time FROM `testlab-db`.step
WHERE step_type IN ('cc_chg', 'cv_chg', 'cc_dchg');