select distinct test_id, builder from `testlab-db`.`schedule` where barcode = '1003-BQV000000000000362-1' and builder like 'CVPP%';
select distinct test_id, builder, barcode from `testlab-db`.`schedule` where builder like 'CVPP%';
select * from `testlab-db`.`schedule` where barcode = '1003-BQV000000000000362-1' and test_id = '2818580620';

select record_time, step_num, voltage, current, capacity, temperature from `testlab-db`.`record`
where barcode = '1003-BQV000000000000362-1' and test_id = '2818580482' and step_type = 'cv_dchg' ;

select barcode, builder, step_num, current, temperature from `testlab-db`.`record`
where 
	barcode = '1003-BQV000000000000362-1' and 
    #test_id = '2818580482' and 
    convert(replace(record_time, ',', '.'), double) = 15 and
    test_id IN (select distinct test_id from `testlab-db`.`schedule` where barcode = '1003-BQV000000000000362-1' and builder like 'CVPP%') and
    step_type = 'cv_dchg'