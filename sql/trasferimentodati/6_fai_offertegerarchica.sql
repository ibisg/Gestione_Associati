truncate table offerte;
truncate table zaimu;
truncate table contributi_straordinari;

insert into offerte
select 
num, 
rtrim(convert(varchar, codice_membro))+cod_dip,
data, 
data_ec, 
importo, 
modalita_vers,
dip_op
from offerte_copy
where 
rtrim(convert(varchar, codice_membro))+cod_dip 
in 
(select 
rtrim(convert(varchar, codice_membro))+cod_dip 
from membri_copy);

insert into zaimu
select num, 
rtrim(convert(varchar, codice_membro))+cod_dip,
importo_lire,
data, 
data_ec, 
importo
from zaimu_copy
where 
rtrim(convert(varchar, codice_membro))+cod_dip 
in 
(select 
rtrim(convert(varchar, codice_membro))+cod_dip 
from membri_copy);

  INSERT INTO contributi_straordinari  
     SELECT contributi_straordinari_copy.num,   
            rtrim(contributi_straordinari_copy.cognome),   
            rtrim(contributi_straordinari_copy.nome),   
            contributi_straordinari_copy.data,   
            contributi_straordinari_copy.data_ec,   
            contributi_straordinari_copy.importo,   
            contributi_straordinari_copy.modalita_vers,   
            contributi_straordinari_copy.dip_op  
       FROM contributi_straordinari_copy  ;


