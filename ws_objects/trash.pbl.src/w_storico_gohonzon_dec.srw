$PBExportHeader$w_storico_gohonzon_dec.srw
forward
global type w_storico_gohonzon_dec from window
end type
type cb_chiudi from commandbutton within w_storico_gohonzon_dec
end type
type dw_current from datawindow within w_storico_gohonzon_dec
end type
end forward

global type w_storico_gohonzon_dec from window
integer width = 2510
integer height = 1836
boolean titlebar = true
string title = "Storico Gohonzon"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
cb_chiudi cb_chiudi
dw_current dw_current
end type
global w_storico_gohonzon_dec w_storico_gohonzon_dec

type variables
string is_codice

s_riferimenti is_riferimenti_s
end variables
event open;dw_current.setTransObject(sqlca)

is_riferimenti_s= message.powerObjectParm

if (is_riferimenti_s.status= 'DEC') then
	
	dw_current.dataObject= 'd_storico_goh_dec'
	
else // DIM...
	
	dw_current.dataObject= 'd_storico_goh_dim'
	
end if

dw_current.retrieve(is_riferimenti_s.codice)

end event

on w_storico_gohonzon_dec.create
this.cb_chiudi=create cb_chiudi
this.dw_current=create dw_current
this.Control[]={this.cb_chiudi,&
this.dw_current}
end on

on w_storico_gohonzon_dec.destroy
destroy(this.cb_chiudi)
destroy(this.dw_current)
end on

type cb_chiudi from commandbutton within w_storico_gohonzon_dec
integer x = 1065
integer y = 1568
integer width = 343
integer height = 128
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
boolean cancel = true
boolean default = true
end type

event clicked;close(parent)
end event

type dw_current from datawindow within w_storico_gohonzon_dec
integer width = 2469
integer height = 1528
integer taborder = 10
string title = "none"
string dataobject = "d_storico_goh_dec"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if row <= 0 then return 0

if f_has_p("O")= false then return -1

is_riferimenti_s.idx= this.getItemDecimal(row, "idx")

openWithParm(w_ins_storico_gohonzon, is_riferimenti_s)

this.setRedraw(false)

	this.retrieve(is_riferimenti_s.codice)
			
this.setRedraw(true)			

end event

