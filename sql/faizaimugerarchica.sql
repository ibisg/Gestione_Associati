truncate table zaimu_gerarchica;

insert into zaimu_gerarchica
select num, convert(varchar, codice_membro)+cod_dip,data, data_ec, importo, modalita_vers from zaimu_copy
where convert(varchar, codice_membro)+cod_dip in (select convert(varchar, codice_membro)+cod_dip from membri_copy);


