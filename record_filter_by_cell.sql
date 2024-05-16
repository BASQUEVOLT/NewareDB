#filter by 1Ah BQV cells
CREATE OR REPLACE VIEW `dev-db`.dchg_record15s_bqv AS 
SELECT dr.* FROM `dev-db`.dchg_record15s dr
JOIN (SELECT * FROM `dev-db`.ids WHERE ID IN ('1003', '1003Old')) AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

CREATE OR REPLACE VIEW `dev-db`.chg_record15s_bqv AS 
SELECT dr.* FROM `dev-db`.chg_record15s dr 
JOIN (SELECT * FROM `dev-db`.ids WHERE ID IN ('1003', '1003Old')) AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

CREATE OR REPLACE VIEW `dev-db`.record60s_bqv AS 
SELECT dr.* FROM `dev-db`.record60s dr
JOIN (SELECT * FROM `dev-db`.ids WHERE ID IN ('1003', '1003Old')) AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

#filter by coin cells
CREATE OR REPLACE VIEW `dev-db`.dchg_record15s_coin AS 
SELECT dr.* FROM `dev-db`.dchg_record15s dr
JOIN (SELECT * FROM `dev-db`.ids WHERE ID LIKE 'Coin') AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

CREATE OR REPLACE VIEW `dev-db`.chg_record15s_coin AS 
SELECT dr.* FROM `dev-db`.chg_record15s dr
JOIN (SELECT * FROM `dev-db`.ids WHERE ID LIKE 'Coin') AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

CREATE OR REPLACE VIEW `dev-db`.record60s_coin AS 
SELECT dr.* FROM `dev-db`.record60s dr
JOIN (SELECT * FROM `dev-db`.ids WHERE ID LIKE 'Coin') AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

#filter by 1Ah CIC cells
CREATE OR REPLACE VIEW `dev-db`.dchg_record15s_cic AS 
SELECT dr.* FROM `dev-db`.dchg_record15s dr
JOIN (SELECT * FROM `dev-db`.ids WHERE ID LIKE '1003CIC') AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

CREATE OR REPLACE VIEW `dev-db`.chg_record15s_cic AS 
SELECT dr.* FROM `dev-db`.chg_record15s dr
JOIN (SELECT * FROM `dev-db`.ids WHERE ID LIKE '1003CIC') AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

CREATE OR REPLACE VIEW `dev-db`.record60s_cic AS 
SELECT dr.* FROM `dev-db`.record60s dr
JOIN (SELECT * FROM `dev-db`.ids WHERE ID LIKE '1003CIC') AS i
ON i.barcode = dr.barcode AND i.test_id = dr.test_id;

