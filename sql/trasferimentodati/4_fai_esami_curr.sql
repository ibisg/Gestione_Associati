truncate  table esami_curr;
insert into esami_curr
select rtrim(convert(varchar, codice_membro))+cod_dip, cod_studio, data_esame, esito, 0, 0 from curr_studio_copy;