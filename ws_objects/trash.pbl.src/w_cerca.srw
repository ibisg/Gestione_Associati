$PBExportHeader$w_cerca.srw
forward
global type w_cerca from w_centered
end type
type sle_trova from singlelineedit within w_cerca
end type
type cb_trova from commandbutton within w_cerca
end type
type cb_estrai from commandbutton within w_cerca
end type
type st_a from statictext within w_cerca
end type
end forward

global type w_cerca from w_centered
integer width = 1499
integer height = 896
string title = "Trova"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
sle_trova sle_trova
cb_trova cb_trova
cb_estrai cb_estrai
st_a st_a
end type
global w_cerca w_cerca

type variables
s_data is_data_s
end variables

on w_cerca.create
int iCurrent
call super::create
this.sle_trova=create sle_trova
this.cb_trova=create cb_trova
this.cb_estrai=create cb_estrai
this.st_a=create st_a
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_trova
this.Control[iCurrent+2]=this.cb_trova
this.Control[iCurrent+3]=this.cb_estrai
this.Control[iCurrent+4]=this.st_a
end on

on w_cerca.destroy
call super::destroy
destroy(this.sle_trova)
destroy(this.cb_trova)
destroy(this.cb_estrai)
destroy(this.st_a)
end on

type sle_trova from singlelineedit within w_cerca
integer x = 288
integer y = 296
integer width = 1093
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
end type

event modified;this.selectText(1, len(this.text))
end event

type cb_trova from commandbutton within w_cerca
integer x = 978
integer y = 492
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
boolean cancel = true
end type

event clicked;setNull(sle_trova.text)
closeWithReturn(parent,sle_trova.text)
end event

type cb_estrai from commandbutton within w_cerca
integer x = 549
integer y = 492
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Trova"
boolean default = true
end type

event clicked;closeWithReturn(parent, sle_trova.text)
end event

type st_a from statictext within w_cerca
integer x = 46
integer y = 320
integer width = 238
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Trova:"
alignment alignment = center!
boolean focusrectangle = false
end type

