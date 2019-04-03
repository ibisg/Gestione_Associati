$PBExportHeader$w_confirm_update.srw
forward
global type w_confirm_update from w_centered
end type
type st_wait from statictext within w_confirm_update
end type
end forward

global type w_confirm_update from w_centered
integer width = 1088
integer height = 604
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
st_wait st_wait
end type
global w_confirm_update w_confirm_update

event open;call super::open; this.title= parentWIndow().getActiveSheet().title
timer(0.55)
end event

event close;call super::close;timer(0)
end event

event timer;call super::timer;close(this)
end event

on w_confirm_update.create
int iCurrent
call super::create
this.st_wait=create st_wait
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_wait
end on

on w_confirm_update.destroy
call super::destroy
destroy(this.st_wait)
end on

type st_wait from statictext within w_confirm_update
integer x = 73
integer y = 252
integer width = 910
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Aggiornamento eseguito"
alignment alignment = center!
boolean focusrectangle = false
end type

