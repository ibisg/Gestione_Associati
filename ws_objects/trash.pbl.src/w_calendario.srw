$PBExportHeader$w_calendario.srw
forward
global type w_calendario from window
end type
type uodw_mese from uodw_calendario within w_calendario
end type
end forward

global type w_calendario from window
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
uodw_mese uodw_mese
end type
global w_calendario w_calendario

on w_calendario.create
this.uodw_mese=create uodw_mese
this.Control[]={this.uodw_mese}
end on

on w_calendario.destroy
destroy(this.uodw_mese)
end on

event resize;uodw_mese.height= this.height - 120
end event

event open;uodw_mese.setRowFocusIndicator(hand!)

return uodw_mese.uf_mese(month(today()), year(today()) )
end event

type uodw_mese from uodw_calendario within w_calendario
integer width = 896
integer taborder = 20
borderstyle borderstyle = stylebox!
end type

