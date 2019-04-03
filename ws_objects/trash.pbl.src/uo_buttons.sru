$PBExportHeader$uo_buttons.sru
forward
global type uo_buttons from userobject
end type
type pb_struttura from picturebutton within uo_buttons
end type
type cb_reset from commandbutton within uo_buttons
end type
type cb_salva from commandbutton within uo_buttons
end type
type cb_cancella from commandbutton within uo_buttons
end type
type cb_annulla from commandbutton within uo_buttons
end type
type cb_estrazione from commandbutton within uo_buttons
end type
type cb_ordina from commandbutton within uo_buttons
end type
type cb_nuovo from commandbutton within uo_buttons
end type
type gb_buttons from groupbox within uo_buttons
end type
end forward

global type uo_buttons from userobject
integer width = 4219
integer height = 264
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_struttura pb_struttura
cb_reset cb_reset
cb_salva cb_salva
cb_cancella cb_cancella
cb_annulla cb_annulla
cb_estrazione cb_estrazione
cb_ordina cb_ordina
cb_nuovo cb_nuovo
gb_buttons gb_buttons
end type
global uo_buttons uo_buttons

type variables
boolean b_enabled_nuovo, b_enabled_ricerca, b_enabled_estrazione, b_enabled_annulla, b_enabled_cancella, b_enabled_salva, b_enabled_reset, b_enabled_struttura
end variables

forward prototypes
public function integer uof_ordina ()
end prototypes

public function integer uof_ordina ();return beep(10)
end function

on uo_buttons.create
this.pb_struttura=create pb_struttura
this.cb_reset=create cb_reset
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_annulla=create cb_annulla
this.cb_estrazione=create cb_estrazione
this.cb_ordina=create cb_ordina
this.cb_nuovo=create cb_nuovo
this.gb_buttons=create gb_buttons
this.Control[]={this.pb_struttura,&
this.cb_reset,&
this.cb_salva,&
this.cb_cancella,&
this.cb_annulla,&
this.cb_estrazione,&
this.cb_ordina,&
this.cb_nuovo,&
this.gb_buttons}
end on

on uo_buttons.destroy
destroy(this.pb_struttura)
destroy(this.cb_reset)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_annulla)
destroy(this.cb_estrazione)
destroy(this.cb_ordina)
destroy(this.cb_nuovo)
destroy(this.gb_buttons)
end on

event constructor;cb_nuovo.visible= b_enabled_nuovo
cb_ordina.visible= b_enabled_ricerca
cb_estrazione.visible= b_enabled_estrazione
cb_annulla.visible= b_enabled_annulla
cb_cancella.visible= b_enabled_cancella
cb_salva.visible= b_enabled_cancella
cb_reset.visible= b_enabled_reset
pb_struttura.visible= b_enabled_struttura

end event

type pb_struttura from picturebutton within uo_buttons
integer x = 23
integer y = 48
integer width = 174
integer height = 136
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "D:\svil\Svil7\Risorse\where.bmp"
alignment htextalign = left!
end type

type cb_reset from commandbutton within uo_buttons
integer x = 3611
integer y = 60
integer width = 558
integer height = 112
integer taborder = 110
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

type cb_salva from commandbutton within uo_buttons
integer x = 3045
integer y = 60
integer width = 558
integer height = 112
integer taborder = 110
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

type cb_cancella from commandbutton within uo_buttons
integer x = 2478
integer y = 60
integer width = 558
integer height = 112
integer taborder = 110
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

type cb_annulla from commandbutton within uo_buttons
integer x = 1344
integer y = 60
integer width = 558
integer height = 112
integer taborder = 100
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

type cb_estrazione from commandbutton within uo_buttons
integer x = 777
integer y = 60
integer width = 558
integer height = 112
integer taborder = 90
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

type cb_ordina from commandbutton within uo_buttons
integer x = 210
integer y = 60
integer width = 558
integer height = 112
integer taborder = 90
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

type cb_nuovo from commandbutton within uo_buttons
integer x = 1911
integer y = 60
integer width = 558
integer height = 112
integer taborder = 80
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

type gb_buttons from groupbox within uo_buttons
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

