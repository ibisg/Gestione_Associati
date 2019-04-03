delete from struttura_geo;

update regioni
set vc_nodo= rtrim(cod_nazione)+'.'+rtrim(cod_regione) , vc_parent= rtrim(cod_nazione);

update province
set vc_nodo= rtrim(cod_nazione)+'.'+rtrim(cod_regione)+'.'+rtrim(cod_provincia),
		vc_parent= rtrim(cod_nazione)+'.'+rtrim(cod_regione);

update localita
set vc_nodo=  rtrim(cod_nazione)+'.'+rtrim(cod_regione)+'.'+rtrim(cod_provincia)+'.'+rtrim(id),
		vc_aprent=  rtrim(cod_nazione)+'.'+rtrim(cod_regione)+'.'+rtrim(cod_provincia);

insert  struttura_geo (vc_nodo, vc_parent, livello, descrizione)
(select vc_nodo, vc_parent, 2, descrizione from regioni) ;

insert  struttura_geo (vc_nodo, vc_parent, livello, descrizione)
(select vc_nodo, vc_parent, 3, descrizione from province) ;

insert  struttura_geo (vc_nodo, vc_parent, livello, descrizione, dip_pt, alias, zone)
(select vc_nodo, vc_aprent, 4, localita, dip_pt, alias, zone from localita) ;



