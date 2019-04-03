$PBExportHeader$w_sposta_cerimonia.srw
forward
global type w_sposta_cerimonia from w_centered
end type
type cb_annulla from commandbutton within w_sposta_cerimonia
end type
type cb_importa from commandbutton within w_sposta_cerimonia
end type
type dw_current from datawindow within w_sposta_cerimonia
end type
end forward

global type w_sposta_cerimonia from w_centered
integer width = 3173
integer height = 1740
string title = "Sposta in una diversa cerimonia"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
cb_annulla cb_annulla
cb_importa cb_importa
dw_current dw_current
end type
global w_sposta_cerimonia w_sposta_cerimonia

type variables
decimal id_id
end variables

on w_sposta_cerimonia.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_importa=create cb_importa
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_importa
this.Control[iCurrent+3]=this.dw_current
end on

on w_sposta_cerimonia.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_importa)
destroy(this.dw_current)
end on

event open;call super::open;long ll_rows
string ls_filter

s_evento ls_evento_s

ls_evento_s= message.powerObjectParm

dw_current.setRowFocusIndicator(focusRect!)

dw_current.setTransObject(sqlca)

ll_rows= dw_current.retrieve(ls_evento_s.id, ls_evento_s.cod_dip)

// GdS 28/02/2017
//if f_has_p("S")  then
//	ls_filter= "cod_dip='"+ls_evento_s.cod_dip+"' "
//else
//	ls_filter= "cod_dip='"+s_session_s.cod_dip+"' "
//end if
//
//dw_current.setFilter(ls_filter)
//dw_current.filter()

return ll_rows
end event

type cb_annulla from commandbutton within w_sposta_cerimonia
integer x = 2789
integer y = 1512
integer width = 343
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, 0)
end event

type cb_importa from commandbutton within w_sposta_cerimonia
integer x = 1394
integer y = 1512
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sposta"
boolean default = true
end type

event clicked;if dw_current.getRow()<= 0 then return -1

dw_current.triggerEvent(doubleClicked!)
//
//id_id= dw_current.getItemDecimal(dw_current.getRow(), "id")
//
//closeWithReturn(parent, id_id)
end event

type dw_current from datawindow within w_sposta_cerimonia
integer width = 3131
integer height = 1484
integer taborder = 10
string title = "none"
string dataobject = "dw_sposta_cerimonia"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if this.getRow()<= 0 then return -1

string ls_cer

ls_cer= trim(this.getItemString( this.getRow(), "descrizione_evento"))+&
			" - "+" turno: "+trim(this.getItemString( this.getRow(), "turno"))+&
			" del "+string(this.getItemDateTime( this.getRow(), "data_evento"), "dd.mm.yyyy")+&
			" alle ore: "+string(this.getItemDateTime( this.getRow(), "ora_inizio"), "hh.mm")

if messageBox(parent.title, "La nuova cerimonia è: "+ls_cer+"~nConfermi?", question!, yesNo!, 2)= 2 then return

id_id= this.getItemDecimal( this.getRow(), "id")

closeWithReturn(parent, id_id)
end event

event rowfocuschanged;f_select_current_row(this)
end event

