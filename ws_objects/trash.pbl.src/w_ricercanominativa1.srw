$PBExportHeader$w_ricercanominativa1.srw
forward
global type w_ricercanominativa1 from w_centered
end type
type dw_current from datawindow within w_ricercanominativa1
end type
end forward

global type w_ricercanominativa1 from w_centered
integer width = 3392
integer height = 1876
dw_current dw_current
end type
global w_ricercanominativa1 w_ricercanominativa1

on w_ricercanominativa1.create
int iCurrent
call super::create
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_current
end on

on w_ricercanominativa1.destroy
call super::destroy
destroy(this.dw_current)
end on

type dw_current from datawindow within w_ricercanominativa1
integer width = 571
integer height = 600
integer taborder = 10
string title = "none"
string dataobject = "dw_ricercanominativa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

