truncate table gohonzon_storico;
insert into gohonzon_storico
select convert(varchar, codice_membro)+cod_dip, tipo_goh, data, "", cod_causale, note from storico_goh_copy;