$PBExportHeader$w_mostrastruttura.srw
forward
global type w_mostrastruttura from window
end type
type dw_current from datawindow within w_mostrastruttura
end type
end forward

global type w_mostrastruttura from window
integer width = 3726
integer height = 1788
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_current dw_current
end type
global w_mostrastruttura w_mostrastruttura

on w_mostrastruttura.create
this.dw_current=create dw_current
this.Control[]={this.dw_current}
end on

on w_mostrastruttura.destroy
destroy(this.dw_current)
end on

event open;dw_current.setTransObject(sqlca)
dw_current.retrieve()
end event

type dw_current from datawindow within w_mostrastruttura
integer x = 27
integer y = 24
integer width = 3639
integer height = 1520
integer taborder = 10
string title = "none"
string dataobject = "dw_gerarchica"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;s_struttura s_struttura_s[]
integer li_ret
string ls_struttura
li_ret= f_cercastruttura_bw(dw_current.getItemNumber(row, "livello"), dw_current.getItemNumber(row, "nodo"), s_struttura_s[] )

messageBox("Struttura", ls_struttura, information!)
end event

