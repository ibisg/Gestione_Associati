$PBExportHeader$w_assegna_struttura_new.srw
forward
global type w_assegna_struttura_new from w_centered
end type
type tv_struttura from uotv_struttura within w_assegna_struttura_new
end type
type cb_chiudi from commandbutton within w_assegna_struttura_new
end type
type cb_seleziona from commandbutton within w_assegna_struttura_new
end type
end forward

global type w_assegna_struttura_new from w_centered
integer width = 2560
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
global w_assegna_struttura_new w_assegna_struttura_new

type variables
boolean ib_viewall
end variables

event open;call super::open;long ll_handle
string ls_nodo
s_struttura s_struttura_s

s_struttura_s= message.powerObjectParm

if s_struttura_s.livello= 0 then ib_viewall= true

tv_struttura.il_fino_a_quale_livello= s_struttura_s.livello


tv_struttura.uf_populate(0)
//ll_handle= tv_struttura.findItem(rootTreeItem!, 0)
//tv_struttura.ExpandItem ( ll_handle )
ls_nodo= s_struttura_s.vc_nodo
tv_struttura.uf_cerca_nodo(ls_nodo)

return 0


end event

on w_assegna_struttura_new.create
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

on w_assegna_struttura_new.destroy
call super::destroy
destroy(this.tv_struttura)
destroy(this.cb_chiudi)
destroy(this.cb_seleziona)
end on

event resize;call super::resize;tv_struttura.width= this.width - 32
end event

type tv_struttura from uotv_struttura within w_assegna_struttura_new
integer width = 2482
integer height = 1236
integer taborder = 10
end type

event selectionchanged;call super::selectionchanged;treeViewItem ltvi_struttura

this.getItem(newhandle, ltvi_struttura)

is_struttura_s= ltvi_struttura.data

// Se il_fino_a_quale_livello è uguale a 0 significa che devo lasciare il bottone Incolla sempre abilitato
// Se è > 0 significa che il bottone si abilita dal livello indicato, compreso, in poi

if ib_viewall then
	
		cb_seleziona.enabled= true
		
	else

		if is_struttura_s.livello= il_fino_a_quale_livello then
			cb_seleziona.enabled= true
		else
			cb_seleziona.enabled= false
		end if
		
end if

return 0
end event

type cb_chiudi from commandbutton within w_assegna_struttura_new
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

type cb_seleziona from commandbutton within w_assegna_struttura_new
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

