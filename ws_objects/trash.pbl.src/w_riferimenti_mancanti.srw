$PBExportHeader$w_riferimenti_mancanti.srw
forward
global type w_riferimenti_mancanti from window
end type
type uodw_current from uodw_generica within w_riferimenti_mancanti
end type
type cb_annulla from commandbutton within w_riferimenti_mancanti
end type
type cb_chiudi from commandbutton within w_riferimenti_mancanti
end type
end forward

global type w_riferimenti_mancanti from window
integer width = 2501
integer height = 1692
boolean titlebar = true
string title = "Inserimento riferimenti mancanti"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
uodw_current uodw_current
cb_annulla cb_annulla
cb_chiudi cb_chiudi
end type
global w_riferimenti_mancanti w_riferimenti_mancanti

type variables
s_lista is_lista_s
m_preview im_preview
end variables

on w_riferimenti_mancanti.create
this.uodw_current=create uodw_current
this.cb_annulla=create cb_annulla
this.cb_chiudi=create cb_chiudi
this.Control[]={this.uodw_current,&
this.cb_annulla,&
this.cb_chiudi}
end on

on w_riferimenti_mancanti.destroy
destroy(this.uodw_current)
destroy(this.cb_annulla)
destroy(this.cb_chiudi)
end on

event open;is_lista_s= message.powerObjectParm

im_preview= create m_preview

uodw_current.setTransObject(sqlca)

uodw_current.retrieve(is_lista_s.cod_lista, is_lista_s.cod_rif)
end event

type uodw_current from uodw_generica within w_riferimenti_mancanti
integer width = 2464
integer taborder = 10
string dataobject = "dw_liste_destinatari_mancanti"
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_current

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false
	
im_preview.PopMenu ( w_riferimenti_mancanti.PointerX(), w_riferimenti_mancanti.PointerY() )
end event

event buttonclicked;call super::buttonclicked;s_session ls_session_s

ls_session_s= s_session_s

if dwo.name= "b_rif" then
		
		integer li_ret
		s_riferimenti s_riferimenti_s
		string ls_message, ls_where
		
		// può modificare il riferimento corrente
		
				if messageBox(parent.title, "Vuoi inserire il riferimento mancante?", Question!, yesNo!, 2)= 2 then return 0
								
				s_riferimenti_s.codice= this.getItemString(row, "codice")
				s_riferimenti_s.rif_membri= true
				s_riferimenti_s.cod_rif= is_lista_s.cod_rif // this.getItemString(row, "cod_rif")
				s_riferimenti_s.idx= 0 //this.getItemDecimal(row, "idx")
				
				if openWithParm(w_ins_riferimenti, s_riferimenti_s)= -1 then return -1
				
				li_ret= message.doubleParm
				
				if li_ret= -1 then return -1
	
				//ls_where= "  WHERE riferimenti.cod_rif = ~~'MA~~'    and riferimenti.codice= ~~'"+s_riferimenti_s.codice+"~~'"
			
//				this.getChild("riferimento_descr", idwc_mailrif)
//				f_mod_select(ls_where, idwc_mailrif)
				
				this.setItem(row, "riferimento_descr", "")
				
				ls_message= "Liste: modificato riferimento per "+s_riferimenti_s.codice
				
				f_log(ls_session_s, ls_message, true)
		
end if


	
end event

type cb_annulla from commandbutton within w_riferimenti_mancanti
integer x = 1403
integer y = 1436
integer width = 329
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;closeWithReturn(parent, -1)
end event

type cb_chiudi from commandbutton within w_riferimenti_mancanti
integer x = 1065
integer y = 1436
integer width = 329
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aggiorna"
end type

event clicked;closeWithReturn(parent, 0)
end event

