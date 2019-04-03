$PBExportHeader$w_seleziona_livello_studio.srw
forward
global type w_seleziona_livello_studio from window
end type
type cb_2 from commandbutton within w_seleziona_livello_studio
end type
type cb_seleziona from commandbutton within w_seleziona_livello_studio
end type
type rb_0 from radiobutton within w_seleziona_livello_studio
end type
type rb_5 from radiobutton within w_seleziona_livello_studio
end type
type rb_4 from radiobutton within w_seleziona_livello_studio
end type
type rb_3 from radiobutton within w_seleziona_livello_studio
end type
type rb_2 from radiobutton within w_seleziona_livello_studio
end type
type rb_1 from radiobutton within w_seleziona_livello_studio
end type
type gb_livelli from groupbox within w_seleziona_livello_studio
end type
end forward

global type w_seleziona_livello_studio from window
integer width = 1047
integer height = 980
boolean titlebar = true
string title = "Selezione livello"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_2 cb_2
cb_seleziona cb_seleziona
rb_0 rb_0
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
gb_livelli gb_livelli
end type
global w_seleziona_livello_studio w_seleziona_livello_studio

type variables
string is_livello
end variables

on w_seleziona_livello_studio.create
this.cb_2=create cb_2
this.cb_seleziona=create cb_seleziona
this.rb_0=create rb_0
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.gb_livelli=create gb_livelli
this.Control[]={this.cb_2,&
this.cb_seleziona,&
this.rb_0,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.gb_livelli}
end on

on w_seleziona_livello_studio.destroy
destroy(this.cb_2)
destroy(this.cb_seleziona)
destroy(this.rb_0)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.gb_livelli)
end on

type cb_2 from commandbutton within w_seleziona_livello_studio
integer x = 654
integer y = 736
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;setNull(is_livello)

closeWithReturn(parent, is_livello)
end event

type cb_seleziona from commandbutton within w_seleziona_livello_studio
integer x = 146
integer y = 736
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seleziona"
boolean default = true
end type

event clicked;closeWithReturn(parent, is_livello)
end event

type rb_0 from radiobutton within w_seleziona_livello_studio
integer x = 146
integer y = 100
integer width = 384
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nessun esame"
end type

event clicked;is_livello= '00'
end event

type rb_5 from radiobutton within w_seleziona_livello_studio
integer x = 146
integer y = 544
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "5° Livello"
end type

event clicked;is_livello= '05'
end event

type rb_4 from radiobutton within w_seleziona_livello_studio
integer x = 146
integer y = 456
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "4° Livello"
end type

event clicked;is_livello= '04'
end event

type rb_3 from radiobutton within w_seleziona_livello_studio
integer x = 146
integer y = 368
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "3° Livello"
end type

event clicked;is_livello= '03'
end event

type rb_2 from radiobutton within w_seleziona_livello_studio
integer x = 146
integer y = 280
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "2° Livello"
end type

event clicked;is_livello= '02'
end event

type rb_1 from radiobutton within w_seleziona_livello_studio
integer x = 146
integer y = 192
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "1° Livello"
end type

event clicked;is_livello= '01'
end event

type gb_livelli from groupbox within w_seleziona_livello_studio
integer width = 997
integer height = 676
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selezione livello di studio"
end type

