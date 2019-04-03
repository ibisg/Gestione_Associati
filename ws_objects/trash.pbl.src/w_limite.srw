﻿$PBExportHeader$w_limite.srw
forward
global type w_limite from window
end type
type tab_soglia from tab within w_limite
end type
type tabpage_sessione from userobject within tab_soglia
end type
type st_1 from statictext within tabpage_sessione
end type
type em_data from editmask within tabpage_sessione
end type
type sle_livello from singlelineedit within tabpage_sessione
end type
type cb_annulla from commandbutton within tabpage_sessione
end type
type cb_next from commandbutton within tabpage_sessione
end type
type st_sessione from statictext within tabpage_sessione
end type
type dw_current from datawindow within tabpage_sessione
end type
type tabpage_sessione from userobject within tab_soglia
st_1 st_1
em_data em_data
sle_livello sle_livello
cb_annulla cb_annulla
cb_next cb_next
st_sessione st_sessione
dw_current dw_current
end type
type tabpage_voto from userobject within tab_soglia
end type
type cb_end from commandbutton within tabpage_voto
end type
type cb_last from commandbutton within tabpage_voto
end type
type st_voto from statictext within tabpage_voto
end type
type em_soglia from editmask within tabpage_voto
end type
type tabpage_voto from userobject within tab_soglia
cb_end cb_end
cb_last cb_last
st_voto st_voto
em_soglia em_soglia
end type
type tab_soglia from tab within w_limite
tabpage_sessione tabpage_sessione
tabpage_voto tabpage_voto
end type
end forward

global type w_limite from window
integer width = 1815
integer height = 1784
boolean titlebar = true
string title = "Inserimento volo minimo"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
tab_soglia tab_soglia
end type
global w_limite w_limite

type variables
datetime idt_data
string is_livello
end variables

on w_limite.create
this.tab_soglia=create tab_soglia
this.Control[]={this.tab_soglia}
end on

on w_limite.destroy
destroy(this.tab_soglia)
end on

event open;f_centra(w_limite)

tab_soglia.tabpage_sessione.dw_current.setRowFocusIndicator(focusRect!)

tab_soglia.tabpage_sessione.dw_current.setTransObject(sqlca)

tab_soglia.tabpage_voto.enabled= false

end event

type tab_soglia from tab within w_limite
integer width = 1746
integer height = 1624
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_sessione tabpage_sessione
tabpage_voto tabpage_voto
end type

on tab_soglia.create
this.tabpage_sessione=create tabpage_sessione
this.tabpage_voto=create tabpage_voto
this.Control[]={this.tabpage_sessione,&
this.tabpage_voto}
end on

on tab_soglia.destroy
destroy(this.tabpage_sessione)
destroy(this.tabpage_voto)
end on

event selectionchanged;if newindex= 1 then
	tab_soglia.tabpage_sessione.dw_current.retrieve()
else
	tab_soglia.tabpage_voto.em_soglia.selecttext(1, 3/*len(tab_soglia.tabpage_voto.em_soglia.text) */) 
end if
end event

type tabpage_sessione from userobject within tab_soglia
integer x = 18
integer y = 100
integer width = 1710
integer height = 1508
long backcolor = 67108864
string text = "1 - Sessione"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
em_data em_data
sle_livello sle_livello
cb_annulla cb_annulla
cb_next cb_next
st_sessione st_sessione
dw_current dw_current
end type

on tabpage_sessione.create
this.st_1=create st_1
this.em_data=create em_data
this.sle_livello=create sle_livello
this.cb_annulla=create cb_annulla
this.cb_next=create cb_next
this.st_sessione=create st_sessione
this.dw_current=create dw_current
this.Control[]={this.st_1,&
this.em_data,&
this.sle_livello,&
this.cb_annulla,&
this.cb_next,&
this.st_sessione,&
this.dw_current}
end on

on tabpage_sessione.destroy
destroy(this.st_1)
destroy(this.em_data)
destroy(this.sle_livello)
destroy(this.cb_annulla)
destroy(this.cb_next)
destroy(this.st_sessione)
destroy(this.dw_current)
end on

type st_1 from statictext within tabpage_sessione
integer y = 980
integer width = 713
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sessione selezionata:"
boolean focusrectangle = false
end type

type em_data from editmask within tabpage_sessione
integer x = 14
integer y = 1076
integer width = 512
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd.mm.yyyy"
end type

type sle_livello from singlelineedit within tabpage_sessione
integer x = 549
integer y = 1076
integer width = 1019
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
end type

type cb_annulla from commandbutton within tabpage_sessione
integer x = 539
integer y = 1240
integer width = 571
integer height = 168
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;s_soglia s_soglia_s

s_soglia_s.soglia= 0

closeWithReturn(w_limite, s_soglia_s)
end event

type cb_next from commandbutton within tabpage_sessione
integer x = 1115
integer y = 1240
integer width = 571
integer height = 168
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Avanti >>"
end type

event clicked;tab_soglia.selectTab(tab_soglia.tabpage_voto)
end event

type st_sessione from statictext within tabpage_sessione
integer y = 28
integer width = 1682
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selezionare con doppio click una sessione di esame"
boolean focusrectangle = false
end type

type dw_current from datawindow within tabpage_sessione
integer y = 120
integer width = 1815
integer height = 824
integer taborder = 10
string title = "none"
string dataobject = "dw_estrai_sessioni"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;//if this.getRow() <= 0 then return 0
//
////f_select_current_row(this)
//
//idt_data= 	this.getItemDateTime( this.getRow() , "data_esame")
//is_livello= 	this.getItemString( this.getRow() , "cod_studio")
//
//cb_next.enabled= true
//
//tab_soglia.tabpage_voto.enabled= true

end event

event doubleclicked;if this.getRow() <= 0 then return 0

//f_select_current_row(this)

idt_data= 	this.getItemDateTime( this.getRow() , "data_esame")
is_livello= 	this.getItemString( this.getRow() , "cod_studio")

cb_next.enabled= true

tab_soglia.tabpage_voto.enabled= true

em_data.text= string(idt_data, "dd.mm.yyyy")

sle_livello.text= mid(is_livello, 2, 1)+"° Livello"
end event

type tabpage_voto from userobject within tab_soglia
integer x = 18
integer y = 100
integer width = 1710
integer height = 1508
boolean enabled = false
long backcolor = 67108864
string text = "2 - Voto"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_end cb_end
cb_last cb_last
st_voto st_voto
em_soglia em_soglia
end type

on tabpage_voto.create
this.cb_end=create cb_end
this.cb_last=create cb_last
this.st_voto=create st_voto
this.em_soglia=create em_soglia
this.Control[]={this.cb_end,&
this.cb_last,&
this.st_voto,&
this.em_soglia}
end on

on tabpage_voto.destroy
destroy(this.cb_end)
destroy(this.cb_last)
destroy(this.st_voto)
destroy(this.em_soglia)
end on

type cb_end from commandbutton within tabpage_voto
integer x = 1134
integer y = 1240
integer width = 571
integer height = 168
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Finisci >>"
end type

event clicked;s_soglia s_soglia_s

s_soglia_s.soglia= integer(em_soglia.text)

s_soglia_s.data= idt_data
s_soglia_s.livello= is_livello


closeWithReturn(w_limite, s_soglia_s)
end event

type cb_last from commandbutton within tabpage_voto
integer x = 562
integer y = 1240
integer width = 571
integer height = 168
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "<< Indietro"
end type

event clicked;tab_soglia.selectTab(tab_soglia.tabpage_sessione)
end event

type st_voto from statictext within tabpage_voto
integer x = 64
integer y = 460
integer width = 1609
integer height = 96
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inserire il voto minimo per la promozione"
boolean focusrectangle = false
end type

type em_soglia from editmask within tabpage_voto
integer x = 507
integer y = 620
integer width = 645
integer height = 284
integer taborder = 20
integer textsize = -36
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
boolean spin = true
double increment = 1
string minmax = "1~~100"
end type

event modified;if integer(this.text) < 0 or integer(this.text) > 100 then
		messageBox(parent.text, "Votazione al di fuori dei limiti ( 0 - 100 )", information!)
		return 
	end if

if this.text= '0' then
	cb_end.enabled= false
else
	cb_end.enabled= true	
end if
end event

