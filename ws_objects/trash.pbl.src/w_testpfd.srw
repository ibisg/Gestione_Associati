$PBExportHeader$w_testpfd.srw
forward
global type w_testpfd from window
end type
type cb_1 from commandbutton within w_testpfd
end type
end forward

global type w_testpfd from window
integer width = 3168
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_1 cb_1
end type
global w_testpfd w_testpfd

on w_testpfd.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_testpfd.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_testpfd
integer x = 1230
integer y = 284
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;nca_test lnca_test

lnca_test.uof_test()
end event
