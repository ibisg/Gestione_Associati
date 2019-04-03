$PBExportHeader$w_gohonzon_causali_resi.srw
forward
global type w_gohonzon_causali_resi from window
end type
type cb_seleziona from commandbutton within w_gohonzon_causali_resi
end type
type cb_annulla from commandbutton within w_gohonzon_causali_resi
end type
type uodw_current from uodw_generica within w_gohonzon_causali_resi
end type
end forward

global type w_gohonzon_causali_resi from window
integer width = 1728
integer height = 1284
boolean titlebar = true
string title = "Causali resi"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_seleziona cb_seleziona
cb_annulla cb_annulla
uodw_current uodw_current
end type
global w_gohonzon_causali_resi w_gohonzon_causali_resi

on w_gohonzon_causali_resi.create
this.cb_seleziona=create cb_seleziona
this.cb_annulla=create cb_annulla
this.uodw_current=create uodw_current
this.Control[]={this.cb_seleziona,&
this.cb_annulla,&
this.uodw_current}
end on

on w_gohonzon_causali_resi.destroy
destroy(this.cb_seleziona)
destroy(this.cb_annulla)
destroy(this.uodw_current)
end on

event open;uodw_current.setTransObject(sqlca)
uodw_current.retrieve()
end event

type cb_seleziona from commandbutton within w_gohonzon_causali_resi
integer x = 681
integer y = 1044
integer width = 343
integer height = 116
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seleziona"
boolean default = true
end type

event clicked;uodw_current.triggerevent("doubleclicked")
end event

type cb_annulla from commandbutton within w_gohonzon_causali_resi
integer x = 1317
integer y = 1044
integer width = 343
integer height = 116
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;closeWithReturn(parent, "")
end event

type uodw_current from uodw_generica within w_gohonzon_causali_resi
integer width = 1705
integer height = 996
integer taborder = 10
string dataobject = "dw_gohonzon_causali_resi"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event doubleclicked;call super::doubleclicked;string ls_causale

ls_causale= this.getItemString(this.getRow(), "cod_causale")

closeWithReturn(parent, ls_causale)
end event

