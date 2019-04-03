$PBExportHeader$w_liste_manuali_tab_old.srw
forward
global type w_liste_manuali_tab_old from w_liste_invio_tab
end type
type rb_doc from radiobutton within w_liste_manuali_tab_old
end type
type pb_carica from commandbutton within w_liste_manuali_tab_old
end type
type gb_tipo from groupbox within w_liste_manuali_tab_old
end type
end forward

global type w_liste_manuali_tab_old from w_liste_invio_tab
integer width = 4133
integer height = 3060
string title = "Generazione liste"
rb_doc rb_doc
pb_carica pb_carica
gb_tipo gb_tipo
end type
global w_liste_manuali_tab_old w_liste_manuali_tab_old

type variables
dataWindowChild dwc_cod_lista

end variables

on w_liste_manuali_tab_old.create
int iCurrent
call super::create
this.rb_doc=create rb_doc
this.pb_carica=create pb_carica
this.gb_tipo=create gb_tipo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_doc
this.Control[iCurrent+2]=this.pb_carica
this.Control[iCurrent+3]=this.gb_tipo
end on

on w_liste_manuali_tab_old.destroy
call super::destroy
destroy(this.rb_doc)
destroy(this.pb_carica)
destroy(this.gb_tipo)
end on

type tab_send from w_liste_invio_tab`tab_send within w_liste_manuali_tab_old
integer y = 280
integer width = 4027
integer height = 2672
end type

type tabpage_mail from w_liste_invio_tab`tabpage_mail within tab_send
integer width = 3991
integer height = 2556
end type

type st_1 from w_liste_invio_tab`st_1 within tabpage_mail
end type

type pb_invia from w_liste_invio_tab`pb_invia within tabpage_mail
end type

event pb_invia::clicked;call super::clicked;if ancestorReturnValue= 0 then
	pb_carica.enabled= true
end if
end event

type cbx_copiamittente from w_liste_invio_tab`cbx_copiamittente within tabpage_mail
end type

type sle_oggetto from w_liste_invio_tab`sle_oggetto within tabpage_mail
end type

type cbx_receipt from w_liste_invio_tab`cbx_receipt within tabpage_mail
end type

type mle_messaggio from w_liste_invio_tab`mle_messaggio within tabpage_mail
end type

type dw_allegati from w_liste_invio_tab`dw_allegati within tabpage_mail
end type

type dw_liste_mail from w_liste_invio_tab`dw_liste_mail within tabpage_mail
end type

event dw_liste_mail::retrievestart;call super::retrievestart;return 2 // append
end event

type gb_3 from w_liste_invio_tab`gb_3 within tabpage_mail
end type

type gb_body from w_liste_invio_tab`gb_body within tabpage_mail
end type

type gb_1 from w_liste_invio_tab`gb_1 within tabpage_mail
end type

type gb_4 from w_liste_invio_tab`gb_4 within tabpage_mail
integer width = 1970
end type

type gb_mittente from w_liste_invio_tab`gb_mittente within tabpage_mail
end type

type sle_mittente from w_liste_invio_tab`sle_mittente within tabpage_mail
end type

type cbx_lista from w_liste_invio_tab`cbx_lista within tabpage_mail
end type

type gb_allegati from w_liste_invio_tab`gb_allegati within tabpage_mail
end type

type tabpage_lettera from w_liste_invio_tab`tabpage_lettera within tab_send
integer width = 3991
integer height = 2556
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
integer height = 2556
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
integer height = 2556
end type

type st_sms from w_liste_invio_tab`st_sms within tabpage_sms
end type

type sle_sms from w_liste_invio_tab`sle_sms within tabpage_sms
end type

type cb_inviasms from w_liste_invio_tab`cb_inviasms within tabpage_sms
end type

event cb_inviasms::clicked;call super::clicked;if ancestorReturnValue= 0 then
	pb_carica.enabled= true
end if
end event

type dw_liste_sms from w_liste_invio_tab`dw_liste_sms within tabpage_sms
end type

type gb_sms from w_liste_invio_tab`gb_sms within tabpage_sms
end type

type mle_messaggiosms from w_liste_invio_tab`mle_messaggiosms within tabpage_sms
end type

type gb_bodysms from w_liste_invio_tab`gb_bodysms within tabpage_sms
end type

type gb_2 from w_liste_invio_tab`gb_2 within w_liste_manuali_tab_old
end type

type gb_5 from w_liste_invio_tab`gb_5 within w_liste_manuali_tab_old
end type

type gb_6 from w_liste_invio_tab`gb_6 within w_liste_manuali_tab_old
end type

type gb_7 from w_liste_invio_tab`gb_7 within w_liste_manuali_tab_old
end type

type rb_doc from radiobutton within w_liste_manuali_tab_old
boolean visible = false
integer x = 2473
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

type pb_carica from commandbutton within w_liste_manuali_tab_old
integer x = 27
integer y = 88
integer width = 3982
integer height = 120
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Clicca qui per selezionare una lista"
end type

event clicked;open(w_seleziona_lista)

is_lista_s= message.powerObjectParm

if is_lista_s.idx= 0 then return -1

parent.event ue_list(is_lista_s)
//this.enabled= false
end event

type gb_tipo from groupbox within w_liste_manuali_tab_old
integer y = 4
integer width = 4027
integer height = 264
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona lista"
end type

