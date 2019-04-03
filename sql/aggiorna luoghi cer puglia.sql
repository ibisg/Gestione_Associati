/*update ga..membri_gerarchica m1, seg2ga..membri_gerarchica m2
set m1.luogo_cer= m2.luogo_cer*/

select m1.vc_parent, m1.luogo_cer, m2.luogo_cer
from ga..membri_gerarchica m1, seg2ga..membri_gerarchica m2
where m1.codice=  m2.codice
and m1.luogo_cer <> m2.luogo_cer
and m1.vc_parent like "IT.SUD.S4%";