$PBExportHeader$w_consulta_filtra.srw
forward
global type w_consulta_filtra from window
end type
type cb_annulla from commandbutton within w_consulta_filtra
end type
type cb_seleziona from commandbutton within w_consulta_filtra
end type
type dw_filtra from datawindow within w_consulta_filtra
end type
end forward

global type w_consulta_filtra from window
integer width = 882
integer height = 712
boolean titlebar = true
string title = "Selezione tipo componenti"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_annulla cb_annulla
cb_seleziona cb_seleziona
dw_filtra dw_filtra
end type
global w_consulta_filtra w_consulta_filtra

event open;dw_filtra.insertRow(0)
end event

on w_consulta_filtra.create
this.cb_annulla=create cb_annulla
this.cb_seleziona=create cb_seleziona
this.dw_filtra=create dw_filtra
this.Control[]={this.cb_annulla,&
this.cb_seleziona,&
this.dw_filtra}
end on

on w_consulta_filtra.destroy
destroy(this.cb_annulla)
destroy(this.cb_seleziona)
destroy(this.dw_filtra)
end on

type cb_annulla from commandbutton within w_consulta_filtra
integer x = 521
integer y = 464
integer width = 283
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, -1)
end event

type cb_seleziona from commandbutton within w_consulta_filtra
integer x = 55
integer y = 464
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seleziona"
end type

event clicked;integer li_ret

li_ret= dw_filtra.getItemNumber(1, "flag")

closeWithReturn(parent, li_ret)
end event

type dw_filtra from datawindow within w_consulta_filtra
integer x = 46
integer width = 809
integer height = 456
integer taborder = 10
string title = "Seleziona tipo componente"
string dataobject = "dw_consulta_filtra"
boolean border = false
string icon = "Question!"
boolean livescroll = true
end type

