$PBExportHeader$w_message_negative.srw
forward
global type w_message_negative from window
end type
type p_2 from picture within w_message_negative
end type
type st_wait from statictext within w_message_negative
end type
end forward

global type w_message_negative from window
integer width = 1120
integer height = 632
windowtype windowtype = response!
long backcolor = 67108864
boolean clientedge = true
boolean center = true
windowanimationstyle closeanimation = fadeanimation!
p_2 p_2
st_wait st_wait
end type
global w_message_negative w_message_negative

event open;timer(2)

end event

event timer;close(this)
end event

on w_message_negative.create
this.p_2=create p_2
this.st_wait=create st_wait
this.Control[]={this.p_2,&
this.st_wait}
end on

on w_message_negative.destroy
destroy(this.p_2)
destroy(this.st_wait)
end on

type p_2 from picture within w_message_negative
integer x = 846
integer y = 196
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "charlieBrownUnhappy.gif"
boolean focusrectangle = false
end type

type st_wait from statictext within w_message_negative
integer y = 244
integer width = 850
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
string text = "Aggiornamento non eseguito..."
alignment alignment = center!
boolean focusrectangle = false
end type

