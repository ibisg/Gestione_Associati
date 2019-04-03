drop table storico_goh;
CREATE TABLE dbo.storico_goh (codice varchar(30) NOT NULL, tipo_goh char(30) NOT NULL, data datetime NOT NULL, cod_causale char(3) NOT NULL, note varchar(120) NULL) ;

insert into storico_goh
select codice, tipo_goh, data, cod_causale, note from storico_goh_bis;