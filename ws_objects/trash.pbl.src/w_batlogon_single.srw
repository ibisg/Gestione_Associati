$PBExportHeader$w_batlogon_single.srw
forward
global type w_batlogon_single from window
end type
type cb_ok from commandbutton within w_batlogon_single
end type
type cb_cambia_pw from commandbutton within w_batlogon_single
end type
type cb_annulla from commandbutton within w_batlogon_single
end type
type sle_connessione from singlelineedit within w_batlogon_single
end type
type st_2 from statictext within w_batlogon_single
end type
type st_1 from statictext within w_batlogon_single
end type
type cb_connessione from commandbutton within w_batlogon_single
end type
type sle_password from singlelineedit within w_batlogon_single
end type
type sle_username from singlelineedit within w_batlogon_single
end type
end forward

global type w_batlogon_single from window
integer x = 997
integer y = 400
integer width = 1627
integer height = 772
boolean titlebar = true
string title = "Login"
windowtype windowtype = response!
long backcolor = 134217748
cb_ok cb_ok
cb_cambia_pw cb_cambia_pw
cb_annulla cb_annulla
sle_connessione sle_connessione
st_2 st_2
st_1 st_1
cb_connessione cb_connessione
sle_password sle_password
sle_username sle_username
end type
global w_batlogon_single w_batlogon_single

on w_batlogon_single.create
this.cb_ok=create cb_ok
this.cb_cambia_pw=create cb_cambia_pw
this.cb_annulla=create cb_annulla
this.sle_connessione=create sle_connessione
this.st_2=create st_2
this.st_1=create st_1
this.cb_connessione=create cb_connessione
this.sle_password=create sle_password
this.sle_username=create sle_username
this.Control[]={this.cb_ok,&
this.cb_cambia_pw,&
this.cb_annulla,&
this.sle_connessione,&
this.st_2,&
this.st_1,&
this.cb_connessione,&
this.sle_password,&
this.sle_username}
end on

on w_batlogon_single.destroy
destroy(this.cb_ok)
destroy(this.cb_cambia_pw)
destroy(this.cb_annulla)
destroy(this.sle_connessione)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_connessione)
destroy(this.sle_password)
destroy(this.sle_username)
end on

type cb_ok from commandbutton within w_batlogon_single
event clicked pbm_bnclicked
integer x = 1147
integer y = 176
integer width = 357
integer height = 88
integer taborder = 41
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Ok"
end type

type cb_cambia_pw from commandbutton within w_batlogon_single
event clicked pbm_bnclicked
integer x = 1147
integer y = 400
integer width = 357
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Cambia pw"
end type

type cb_annulla from commandbutton within w_batlogon_single
integer x = 1147
integer y = 288
integer width = 357
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
boolean cancel = true
end type

type sle_connessione from singlelineedit within w_batlogon_single
integer x = 32
integer y = 540
integer width = 1545
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217742
boolean autohscroll = false
end type

type st_2 from statictext within w_batlogon_single
integer x = 96
integer y = 296
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217742
boolean enabled = false
string text = "Password:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_batlogon_single
integer x = 96
integer y = 72
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217742
boolean enabled = false
string text = "Nome utente:"
boolean focusrectangle = false
end type

type cb_connessione from commandbutton within w_batlogon_single
event type integer ue_connection_default ( )
integer x = 1147
integer y = 64
integer width = 357
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Co&nnessione"
boolean default = true
end type

type sle_password from singlelineedit within w_batlogon_single
integer x = 567
integer y = 284
integer width = 480
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
textcase textcase = lower!
integer limit = 30
borderstyle borderstyle = stylelowered!
end type

type sle_username from singlelineedit within w_batlogon_single
integer x = 567
integer y = 60
integer width = 480
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = lower!
integer limit = 30
borderstyle borderstyle = stylelowered!
end type

