select * from struttura s
where livello= 7 and
(select count(*) from membri_gerarchica m where (m.cod_att_ist_1= '101' OR m.cod_att_ist_2= '101') and m.vc_parent= s.vc_nodo)=0;