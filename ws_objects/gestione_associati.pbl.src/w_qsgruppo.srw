$PBExportHeader$w_qsgruppo.srw
forward
global type w_qsgruppo from window
end type
type cb_chiudi from commandbutton within w_qsgruppo
end type
type dw_current from datawindow within w_qsgruppo
end type
end forward

global type w_qsgruppo from window
integer width = 2011
integer height = 956
boolean titlebar = true
string title = "Q.S. gruppo"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_chiudi cb_chiudi
dw_current dw_current
end type
global w_qsgruppo w_qsgruppo

event open;s_struttura s_struttura_s

s_struttura_s= message.powerObjectParm

dw_current.setTransObject(sqlca)

dw_current.retrieve(s_struttura_s.vc_nodo)
end event

on w_qsgruppo.create
this.cb_chiudi=create cb_chiudi
this.dw_current=create dw_current
this.Control[]={this.cb_chiudi,&
this.dw_current}
end on

on w_qsgruppo.destroy
destroy(this.cb_chiudi)
destroy(this.dw_current)
end on

type cb_chiudi from commandbutton within w_qsgruppo
integer x = 823
integer y = 732
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

type dw_current from datawindow within w_qsgruppo
integer width = 1989
integer height = 704
integer taborder = 10
string title = "none"
string dataobject = "dctb_qsgruppo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

