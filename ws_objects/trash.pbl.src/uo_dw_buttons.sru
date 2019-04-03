$PBExportHeader$uo_dw_buttons.sru
forward
global type uo_dw_buttons from userobject
end type
type uo_1 from uo_buttons within uo_dw_buttons
end type
type dw_current from datawindow within uo_dw_buttons
end type
end forward

global type uo_dw_buttons from userobject
integer width = 3273
integer height = 1396
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
string picturename = "Search!"
long picturemaskcolor = 536870912
uo_1 uo_1
dw_current dw_current
end type
global uo_dw_buttons uo_dw_buttons

on uo_dw_buttons.create
this.uo_1=create uo_1
this.dw_current=create dw_current
this.Control[]={this.uo_1,&
this.dw_current}
end on

on uo_dw_buttons.destroy
destroy(this.uo_1)
destroy(this.dw_current)
end on

type uo_1 from uo_buttons within uo_dw_buttons
integer y = 1044
integer taborder = 80
boolean b_enabled_ricerca = true
boolean b_enabled_estrazione = true
boolean b_enabled_annulla = true
boolean b_enabled_reset = true
end type

on uo_1.destroy
call uo_buttons::destroy
end on

type dw_current from datawindow within uo_dw_buttons
integer width = 3141
integer height = 1016
integer taborder = 10
string dataobject = "dw_ricerca_associati"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event resize;//dw_current.height= this.height - 450
//
//dw_current.width= this.width - 20

uo_buttons.y= dw_current.height
uo_buttons.x= dw_current.width - uo_buttons.width
end event

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, false)

SetSqlPreview ( sqlsyntax)
end event

