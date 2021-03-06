  SELECT 
comune.codistat,
comune.denominazionestd,
provincia.sigla,
regione.denominazione,
comune.cap      
    FROM comune, provincia, regione where  comune.idprovincia= provincia.id and provincia.idregione= regione.id
   UNION   
  SELECT 
frazione.codistat,
frazione.denominazionestd+' - Frazione di '+comune.denominazionestd,
provincia.sigla,
regione.denominazione,  
frazione.cap
    FROM frazione, comune, provincia, regione
where frazione.codistat <> '' and
frazione.idcomune=comune.id  and frazione.idcomune= comune.id and comune.idprovincia= provincia.id and provincia.idregione= regione.id;

