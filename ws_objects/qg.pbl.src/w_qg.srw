$PBExportHeader$w_qg.srw
forward
global type w_qg from window
end type
type dw_current from datawindow within w_qg
end type
end forward

global type w_qg from window
integer width = 3168
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_current dw_current
end type
global w_qg w_qg

event resize;dw_current.height= this.height - 120
dw_current.width= this.width - 120
end event

on w_qg.create
this.dw_current=create dw_current
this.Control[]={this.dw_current}
end on

on w_qg.destroy
destroy(this.dw_current)
end on

type dw_current from datawindow within w_qg
integer x = 9
integer y = 8
integer width = 3017
integer height = 1156
integer taborder = 10
string title = "none"
string dataobject = "dw_qg_struttura"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

