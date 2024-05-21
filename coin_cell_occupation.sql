SELECT operator, count(*) AS frequency FROM `lab-db`.coincell_parameters cc
join `testlab-db`.`channel_status` cs
on cs.packBarCode = cc.Database_name
where cs.btsSysState = 'running'
group by operator