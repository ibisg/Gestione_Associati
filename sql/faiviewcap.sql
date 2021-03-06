  SELECT comune.id,   
			0,
         comune.denominazionestd, 
         comune.multicap,   
         comune.cap,
	    comune.codistat,
	    provincia.sigla,
	    regione.denominazione  
    FROM comune, provincia, regione where  comune.idprovincia= provincia.id and provincia.idregione= regione.id
   UNION   
  SELECT frazione.idcomune,
		frazione.id,   
		frazione.denominazionestd+' - Frazione di '+comune.denominazionestd,
         'X',   
         frazione.cap,
	    frazione.codistat,
	    provincia.sigla,
	    regione.denominazione    
    FROM frazione, comune, provincia, regione
where frazione.idcomune=comune.id  and frazione.idcomune= comune.id and comune.idprovincia= provincia.id and provincia.idregione= regione.id;

