$PBExportHeader$w_sel_utenti_web.srw
forward
global type w_sel_utenti_web from window
end type
type cb_annulla from commandbutton within w_sel_utenti_web
end type
type cb_importa from commandbutton within w_sel_utenti_web
end type
type dw_current from datawindow within w_sel_utenti_web
end type
end forward

global type w_sel_utenti_web from window
integer width = 1874
integer height = 1236
boolean titlebar = true
string title = "Selezione utenti web"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_annulla cb_annulla
cb_importa cb_importa
dw_current dw_current
end type
global w_sel_utenti_web w_sel_utenti_web

type variables
boolean ib_livsup= false
string is_nodo

s_selezione_utenti_web is_selezione_utenti_web
end variables

on w_sel_utenti_web.create
this.cb_annulla=create cb_annulla
this.cb_importa=create cb_importa
this.dw_current=create dw_current
this.Control[]={this.cb_annulla,&
this.cb_importa,&
this.dw_current}
end on

on w_sel_utenti_web.destroy
destroy(this.cb_annulla)
destroy(this.cb_importa)
destroy(this.dw_current)
end on

event open;is_selezione_utenti_web= message.powerObjectParm

dw_current.setTransObject(sqlca)
dw_current.retrieve( is_selezione_utenti_web.as_nodo, is_selezione_utenti_web.ai_livello )
end event

type cb_annulla from commandbutton within w_sel_utenti_web
integer x = 1385
integer y = 988
integer width = 343
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;s_utenti_web s_utenti_web_s

s_utenti_web_s.codice=""
s_utenti_web_s.cognome_nome= ""

closeWithReturn(parent, s_utenti_web_s )
end event

type cb_importa from commandbutton within w_sel_utenti_web
integer x = 1047
integer y = 988
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Importa"
end type

event clicked;dw_current.triggerevent(doubleClicked!)
end event

type dw_current from datawindow within w_sel_utenti_web
integer width = 1833
integer height = 956
integer taborder = 10
string title = "none"
string dataobject = "dddw_utenti_web"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;s_utenti_web s_utenti_web_s

if this.getRow() <= 0 then return 0

s_utenti_web_s.codice= this.getItemString(this.getRow(), "codice")
s_utenti_web_s.cognome_nome=  this.getItemString(this.getRow(), "cnome")

closeWithReturn(parent, s_utenti_web_s)
end event

event rowfocuschanged;f_select_current_row(this)
end event

