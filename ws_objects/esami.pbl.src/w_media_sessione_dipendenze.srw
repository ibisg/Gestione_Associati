$PBExportHeader$w_media_sessione_dipendenze.srw
forward
global type w_media_sessione_dipendenze from window
end type
type uodw_current from uodw_generica within w_media_sessione_dipendenze
end type
end forward

global type w_media_sessione_dipendenze from window
integer width = 3419
integer height = 1984
boolean titlebar = true
string title = "Media sessione"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = child!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
uodw_current uodw_current
end type
global w_media_sessione_dipendenze w_media_sessione_dipendenze

type variables
m_preview im_preview
end variables

event open;decimal ld_id

ld_id= message.doubleParm

im_preview= create m_preview

uodw_current.setTransObject(sqlca)

uodw_current.retrieve(ld_id)
end event

on w_media_sessione_dipendenze.create
this.uodw_current=create uodw_current
this.Control[]={this.uodw_current}
end on

on w_media_sessione_dipendenze.destroy
destroy(this.uodw_current)
end on

event resize;uodw_current.height= WorkSpaceHeight ( ) - 120
end event

type uodw_current from uodw_generica within w_media_sessione_dipendenze
integer width = 3346
integer height = 1660
integer taborder = 10
string dataobject = "dw_media"
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_current

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_media_sessione_dipendenze.PointerX(), w_media_sessione_dipendenze.PointerY() )
end event

