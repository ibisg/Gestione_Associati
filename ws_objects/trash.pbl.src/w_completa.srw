$PBExportHeader$w_completa.srw
forward
global type w_completa from w_centered
end type
type uodw_current from uodw_generica within w_completa
end type
end forward

global type w_completa from w_centered
integer width = 5353
integer height = 3512
string title = "Report membri completo"
string menuname = "m_stampa_completa"
windowtype windowtype = popup!
long backcolor = 81324524
string icon = "Query5!"
boolean clientedge = true
event type integer ue_stampa ( )
uodw_current uodw_current
end type
global w_completa w_completa

event type integer ue_stampa();	return OpenWithParm ( w_dw_print_options, this.uodw_current )
end event

on w_completa.create
int iCurrent
call super::create
if this.MenuName = "m_stampa_completa" then this.MenuID = create m_stampa_completa
this.uodw_current=create uodw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uodw_current
end on

on w_completa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uodw_current)
end on

event open;call super::open;string ls_struttura

ls_struttura= message.stringParm

uodw_current.Object.DataWindow.Print.Preview= "yes"

uodw_current.setTransObject(sqlca)

uodw_current.retrieve(ls_struttura)
end event

event resize;call super::resize;uodw_current.width= this.width - 120
uodw_current.height= this.height - 180
end event

type uodw_current from uodw_generica within w_completa
integer x = 27
integer y = 12
integer taborder = 10
string dataobject = "dw_completa"
end type

