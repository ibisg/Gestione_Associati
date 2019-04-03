$PBExportHeader$w_seleziona_lista_multipla.srw
forward
global type w_seleziona_lista_multipla from window
end type
type cb_annulla from commandbutton within w_seleziona_lista_multipla
end type
type cb_seleziona from commandbutton within w_seleziona_lista_multipla
end type
type rb_sms from radiobutton within w_seleziona_lista_multipla
end type
type rb_labels from radiobutton within w_seleziona_lista_multipla
end type
type rb_mail from radiobutton within w_seleziona_lista_multipla
end type
type dw_cod_lista from datawindow within w_seleziona_lista_multipla
end type
type gb_seleziona_lista from groupbox within w_seleziona_lista_multipla
end type
type gb_carica from groupbox within w_seleziona_lista_multipla
end type
end forward

global type w_seleziona_lista_multipla from window
integer width = 2382
integer height = 2048
boolean titlebar = true
string title = "Seleziona lista"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_annulla cb_annulla
cb_seleziona cb_seleziona
rb_sms rb_sms
rb_labels rb_labels
rb_mail rb_mail
dw_cod_lista dw_cod_lista
gb_seleziona_lista gb_seleziona_lista
gb_carica gb_carica
end type
global w_seleziona_lista_multipla w_seleziona_lista_multipla

type variables
long il_rows
s_lista is_lista_s

string is_or
end variables

on w_seleziona_lista_multipla.create
this.cb_annulla=create cb_annulla
this.cb_seleziona=create cb_seleziona
this.rb_sms=create rb_sms
this.rb_labels=create rb_labels
this.rb_mail=create rb_mail
this.dw_cod_lista=create dw_cod_lista
this.gb_seleziona_lista=create gb_seleziona_lista
this.gb_carica=create gb_carica
this.Control[]={this.cb_annulla,&
this.cb_seleziona,&
this.rb_sms,&
this.rb_labels,&
this.rb_mail,&
this.dw_cod_lista,&
this.gb_seleziona_lista,&
this.gb_carica}
end on

on w_seleziona_lista_multipla.destroy
destroy(this.cb_annulla)
destroy(this.cb_seleziona)
destroy(this.rb_sms)
destroy(this.rb_labels)
destroy(this.rb_mail)
destroy(this.dw_cod_lista)
destroy(this.gb_seleziona_lista)
destroy(this.gb_carica)
end on

event open;//dw_cod_lista.setRowFocusIndicator(FocusRect!)

dw_cod_lista.setTransObject(sqlca)
il_rows= dw_cod_lista.retrieve()	

if il_rows <= 0 then
	messageBox(this.title, "Nessuna lista disponibile.", information!)
	is_lista_s.idx= 0
	closeWithReturn(this, is_lista_s )
end if

return 0
end event

type cb_annulla from commandbutton within w_seleziona_lista_multipla
integer x = 1184
integer y = 1784
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_seleziona from commandbutton within w_seleziona_lista_multipla
integer x = 832
integer y = 1784
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Seleziona"
boolean default = true
end type

event clicked;long ll_idx

choose case is_lista_s.tipo_lista
		
	case "MAIL"
		
		w_liste_manuali_tab.tab_send.tabpage_mail.dw_liste_mail.reset()
		
	case "LABELS"
		
		w_liste_manuali_tab.tab_send.tabpage_etichette.dw_etichette.reset()
		
	case "SMS"
		
		w_liste_manuali_tab.tab_send.tabpage_sms.dw_liste_sms.reset()
		
end choose

for ll_idx= 1 to il_rows
	
	if dw_cod_lista.getItemNumber(ll_idx, "ok") = 1 then
		
		is_lista_s.idx= dw_cod_lista.getItemDecimal(ll_idx, "idx")
		
		if is_lista_s.idx= 0 then continue
		
	if ll_idx= 1 then
		
		w_liste_manuali_tab.is_or= " and (liste.idx= "+string(is_lista_s.idx)
	
	else
	
		w_liste_manuali_tab.is_or += " OR liste.idx= "+string(is_lista_s.idx)
		
	end if
	
	if ll_idx= il_rows then w_liste_manuali_tab.is_or += ")"
	
	end if
	
	w_liste_manuali_tab.event ue_list(is_lista_s)
	
	//this.enabled= false

next

close(parent)
end event

type rb_sms from radiobutton within w_seleziona_lista_multipla
integer x = 1362
integer y = 1680
integer width = 306
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "SMS"
end type

event clicked;is_lista_s.tipo_lista= 'SMS'
is_lista_s.cod_rif= 'TM'
cb_seleziona.enabled= true
end event

type rb_labels from radiobutton within w_seleziona_lista_multipla
integer x = 1038
integer y = 1680
integer width = 306
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Etichette"
end type

event clicked;is_lista_s.tipo_lista= 'LABELS'
is_lista_s.cod_rif= 'LA'
cb_seleziona.enabled= true
end event

type rb_mail from radiobutton within w_seleziona_lista_multipla
integer x = 713
integer y = 1680
integer width = 306
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "E-mail"
end type

event clicked;is_lista_s.tipo_lista= 'MAIL'
is_lista_s.cod_rif= 'MA'
cb_seleziona.enabled= true
end event

type dw_cod_lista from datawindow within w_seleziona_lista_multipla
integer x = 46
integer y = 52
integer width = 2231
integer height = 1496
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cod_lista_multipla"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;rb_mail.enabled= true
rb_labels.enabled= true
rb_sms.enabled= true

rb_mail.checked= false
rb_labels.checked= false
rb_sms.checked= false


end event

event itemchanged;if row <= 0 then return -1

cb_seleziona.enabled= true
end event

event sqlpreview;//string ls_query
//
//if f_has_p('D') then
//	ls_query= " where liste.flag_riservata= 'P' and liste.cod_dip='"+ s_utente_s.s_dip_operativa+"'"
//	sqlsyntax += ls_query
//	setSqlPreview(sqlsyntax)
//end if
end event

event rowfocuschanged;f_select_current_row(this)
end event

type gb_seleziona_lista from groupbox within w_seleziona_lista_multipla
integer x = 18
integer width = 2304
integer height = 1576
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Seleziona lista destinatari "
end type

type gb_carica from groupbox within w_seleziona_lista_multipla
integer x = 667
integer y = 1624
integer width = 1006
integer height = 140
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo lista"
end type

