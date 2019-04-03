$PBExportHeader$w_lettere.srw
forward
global type w_lettere from w_centered
end type
type dw_current from datawindow within w_lettere
end type
end forward

global type w_lettere from w_centered
integer width = 4882
integer height = 2276
string menuname = "m_preview_scheda"
dw_current dw_current
end type
global w_lettere w_lettere

on w_lettere.create
int iCurrent
call super::create
if this.MenuName = "m_preview_scheda" then this.MenuID = create m_preview_scheda
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_current
end on

on w_lettere.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_current)
end on

event open;call super::open;dw_current.setTransObject(sqlca)

dw_current.retrieve("168306RM")

end event

type dw_current from datawindow within w_lettere
integer x = 37
integer y = 28
integer width = 4791
integer height = 2100
integer taborder = 10
string title = "none"
string dataobject = "dw_letterapresentazione"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

