$PBExportHeader$w_soglia.srw
forward
global type w_soglia from window
end type
type dw_1 from datawindow within w_soglia
end type
end forward

global type w_soglia from window
integer width = 3168
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_1 dw_1
end type
global w_soglia w_soglia

on w_soglia.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_soglia.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_soglia
integer x = 114
integer y = 144
integer width = 2126
integer height = 600
integer taborder = 10
string title = "none"
string dataobject = "d_s_sessione"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

