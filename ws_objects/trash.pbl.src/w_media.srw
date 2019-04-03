$PBExportHeader$w_media.srw
forward
global type w_media from window
end type
type tab_soglia from tab within w_media
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
type tabpage_media from userobject within tab_soglia
end type
type cb_stampa from commandbutton within tabpage_media
end type
type dw_media from datawindow within tabpage_media
end type
type cb_end from commandbutton within tabpage_media
end type
type cb_last from commandbutton within tabpage_media
end type
type tabpage_media from userobject within tab_soglia
cb_stampa cb_stampa
dw_media dw_media
cb_end cb_end
cb_last cb_last
end type
type tab_soglia from tab within w_media
tabpage_sessione tabpage_sessione
tabpage_media tabpage_media
end type
end forward

global type w_media from window
integer width = 2990
integer height = 2988
boolean titlebar = true
string title = "Inserimento volo minimo"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
tab_soglia tab_soglia
end type
global w_media w_media

type variables
datetime idt_data
string is_livello
end variables

on w_media.create
this.tab_soglia=create tab_soglia
this.Control[]={this.tab_soglia}
end on

on w_media.destroy
destroy(this.tab_soglia)
end on

event open;f_centra(w_media)

tab_soglia.tabpage_sessione.dw_current.setRowFocusIndicator(focusRect!)

tab_soglia.tabpage_sessione.dw_current.setTransObject(sqlca)

tab_soglia.tabpage_media.dw_media.setTransObject(sqlca)

tab_soglia.tabpage_media.enabled= false

end event

type tab_soglia from tab within w_media
integer width = 2935
integer height = 2800
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
tabpage_media tabpage_media
end type

on tab_soglia.create
this.tabpage_sessione=create tabpage_sessione
this.tabpage_media=create tabpage_media
this.Control[]={this.tabpage_sessione,&
this.tabpage_media}
end on

on tab_soglia.destroy
destroy(this.tabpage_sessione)
destroy(this.tabpage_media)
end on

event selectionchanged;if newindex= 1 then
	tab_soglia.tabpage_sessione.dw_current.retrieve()
else
	tab_soglia.tabpage_media.dw_media.retrieve(idt_data, is_livello)
end if

end event

type tabpage_sessione from userobject within tab_soglia
integer x = 18
integer y = 100
integer width = 2898
integer height = 2684
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
integer y = 1656
integer width = 713
integer height = 72
integer textsize = -12
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
integer y = 1752
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
integer y = 1752
integer width = 1143
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
integer y = 1916
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

event clicked;close(w_media)
end event

type cb_next from commandbutton within tabpage_sessione
integer x = 1115
integer y = 1916
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

event clicked;tab_soglia.selectTab(tab_soglia.tabpage_media)
end event

type st_sessione from statictext within tabpage_sessione
integer y = 28
integer width = 1682
integer height = 88
integer textsize = -12
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
integer width = 1870
integer height = 1536
integer taborder = 10
string title = "none"
string dataobject = "dw_estrai_sessioni"
boolean vscrollbar = true
boolean livescroll = true
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

tab_soglia.tabpage_media.enabled= true

em_data.text= string(idt_data, "dd.mm.yyyy")

sle_livello.text= mid(is_livello, 2, 1)+"° Livello"
end event

type tabpage_media from userobject within tab_soglia
integer x = 18
integer y = 100
integer width = 2898
integer height = 2684
boolean enabled = false
long backcolor = 67108864
string text = "2 - Media"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_stampa cb_stampa
dw_media dw_media
cb_end cb_end
cb_last cb_last
end type

on tabpage_media.create
this.cb_stampa=create cb_stampa
this.dw_media=create dw_media
this.cb_end=create cb_end
this.cb_last=create cb_last
this.Control[]={this.cb_stampa,&
this.dw_media,&
this.cb_end,&
this.cb_last}
end on

on tabpage_media.destroy
destroy(this.cb_stampa)
destroy(this.dw_media)
destroy(this.cb_end)
destroy(this.cb_last)
end on

type cb_stampa from commandbutton within tabpage_media
integer x = 1742
integer y = 2504
integer width = 571
integer height = 168
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;close(w_media)
end event

type dw_media from datawindow within tabpage_media
integer x = 5
integer y = 8
integer width = 2894
integer height = 2464
integer taborder = 30
string title = "none"
string dataobject = "dw_media"
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;//dw_media.Object.t_nodo.Text= str_ini.v_nodo
end event

type cb_end from commandbutton within tabpage_media
integer x = 2322
integer y = 2504
integer width = 571
integer height = 168
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi >>"
end type

event clicked;close(w_media)
end event

type cb_last from commandbutton within tabpage_media
integer x = 1161
integer y = 2504
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

