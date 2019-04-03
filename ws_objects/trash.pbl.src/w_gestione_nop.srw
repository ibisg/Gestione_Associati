$PBExportHeader$w_gestione_nop.srw
forward
global type w_gestione_nop from w_generica_sheet
end type
end forward

global type w_gestione_nop from w_generica_sheet
integer width = 4818
end type
global w_gestione_nop w_gestione_nop

type variables
m_preview_nop im_preview_nop
end variables
on w_gestione_nop.create
call super::create
end on

on w_gestione_nop.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;im_preview_nop= create m_preview_nop
end event

type uodw_current from w_generica_sheet`uodw_current within w_gestione_nop
integer y = 60
string dataobject = "dw_gestione_nop"
boolean ib_allowrowselection = true
end type

event uodw_current::doubleclicked;call super::doubleclicked;//integer li_count, li_ret
//string ls_nodo, ls_codice, ls_id
//
//ls_nodo= this.getItemString(row, "vc_parent")
//
//select count(*)
//into :li_count
//from struttura
//where
//vc_nodo= :ls_nodo;
//
//if trap_sql(sqlca, "VCNODO01") < 0 then return -1
//
//if li_count= 0 or isNull(li_count) then
//	
//	// non esiste il gruppo...
//	
//	messageBox( parent.title, ls_nodo+" è inesistente, deve essere ridefinita la struttura di appartenenza.", information!)
//	
//	s_struttura s_struttura_s
//
//	is_assegnastruttura_s.as_struttura_s.livello= gi_maxlivello // is_assegnastruttura_s.ai_maxlivello
//	is_assegnastruttura_s.ab_abilitaincolla= false
//	is_assegnastruttura_s.ai_maxlivello= gi_maxlivello // is_assegnastruttura_s.ai_maxlivello
//	is_assegnastruttura_s.ai_ultimolivelloparent= gi_maxlivello // is_assegnastruttura_s.ai_ultimolivelloparent
//	is_assegnastruttura_s.as_ambito= gs_ambito // is_assegnastruttura_s.as_ambito
//
//	is_assegnastruttura_s.ab_abilitaincolla= false
//	
//	s_struttura_s= this.uof_struttura(is_assegnastruttura_s)
//	
//	if s_struttura_s.livello= -1 then return -1
//	
//	this.setItem(row, "vc_parent", s_struttura_s.vc_nodo) 
//	
//	if this.uof_aggiorna() < 0 then goto errore
//	
//end if
//
//	ls_id= this.getItemString(row, "nome")+" " +this.getItemString(row, "cognome")
//
//	if messageBox( parent.title, "I dati di "+ls_id+" verranno reinseriti nell'archivio degli associati.~nVuoi proseguire?", question!, yesNo!, 2)= 2 then return -1
//	
//	ls_codice= this.getItemString(row, "codice")
//	
//	insert into membri_gerarchica
//	select * from membri_dim where codice= :ls_codice;
//	
//	if trap_sql(sqlca, "REINSDIM01.1") < 0 then
//		li_ret= 1
//		goto errore
//	end if
//	
//	insert into esami_curr
//	SELECT 
//			codice,   
//			cod_studio,   
//			data_esame,   
//			esito,   
//			voto,   
//			soglia,   
//			note  
//	FROM esami_curr_dim
//	where codice= :ls_codice;
//	
//	if trap_sql(sqlca, "INSDIM01.2") < 0 then 
//		li_ret= 1
//		goto errore 
//
//	end if
//	
//	insert into gohonzon_storico
//	select 
//		codice,   
//		tipo_goh,   
//		data,   
//		luogo,   
//		cod_causale,   
//		note  
//	from gohonzon_storico_dim
//	where codice= :ls_codice;
//	
//	if trap_sql(sqlca, "INSDIM01.3") < 0 then
//		li_ret= 1
//		goto errore
//	end if
//	
//	insert into riferimenti
//	select
//		codice,
//		cod_rif,
//		riferimento_descr,
//		predefinito,
//		note,
//		flag_riservato
//	from riferimenti_dim where codice= :ls_codice;
//	
//	if trap_sql(sqlca, "INSDIM01.4") < 0 then
//		li_ret= 1
//		goto errore
//	end if
//	
//	insert into storico_resp
//	select * from storico_resp_dim where codice= :ls_codice;
//	
//	if trap_sql(sqlca, "INSDIM01.5") < 0 then
//		li_ret= 1
//		goto errore
//	end if
//	
//	insert into offerte
//	select * from offerte_dim where codice= :ls_codice;
//	
//	if trap_sql(sqlca, "INSDIM01.6") < 0 then
//		li_ret= 1
//		goto errore
//	end if
//	
//	insert into zaimu
//	select * from zaimu_dim where codice= :ls_codice;
//	
//	if trap_sql(sqlca, "INSDIM01.7") < 0 then
//		li_ret= 1
//		goto errore
//	end if
//	
//	this.deleteRow(0)
//	
//	if this.uof_aggiorna() < 0 then goto errore
//	
//	return 0
//	
//	errore:
//	
//	if sqlca.sqlcode < 0 then
//		
//		rollback;
//		trap_sql(sqlca, "DELDIM03")
//		
//		return -1
//		
//	end if		
//
//
//
end event

event uodw_current::rbuttondown;if this.ib_queryMode= true then
	messageBox(parent.title, "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview_nop.iuodw_generica= this

im_preview_nop.m_aggiungi.visible= false
im_preview_nop.m_rimuovi.visible= false
im_preview_nop.m_salva.visible= false

im_preview_nop.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

