$PBExportHeader$w_assegna_struttura_old.srw
forward
global type w_assegna_struttura_old from w_centered
end type
type cb_ricerca from commandbutton within w_assegna_struttura_old
end type
type tv_struttura from uotv_struttura within w_assegna_struttura_old
end type
type cb_annulla from commandbutton within w_assegna_struttura_old
end type
type cb_seleziona from commandbutton within w_assegna_struttura_old
end type
end forward

global type w_assegna_struttura_old from w_centered
integer width = 2560
integer height = 1564
string title = "Seleziona struttura"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
cb_ricerca cb_ricerca
tv_struttura tv_struttura
cb_annulla cb_annulla
cb_seleziona cb_seleziona
end type
global w_assegna_struttura_old w_assegna_struttura_old

type variables

end variables

event open;call super::open;long ll_handle
s_struttura s_struttura_s

s_struttura_s= message.powerObjectParm

tv_struttura.il_fino_a_quale_livello= s_struttura_s.livello 
tv_struttura.uf_populate(0)
//ll_handle= tv_struttura.findItem(rootTreeItem!, 0)
//tv_struttura.ExpandItem ( ll_handle )

tv_struttura.uf_cerca_nodo(s_struttura_s.vc_nodo)

return 0


end event

on w_assegna_struttura_old.create
int iCurrent
call super::create
this.cb_ricerca=create cb_ricerca
this.tv_struttura=create tv_struttura
this.cb_annulla=create cb_annulla
this.cb_seleziona=create cb_seleziona
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ricerca
this.Control[iCurrent+2]=this.tv_struttura
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.cb_seleziona
end on

on w_assegna_struttura_old.destroy
call super::destroy
destroy(this.cb_ricerca)
destroy(this.tv_struttura)
destroy(this.cb_annulla)
destroy(this.cb_seleziona)
end on

event resize;call super::resize;tv_struttura.width= this.width - 32
end event

type cb_ricerca from commandbutton within w_assegna_struttura_old
integer y = 1284
integer width = 494
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca struttura"
end type

event clicked;string ls_struttura

SetPointer ( hourglass! )

parent.SetRedraw ( false )

if OpenWithParm (w_ricerca_struttura, tv_struttura.il_fino_a_quale_livello)  < 0 then return -1

ls_struttura= message.stringParm

tv_struttura.uf_cerca_nodo(ls_struttura)

parent.SetRedraw ( true )

return 0
end event

type tv_struttura from uotv_struttura within w_assegna_struttura_old
integer width = 2482
integer height = 1236
integer taborder = 10
end type

event selectionchanged;call super::selectionchanged;treeViewItem ltvi_struttura

this.getItem(newhandle, ltvi_struttura)

is_struttura_s= ltvi_struttura.data

if is_struttura_s.livello= il_fino_a_quale_livello then
	cb_seleziona.enabled= true
else
	cb_seleziona.enabled= false
end if

return 0
end event

type cb_annulla from commandbutton within w_assegna_struttura_old
integer x = 2062
integer y = 1284
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
boolean cancel = true
end type

event clicked;s_struttura s_struttura_s
s_struttura_s.livello= -1
closeWithReturn(parent, s_struttura_s)
end event

type cb_seleziona from commandbutton within w_assegna_struttura_old
integer x = 1019
integer y = 1284
integer width = 443
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Incolla"
boolean default = true
end type

event clicked;closeWithReturn(parent, tv_struttura.is_struttura_s)
end event

