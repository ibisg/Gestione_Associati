truncate table gohonzon_storico;
insert into gohonzon_storico
select rtrim(convert(varchar, codice_membro))+cod_dip, tipo_goh, data, "", cod_causale, rtrim(note) from storico_goh_copy;