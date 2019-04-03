/*ALTER TABLE [membri_gerarchica] DROP CONSTRAINT [FK_membri_gerarchica_struttura];*/

/* update struttura set livello= livello+1 where livello >= 2; */

/* insert into struttura (livello, codice, vc_nodo, vc_parent, relazione, descrizione) values(2, 0, 'IT.0' ,  'IT', 'G',  'RESTO D''ITALIA'); */

/*update struttura
set vc_parent= substring(vc_parent, 1, 3) + '0.' + substring(vc_parent, 4, len(vc_parent) ),
vc_nodo= substring(vc_nodo, 1, 3) + '0.' + substring(vc_nodo, 4, len(vc_nodo) )
where livello > 2; */

/* update membri_gerarchica
set vc_parent= substring(vc_parent, 1, 3) + '0.' + substring(vc_parent, 4, len(vc_parent) ); */

ALTER TABLE membri_gerarchica WITH NOCHECK ADD  CONSTRAINT [FK_membri_gerarchica_struttura] FOREIGN KEY([vc_parent])
REFERENCES [struttura] ([vc_nodo]);
ALTER TABLE [membri_gerarchica] CHECK CONSTRAINT [FK_membri_gerarchica_struttura];




 


