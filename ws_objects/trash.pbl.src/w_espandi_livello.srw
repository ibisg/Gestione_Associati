$PBExportHeader$w_espandi_livello.srw
forward
global type w_espandi_livello from w_centered
end type
type cb_1 from commandbutton within w_espandi_livello
end type
type dw_current from datawindow within w_espandi_livello
end type
end forward

global type w_espandi_livello from w_centered
integer width = 2830
integer height = 1172
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_1 cb_1
dw_current dw_current
end type
global w_espandi_livello w_espandi_livello

type variables
dataWIndowChild idwc_livello_struttura_child, idwc_livello_struttura_parent
integer ii_livello
end variables

event open;call super::open;long ll_row
s_struttura s_struttura_loc

s_struttura_loc= message.powerObjectParm

ll_row= dw_current.insertRow(0)
dw_current.getChild( 'livello_struttura_child', idwc_livello_struttura_child )
idwc_livello_struttura_child.setFilter(" livello > "+string(s_struttura_loc.livello) )
idwc_livello_struttura_child.filter()
idwc_livello_struttura_child.setTransObject(sqlca)
idwc_livello_struttura_child.retrieve(sqlca)

dw_current.getChild( 'livello_struttura_parent', idwc_livello_struttura_parent )


idwc_livello_struttura_parent.setTransObject(sqlca)
idwc_livello_struttura_parent.retrieve(sqlca)

dw_current.setItem( ll_row, "livello_struttura_parent", s_struttura_loc.livello)
dw_current.setItem( ll_row, "descrizione_struttura", s_struttura_loc.descrizione_struttura)



end event

on w_espandi_livello.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_current
end on

on w_espandi_livello.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_current)
end on

type cb_1 from commandbutton within w_espandi_livello
integer x = 1038
integer y = 876
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Espandi"
end type

event clicked;CloseWithReturn( parent, ii_livello )
end event

type dw_current from datawindow within w_espandi_livello
integer x = 37
integer y = 32
integer width = 2720
integer height = 804
integer taborder = 10
string title = "none"
string dataobject = "dw_espandilivello"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_livello= integer(data)
end event

