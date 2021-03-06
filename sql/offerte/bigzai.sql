select distinct 
( select descrizione
from struttura
where livello= 3
and vc_nodo= substring(membri_gerarchica.vc_parent, 1, len(vc_nodo) ) ) Regione,
( select descrizione
from struttura
where livello= 4
and vc_nodo= substring(membri_gerarchica.vc_parent, 1, len(vc_nodo) ) ) Territorio,
membri_gerarchica.vc_parent, 
cod_dis, membri_gerarchica.codice, cognome, nome, ind_dom, sum(importo) totale,
(select riferimento_descr from riferimenti where codice= membri_gerarchica.codice and cod_rif ="TF" and predefinito= 1) TF,
			(select riferimento_descr from riferimenti where codice= membri_gerarchica.codice and cod_rif ="TM" and predefinito= 1) TM
from offerte, membri_gerarchica, struttura
where datepart(year, data)=2008 and
		offerte.codice= membri_gerarchica.codice and
		struttura.vc_nodo= membri_gerarchica.vc_parent
group by  membri_gerarchica.vc_parent, cod_dis, membri_gerarchica.codice, cognome, nome, ind_dom
having sum(importo) >= 500
order by totale DESC;