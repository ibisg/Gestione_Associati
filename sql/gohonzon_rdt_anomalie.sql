select m.codice, vc_parent, m.cognome, m.nome, g.cod_causale, g.tipo_goh, g.data from 
membri_gerarchica m, gohonzon_storico g
where
m.codice= g.codice and
g.cod_causale= 'RDT' and data= (select MAX(data) from gohonzon_storico g1 where g1.codice= m.codice);