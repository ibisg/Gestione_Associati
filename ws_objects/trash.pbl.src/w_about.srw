$PBExportHeader$w_about.srw
forward
global type w_about from window
end type
type sle_rev from singlelineedit within w_about
end type
type sle_appl from singlelineedit within w_about
end type
type sle_capcitta from singlelineedit within w_about
end type
type sle_ind from singlelineedit within w_about
end type
type sle_ragsoc from singlelineedit within w_about
end type
type cb_ok from commandbutton within w_about
end type
end forward

global type w_about from window
integer x = 1184
integer y = 852
integer width = 1166
integer height = 836
boolean titlebar = true
string title = "Info"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
sle_rev sle_rev
sle_appl sle_appl
sle_capcitta sle_capcitta
sle_ind sle_ind
sle_ragsoc sle_ragsoc
cb_ok cb_ok
end type
global w_about w_about

on w_about.create
this.sle_rev=create sle_rev
this.sle_appl=create sle_appl
this.sle_capcitta=create sle_capcitta
this.sle_ind=create sle_ind
this.sle_ragsoc=create sle_ragsoc
this.cb_ok=create cb_ok
this.Control[]={this.sle_rev,&
this.sle_appl,&
this.sle_capcitta,&
this.sle_ind,&
this.sle_ragsoc,&
this.cb_ok}
end on

on w_about.destroy
destroy(this.sle_rev)
destroy(this.sle_appl)
destroy(this.sle_capcitta)
destroy(this.sle_ind)
destroy(this.sle_ragsoc)
destroy(this.cb_ok)
end on

event open;string appo

appo= ragione_sociale
sle_ragsoc.text= appo

appo= indirizzo
sle_ind.text= appo

appo= cap_citta
sle_capcitta.text= appo

appo= nome_applicazione
sle_appl.text= appo

end event

type sle_rev from singlelineedit within w_about
integer x = 91
integer y = 456
integer width = 1047
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Revisione"
boolean border = false
boolean autohscroll = false
end type

type sle_appl from singlelineedit within w_about
integer x = 91
integer y = 348
integer width = 1047
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Nome Applicazione"
boolean border = false
boolean autohscroll = false
end type

type sle_capcitta from singlelineedit within w_about
integer x = 91
integer y = 240
integer width = 1047
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "CapCitta"
boolean border = false
boolean autohscroll = false
end type

type sle_ind from singlelineedit within w_about
integer x = 87
integer y = 132
integer width = 1047
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Indirizzo"
boolean border = false
boolean autohscroll = false
end type

type sle_ragsoc from singlelineedit within w_about
integer x = 91
integer y = 24
integer width = 1047
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Ragione Sociale"
boolean border = false
boolean autohscroll = false
end type

type cb_ok from commandbutton within w_about
integer x = 430
integer y = 608
integer width = 279
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Chiudi"
boolean cancel = true
boolean default = true
end type

event clicked;Close (Parent)
end event

