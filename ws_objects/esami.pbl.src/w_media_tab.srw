$PBExportHeader$w_media_tab.srw
forward
global type w_media_tab from window
end type
type cb_1 from commandbutton within w_media_tab
end type
type uodw_current from uodw_generica within w_media_tab
end type
end forward

global type w_media_tab from window
integer width = 2377
integer height = 1600
boolean titlebar = true
string title = "Calcolo del voto medio"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Asterisk!"
boolean clientedge = true
boolean center = true
cb_1 cb_1
uodw_current uodw_current
end type
global w_media_tab w_media_tab

type variables
m_preview im_preview
end variables

event open;decimal ld_id

ld_id= message.doubleParm

im_preview= create m_preview

uodw_current.setTransObject(sqlca)

uodw_current.retrieve(ld_id)
end event

on w_media_tab.create
this.cb_1=create cb_1
this.uodw_current=create uodw_current
this.Control[]={this.cb_1,&
this.uodw_current}
end on

on w_media_tab.destroy
destroy(this.cb_1)
destroy(this.uodw_current)
end on

type cb_1 from commandbutton within w_media_tab
integer x = 878
integer y = 1336
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type uodw_current from uodw_generica within w_media_tab
integer width = 2309
integer taborder = 10
string dataobject = "dw_media"
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_current

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_media_tab.PointerX(), w_media_tab.PointerY() )
end event

