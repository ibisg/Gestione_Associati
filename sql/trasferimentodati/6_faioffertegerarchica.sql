truncate table offerte;
truncate table zaimu;
truncate table contributi_straordinari;

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

  INSERT INTO contributi_straordinari  
     SELECT contributi_straordinari_copy.num,   
            contributi_straordinari_copy.cognome,   
            contributi_straordinari_copy.nome,   
            contributi_straordinari_copy.data,   
            contributi_straordinari_copy.data_ec,   
            contributi_straordinari_copy.importo,   
            contributi_straordinari_copy.modalita_vers,   
            contributi_straordinari_copy.dip_op  
       FROM contributi_straordinari_copy  ;



