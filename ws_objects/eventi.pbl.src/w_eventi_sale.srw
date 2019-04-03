$PBExportHeader$w_eventi_sale.srw
forward
global type w_eventi_sale from window
end type
type cb_chiudi from commandbutton within w_eventi_sale
end type
type dw_current from datawindow within w_eventi_sale
end type
end forward

global type w_eventi_sale from window
integer width = 2615
integer height = 2004
boolean titlebar = true
string title = "Eventi: gestione sale"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
cb_chiudi cb_chiudi
dw_current dw_current
end type
global w_eventi_sale w_eventi_sale

type variables
s_evento is_evento_s
end variables

event open;dw_current.setTransObject(sqlca)
dw_current.retrieve()
end event

on w_eventi_sale.create
this.cb_chiudi=create cb_chiudi
this.dw_current=create dw_current
this.Control[]={this.cb_chiudi,&
this.dw_current}
end on

on w_eventi_sale.destroy
destroy(this.cb_chiudi)
destroy(this.dw_current)
end on

type cb_chiudi from commandbutton within w_eventi_sale
integer x = 2103
integer y = 1768
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type dw_current from datawindow within w_eventi_sale
integer width = 2569
integer height = 1736
integer taborder = 10
string title = "none"
string dataobject = "tvdw_eventi_sale"
boolean vscrollbar = true
string icon = "Database!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;string ls_query

if NOT f_has_p("S")  then
	ls_query= " and eventi_luoghi.cod_dip= '"+ s_session_s.cod_dip+"'"
	sqlsyntax += ls_query
	setSqlPreview(sqlsyntax)
end if
end event

event rowfocuschanged;is_evento_s.cod_dip= this.getItemString(this.getRow(), "cod_dip")
is_evento_s.cod_luogo= this.getItemString(this.getRow(), "cod_luogo")
is_evento_s.cod_sala= this.getItemString(this.getRow(), "cod_sala")
end event

event doubleclicked;if row <= 0 then return -1

openWithParm(w_ins_eventi_sale, is_evento_s)

if message.doubleParm= 0 then
	
	dw_current.retrieve()

	long ll_found

	ll_found = dw_current.Find("cod_dip='"+s_session_s.cod_dip+"' ", 1, dw_current.RowCount())
	
	if ll_found > 0 then dw_current.expand(ll_found,1)
	
end if
end event

event buttonclicked;if this.getRow() <= 0 then return

if dwo.name= "b_p" then
	is_evento_s.cod_dip= this.getItemString(this.getRow(), "cod_dip")
	is_evento_s.cod_luogo= this.getItemString(this.getRow(), "cod_luogo")
	is_evento_s.cod_sala= ""
	openWithParm(w_ins_eventi_sale, is_evento_s)
	dw_current.retrieve()
	
	long ll_found

	ll_found = dw_current.Find("cod_dip='"+s_session_s.cod_dip+"' ", 1, dw_current.RowCount())
	
	if ll_found > 0 then dw_current.expand(ll_found,1)
		
end if
end event

