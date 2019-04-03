$PBExportHeader$w_diplomi.srw
forward
global type w_diplomi from w_centered
end type
type uodw_diplomi from uodw_generica within w_diplomi
end type
end forward

global type w_diplomi from w_centered
integer width = 4439
integer height = 2440
string title = "Diplomi"
boolean minbox = false
boolean maxbox = false
windowtype windowtype = popup!
long backcolor = 81324524
string icon = "Query5!"
boolean toolbarvisible = false
boolean clientedge = true
uodw_diplomi uodw_diplomi
end type
global w_diplomi w_diplomi

type variables
m_preview im_preview
end variables

event resize;call super::resize;w_frame_template w_parent

w_parent= this.parentWindow()

this.height= w_parent.WorkSpaceHeight() - 240
uodw_diplomi.height= this.height - 240
uodw_diplomi.width= this.width - 120

if ib_centered then wf_center()

end event

event open;call super::open;im_preview= create m_preview
end event

on w_diplomi.create
int iCurrent
call super::create
this.uodw_diplomi=create uodw_diplomi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uodw_diplomi
end on

on w_diplomi.destroy
call super::destroy
destroy(this.uodw_diplomi)
end on

type uodw_diplomi from uodw_generica within w_diplomi
integer taborder = 10
string dataobject = "dw_diplomi"
string icon = "Query5!"
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_diplomi

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false
//im_preview.m_layoutdistampa.enabled= true

im_preview.PopMenu ( w_diplomi.PointerX(), w_diplomi.PointerY() )
end event

