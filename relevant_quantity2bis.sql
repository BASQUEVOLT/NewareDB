CREATE OR REPLACE VIEW `dev-db`.cycle_data AS
SELECT * FROM `dev-db`.cycle_data_view
WHERE my_soh > 79;