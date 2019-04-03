$PBExportHeader$w_storico_gohonzon_dim.srw
forward
global type w_storico_gohonzon_dim from window
end type
type cb_chiudi from commandbutton within w_storico_gohonzon_dim
end type
type dw_current from datawindow within w_storico_gohonzon_dim
end type
end forward

global type w_storico_gohonzon_dim from window
integer width = 2510
integer height = 1836
boolean titlebar = true
string title = "Storico Gohonzon"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
cb_chiudi cb_chiudi
dw_current dw_current
end type
global w_storico_gohonzon_dim w_storico_gohonzon_dim

event open;string ls_codice

dw_current.setTransObject(sqlca)

ls_codice= message.stringParm

dw_current.retrieve(ls_codice)

end event

on w_storico_gohonzon_dim.create
this.cb_chiudi=create cb_chiudi
this.dw_current=create dw_current
this.Control[]={this.cb_chiudi,&
this.dw_current}
end on

on w_storico_gohonzon_dim.destroy
destroy(this.cb_chiudi)
destroy(this.dw_current)
end on

type cb_chiudi from commandbutton within w_storico_gohonzon_dim
integer x = 1065
integer y = 1568
integer width = 343
integer height = 128
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
boolean cancel = true
boolean default = true
end type

event clicked;close(parent)
end event

type dw_current from datawindow within w_storico_gohonzon_dim
integer width = 2469
integer height = 1528
integer taborder = 10
string title = "none"
string dataobject = "d_storico_goh_dim"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

