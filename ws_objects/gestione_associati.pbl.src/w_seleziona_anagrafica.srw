$PBExportHeader$w_seleziona_anagrafica.srw
forward
global type w_seleziona_anagrafica from w_centered
end type
type cb_annulla from commandbutton within w_seleziona_anagrafica
end type
type sle_struttura from singlelineedit within w_seleziona_anagrafica
end type
type dw_current from datawindow within w_seleziona_anagrafica
end type
end forward

global type w_seleziona_anagrafica from w_centered
integer width = 2761
integer height = 1728
string title = "Ricerca struttura"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Question!"
boolean clientedge = true
boolean center = true
cb_annulla cb_annulla
sle_struttura sle_struttura
dw_current dw_current
end type
global w_seleziona_anagrafica w_seleziona_anagrafica

type variables
integer il_fino_a_quale_livello
end variables

event open;call super::open;string ls_struttura

dw_current.setTransObject(sqlca)

ls_struttura= message.stringParm

dw_current.retrieve(ls_struttura)
end event

on w_seleziona_anagrafica.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.sle_struttura=create sle_struttura
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.sle_struttura
this.Control[iCurrent+3]=this.dw_current
end on

on w_seleziona_anagrafica.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.sle_struttura)
destroy(this.dw_current)
end on

type cb_annulla from commandbutton within w_seleziona_anagrafica
integer x = 1184
integer y = 1472
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;close(parent)
end event

type sle_struttura from singlelineedit within w_seleziona_anagrafica
integer y = 1284
integer width = 2706
integer height = 164
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
end type

type dw_current from datawindow within w_seleziona_anagrafica
event ue_keyenter pbm_dwnprocessenter
integer width = 2706
integer height = 1264
integer taborder = 10
string title = "Ricerca struttura"
string dataobject = "dw_selezione_anagrafica"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keyenter;triggerEvent(doubleclicked!)
end event

event sqlpreview;if pos(lower(sqlsyntax), "where", 1)= 0 then
	sqlsyntax += " where vc_nodo like '"+gs_ambito+"%'"
else
	sqlsyntax += " and vc_nodo like '"+gs_ambito+"%'"
end if	

SetSqlPreview ( sqlsyntax )
end event

event doubleclicked;long ll_tvi
string ls_codice

ls_codice= this.getItemString(this.getRow(), "codice")

closeWithReturn(parent, ls_codice)
end event

event retrieveend;this.setRow(1)
parent.sle_struttura.text= f_descrizione_struttura(this.getItemString(1, "vc_nodo") )
end event

event rowfocuschanged;f_select_current_row (dw_current)
if this.getRow() > 0 then
	parent.sle_struttura.text= f_descrizione_struttura(this.getItemString(this.getRow(), "vc_nodo") )
end if
end event

