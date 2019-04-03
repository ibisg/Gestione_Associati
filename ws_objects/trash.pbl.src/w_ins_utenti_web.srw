$PBExportHeader$w_ins_utenti_web.srw
forward
global type w_ins_utenti_web from window
end type
type cb_annulla from commandbutton within w_ins_utenti_web
end type
type uodw_current from uodw_generica within w_ins_utenti_web
end type
end forward

global type w_ins_utenti_web from window
integer width = 1157
integer height = 1376
boolean titlebar = true
string title = "Assegnazione utenza web"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_annulla cb_annulla
uodw_current uodw_current
end type
global w_ins_utenti_web w_ins_utenti_web

type variables
string is_nodo
s_selezione_utenti_web is_selezione_utenti_web
end variables

event open;is_selezione_utenti_web= message.powerObjectParm

uodw_current.setTransObject(sqlca)
uodw_current.retrieve(is_selezione_utenti_web.as_nodo)
end event

on w_ins_utenti_web.create
this.cb_annulla=create cb_annulla
this.uodw_current=create uodw_current
this.Control[]={this.cb_annulla,&
this.uodw_current}
end on

on w_ins_utenti_web.destroy
destroy(this.cb_annulla)
destroy(this.uodw_current)
end on

type cb_annulla from commandbutton within w_ins_utenti_web
integer x = 777
integer y = 1156
integer width = 343
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;	closeWithReturn(parent, 0)
end event

type uodw_current from uodw_generica within w_ins_utenti_web
integer width = 1120
integer height = 1108
integer taborder = 30
string dataobject = "dw_ins_utenti_web"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;if dwo.name= "b_p" then
	
	openWithParm(w_sel_utenti_web, is_selezione_utenti_web)
	
	string ls_codice
	s_utenti_web s_utenti_web_s
	
	s_utenti_web_s= message.powerObjectParm
	
	if s_utenti_web_s.codice= "" then return -1
	
	this.setItem(this.getRow(), "codice", s_utenti_web_s.codice)
	this.setItem(this.getRow(), "vc_nodo", is_selezione_utenti_web.as_nodo)
	this.setItem(this.getRow(), "cognome_nome", s_utenti_web_s.cognome_nome)
	
end if

if dwo.name= "b_aggiorna" or dwo.name= "b_m" then
	
	closeWithReturn(parent, 1)
	
end if


	
	
end event

event itemchanged;call super::itemchanged;if dwo.name= "password" then
	
	this.setItem(row, "dt_pwchange", today())
	
end if
end event

