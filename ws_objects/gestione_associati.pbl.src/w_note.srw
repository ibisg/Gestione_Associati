$PBExportHeader$w_note.srw
forward
global type w_note from w_centered
end type
type cb_salva from commandbutton within w_note
end type
type dw_current from datawindow within w_note
end type
end forward

global type w_note from w_centered
integer width = 1111
integer height = 908
string title = "Note"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
boolean clientedge = true
boolean center = true
cb_salva cb_salva
dw_current dw_current
end type
global w_note w_note

on w_note.create
int iCurrent
call super::create
this.cb_salva=create cb_salva
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salva
this.Control[iCurrent+2]=this.dw_current
end on

on w_note.destroy
call super::destroy
destroy(this.cb_salva)
destroy(this.dw_current)
end on

event open;call super::open;long ll_row
string ls_note

s_session_s.context= "Inserimento note"

ls_note= message.stringParm

ll_row= dw_current.insertRow(0)

dw_current.setItem(ll_row,"note" , ls_note)
end event

type cb_salva from commandbutton within w_note
integer x = 370
integer y = 660
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Ok"
boolean default = true
end type

event clicked;dw_current.acceptText()

closeWIthReturn(parent, dw_current.getItemString(1, "note") )
end event

type dw_current from datawindow within w_note
integer width = 1079
integer height = 612
integer taborder = 10
string title = "none"
string dataobject = "d_note"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

