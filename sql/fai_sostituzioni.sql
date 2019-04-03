drop table sostituzioni;
CREATE TABLE dbo.sostituzioni 
(codice varchar(30) NOT NULL, 
id decimal(18,0) NOT NULL,
cod_causale char(3) NOT NULL, 
tipo_goh char(30) NOT NULL, 
flag_part char(1) NULL, 
note varchar(120) NULL) ;
