select distinct 
(select l1.descrizione from livelli_struttura l1 where l1.livello= 2) livello,
(select s1.descrizione from struttura s1 where s1.vc_nodo= 'IT.S1') descrizione_livello,
livelli_struttura.descrizione livello_raggruppamento, 
struttura.descrizione descrizione_raggruppamento,
membri_gerarchica.flag_dis status,
sum ( offerte_gerarchica.importo ) importo,
offerte_gerarchica.importo*0,
count ( distinct membri_gerarchica.codice ) n_soci

from membri_gerarchica,  offerte_gerarchica,  livelli_struttura, struttura
where 
membri_gerarchica.cod_dis != 'DEC' 
and membri_gerarchica.codice *= offerte_gerarchica.codice 
and membri_gerarchica.data_cer <= convert(datetime, '25.08.05 23:59:59', 3) 
and offerte_gerarchica.data between convert(datetime, '01.01.05 00:00:00', 3) AND convert(datetime, '25.08.05 23:59:59', 3) 
and substring(membri_gerarchica.vc_parent, 1, 11) = substring(struttura.vc_nodo, 1, 11)
and struttura.livello= 5
and livelli_struttura.livello=5

group by
livelli_struttura.descrizione, 
struttura.descrizione ,
membri_gerarchica.flag_dis ,
offerte_gerarchica.importo*0;