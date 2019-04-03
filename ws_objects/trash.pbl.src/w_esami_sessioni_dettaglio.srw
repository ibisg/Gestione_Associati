$PBExportHeader$w_esami_sessioni_dettaglio.srw
forward
global type w_esami_sessioni_dettaglio from window
end type
type cb_chiudi from commandbutton within w_esami_sessioni_dettaglio
end type
type uodw_dettaglio from uodw_generica within w_esami_sessioni_dettaglio
end type
end forward

global type w_esami_sessioni_dettaglio from window
integer width = 2848
integer height = 1868
boolean titlebar = true
string title = "Dettaglio della sessione"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
cb_chiudi cb_chiudi
uodw_dettaglio uodw_dettaglio
end type
global w_esami_sessioni_dettaglio w_esami_sessioni_dettaglio

type variables
m_preview im_preview
end variables

on w_esami_sessioni_dettaglio.create
this.cb_chiudi=create cb_chiudi
this.uodw_dettaglio=create uodw_dettaglio
this.Control[]={this.cb_chiudi,&
this.uodw_dettaglio}
end on

on w_esami_sessioni_dettaglio.destroy
destroy(this.cb_chiudi)
destroy(this.uodw_dettaglio)
end on

event open;decimal ld_id

ld_id= message.doubleParm

im_preview= create m_preview

uodw_dettaglio.setTransObject(sqlca)

uodw_dettaglio.retrieve(ld_id)
end event

type cb_chiudi from commandbutton within w_esami_sessioni_dettaglio
integer x = 1234
integer y = 1640
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

type uodw_dettaglio from uodw_generica within w_esami_sessioni_dettaglio
integer width = 2811
integer height = 1612
integer taborder = 10
string dataobject = "dw_esami_sessioni_dettaglio"
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_dettaglio

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false

im_preview.PopMenu ( w_esami_sessioni_dettaglio.PointerX(), w_esami_sessioni_dettaglio.PointerY() )
end event

