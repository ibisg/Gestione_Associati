$PBExportHeader$w_ricerca_doppioni.srw
forward
global type w_ricerca_doppioni from window
end type
type cb_1 from commandbutton within w_ricerca_doppioni
end type
type dw_current from datawindow within w_ricerca_doppioni
end type
end forward

global type w_ricerca_doppioni from window
integer width = 2592
integer height = 1640
boolean titlebar = true
string title = "Attenzione: nomi simili sono presenti  in banca dati"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Information!"
boolean clientedge = true
boolean center = true
cb_1 cb_1
dw_current dw_current
end type
global w_ricerca_doppioni w_ricerca_doppioni

event open;s_ricercanominativa is_ricercanominativa

is_ricercanominativa= message.powerObjectParm

dw_current.setTransObject(sqlca)

dw_current.retrieve("%"+is_ricercanominativa.cognome+"%", "%"+ is_ricercanominativa.nome+ "%")
end event

on w_ricerca_doppioni.create
this.cb_1=create cb_1
this.dw_current=create dw_current
this.Control[]={this.cb_1,&
this.dw_current}
end on

on w_ricerca_doppioni.destroy
destroy(this.cb_1)
destroy(this.dw_current)
end on

type cb_1 from commandbutton within w_ricerca_doppioni
integer x = 1047
integer y = 1396
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type dw_current from datawindow within w_ricerca_doppioni
integer width = 2551
integer height = 1368
integer taborder = 10
string title = "none"
string dataobject = "dw_doppioni"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

