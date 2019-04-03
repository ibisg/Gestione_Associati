$PBExportHeader$uo_testdw.sru
forward
global type uo_testdw from userobject
end type
type dw_current from uodw_anagrafica within uo_testdw
end type
type cb_nuovo from commandbutton within uo_testdw
end type
type cb_ordina from commandbutton within uo_testdw
end type
type cb_estrazione from commandbutton within uo_testdw
end type
type cb_annulla from commandbutton within uo_testdw
end type
type cb_cancella from commandbutton within uo_testdw
end type
type cb_salva from commandbutton within uo_testdw
end type
type cb_reset from commandbutton within uo_testdw
end type
type pb_struttura from picturebutton within uo_testdw
end type
type gb_buttons from groupbox within uo_testdw
end type
end forward

global type uo_testdw from userobject
integer width = 4549
integer height = 2216
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_current dw_current
cb_nuovo cb_nuovo
cb_ordina cb_ordina
cb_estrazione cb_estrazione
cb_annulla cb_annulla
cb_cancella cb_cancella
cb_salva cb_salva
cb_reset cb_reset
pb_struttura pb_struttura
gb_buttons gb_buttons
end type
global uo_testdw uo_testdw

type variables
boolean b_enabled_nuovo, b_enabled_ricerca, b_enabled_estrazione, b_enabled_annulla, b_enabled_cancella, b_enabled_salva, b_enabled_reset, b_enabled_struttura
end variables

on uo_testdw.create
this.dw_current=create dw_current
this.cb_nuovo=create cb_nuovo
this.cb_ordina=create cb_ordina
this.cb_estrazione=create cb_estrazione
this.cb_annulla=create cb_annulla
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.cb_reset=create cb_reset
this.pb_struttura=create pb_struttura
this.gb_buttons=create gb_buttons
this.Control[]={this.dw_current,&
this.cb_nuovo,&
this.cb_ordina,&
this.cb_estrazione,&
this.cb_annulla,&
this.cb_cancella,&
this.cb_salva,&
this.cb_reset,&
this.pb_struttura,&
this.gb_buttons}
end on

on uo_testdw.destroy
destroy(this.dw_current)
destroy(this.cb_nuovo)
destroy(this.cb_ordina)
destroy(this.cb_estrazione)
destroy(this.cb_annulla)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.cb_reset)
destroy(this.pb_struttura)
destroy(this.gb_buttons)
end on

type dw_current from uodw_anagrafica within uo_testdw
integer y = 220
integer taborder = 40
string dataobject = "dw_ricerca_associati"
end type

event resize;call super::resize;this.height= parent.height - 30
end event

type cb_nuovo from commandbutton within uo_testdw
integer x = 1911
integer y = 60
integer width = 558
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Nuovo"
end type

event clicked;if b_enabled_nuovo then cb_nuovo.enabled= false
if b_enabled_ricerca then cb_ordina.enabled= false
integer li_ret

if b_enabled_estrazione then cb_estrazione.enabled= false
if b_enabled_annulla then cb_annulla.enabled= false
if b_enabled_cancella then cb_cancella.enabled= true
if b_enabled_salva then cb_salva.enabled= true
if b_enabled_reset then cb_reset.enabled= true

end event

type cb_ordina from commandbutton within uo_testdw
integer x = 210
integer y = 60
integer width = 558
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ordina"
end type

event clicked;if b_enabled_nuovo then cb_nuovo.enabled= false
//if b_enabled_ricerca then cb_ricerca.enabled= false
if b_enabled_estrazione then cb_estrazione.enabled= true
if b_enabled_annulla then cb_annulla.enabled= false
if b_enabled_cancella then cb_cancella.enabled= false
if b_enabled_salva then cb_salva.enabled= false
if b_enabled_reset then cb_reset.enabled= true
end event

type cb_estrazione from commandbutton within uo_testdw
integer x = 777
integer y = 60
integer width = 558
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Estrazione"
boolean default = true
end type

event clicked;if b_enabled_nuovo then cb_nuovo.enabled= true
if b_enabled_ricerca then cb_ordina.enabled= true
if b_enabled_estrazione then cb_estrazione.enabled= false
if b_enabled_annulla then cb_annulla.enabled= false
if b_enabled_cancella then cb_cancella.enabled= true
if b_enabled_salva then cb_salva.enabled= true
if b_enabled_reset then cb_reset.enabled= true
end event

type cb_annulla from commandbutton within uo_testdw
integer x = 1344
integer y = 60
integer width = 558
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Annulla"
boolean cancel = true
end type

event clicked;this.enabled= false
end event

type cb_cancella from commandbutton within uo_testdw
integer x = 2478
integer y = 60
integer width = 558
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancella"
end type

event clicked;if b_enabled_nuovo then cb_nuovo.enabled= false
if b_enabled_ricerca then cb_ordina.enabled= false
if b_enabled_estrazione then cb_estrazione.enabled= false
if b_enabled_annulla then cb_annulla.enabled= false
if b_enabled_cancella then cb_cancella.enabled= false
if b_enabled_salva then cb_salva.enabled= true
if b_enabled_reset then cb_reset.enabled= true
end event

type cb_salva from commandbutton within uo_testdw
integer x = 3045
integer y = 60
integer width = 558
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salva"
end type

event clicked;if b_enabled_nuovo then cb_nuovo.enabled= true
if b_enabled_ricerca then cb_ordina.enabled= true
if b_enabled_estrazione then cb_estrazione.enabled= false
if b_enabled_annulla then cb_annulla.enabled= false
if b_enabled_cancella then cb_cancella.enabled= true
if b_enabled_salva then cb_salva.enabled= true
if b_enabled_reset then cb_reset.enabled= true
end event

type cb_reset from commandbutton within uo_testdw
integer x = 3611
integer y = 60
integer width = 558
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Rese&t"
end type

event clicked;if b_enabled_nuovo then cb_nuovo.enabled= true
if b_enabled_ricerca then cb_ordina.enabled= true
if b_enabled_estrazione then cb_estrazione.enabled= false
if b_enabled_annulla then cb_annulla.enabled= false
if b_enabled_cancella then cb_cancella.enabled= true
if b_enabled_salva then cb_salva.enabled= true
if b_enabled_reset then cb_reset.enabled= true
end event

type pb_struttura from picturebutton within uo_testdw
integer x = 23
integer y = 48
integer width = 174
integer height = 136
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "D:\svil\Svil7\Risorse\where.bmp"
alignment htextalign = left!
end type

type gb_buttons from groupbox within uo_testdw
integer width = 4197
integer height = 204
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

