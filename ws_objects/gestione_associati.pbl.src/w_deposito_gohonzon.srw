$PBExportHeader$w_deposito_gohonzon.srw
forward
global type w_deposito_gohonzon from window
end type
type dw_deposito from datawindow within w_deposito_gohonzon
end type
end forward

global type w_deposito_gohonzon from window
integer width = 5157
integer height = 1864
boolean titlebar = true
string title = "Deposito Gohonzon"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 8421376
string icon = "Report5!"
boolean clientedge = true
boolean center = true
event ue_open ( )
dw_deposito dw_deposito
end type
global w_deposito_gohonzon w_deposito_gohonzon

event ue_open();dw_deposito.setTransObject(sqlca)
//this.setRedraw(false)
dw_deposito.retrieve()
this.setRedraw(true)


end event

event resize;this.setRedraw(false)
	dw_deposito.height= this.height - 120
	dw_deposito.x= this.width/2 -dw_deposito.width/2
//this.setRedraw(true)

event post ue_open()
end event

on w_deposito_gohonzon.create
this.dw_deposito=create dw_deposito
this.Control[]={this.dw_deposito}
end on

on w_deposito_gohonzon.destroy
destroy(this.dw_deposito)
end on

type dw_deposito from datawindow within w_deposito_gohonzon
integer width = 5129
integer height = 1516
integer taborder = 10
string title = "none"
string dataobject = "dwtv_deposito_gohonzon"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;integer li_ret
s_riferimenti s_riferimenti_s
s_riferimenti_s.codice= this.getItemString(getRow(), "codice")
s_riferimenti_s.status= this.getItemString(getRow(), "cod_dis")

openWithParm(w_storico_gohonzon, s_riferimenti_s)

li_ret= message.DoubleParm

if li_ret= -1 then return

this.setRedraw(false)
	//this.retrieve(s_riferimenti_s.codice)
	this.ReselectRow(row)
this.setRedraw(true)


end event

