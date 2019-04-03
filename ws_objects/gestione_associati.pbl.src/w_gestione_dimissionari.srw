$PBExportHeader$w_gestione_dimissionari.srw
forward
global type w_gestione_dimissionari from w_generica_sheet
end type
end forward

global type w_gestione_dimissionari from w_generica_sheet
integer width = 4818
end type
global w_gestione_dimissionari w_gestione_dimissionari

type variables
m_preview_dimissionari im_preview_dimissionari
end variables

on w_gestione_dimissionari.create
call super::create
end on

on w_gestione_dimissionari.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;im_preview_dimissionari= create m_preview_dimissionari
end event

type uodw_current from w_generica_sheet`uodw_current within w_gestione_dimissionari
string dataobject = "dw_gestione_dimissionari"
boolean ib_dbcancel = true
boolean ib_allowrowselection = true
end type

event uodw_current::rbuttondown;if this.ib_queryMode= true then
	messageBox(parent.title, "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview_dimissionari.iuodw_generica= this

im_preview_dimissionari.m_aggiungi.visible= false
im_preview_dimissionari.m_rimuovi.visible= false
im_preview_dimissionari.m_salva.visible= false

im_preview_dimissionari.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

event uodw_current::itemchanged;call super::itemchanged;if dwo.name= 'cod_dis' then
	
	s_session ls_session_s
	string ls_message

	ls_session_s.context= "Gestione dimissionati e non praticanti"
	ls_session_s.causale= "STATUS"
	ls_session_s.status_src= this.getItemString(row, "cod_dis")
	ls_session_s.status_tgt= data
	ls_session_s.codice=  this.getItemString(row, "codice")

	ls_message= "Modificato lo status da "+ls_session_s.status_src+" a: "+ls_session_s.status_tgt
	
	ls_session_s.tipo_variazione_src= "DA-"+	ls_session_s.status_src
	ls_session_s.tipo_variazione_tgt= "A-"+ls_session_s.status_tgt
	
	f_log(ls_session_s, ls_message, false)
	
	update membri_dim
	set d_ult_mod= getdate()
	where codice= :ls_session_s.codice;
	
	if trap_sql(sqlca, "ITEMCHANGED_DIM01") < 0 then return -1

end if
end event

