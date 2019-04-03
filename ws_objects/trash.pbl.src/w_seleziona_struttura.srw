$PBExportHeader$w_seleziona_struttura.srw
forward
global type w_seleziona_struttura from w_centered
end type
type cb_1 from commandbutton within w_seleziona_struttura
end type
type sle_struttura from singlelineedit within w_seleziona_struttura
end type
type lv_struttura from listview within w_seleziona_struttura
end type
end forward

global type w_seleziona_struttura from w_centered
integer height = 1580
cb_1 cb_1
sle_struttura sle_struttura
lv_struttura lv_struttura
end type
global w_seleziona_struttura w_seleziona_struttura

on w_seleziona_struttura.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.sle_struttura=create sle_struttura
this.lv_struttura=create lv_struttura
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.sle_struttura
this.Control[iCurrent+3]=this.lv_struttura
end on

on w_seleziona_struttura.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.sle_struttura)
destroy(this.lv_struttura)
end on

type cb_1 from commandbutton within w_seleziona_struttura
integer x = 965
integer y = 1228
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type sle_struttura from singlelineedit within w_seleziona_struttura
integer x = 41
integer y = 1060
integer width = 2437
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type lv_struttura from listview within w_seleziona_struttura
integer x = 32
integer y = 32
integer width = 2441
integer height = 960
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long largepicturemaskcolor = 536870912
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

