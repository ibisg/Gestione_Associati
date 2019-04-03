create view vw_query as (select 
convert(varchar, membri.codice_membro)+membri.cod_dip Codice, 
membri.cognome Cognome, 
membri.nome Nome,
membri.ind_dom Domicilio,
membri.cap_dom Cap,
tab_comuni.comune Comune,
tab_comuni.provincia Provincia,
tab_comuni.regione Regione,
nazioni.descrizione Nazione,
membri.num_tel Telefono,
membri.num_tel_2 Cellulare,
divisione.descrizione Divisione,
liv_studio.descrizione Livello_Studio,
non_attivi.descrizione Stato,
att_ist.descrizione Responsabilità,
staff_e_resp.descrizione Staff
from membri, tab_comuni, nazioni, divisione, liv_studio, non_attivi, att_ist, staff_e_resp
where
membri.cod_com= tab_comuni.cod_com and 
membri.cod_nazione= nazioni.cod_nazione and
membri.cod_div= divisione.cod_div and
liv_studio.cod_studio= membri.cod_studio and
non_attivi.cod_dis= membri.cod_dis and
att_ist.cod_att_ist= membri.cod_att_ist_1 and
att_ist.cod_att_ist= membri.cod_att_ist_2 and
staff_e_resp.codice_staff= membri.codice_staff
);

