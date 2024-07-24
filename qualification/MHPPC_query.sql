select distinct barcode, builder, test_id from `testlab-db`.`schedule`
where builder like '%MHPPC%' and barcode not like 'trial %';

select * from `testlab-db`.`schedule`
where barcode = 'RDMLBV4NMC9XX23100022' and test_id = '2818599678';

select * from `testlab-db`.`step`
where barcode = 'RDMLBV4NMC9XX23100022' and test_id = '2818580506';

select 
	s.barcode, 
    r.cycle_id, 
    r.step_type, 
    s.end_voltage, 
    r.step_num, 
    r.step_id,
    r.record_time, 
    r.voltage, 
    r.current,
    (convert(replace(r.voltage, ',', '.'), double) - convert(replace(s.end_voltage, ',', '.'), double))/convert(replace(r.current, ',', '.'), double)*1000 AS DCIR
from `testlab-db`.`step` s
join `testlab-db`.`record` r
on s.barcode = r.barcode and s.test_id = r.test_id and s.step_num = r.step_num - 1
where r.barcode = '1003-BQV000000000000378-1' and r.test_id = '2818580472' and r.step_id >= 12 and r.step_id not in (30, 51) and r.step_type in ('cc_dchg', 'cc_chg') and r.record_time = 1;

