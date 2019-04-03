$PBExportHeader$w_seleziona_cerimonie.srw
forward
global type w_seleziona_cerimonie from window
end type
type cb_1 from commandbutton within w_seleziona_cerimonie
end type
type uodw_current from uodw_generica within w_seleziona_cerimonie
end type
end forward

global type w_seleziona_cerimonie from window
integer width = 3282
integer height = 1580
boolean titlebar = true
string title = "Seleziona cerimonie"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_1 cb_1
uodw_current uodw_current
end type
global w_seleziona_cerimonie w_seleziona_cerimonie

on w_seleziona_cerimonie.create
this.cb_1=create cb_1
this.uodw_current=create uodw_current
this.Control[]={this.cb_1,&
this.uodw_current}
end on

on w_seleziona_cerimonie.destroy
destroy(this.cb_1)
destroy(this.uodw_current)
end on

event open;long ll_rows

uodw_current.setTransObject(sqlca)
ll_rows= uodw_current.retrieve(s_session_s.cod_dip)

if ll_rows= 0 then messageBox(this.title, "Non sono state definite cerimonie di consegna per questa dipendenza")

end event

type cb_1 from commandbutton within w_seleziona_cerimonie
integer x = 1454
integer y = 1324
integer width = 343
integer height = 128
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Seleziona"
end type

event clicked;uodw_current.triggerEvent(doubleclicked!)
end event

type uodw_current from uodw_generica within w_seleziona_cerimonie
integer width = 3246
integer taborder = 10
string dataobject = "dw_sel_cerimonia"
boolean ib_isgrid = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event doubleclicked;call super::doubleclicked;closeWithReturn(parent, this.getItemDecimal(this.getRow(), "id"))
end event

