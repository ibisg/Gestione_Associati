$PBExportHeader$w_info_dim_fs.srw
forward
global type w_info_dim_fs from window
end type
type uodw_current from uodw_generica within w_info_dim_fs
end type
end forward

global type w_info_dim_fs from window
integer width = 2309
integer height = 2064
boolean titlebar = true
string title = "Offerte"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
uodw_current uodw_current
end type
global w_info_dim_fs w_info_dim_fs

type variables
m_preview im_preview
end variables

on w_info_dim_fs.create
this.uodw_current=create uodw_current
this.Control[]={this.uodw_current}
end on

on w_info_dim_fs.destroy
destroy(this.uodw_current)
end on

event open;s_riferimenti s_riferimenti_s

s_riferimenti_s= message.powerObjectParm

im_preview= create m_preview

if s_riferimenti_s.status= 'DIM' OR s_riferimenti_s.status= 'NOP' then

	uodw_current.dataObject= 'dw_info_dim'

else
	
	uodw_current.dataObject= 'dw_info_fs'

end if

uodw_current.setTransObject(sqlca)

uodw_current.retrieve(s_riferimenti_s.codice)
end event

type uodw_current from uodw_generica within w_info_dim_fs
integer width = 2267
integer height = 1960
integer taborder = 10
string dataobject = "dw_info_dim"
boolean hscrollbar = false
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_current

	im_preview.m_aggiungi.visible= false
	im_preview.m_inserisci.visible= false
	im_preview.m_rimuovi.visible= false
	im_preview.m_salva.visible= false
	
im_preview.PopMenu ( w_info_dim_fs.PointerX(), w_info_dim_fs.PointerY() )
end event

