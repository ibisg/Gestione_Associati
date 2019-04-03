$PBExportHeader$w_credits_ga.srw
forward
global type w_credits_ga from w_centered
end type
type cb_chiudi from commandbutton within w_credits_ga
end type
type p_info from picture within w_credits_ga
end type
type st_info from statictext within w_credits_ga
end type
end forward

global type w_credits_ga from w_centered
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
boolean center = true
cb_chiudi cb_chiudi
p_info p_info
st_info st_info
end type
global w_credits_ga w_credits_ga

on w_credits_ga.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.p_info=create p_info
this.st_info=create st_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.p_info
this.Control[iCurrent+3]=this.st_info
end on

on w_credits_ga.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.p_info)
destroy(this.st_info)
end on

type cb_chiudi from commandbutton within w_credits_ga
integer x = 645
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

type p_info from picture within w_credits_ga
integer x = 585
integer y = 152
integer width = 457
integer height = 368
boolean originalsize = true
string picturename = "monkey_smoking.gif"
boolean focusrectangle = false
end type

type st_info from statictext within w_credits_ga
integer x = 41
integer y = 636
integer width = 1531
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 0
string text = "Gestione associati - Rev. 0.4.9 - 30/04/2008"
alignment alignment = center!
boolean focusrectangle = false
end type

