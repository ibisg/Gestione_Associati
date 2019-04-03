$PBExportHeader$w_confirm_update.srw
forward
global type w_confirm_update from window
end type
type st_wait from statictext within w_confirm_update
end type
type p_1 from picture within w_confirm_update
end type
end forward

global type w_confirm_update from window
integer width = 1102
integer height = 688
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
windowanimationstyle closeanimation = fadeanimation!
st_wait st_wait
p_1 p_1
end type
global w_confirm_update w_confirm_update

event open;timer(1)
end event

event timer;close(this)
end event

on w_confirm_update.create
this.st_wait=create st_wait
this.p_1=create p_1
this.Control[]={this.st_wait,&
this.p_1}
end on

on w_confirm_update.destroy
destroy(this.st_wait)
destroy(this.p_1)
end on

type st_wait from statictext within w_confirm_update
integer x = 46
integer y = 244
integer width = 805
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 16711680
long backcolor = 81324524
boolean enabled = false
string text = "Aggiornamento eseguito..."
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_confirm_update
integer x = 846
integer y = 196
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "charlieBrownHappy.gif"
boolean focusrectangle = false
end type

