$PBExportHeader$w_storico_gohonzonnew.srw
forward
global type w_storico_gohonzonnew from window
end type
type uodw_current from uodw_generica within w_storico_gohonzonnew
end type
type cb_chiudi from commandbutton within w_storico_gohonzonnew
end type
end forward

global type w_storico_gohonzonnew from window
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
uodw_current uodw_current
cb_chiudi cb_chiudi
end type
global w_storico_gohonzonnew w_storico_gohonzonnew

type variables
string is_codice

s_riferimenti is_riferimenti_s
end variables

event open;long ll_row

is_riferimenti_s= message.powerObjectParm

choose case is_riferimenti_s.status
		
	case 'DEC'
	
	uodw_current.dataObject= 'd_storico_goh_dec'
	
	case 'DIM' 
	
	uodw_current.dataObject= 'd_storico_goh_dim'
	
	case else
	
	uodw_current.dataObject= 'd_storico_goh'
		
end choose

uodw_current.setTransObject(sqlca)

ll_row= uodw_current.retrieve(is_riferimenti_s.codice)

uodw_current.object.b_p.visible= true


end event

on w_storico_gohonzonnew.create
this.uodw_current=create uodw_current
this.cb_chiudi=create cb_chiudi
this.Control[]={this.uodw_current,&
this.cb_chiudi}
end on

on w_storico_gohonzonnew.destroy
destroy(this.uodw_current)
destroy(this.cb_chiudi)
end on

type uodw_current from uodw_generica within w_storico_gohonzonnew
integer width = 2473
integer height = 1544
integer taborder = 10
string dataobject = "d_storico_goh_dec"
boolean ib_isgrid = true
boolean ib_allowrowselection = true
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

type cb_chiudi from commandbutton within w_storico_gohonzonnew
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

