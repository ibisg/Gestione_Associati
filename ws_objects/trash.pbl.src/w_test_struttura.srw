$PBExportHeader$w_test_struttura.srw
forward
global type w_test_struttura from w_struttura_tv
end type
type cb_chiudi from commandbutton within w_test_struttura
end type
type cb_seleziona from commandbutton within w_test_struttura
end type
end forward

global type w_test_struttura from w_struttura_tv
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
cb_chiudi cb_chiudi
cb_seleziona cb_seleziona
end type
global w_test_struttura w_test_struttura

type variables
boolean ib_abilitaincolla
end variables

event open;call super::open;//s_assegnastruttura s_assegnastruttura_s
//
//s_assegnastruttura_s= message.powerObjectParm
//
//if s_assegnastruttura_s.al_ultimolivelloparent > 0 then tv_struttura.il_ultimolivelloparent= s_assegnastruttura_s.al_ultimolivelloparent
//
//tv_struttura.uf_populate(0)
//
//ib_abilitaincolla= s_assegnastruttura_s.ab_abilitaincolla // se true il bottone incolla è sempre abilitato
//
////tv_struttura.uf_cerca_nodo(s_assegnastruttura_s.as_struttura_s.vc_nodo) //se vc_nodo= "" allora non punta ad un nodo in particolare...
//
//return 0
end event

event resize;call super::resize;tv_struttura.width= this.width - 32
end event

on w_test_struttura.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_seleziona=create cb_seleziona
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_seleziona
end on

on w_test_struttura.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_seleziona)
end on

type pb_estesa from w_struttura_tv`pb_estesa within w_test_struttura
end type

type pb_trova from w_struttura_tv`pb_trova within w_test_struttura
end type

type sle_cerca from w_struttura_tv`sle_cerca within w_test_struttura
end type

type tv_struttura from w_struttura_tv`tv_struttura within w_test_struttura
integer width = 1975
integer height = 1356
end type

event tv_struttura::selectionchanged;call super::selectionchanged;treeViewItem ltvi_struttura

this.getItem(newhandle, ltvi_struttura)

is_struttura_s= ltvi_struttura.data

//if is_struttura_s.livello= il_fino_a_quale_livello then

if ib_abilitaincolla= true then
	cb_seleziona.enabled= true
else
	if is_struttura_s.livello= il_ultimolivelloparent + 1 then
		cb_seleziona.enabled= true
	else
		cb_seleziona.enabled= false
	end if
end if

return 0
end event

type cb_chiudi from commandbutton within w_test_struttura
integer x = 1431
integer y = 1524
integer width = 590
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Chiudi"
boolean cancel = true
end type

event clicked;s_struttura s_struttura_s
s_struttura_s.livello= -1
closeWithReturn(parent, s_struttura_s)
end event

type cb_seleziona from commandbutton within w_test_struttura
integer x = 827
integer y = 1524
integer width = 590
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "&Incolla"
boolean default = true
end type

event clicked;closeWithReturn(parent, tv_struttura.is_struttura_s)
end event

