delete from riferimenti;

insert into riferimenti
select
convert(varchar(20), codice_membro)+cod_dip,
"TF",
num_tel,
"1",
"",
"N"
from membri_copy
where num_tel is not null and num_tel != "";

insert into riferimenti
select 
convert(varchar(20), codice_membro)+cod_dip,
"TM",
num_tel_2,
"1",
"",
"N"
from membri_copy
where num_tel_2 is not null and num_tel_2 != "";

insert into riferimenti
select 
convert(varchar(20), codice_membro)+cod_dip,
"MA",
e_mail,
"1",
"",
"N"
from membri_copy
where e_mail is not null and e_mail != "";
