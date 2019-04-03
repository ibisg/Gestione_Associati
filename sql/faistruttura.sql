drop table struttura;
CREATE TABLE
dbo.struttura (
livello int NOT NULL, 
id_nodo int NOT NULL, 
id_parent int NOT NULL, 
relazione char(1) NOT NULL, 
codice varchar(10) NOT NULL, 
vc_parent varchar(60) NOT NULL,
vc_nodo varchar(60) NOT NULL,
descrizione varchar(60) NOT NULL ,
CONSTRAINT xpk_struttura PRIMARY KEY (id_nodo)
CONSTRAINT xuk_struttura (id_parent)
CONSTRAINT xdk_struttura (vc_nodo)
CONSTRAINT xdk_struttura (vc_parent)) 

alter table dbo.membri_gerarchica add constraint xpk_codice primary key nonclustered (codice) ;
create clustered index xdk_cognome on dbo.membri_gerarchica (cognome ) ;
create clustered index xdk_nodo on dbo.membri_gerarchica (id_parent ) ;
create clustered index xdk_vc_parent on dbo.membri_gerarchica (vc_parent ) ;
