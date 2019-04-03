$PBExportHeader$w_oleword.srw
forward
global type w_oleword from w_ricerca_small
end type
type cb_merge from commandbutton within w_oleword
end type
type pb_struttura from picturebutton within w_oleword
end type
end forward

global type w_oleword from w_ricerca_small
integer width = 4201
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
windowstate windowstate = maximized!
boolean ib_resize = true
cb_merge cb_merge
pb_struttura pb_struttura
end type
global w_oleword w_oleword

on w_oleword.create
int iCurrent
call super::create
this.cb_merge=create cb_merge
this.pb_struttura=create pb_struttura
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_merge
this.Control[iCurrent+2]=this.pb_struttura
end on

on w_oleword.destroy
call super::destroy
destroy(this.cb_merge)
destroy(this.pb_struttura)
end on

type dw_current from w_ricerca_small`dw_current within w_oleword
event ue_struttura ( )
integer x = 0
integer y = 0
integer width = 3561
string title = "Stampa diplomi"
string dataobject = "dw_oleword"
string icon = "Report5!"
end type

event dw_current::ue_struttura();s_struttura s_struttura_s

s_struttura_s.livello= MAX_LIVELLO

openWithParm(w_mostra_struttura, s_struttura_s)

s_struttura_s= message.powerObjectParm

dw_current.setColumn("vc_parent")
dw_current.setText(s_struttura_s.vc_nodo) 

return 
end event

type cb_importa from w_ricerca_small`cb_importa within w_oleword
boolean visible = false
integer x = 3602
integer y = 720
string text = "&Importa"
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_oleword
integer x = 3602
integer y = 488
string text = "&Annulla l~'estrazione"
end type

type cb_query from w_ricerca_small`cb_query within w_oleword
integer x = 3602
string text = "&Estrazione"
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_oleword
integer x = 3602
string text = "&Chiudi"
end type

type cb_merge from commandbutton within w_oleword
integer x = 3602
integer y = 952
integer width = 558
integer height = 192
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Genera i diplomi"
end type

event clicked;integer li_ret

nca_word lnca_word

if parent.dw_current.rowCount() = 0 then
	messageBox(parent.title, "Estrarre i dati.", exclamation!)
	return -1
end if

li_ret= lnca_word.ncf_insert_data_fields("d:\svil\ole\olesource.doc", parent.dw_current)

li_ret= lnca_word.ncf_ole_connect("d:\svil\ole\olesource.doc", "d:\svil\ole\oleletter.doc")

return 0

//parent.wf_ole_connect()
end event

type pb_struttura from picturebutton within w_oleword
integer x = 3794
integer y = 1184
integer width = 174
integer height = 136
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "where.bmp"
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

event clicked;dw_current.event ue_struttura()
end event

