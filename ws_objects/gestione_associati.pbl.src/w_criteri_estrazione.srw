$PBExportHeader$w_criteri_estrazione.srw
forward
global type w_criteri_estrazione from w_centered
end type
type em_a from editmask within w_criteri_estrazione
end type
type em_da from editmask within w_criteri_estrazione
end type
type cb_annulla from commandbutton within w_criteri_estrazione
end type
type cb_estrai from commandbutton within w_criteri_estrazione
end type
type st_a from statictext within w_criteri_estrazione
end type
type st_da from statictext within w_criteri_estrazione
end type
end forward

global type w_criteri_estrazione from w_centered
integer width = 1499
integer height = 896
string title = "Criteri di estrazione"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean center = true
em_a em_a
em_da em_da
cb_annulla cb_annulla
cb_estrai cb_estrai
st_a st_a
st_da st_da
end type
global w_criteri_estrazione w_criteri_estrazione

type variables
s_data is_data_s
end variables

event open;call super::open; em_da.text="01.01."+string(year(today() ) )

em_a.text= string(datetime(today() ), "dd.mm.yyyy")

is_data_s.ls_da= em_da.text

is_data_s.ls_a= em_a.text

return 0



end event

on w_criteri_estrazione.create
int iCurrent
call super::create
this.em_a=create em_a
this.em_da=create em_da
this.cb_annulla=create cb_annulla
this.cb_estrai=create cb_estrai
this.st_a=create st_a
this.st_da=create st_da
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_a
this.Control[iCurrent+2]=this.em_da
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.cb_estrai
this.Control[iCurrent+5]=this.st_a
this.Control[iCurrent+6]=this.st_da
end on

on w_criteri_estrazione.destroy
call super::destroy
destroy(this.em_a)
destroy(this.em_da)
destroy(this.cb_annulla)
destroy(this.cb_estrai)
destroy(this.st_a)
destroy(this.st_da)
end on

type em_a from editmask within w_criteri_estrazione
integer x = 622
integer y = 296
integer width = 485
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd.mm.yyyy"
boolean dropdowncalendar = true
end type

type em_da from editmask within w_criteri_estrazione
integer x = 622
integer y = 156
integer width = 485
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd.mm.yyyy"
boolean dropdowncalendar = true
end type

type cb_annulla from commandbutton within w_criteri_estrazione
integer x = 855
integer y = 492
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Annulla"
boolean cancel = true
end type

event clicked;setNull(is_data_s.ls_da)
closeWithReturn(parent, is_data_s)
end event

type cb_estrai from commandbutton within w_criteri_estrazione
integer x = 443
integer y = 492
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Estrai"
boolean default = true
end type

event clicked;is_data_s.ls_da= em_da.text
is_data_s.ls_a= em_a.text

closeWithReturn(parent, is_data_s)
end event

type st_a from statictext within w_criteri_estrazione
integer x = 334
integer y = 320
integer width = 238
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 81324524
string text = "A:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_da from statictext within w_criteri_estrazione
integer x = 334
integer y = 180
integer width = 238
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 81324524
string text = "Da:"
alignment alignment = right!
boolean focusrectangle = false
end type

