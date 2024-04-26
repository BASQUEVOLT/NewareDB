#this script calculate the Coulombic Efficiency (CE), Round Trip Efficiency (RTE) and State of Healt (SOH) vs cycle number,
#for the cell specified in the @cell_barcode and use as a reference cycle the cycle the defined in the row 13 of the script.
#NB offset X means row X+1!

SET @cell_barcode = '%BQV%064%';
SELECT DISTINCT test_id FROM `testlab-db`.schedule WHERE barcode LIKE @cell_barcode AND Builder in ('CY', 'FMCY') INTO @testid;
select @testid;

SELECT DISTINCT Builder, test_id FROM `testlab-db`.schedule WHERE barcode LIKE @cell_barcode;

SELECT @cell_barcode, @testid;

SELECT specific_discharge_capacity
FROM `testlab-db`.cycle
WHERE barcode LIKE @cell_barcode AND test_id LIKE @testid
ORDER BY CAST(cycle_id as UNSIGNED) ASC
LIMIT 1 OFFSET 4
INTO @specific_dchg_capa_cycle5;

select cycle_id, 
	100*convert(replace(specific_discharge_capacity, ',', '.'), DOUBLE) / convert(replace(specific_charge_capacity, ',', '.'), DOUBLE) as CE,
    100*convert(replace(specific_discharge_energy, ',', '.'), DOUBLE) / convert(replace(specific_charge_energy, ',', '.'), DOUBLE) as RTE,
    100*convert(replace(specific_discharge_capacity, ',', '.'), DOUBLE) / convert(replace(@specific_dchg_capa_cycle5, ',', '.'), DOUBLE) as SOH
FROM `testlab-db`.cycle WHERE barcode LIKE @cell_barcode AND test_id LIKE @testid;