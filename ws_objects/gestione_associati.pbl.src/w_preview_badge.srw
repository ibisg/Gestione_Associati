$PBExportHeader$w_preview_badge.srw
forward
global type w_preview_badge from w_preview
end type
end forward

global type w_preview_badge from w_preview
integer width = 4430
end type
global w_preview_badge w_preview_badge

type variables
long il_prima
end variables

on w_preview_badge.create
call super::create
end on

on w_preview_badge.destroy
call super::destroy
end on

event open;call super::open;destroy m_preview

im_preview= create m_preview_badge
end event

type uodw_current from w_preview`uodw_current within w_preview_badge
event type integer ue_stampa ( )
string dataobject = "dw_labels_membri"
boolean ib_readonly = true
end type

event type integer uodw_current::ue_stampa();long ll_etichette_a_vuoto, ll_to_delete, ll_idx

openWithParm(w_setup_labels, this)

ll_etichette_a_vuoto= message.doubleParm

uodw_current.setRedraw(false)

if il_prima= 0 then
	
	il_prima= ll_etichette_a_vuoto
	
	for ll_idx= 1 to il_prima
		
		uodw_current.insertRow(1)
		
	next
	
elseif il_prima < ll_etichette_a_vuoto then
	
	for ll_idx= il_prima + 1 to ll_etichette_a_vuoto
		
		uodw_current.insertRow(1)
		
	next
	
elseif il_prima > ll_etichette_a_vuoto then
	
	ll_to_delete= il_prima - ll_etichette_a_vuoto
	
	uodw_current.setRow(1)
	
	for ll_idx= 1 to ll_to_delete
		
		uodw_current.deleteRow(0)
		
	next
	
end if

uodw_current.setRedraw(true)

il_prima= ll_etichette_a_vuoto

return 0
end event

event uodw_current::rbuttondown;im_preview.iuodw_generica= uodw_current

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false
im_preview.m_inserisci.visible= false
im_preview.m_ordina.visible= false
im_preview.m_impostapagina.visible= false

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )



end event

