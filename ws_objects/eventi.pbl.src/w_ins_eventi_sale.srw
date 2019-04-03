$PBExportHeader$w_ins_eventi_sale.srw
forward
global type w_ins_eventi_sale from window
end type
type cb_chiudi from commandbutton within w_ins_eventi_sale
end type
type uodw_eventi_sale from uodw_generica within w_ins_eventi_sale
end type
end forward

global type w_ins_eventi_sale from window
integer width = 1586
integer height = 964
boolean titlebar = true
string title = "Inserimento sale"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_chiudi cb_chiudi
uodw_eventi_sale uodw_eventi_sale
end type
global w_ins_eventi_sale w_ins_eventi_sale

type variables
s_evento is_evento_s
end variables

on w_ins_eventi_sale.create
this.cb_chiudi=create cb_chiudi
this.uodw_eventi_sale=create uodw_eventi_sale
this.Control[]={this.cb_chiudi,&
this.uodw_eventi_sale}
end on

on w_ins_eventi_sale.destroy
destroy(this.cb_chiudi)
destroy(this.uodw_eventi_sale)
end on

event open;long ll_row

is_evento_s= message.powerObjectParm

uodw_eventi_sale.setTransObject(sqlca)

if is_evento_s.cod_sala= "" then
	
	ll_row= uodw_eventi_sale.insertRow(0)
	uodw_eventi_sale.setItem(ll_row, "cod_dip", is_evento_s.cod_dip)
	uodw_eventi_sale.setItem(ll_row, "cod_luogo", is_evento_s.cod_luogo)
	
else
	
	uodw_eventi_sale.retrieve(is_evento_s.cod_dip,  is_evento_s.cod_luogo,  is_evento_s.cod_sala)
	
end if
end event

event closequery;choose case uodw_eventi_sale.uof_modificheincorso()
		
	case 1 to 2
		
		return 0
		
	case 3
		
		return 1
		
end choose
end event

type cb_chiudi from commandbutton within w_ins_eventi_sale
integer x = 1065
integer y = 688
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

event clicked;	closeWithReturn(parent, 1)
end event

type uodw_eventi_sale from uodw_generica within w_ins_eventi_sale
integer width = 1527
integer height = 668
integer taborder = 10
string dataobject = "dw_eventi_sale"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;if dwo.name= "b_aggiorna" or dwo.name= "b_m" then
	
	if ancestorReturnValue < 0 then return
	closeWithReturn(parent, 0)
	
end if
end event

