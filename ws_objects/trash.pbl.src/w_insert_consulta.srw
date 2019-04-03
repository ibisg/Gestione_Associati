$PBExportHeader$w_insert_consulta.srw
forward
global type w_insert_consulta from w_centered
end type
type cb_annulla from commandbutton within w_insert_consulta
end type
type uodw_current from uodw_generica within w_insert_consulta
end type
end forward

global type w_insert_consulta from w_centered
integer width = 2057
integer height = 780
string title = "Inserisci/Aggiorna dati degli organi dell~'Istituto"
cb_annulla cb_annulla
uodw_current uodw_current
end type
global w_insert_consulta w_insert_consulta

event open;call super::open;string ls_descrizione

s_session_s.context= "Aggiungi/Rimuovi elementi di struttura"

//is_struttura_s= message.powerObjectParm

//select descrizione into :is_descrizione_struttura from struttura_livelli where livello= :is_struttura_s.livello + 1;

//sle_header.text= "Elenco entità contenute in: "+is_struttura_s.descrizione_livello+" "+is_struttura_s.descrizione_struttura

//this.title= "Elenco entità contenute in: "+is_struttura_s.descrizione_livello+" "+is_struttura_s.descrizione_struttura

//dw_current.setRowFocusIndicator(focusrect!)

uodw_current.setTransObject(sqlca)

//uodw_current.retrieve(is_struttura_s.vc_nodo)
end event

on w_insert_consulta.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.uodw_current=create uodw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.uodw_current
end on

on w_insert_consulta.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.uodw_current)
end on

type cb_annulla from commandbutton within w_insert_consulta
integer x = 1481
integer y = 532
integer width = 343
integer height = 120
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

type uodw_current from uodw_generica within w_insert_consulta
integer x = 101
integer y = 32
integer width = 1815
integer height = 480
integer taborder = 10
string dataobject = "dw_insert_consulta"
boolean maxbox = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isgrid = true
end type

