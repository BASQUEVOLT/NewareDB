select distinct test_id, barcode, builder from `testlab-db`.`schedule` where builder like 'Rate%' and barcode like '%BQV%';

select * from `testlab-db`.`schedule` where barcode = '1003-BQV000000000000263-1' and test_id = '236';
select * from `testlab-db`.`step` where barcode = '1003-BQV000000000000263-1' and test_id = '2818599703';# and step_type = 'cc_dchg';

select 
	s.barcode, 
    s.test_id, 
    ss.builder,
    convert(s.step_id, unsigned) as step_id, 
    convert(s.step_num, unsigned) as step_num,
    convert(replace(s.step_time, ',', '.'), double) as step_time,
    convert(replace(ss.setting_current, ',', '.'), double) as setting_current,
    convert(replace(s.dchag_capacity, ',', '.'), double) as dchag_capacity, 
    s.end_temp 
from `testlab-db`.`step` s
join `testlab-db`.`schedule` ss
on s.barcode = ss.barcode and s.test_id = ss.test_id and s.step_id = ss.step_id
where s.barcode = '1003-BQV000000000000263-1' and s.test_id = '2818599703' and s.step_type = 'cc_dchg' and convert(s.step_num, unsigned) >= 12 and convert(s.step_num, unsigned) % 7 = (12 - 7);