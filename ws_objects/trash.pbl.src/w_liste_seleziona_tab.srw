$PBExportHeader$w_liste_seleziona_tab.srw
forward
global type w_liste_seleziona_tab from w_liste_invio_tab
end type
type pb_carica from picturebutton within w_liste_seleziona_tab
end type
type rb_sms from radiobutton within w_liste_seleziona_tab
end type
type rb_labels from radiobutton within w_liste_seleziona_tab
end type
type rb_doc from radiobutton within w_liste_seleziona_tab
end type
type rb_mail from radiobutton within w_liste_seleziona_tab
end type
type dw_1 from uodw_generica within w_liste_seleziona_tab
end type
type gb_seleziona_lista from groupbox within w_liste_seleziona_tab
end type
type gb_tipo from groupbox within w_liste_seleziona_tab
end type
type gb_carica from groupbox within w_liste_seleziona_tab
end type
end forward

global type w_liste_seleziona_tab from w_liste_invio_tab
integer width = 4133
integer height = 2712
string title = "Generazione liste"
pb_carica pb_carica
rb_sms rb_sms
rb_labels rb_labels
rb_doc rb_doc
rb_mail rb_mail
dw_1 dw_1
gb_seleziona_lista gb_seleziona_lista
gb_tipo gb_tipo
gb_carica gb_carica
end type
global w_liste_seleziona_tab w_liste_seleziona_tab

type variables
dataWindowChild dwc_cod_lista

end variables

on w_liste_seleziona_tab.create
int iCurrent
call super::create
this.pb_carica=create pb_carica
this.rb_sms=create rb_sms
this.rb_labels=create rb_labels
this.rb_doc=create rb_doc
this.rb_mail=create rb_mail
this.dw_1=create dw_1
this.gb_seleziona_lista=create gb_seleziona_lista
this.gb_tipo=create gb_tipo
this.gb_carica=create gb_carica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_carica
this.Control[iCurrent+2]=this.rb_sms
this.Control[iCurrent+3]=this.rb_labels
this.Control[iCurrent+4]=this.rb_doc
this.Control[iCurrent+5]=this.rb_mail
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_seleziona_lista
this.Control[iCurrent+8]=this.gb_tipo
this.Control[iCurrent+9]=this.gb_carica
end on

on w_liste_seleziona_tab.destroy
call super::destroy
destroy(this.pb_carica)
destroy(this.rb_sms)
destroy(this.rb_labels)
destroy(this.rb_doc)
destroy(this.rb_mail)
destroy(this.dw_1)
destroy(this.gb_seleziona_lista)
destroy(this.gb_tipo)
destroy(this.gb_carica)
end on

event open;call super::open;long ll_row

//dw_cod_lista.GetChild('cod_lista', dwc_cod_lista)

//dwc_cod_lista.setTransObject(sqlca)

//dwc_cod_lista.retrieve()

//string ls_query
//
//if gb_is_superuser= false then
//	dwc_cod_lista.setFilter("flag_riservata= 'P'")
//	dwc_cod_lista.filter()
//end if

//dw_cod_lista.setRowFocusIndicator(hand!)
//
//dw_cod_lista.setTransObject(sqlca)
//ll_row= dw_cod_lista.retrieve()	

if ll_row <= 0 then
	messageBox(this.title, "Nessuna lista disponibile.", information!)
	close(this)
end if

return 0
end event

type tab_send from w_liste_invio_tab`tab_send within w_liste_seleziona_tab
integer y = 456
integer width = 4027
end type

type tabpage_mail from w_liste_invio_tab`tabpage_mail within tab_send
integer width = 3991
end type

type sle_oggetto from w_liste_invio_tab`sle_oggetto within tabpage_mail
end type

type cbx_receipt from w_liste_invio_tab`cbx_receipt within tabpage_mail
end type

type cb_invia from w_liste_invio_tab`cb_invia within tabpage_mail
end type

type mle_messaggio from w_liste_invio_tab`mle_messaggio within tabpage_mail
end type

type dw_allegati from w_liste_invio_tab`dw_allegati within tabpage_mail
borderstyle borderstyle = stylelowered!
end type

type dw_liste_mail from w_liste_invio_tab`dw_liste_mail within tabpage_mail
end type

type gb_3 from w_liste_invio_tab`gb_3 within tabpage_mail
end type

type gb_body from w_liste_invio_tab`gb_body within tabpage_mail
end type

type gb_1 from w_liste_invio_tab`gb_1 within tabpage_mail
end type

type gb_4 from w_liste_invio_tab`gb_4 within tabpage_mail
end type

type sle_mittente from w_liste_invio_tab`sle_mittente within tabpage_mail
end type

type cbx_lista from w_liste_invio_tab`cbx_lista within tabpage_mail
end type

type tabpage_lettera from w_liste_invio_tab`tabpage_lettera within tab_send
integer width = 3991
end type

type cb_cancella1 from w_liste_invio_tab`cb_cancella1 within tabpage_lettera
end type

type dw_liste_documenti from w_liste_invio_tab`dw_liste_documenti within tabpage_lettera
integer width = 3483
end type

type gb_31 from w_liste_invio_tab`gb_31 within tabpage_lettera
integer width = 3584
end type

type gb_bodydoc from w_liste_invio_tab`gb_bodydoc within tabpage_lettera
end type

type tabpage_etichette from w_liste_invio_tab`tabpage_etichette within tab_send
integer width = 3991
end type

type cb_setup_labels from w_liste_invio_tab`cb_setup_labels within tabpage_etichette
end type

type cb_stampa_etichette from w_liste_invio_tab`cb_stampa_etichette within tabpage_etichette
end type

type dw_etichette from w_liste_invio_tab`dw_etichette within tabpage_etichette
end type

type gb_labels from w_liste_invio_tab`gb_labels within tabpage_etichette
boolean enabled = false
end type

type tabpage_sms from w_liste_invio_tab`tabpage_sms within tab_send
integer width = 3991
end type

type st_sms from w_liste_invio_tab`st_sms within tabpage_sms
end type

type sle_sms from w_liste_invio_tab`sle_sms within tabpage_sms
end type

type cb_inviasms from w_liste_invio_tab`cb_inviasms within tabpage_sms
end type

type dw_liste_sms from w_liste_invio_tab`dw_liste_sms within tabpage_sms
end type

type gb_sms from w_liste_invio_tab`gb_sms within tabpage_sms
end type

type mle_messaggiosms from w_liste_invio_tab`mle_messaggiosms within tabpage_sms
end type

type gb_bodysms from w_liste_invio_tab`gb_bodysms within tabpage_sms
end type

type gb_2 from w_liste_invio_tab`gb_2 within w_liste_seleziona_tab
end type

type pb_carica from picturebutton within w_liste_seleziona_tab
integer x = 2907
integer y = 176
integer width = 119
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean originalsize = true
string picturename = "doublenextarrow.gif"
alignment htextalign = left!
end type

event clicked;//if dw_cod_lista.getRow() <= 0 then return -1
//
//is_lista_s.cod_lista= dw_cod_lista.getItemString(dw_cod_lista.getRow(), "cod_lista")
parent.event ue_list(is_lista_s)
this.enabled= false
end event

type rb_sms from radiobutton within w_liste_seleziona_tab
integer x = 2482
integer y = 328
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
pb_carica.enabled= true
end event

type rb_labels from radiobutton within w_liste_seleziona_tab
integer x = 2482
integer y = 240
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
pb_carica.enabled= true
end event

type rb_doc from radiobutton within w_liste_seleziona_tab
boolean visible = false
integer x = 2482
integer y = 76
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
string text = "Lettera"
end type

event clicked;is_lista_s.tipo_lista= 'DOC'
pb_carica.enabled= true
end event

type rb_mail from radiobutton within w_liste_seleziona_tab
integer x = 2482
integer y = 160
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
pb_carica.enabled= true
end event

type dw_1 from uodw_generica within w_liste_seleziona_tab
integer x = 41
integer y = 56
integer width = 2405
integer height = 340
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_sel_destinatari"
end type

type gb_seleziona_lista from groupbox within w_liste_seleziona_tab
integer x = 18
integer width = 2441
integer height = 432
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Seleziona lista destinatari da: "
end type

type gb_tipo from groupbox within w_liste_seleziona_tab
integer x = 2802
integer y = 4
integer width = 334
integer height = 428
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carica lista"
end type

type gb_carica from groupbox within w_liste_seleziona_tab
integer x = 2464
integer y = 4
integer width = 334
integer height = 428
integer taborder = 50
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

