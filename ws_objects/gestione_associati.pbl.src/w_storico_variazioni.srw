$PBExportHeader$w_storico_variazioni.srw
forward
global type w_storico_variazioni from window
end type
type cb_chiudi from commandbutton within w_storico_variazioni
end type
type dw_current from datawindow within w_storico_variazioni
end type
end forward

global type w_storico_variazioni from window
integer width = 3648
integer height = 1836
boolean titlebar = true
string title = "Storico variazioni"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
cb_chiudi cb_chiudi
dw_current dw_current
end type
global w_storico_variazioni w_storico_variazioni

type variables
string is_codice

s_riferimenti is_riferimenti_s
end variables

event open;is_riferimenti_s= message.powerObjectParm

dw_current.setTransObject(sqlca)

dw_current.retrieve(is_riferimenti_s.codice)

end event

on w_storico_variazioni.create
this.cb_chiudi=create cb_chiudi
this.dw_current=create dw_current
this.Control[]={this.cb_chiudi,&
this.dw_current}
end on

on w_storico_variazioni.destroy
destroy(this.cb_chiudi)
destroy(this.dw_current)
end on

type cb_chiudi from commandbutton within w_storico_variazioni
integer x = 1637
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

type dw_current from datawindow within w_storico_variazioni
integer width = 3611
integer height = 1528
integer taborder = 10
string title = "Storico variazioni"
string dataobject = "dw_vislog"
boolean controlmenu = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;//if row <= 0 then return 0
//
//if f_has_p("O")= false then return -1
//
//is_riferimenti_s.idx= this.getItemDecimal(row, "id")
//
//openWithParm(w_ins_storico_gohonzon, is_riferimenti_s)
//
//this.setRedraw(false)
//
//	this.retrieve(is_riferimenti_s.codice)
//			
//this.setRedraw(true)			

end event

event rowfocuschanged;f_select_current_row(this)
end event

