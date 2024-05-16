SELECT DISTINCT tt2.barcode, tt2.chl_id, tt2.max_cycle_id, tt2.soh, tt2.ce, tt2.rte FROM (
SELECT 
    c1.chl_id,
    c1.barcode,
    convert(c1.cycle_id, unsigned) AS max_cycle_id,
    100*convert(replace(c1.specific_discharge_capacity, ',', '.'), double) / convert(replace(c1.specific_charge_capacity, ',', '.'), double) AS ce,
    100*convert(replace(c1.specific_discharge_energy, ',', '.'), double) / convert(replace(c1.specific_charge_energy, ',', '.'), double) AS rte,
    100*convert(replace(c1.specific_discharge_capacity, ',', '.'), double) / c2.specific_discharge_capacity AS soh
FROM 
    `testlab-db`.`cycle` AS c1
JOIN (
    SELECT 
        barcode,
        MAX(convert(cycle_id, unsigned)) AS max_cycle_id
    FROM 
        `testlab-db`.`cycle`
    GROUP BY 
        barcode
) AS c2_max ON c1.barcode = c2_max.barcode AND c1.cycle_id = c2_max.max_cycle_id
JOIN (
    SELECT 
        barcode,
        convert(replace(specific_discharge_capacity, ',', '.'), double) as specific_discharge_capacity
    FROM 
        `testlab-db`.`cycle`
    WHERE 
        convert(cycle_id, unsigned) = 4
) AS c2 ON c1.barcode = c2.barcode) tt2
JOIN 
(SELECT packBarCode AS barcode
FROM 
    `testlab-db`.channel_status
WHERE 
    btsSysState LIKE 'running' and (packBarCode LIKE '%BQV%' or packBarCode LIKE '%CIC%' or packBarCode LIKE '%RDCC%')) tt
ON tt.barcode = tt2.barcode
ORDER BY tt2.max_cycle_id DESC;

SELECT packBarCode AS barcode
FROM 
    `testlab-db`.channel_status
WHERE 
    btsSysState LIKE 'running' and (packBarCode LIKE '%BQV%' or packBarCode LIKE '%CIC%' or packBarCode LIKE '%RDCC%')
