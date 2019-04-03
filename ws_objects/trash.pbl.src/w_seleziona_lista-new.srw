$PBExportHeader$w_seleziona_lista-new.srw
forward
global type w_seleziona_lista-new from window
end type
type tab_liste from tab within w_seleziona_lista-new
end type
type tabpage_selezione from userobject within tab_liste
end type
type uodw_seleziona from uodw_generica within tabpage_selezione
end type
type tabpage_selezione from userobject within tab_liste
uodw_seleziona uodw_seleziona
end type
type tabpage_eventi from userobject within tab_liste
end type
type ddlb_eventi from dropdownlistbox within tabpage_eventi
end type
type uodw_eventi_messages from uodw_generica within tabpage_eventi
end type
type tabpage_eventi from userobject within tab_liste
ddlb_eventi ddlb_eventi
uodw_eventi_messages uodw_eventi_messages
end type
type tab_liste from tab within w_seleziona_lista-new
tabpage_selezione tabpage_selezione
tabpage_eventi tabpage_eventi
end type
type cb_annulla from commandbutton within w_seleziona_lista-new
end type
type cb_seleziona from commandbutton within w_seleziona_lista-new
end type
type rb_sms from radiobutton within w_seleziona_lista-new
end type
type rb_labels from radiobutton within w_seleziona_lista-new
end type
type rb_mail from radiobutton within w_seleziona_lista-new
end type
type gb_carica from groupbox within w_seleziona_lista-new
end type
end forward

global type w_seleziona_lista-new from window
integer width = 2382
integer height = 2048
boolean titlebar = true
string title = "Seleziona lista"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
tab_liste tab_liste
cb_annulla cb_annulla
cb_seleziona cb_seleziona
rb_sms rb_sms
rb_labels rb_labels
rb_mail rb_mail
gb_carica gb_carica
end type
global w_seleziona_lista-new w_seleziona_lista-new

type variables
s_lista is_lista_s
end variables

on w_seleziona_lista-new.create
this.tab_liste=create tab_liste
this.cb_annulla=create cb_annulla
this.cb_seleziona=create cb_seleziona
this.rb_sms=create rb_sms
this.rb_labels=create rb_labels
this.rb_mail=create rb_mail
this.gb_carica=create gb_carica
this.Control[]={this.tab_liste,&
this.cb_annulla,&
this.cb_seleziona,&
this.rb_sms,&
this.rb_labels,&
this.rb_mail,&
this.gb_carica}
end on

on w_seleziona_lista-new.destroy
destroy(this.tab_liste)
destroy(this.cb_annulla)
destroy(this.cb_seleziona)
destroy(this.rb_sms)
destroy(this.rb_labels)
destroy(this.rb_mail)
destroy(this.gb_carica)
end on

event open;long ll_row

//dw_cod_lista.setRowFocusIndicator(FocusRect!)

tab_liste.tabpage_selezione.uodw_seleziona.setTransObject(sqlca)
tab_liste.tabpage_eventi.uodw_eventi_messages.setTransObject(sqlca)

ll_row= tab_liste.tabpage_selezione.uodw_seleziona.retrieve()	

if ll_row <= 0 then
	messageBox(this.title, "Nessuna lista disponibile.", information!)
	is_lista_s.idx= 0
	closeWithReturn(this, is_lista_s )
end if

return 0
end event

type tab_liste from tab within w_seleziona_lista-new
event create ( )
event destroy ( )
integer x = 37
integer y = 32
integer width = 2286
integer height = 1548
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_selezione tabpage_selezione
tabpage_eventi tabpage_eventi
end type

on tab_liste.create
this.tabpage_selezione=create tabpage_selezione
this.tabpage_eventi=create tabpage_eventi
this.Control[]={this.tabpage_selezione,&
this.tabpage_eventi}
end on

on tab_liste.destroy
destroy(this.tabpage_selezione)
destroy(this.tabpage_eventi)
end on

event selectionchanged;long ll_row

if newindex= 2 then
	
	ll_row= tab_liste.tabpage_eventi.uodw_eventi_messages.retrieve()	

	if ll_row <= 0 then
		messageBox(parent.title, "Nessun evento disponibile.", information!)
		is_lista_s.idx= 0
		closeWithReturn(parent, is_lista_s )
	end if
	
end if
end event

type tabpage_selezione from userobject within tab_liste
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2249
integer height = 1428
long backcolor = 67108864
string text = "Seleziona una lista"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uodw_seleziona uodw_seleziona
end type

on tabpage_selezione.create
this.uodw_seleziona=create uodw_seleziona
this.Control[]={this.uodw_seleziona}
end on

on tabpage_selezione.destroy
destroy(this.uodw_seleziona)
end on

type uodw_seleziona from uodw_generica within tabpage_selezione
integer taborder = 20
string dataobject = "dw_cod_lista"
end type

type tabpage_eventi from userobject within tab_liste
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2249
integer height = 1428
long backcolor = 67108864
string text = "Crea una lista da eventi in corso"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
ddlb_eventi ddlb_eventi
uodw_eventi_messages uodw_eventi_messages
end type

on tabpage_eventi.create
this.ddlb_eventi=create ddlb_eventi
this.uodw_eventi_messages=create uodw_eventi_messages
this.Control[]={this.ddlb_eventi,&
this.uodw_eventi_messages}
end on

on tabpage_eventi.destroy
destroy(this.ddlb_eventi)
destroy(this.uodw_eventi_messages)
end on

type ddlb_eventi from dropdownlistbox within tabpage_eventi
integer x = 869
integer y = 8
integer width = 731
integer height = 688
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Esami 1° Livello","Esami 2° Livello","Esami 3° Livello","Esami 4° Livello","Esami 5° Livello","Entrata nuovi fedeli","Consegne/Sostituzioni","Corso/Evento","Recitazione","Riunione","Consulta"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_filter

ls_filter= "tipo_evento= "+string(index)

uodw_eventi_messages.setFilter(ls_filter)
uodw_eventi_messages.filter()
end event

type uodw_eventi_messages from uodw_generica within tabpage_eventi
integer x = 14
integer y = 144
integer width = 2249
integer height = 1276
integer taborder = 20
string dataobject = "dw_eventi_messages"
boolean hscrollbar = false
end type

type cb_annulla from commandbutton within w_seleziona_lista-new
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

event clicked;is_lista_s.idx= 0

closeWithReturn(parent, is_lista_s )
end event

type cb_seleziona from commandbutton within w_seleziona_lista-new
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

event clicked;//is_lista_s.idx= dw_cod_lista.getItemDecimal(dw_cod_lista.getRow(), "idx")

closeWithReturn(parent, is_lista_s )
end event

type rb_sms from radiobutton within w_seleziona_lista-new
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

type rb_labels from radiobutton within w_seleziona_lista-new
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

type rb_mail from radiobutton within w_seleziona_lista-new
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

type gb_carica from groupbox within w_seleziona_lista-new
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

