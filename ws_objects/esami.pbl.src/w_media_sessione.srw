$PBExportHeader$w_media_sessione.srw
forward
global type w_media_sessione from window
end type
type uodw_current from uodw_generica within w_media_sessione
end type
end forward

global type w_media_sessione from window
integer width = 2286
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
global w_media_sessione w_media_sessione

type variables
m_preview im_preview
end variables

event open;decimal ld_id

ld_id= message.doubleParm

im_preview= create m_preview

uodw_current.setTransObject(sqlca)

uodw_current.retrieve(ld_id)
end event

on w_media_sessione.create
this.uodw_current=create uodw_current
this.Control[]={this.uodw_current}
end on

on w_media_sessione.destroy
destroy(this.uodw_current)
end on

event resize;uodw_current.height= WorkSpaceHeight ( ) - 120
end event

type uodw_current from uodw_generica within w_media_sessione
integer width = 2222
integer height = 1660
integer taborder = 10
string dataobject = "dw_media_per_data"
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_current

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_media_sessione.PointerX(), w_media_sessione.PointerY() )
end event

