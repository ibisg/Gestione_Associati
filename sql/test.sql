SELECT vgruppi.codice , vgruppi.descrizione , vsettori.codice , vsettori.descrizione , 
 vcapitoli.codice , vcapitoli.descrizione , vcentri.codice , 
 vcentri.descrizione , vterritori.codice , vterritori.descrizione , 
 varee.codice , varee.descrizione , membri_gerarchica.codice_membro , 
 membri_gerarchica.cod_dip , membri_gerarchica.codice,
membri_gerarchica.cognome , 
 membri_gerarchica.nome , membri_gerarchica.citta_nas , 
 membri_gerarchica.prov_nas , membri_gerarchica.data_nas , 
membri_gerarchica.cod_nazione , membri_gerarchica.cod_div , 
 membri_gerarchica.ind_dom , membri_gerarchica.cap_dom , 
 membri_gerarchica.cod_com 
FROM membri_gerarchica , vgruppi , vsettori , vcapitoli , vcentri , vterritori , varee 
 WHERE 
( membri_gerarchica.livello = vgruppi.livello ) and 
 ( membri_gerarchica.id_nodo = vgruppi.id_nodo ) and 
 ( vgruppi.id_parent = vsettori.id_nodo ) and 
 ( vsettori.id_parent = vcapitoli.id_nodo ) and 
 ( vcapitoli.id_parent = vcentri.id_nodo ) and 
 ( vcentri.id_parent = vterritori.id_nodo ) and 
 ( vterritori.id_parent = varee.id_nodo )  and cognome like "%DE SIMONE";
 