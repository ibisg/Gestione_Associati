$PBExportHeader$w_modifica_struttura.srw
forward
global type w_modifica_struttura from w_centered
end type
type cb_2 from commandbutton within w_modifica_struttura
end type
type cb_1 from commandbutton within w_modifica_struttura
end type
type st_4 from statictext within w_modifica_struttura
end type
type st_3 from statictext within w_modifica_struttura
end type
type st_2 from statictext within w_modifica_struttura
end type
type st_1 from statictext within w_modifica_struttura
end type
type em_nuova_descrizione from editmask within w_modifica_struttura
end type
type em_vecchia_descrizione from editmask within w_modifica_struttura
end type
type em_nuovo_codice from editmask within w_modifica_struttura
end type
type em_vecchio_codice from editmask within w_modifica_struttura
end type
end forward

global type w_modifica_struttura from w_centered
integer width = 1472
integer height = 1032
string title = "Modifica struttura"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean clientedge = true
cb_2 cb_2
cb_1 cb_1
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
em_nuova_descrizione em_nuova_descrizione
em_vecchia_descrizione em_vecchia_descrizione
em_nuovo_codice em_nuovo_codice
em_vecchio_codice em_vecchio_codice
end type
global w_modifica_struttura w_modifica_struttura

type variables
s_struttura is_struttura_s
end variables

on w_modifica_struttura.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.em_nuova_descrizione=create em_nuova_descrizione
this.em_vecchia_descrizione=create em_vecchia_descrizione
this.em_nuovo_codice=create em_nuovo_codice
this.em_vecchio_codice=create em_vecchio_codice
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_nuova_descrizione
this.Control[iCurrent+8]=this.em_vecchia_descrizione
this.Control[iCurrent+9]=this.em_nuovo_codice
this.Control[iCurrent+10]=this.em_vecchio_codice
end on

on w_modifica_struttura.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_nuova_descrizione)
destroy(this.em_vecchia_descrizione)
destroy(this.em_nuovo_codice)
destroy(this.em_vecchio_codice)
end on

event open;call super::open;is_struttura_s= message.powerObjectParm

this.title= "Modifica "+is_struttura_s.descrizione_livello

em_vecchio_codice.text= is_struttura_s.codice
em_vecchia_descrizione.text= is_struttura_s.descrizione_struttura
end event

type cb_2 from commandbutton within w_modifica_struttura
integer x = 978
integer y = 700
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;is_struttura_s.handle= -1
closeWithReturn(parent, is_struttura_s)
end event

type cb_1 from commandbutton within w_modifica_struttura
integer x = 978
integer y = 572
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna"
end type

type st_4 from statictext within w_modifica_struttura
integer x = 498
integer y = 332
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Nuova descrizione"
boolean focusrectangle = false
end type

type st_3 from statictext within w_modifica_struttura
integer x = 498
integer y = 100
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Vecchia descrizione"
boolean focusrectangle = false
end type

type st_2 from statictext within w_modifica_struttura
integer x = 78
integer y = 332
integer width = 421
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Nuovo codice"
boolean focusrectangle = false
end type

type st_1 from statictext within w_modifica_struttura
integer x = 78
integer y = 100
integer width = 421
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Vecchio codice"
boolean focusrectangle = false
end type

type em_nuova_descrizione from editmask within w_modifica_struttura
integer x = 498
integer y = 396
integer width = 882
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
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "#"
boolean autoskip = true
end type

type em_vecchia_descrizione from editmask within w_modifica_struttura
integer x = 498
integer y = 168
integer width = 882
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "none"
boolean displayonly = true
maskdatatype maskdatatype = stringmask!
string mask = "#"
boolean autoskip = true
end type

type em_nuovo_codice from editmask within w_modifica_struttura
integer x = 78
integer y = 396
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "#"
boolean autoskip = true
end type

type em_vecchio_codice from editmask within w_modifica_struttura
integer x = 78
integer y = 168
integer width = 402
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "none"
boolean displayonly = true
maskdatatype maskdatatype = stringmask!
string mask = "#"
boolean autoskip = true
end type

