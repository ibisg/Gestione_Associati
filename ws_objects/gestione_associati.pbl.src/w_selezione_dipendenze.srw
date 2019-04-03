$PBExportHeader$w_selezione_dipendenze.srw
forward
global type w_selezione_dipendenze from w_centered
end type
type cb_1 from commandbutton within w_selezione_dipendenze
end type
type dw_current from datawindow within w_selezione_dipendenze
end type
end forward

global type w_selezione_dipendenze from w_centered
integer width = 1015
integer height = 872
string title = "Selezione dipendenza"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_1 cb_1
dw_current dw_current
end type
global w_selezione_dipendenze w_selezione_dipendenze

event open;call super::open;dw_current.setTransObject(sqlca)
dw_current.retrieve()
end event

on w_selezione_dipendenze.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_current
end on

on w_selezione_dipendenze.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_current)
end on

type cb_1 from commandbutton within w_selezione_dipendenze
integer x = 302
integer y = 612
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, "")
end event

type dw_current from datawindow within w_selezione_dipendenze
integer width = 983
integer height = 600
integer taborder = 10
string title = "none"
string dataobject = "dwc_dipendenze"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if row = 0 then return

closeWithReturn(parent, this.getItemString(row, "cod_dip") )
end event

event rowfocuschanged;f_select_current_row(this)
end event

