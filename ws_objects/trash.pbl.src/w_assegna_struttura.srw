$PBExportHeader$w_assegna_struttura.srw
forward
global type w_assegna_struttura from w_centered
end type
type tv_struttura from uotv_struttura within w_assegna_struttura
end type
type cb_chiudi from commandbutton within w_assegna_struttura
end type
type cb_seleziona from commandbutton within w_assegna_struttura
end type
end forward

global type w_assegna_struttura from w_centered
integer width = 2528
integer height = 1564
string title = "Seleziona struttura"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
tv_struttura tv_struttura
cb_chiudi cb_chiudi
cb_seleziona cb_seleziona
end type
global w_assegna_struttura w_assegna_struttura

type variables
boolean ib_abilitaincolla
end variables

event open;call super::open;s_session_s.context= "Assegnazione struttura"

s_assegnastruttura s_assegnastruttura_s

s_assegnastruttura_s= message.powerObjectParm

if s_assegnastruttura_s.ai_ultimolivelloparent > 0 then tv_struttura.is_tvinit_s.ai_ultimolivelloparent= s_assegnastruttura_s.ai_ultimolivelloparent

tv_struttura.is_tvinit_s.ai_maxlivello= s_assegnastruttura_s.ai_maxlivello
tv_struttura.is_tvinit_s.as_ambito= s_assegnastruttura_s.as_ambito

tv_struttura.uf_populate(0)

ib_abilitaincolla= s_assegnastruttura_s.ab_abilitaincolla // se true il bottone incolla è sempre abilitato

tv_struttura.uf_cerca_nodo(s_assegnastruttura_s.as_struttura_s.vc_nodo) //se vc_nodo= "" allora non punta ad un nodo in particolare...

return 0


end event

on w_assegna_struttura.create
int iCurrent
call super::create
this.tv_struttura=create tv_struttura
this.cb_chiudi=create cb_chiudi
this.cb_seleziona=create cb_seleziona
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_struttura
this.Control[iCurrent+2]=this.cb_chiudi
this.Control[iCurrent+3]=this.cb_seleziona
end on

on w_assegna_struttura.destroy
call super::destroy
destroy(this.tv_struttura)
destroy(this.cb_chiudi)
destroy(this.cb_seleziona)
end on

event resize;call super::resize;tv_struttura.width= this.width - 32
end event

type tv_struttura from uotv_struttura within w_assegna_struttura
integer width = 2482
integer height = 1236
integer taborder = 10
end type

event selectionchanged;call super::selectionchanged;treeViewItem ltvi_struttura

this.getItem(newhandle, ltvi_struttura)

is_struttura_s= ltvi_struttura.data

//if is_struttura_s.livello= il_fino_a_quale_livello then

if ib_abilitaincolla= true then
	cb_seleziona.enabled= true
else
	if is_struttura_s.livello= is_tvinit_s.ai_ultimolivelloparent + 1 then
		cb_seleziona.enabled= true
	else
		cb_seleziona.enabled= false
	end if
end if

return 0
end event

type cb_chiudi from commandbutton within w_assegna_struttura
integer x = 1893
integer y = 1284
integer width = 590
integer height = 112
integer taborder = 40
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

type cb_seleziona from commandbutton within w_assegna_struttura
integer x = 1289
integer y = 1284
integer width = 590
integer height = 112
integer taborder = 10
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

