$PBExportHeader$uodw_organigramma.sru
forward
global type uodw_organigramma from datawindow
end type
end forward

global type uodw_organigramma from datawindow
integer width = 2629
integer height = 616
string title = "none"
string dataobject = "dw_organigramma"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global uodw_organigramma uodw_organigramma

type variables
s_struttura is_struttura_s[]
end variables

forward prototypes
public function integer uof_populate (integer ai_livello, string as_nodo)
end prototypes

public function integer uof_populate (integer ai_livello, string as_nodo);boolean lb_1, lb_2, lb_3
long ll_newrow
string ls_nodo

//
//li_length=  len(is_struttura_s.vc_nodo)
//
//if is_struttura_s.livello < gi_maxlivello  then
//	
	declare livello1_cur cursor for
	
	select struttura.livello, vc_nodo, relazione, vc_parent, codice, struttura_livelli.descrizione, struttura.descrizione //, struttura.cod_dip
	from struttura, struttura_livelli
	where	struttura.livello= :ai_livello and vc_nodo = :as_nodo and
				struttura.livello= struttura_livelli.livello;
	if trap_sql(sqlca, "LIV1") < 0 then return -1
	
	open livello1_cur;
	if trap_sql(sqlca, "LIV1.1") < 0 then return -1	
	
		declare livello2_cur cursor for
		
		select struttura.livello, vc_nodo, relazione, vc_parent, codice, struttura_livelli.descrizione, struttura.descrizione //, struttura.cod_dip
		from struttura, struttura_livelli
		where	struttura.livello= :is_struttura_s[1].livello + 1 and vc_parent = :is_struttura_s[1].vc_nodo and
					struttura.livello= struttura_livelli.livello;
		if trap_sql(sqlca, "LIV2") < 0 then return -1
		
		open livello2_cur;
		if trap_sql(sqlca, "LIV2.1") < 0 then return -1	
		
			declare livello3_cur cursor for
			
			select struttura.livello, vc_nodo, relazione, vc_parent, codice, struttura_livelli.descrizione, struttura.descrizione //, struttura.cod_dip
			from struttura, struttura_livelli
			where	struttura.livello= :is_struttura_s[2].livello + 1 and vc_parent = :is_struttura_s[2].vc_nodo and
						struttura.livello= struttura_livelli.livello;
			if trap_sql(sqlca, "LIV3") < 0 then return -1
			
			open livello3_cur;
			if trap_sql(sqlca, "LIV3.1") < 0 then return -1	
	
				do while lb_1= false
				
					fetch livello1_cur into
					:is_struttura_s[1].livello,
					:is_struttura_s[1].vc_nodo,
					:is_struttura_s[1].relazione,
					:is_struttura_s[1].vc_parent,
					:is_struttura_s[1].codice,
					:is_struttura_s[1].descrizione_livello,
					:is_struttura_s[1].descrizione_struttura,
					:is_struttura_s[1].cod_dip;
					if trap_sql(sqlca, "LIV1.3") < 0 then return -1
					
					if sqlca.sqlcode= 100 then lb_1= true
					
						do while lb_2= false
					
							fetch livello2_cur into
							:is_struttura_s[2].livello,
							:is_struttura_s[2].vc_nodo,
							:is_struttura_s[2].relazione,
							:is_struttura_s[2].vc_parent,
							:is_struttura_s[2].codice,
							:is_struttura_s[2].descrizione_livello,
							:is_struttura_s[2].descrizione_struttura,
							:is_struttura_s[2].cod_dip;
							if trap_sql(sqlca, "LIV2.3") < 0 then return -1
							
							if sqlca.sqlcode= 100 then lb_2= true
						
							do while lb_3= false
				
								fetch livello3_cur into
								:is_struttura_s[3].livello,
								:is_struttura_s[3].vc_nodo,
								:is_struttura_s[3].relazione,
								:is_struttura_s[3].vc_parent,
								:is_struttura_s[3].codice,
								:is_struttura_s[3].descrizione_livello,
								:is_struttura_s[3].descrizione_struttura,
								:is_struttura_s[3].cod_dip;
								if trap_sql(sqlca, "LIV3.2") < 0 then return -1
								
								if sqlca.sqlcode= 100 then lb_3= true
								
								ll_newrow= this.insertRow(0)
								this.setItem(ll_newrow, "livello1", is_struttura_s[1].vc_nodo)
								this.setItem(ll_newrow, "livello2", is_struttura_s[2].vc_nodo)
								this.setItem(ll_newrow, "livello3", is_struttura_s[3].vc_nodo)
				
							loop
				
						loop
				
					loop
	
	
	
//	
//	select struttura.livello, vc_nodo, relazione, vc_parent, codice, struttura_livelli.descrizione, struttura.descrizione //, struttura.cod_dip
//	from struttura, struttura_livelli
//	where	struttura.livello= :is_struttura_s.livello+1 and vc_parent = :is_struttura_s.vc_nodo and
//				struttura.livello= struttura_livelli.livello and vc_nodo like :gs_ambito+'%';
//	if trap_sql(sqlca, "LIV0") < 0 then return -1
//	
//	open child_cur;
//	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
//	
//	do while sqlca.sqlcode <> 100
//		
//		fetch child_cur into
//		:is_struttura_s.livello,
//		:is_struttura_s.vc_nodo,
//		:is_struttura_s.relazione,
//		:is_struttura_s.vc_parent,
//		:is_struttura_s.codice,
//		:is_struttura_s.descrizione_livello,
//		:is_struttura_s.descrizione_struttura,
//		:is_struttura_s.cod_dip;
//		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
//		
//		if sqlca.sqlcode= 100 then continue
//		
//		if ll_tvi.expandedonce= false then

return 0
end function

on uodw_organigramma.create
end on

on uodw_organigramma.destroy
end on

