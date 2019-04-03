$PBExportHeader$w_preview_completa.srw
forward
global type w_preview_completa from w_preview_report
end type
end forward

global type w_preview_completa from w_preview_report
end type
global w_preview_completa w_preview_completa

event ue_postopen;call super::ue_postopen;long ll_idx
string ls_nodo, ls_nodo_prec, ls_descrizione, ls_totale

setPointer(hourGlass!)

uodw_current.setRedraw(false)

for ll_idx= 1 to uodw_current.rowCount()
	
	ls_nodo= uodw_current.getItemString(ll_idx, "vc_parent")
	
	if ls_nodo = ls_nodo_prec then goto scrivi
	
	ls_descrizione= f_descrizione_struttura_estesa(ls_nodo)
	
	select struttura_livelli.descrizione+" "+struttura.descrizione+": "
	into :ls_totale
	from struttura_livelli, struttura
	where struttura.vc_nodo= :is_preview_s.criterio and
				struttura_livelli.livello= struttura.livello;
	if trap_sql(sqlca, "POSTOPEN01") < 0 then return -1			
	
	scrivi: 
		uodw_current.setItem(ll_idx, "struttura_completa", ls_descrizione)
		uodw_current.setItem(ll_idx, "summary", ls_totale)
		
		ls_nodo_prec= ls_nodo
	
next

uodw_current.setRedraw(true)

return 0
	
end event

on w_preview_completa.create
call super::create
end on

on w_preview_completa.destroy
call super::destroy
end on

type uodw_current from w_preview_report`uodw_current within w_preview_completa
end type

