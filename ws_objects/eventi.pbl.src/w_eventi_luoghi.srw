$PBExportHeader$w_eventi_luoghi.srw
forward
global type w_eventi_luoghi from window
end type
type cb_annulla from commandbutton within w_eventi_luoghi
end type
type uodw_luoghi from uodw_generica within w_eventi_luoghi
end type
end forward

global type w_eventi_luoghi from window
integer width = 2386
integer height = 1852
boolean titlebar = true
string title = "Eventi: gestione luoghi"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
cb_annulla cb_annulla
uodw_luoghi uodw_luoghi
end type
global w_eventi_luoghi w_eventi_luoghi

on w_eventi_luoghi.create
this.cb_annulla=create cb_annulla
this.uodw_luoghi=create uodw_luoghi
this.Control[]={this.cb_annulla,&
this.uodw_luoghi}
end on

on w_eventi_luoghi.destroy
destroy(this.cb_annulla)
destroy(this.uodw_luoghi)
end on

event open;uodw_luoghi.setTransObject(sqlca)
uodw_luoghi.retrieve()
end event

event closequery;choose case uodw_luoghi.uof_modificheincorso()
		
	case 1 to 2
		
		return 0
		
	case 3
		
		return 1
		
end choose
end event

type cb_annulla from commandbutton within w_eventi_luoghi
integer x = 1733
integer y = 1620
integer width = 439
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

type uodw_luoghi from uodw_generica within w_eventi_luoghi
integer width = 2327
integer height = 1600
integer taborder = 10
string dataobject = "dw_eventi_luoghi"
boolean ib_isgrid = true
boolean ib_allowrowselection = true
end type

event sqlpreview;call super::sqlpreview;string ls_query

if NOT f_has_p("S")  then
	ls_query= " where cod_dip= '"+ s_session_s.cod_dip+"'"
	sqlsyntax += ls_query
	setSqlPreview(sqlsyntax)
end if
end event

