drop table sostituzioni;
CREATE TABLE dbo.sostituzioni (
codice varchar(30) NOT NULL, 
data datetime NOT NULL, 
citta char(30) NOT NULL, 
turno char(2) NOT NULL, 
cod_causale char(3) NOT NULL,
tipo_goh char(30) NOT NULL, 
flag_part char(1) NULL, 
note varchar(120) NULL) ;
