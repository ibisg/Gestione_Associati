select *
from struttura
where livello= 3
and vc_nodo= substring('IT.CEN.C2.ES.AF.CDM.GDU.BAN', 1, len(vc_nodo) );
