truncate table offerte;
truncate table zaimu;

insert into offerte
select num, 
convert(varchar, codice_membro)+cod_dip,
data, 
data_ec, 
importo, 
modalita_vers 
from offerte_copy
where 
convert(varchar, codice_membro)+cod_dip 
in 
(select 
convert(varchar, codice_membro)+cod_dip 
from membri_copy);

truncate table zaimu

insert into zaimu
select num, 
convert(varchar, codice_membro)+cod_dip,
importo_lire,
data, 
data_ec, 
importo
from zaimu_copy
where 
convert(varchar, codice_membro)+cod_dip 
in 
(select 
convert(varchar, codice_membro)+cod_dip 
from membri_copy);


