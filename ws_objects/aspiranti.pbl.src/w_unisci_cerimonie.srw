$PBExportHeader$w_unisci_cerimonie.srw
forward
global type w_unisci_cerimonie from w_centered
end type
type cb_annulla from commandbutton within w_unisci_cerimonie
end type
type cb_unisci from commandbutton within w_unisci_cerimonie
end type
type dw_current from datawindow within w_unisci_cerimonie
end type
end forward

global type w_unisci_cerimonie from w_centered
integer width = 2953
integer height = 1740
string title = "Unisci liste"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
cb_annulla cb_annulla
cb_unisci cb_unisci
dw_current dw_current
end type
global w_unisci_cerimonie w_unisci_cerimonie

on w_unisci_cerimonie.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_unisci=create cb_unisci
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_unisci
this.Control[iCurrent+3]=this.dw_current
end on

on w_unisci_cerimonie.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_unisci)
destroy(this.dw_current)
end on

event open;call super::open;string ls_dip_evento
ls_dip_evento= message.stringParm
dw_current.setTransObject(sqlca)
dw_current.retrieve(ls_dip_evento, 7)
end event

type cb_annulla from commandbutton within w_unisci_cerimonie
integer x = 2565
integer y = 1452
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

type cb_unisci from commandbutton within w_unisci_cerimonie
integer x = 1289
integer y = 1452
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Unisci liste"
boolean default = true
end type

event clicked;decimal ld_id_evento
integer li_tipo

ld_id_evento=  dw_current.getItemDecimal( dw_current.getRow() , "id")
	
closeWithReturn(parent, ld_id_evento)
end event

type dw_current from datawindow within w_unisci_cerimonie
event type integer ue_filter ( long row )
integer width = 2907
integer height = 1392
integer taborder = 10
string title = "none"
string dataobject = "dw_unisci_cerimonie"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type integer ue_filter(long row);string ls_data

this.setRedraw(false)

if this.getItemString(row, "csel")= '1' and ls_data= "" then
	ls_data= string(this.getItemDateTime(row, "data_evento" ), "dd.mm.yyyy" ) 
	this.setFilter("data_evento=datetime('"+ls_data+"')" )
else
	this.setFilter("")
end if

this.filter()

this.sort()

this.groupCalc()

this.setRedraw(true)

return 0
end event

event rowfocuschanged;f_select_current_row(this)
end event

event doubleclicked;cb_unisci.event clicked()
end event

event retrieveend;if rowcount > 0 then cb_unisci.enabled= true
end event

