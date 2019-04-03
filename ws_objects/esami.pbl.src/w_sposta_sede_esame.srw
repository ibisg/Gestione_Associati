$PBExportHeader$w_sposta_sede_esame.srw
forward
global type w_sposta_sede_esame from window
end type
type cb_annulla from commandbutton within w_sposta_sede_esame
end type
type cb_sposta from commandbutton within w_sposta_sede_esame
end type
type uodw_current from uodw_generica within w_sposta_sede_esame
end type
end forward

global type w_sposta_sede_esame from window
integer width = 2962
integer height = 1768
boolean titlebar = true
string title = "Sposta in altra sede di esame"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
event type long ue_open ( s_evento as_evento_s )
cb_annulla cb_annulla
cb_sposta cb_sposta
uodw_current uodw_current
end type
global w_sposta_sede_esame w_sposta_sede_esame

event type long ue_open(s_evento as_evento_s);long ll_rows

uodw_current.setRedraw(false)

ll_rows= uodw_current.retrieve(as_evento_s.id, as_evento_s.tipo_evento)

uodw_current.setRedraw(true)

return ll_rows
end event

event open;s_evento s_evento_s

uodw_current.setTransObject(sqlca)

this.title= string(s_evento_s.tipo_evento)+"° livello - Sposta una persona in un'altra sede di esame"

s_evento_s= message.PowerObjectParm

//messageBox("test", string(s_evento_s.id)+"-"+string(s_evento_s.tipo_evento), information!)

post event ue_open(s_evento_s)
end event

on w_sposta_sede_esame.create
this.cb_annulla=create cb_annulla
this.cb_sposta=create cb_sposta
this.uodw_current=create uodw_current
this.Control[]={this.cb_annulla,&
this.cb_sposta,&
this.uodw_current}
end on

on w_sposta_sede_esame.destroy
destroy(this.cb_annulla)
destroy(this.cb_sposta)
destroy(this.uodw_current)
end on

type cb_annulla from commandbutton within w_sposta_sede_esame
integer x = 2491
integer y = 1504
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;closeWithReturn(parent,-1)
end event

type cb_sposta from commandbutton within w_sposta_sede_esame
integer x = 1262
integer y = 1504
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Sposta"
end type

event clicked;uodw_current.triggerEvent(doubleClicked!)
end event

type uodw_current from uodw_generica within w_sposta_sede_esame
integer width = 2926
integer height = 1464
integer taborder = 10
string dataobject = "dw_seleziona_sessione"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
end type

event doubleclicked;call super::doubleclicked;if this.getRow() <= 0 then return

decimal ld_id

ld_id= this.getItemDecimal(this.getRow(), "id")

closeWithReturn(parent, ld_id)
end event

