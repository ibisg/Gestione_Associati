select distinct livelli_struttura.descrizione, membri_gerarchica.flag_dis status,sum ( offerte_gerarchica.importo ) importo,offerte_gerarchica.importo*0,
count ( distinct membri_gerarchica.codice ) n_soci, struttura5.descrizione descrizione_struttura
 from membri_gerarchica,  
offerte_gerarchica,  livelli_struttura, struttura struttura5, struttura struttura6, struttura struttura7 
where membri_gerarchica.cod_dis != 'DEC' and livelli_struttura.livello=5 and membri_gerarchica.codice *= offerte_gerarchica.codice 
and membri_gerarchica.data_cer <= convert(datetime, '25.08.05 23:59:59', 3) 
and offerte_gerarchica.data between convert(datetime, '01.01.05 00:00:00', 3) AND convert(datetime, '25.08.05 23:59:59', 3) 
and membri_gerarchica.livello = struttura7.livello and membri_gerarchica.id_nodo = struttura7.id_nodo 
and struttura3.livello=3 and struttura4.livello=4 and struttura5.livello=5 and struttura6.livello=6 and struttura7.livello=7 
and struttura3.id_nodo= struttura4.id_parent and struttura4.id_nodo= struttura5.id_parent and struttura5.id_nodo= struttura6.id_parent 
and struttura6.id_nodo= struttura7.id_parent and struttura3.id_nodo=7 
group by livelli_struttura.descrizione, membri_gerarchica.flag_dis, offerte_gerarchica.importo*0, struttura5.descrizione;