$PBExportHeader$w_info_ga.srw
forward
global type w_info_ga from w_centered
end type
type cb_sw from commandbutton within w_info_ga
end type
type cb_chiudi from commandbutton within w_info_ga
end type
type p_info from picture within w_info_ga
end type
type st_info from statictext within w_info_ga
end type
end forward

global type w_info_ga from w_centered
integer width = 1669
integer height = 940
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 0
string icon = "Information!"
boolean clientedge = true
cb_sw cb_sw
cb_chiudi cb_chiudi
p_info p_info
st_info st_info
end type
global w_info_ga w_info_ga

on w_info_ga.create
int iCurrent
call super::create
this.cb_sw=create cb_sw
this.cb_chiudi=create cb_chiudi
this.p_info=create p_info
this.st_info=create st_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_sw
this.Control[iCurrent+2]=this.cb_chiudi
this.Control[iCurrent+3]=this.p_info
this.Control[iCurrent+4]=this.st_info
end on

on w_info_ga.destroy
call super::destroy
destroy(this.cb_sw)
destroy(this.cb_chiudi)
destroy(this.p_info)
destroy(this.st_info)
end on

type cb_sw from commandbutton within w_info_ga
integer x = 1170
integer y = 764
integer width = 430
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Log modifiche SW"
end type

event clicked;open(w_logmodifichesw)
end event

type cb_chiudi from commandbutton within w_info_ga
integer x = 635
integer y = 764
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

type p_info from picture within w_info_ga
integer x = 649
integer y = 292
integer width = 311
integer height = 264
string picturename = "uni.gif"
boolean focusrectangle = false
end type

type st_info from statictext within w_info_ga
integer x = 192
integer y = 636
integer width = 1230
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 0
boolean enabled = false
string text = "Gestione associati 2.1.2 - 24.04.2019"
alignment alignment = center!
boolean focusrectangle = false
end type

