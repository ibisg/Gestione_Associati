$PBExportHeader$w_ricerca_associati_small.srw
forward
global type w_ricerca_associati_small from w_ricerca_small
end type
end forward

global type w_ricerca_associati_small from w_ricerca_small
integer width = 2944
integer height = 1772
string title = "Ricerca "
boolean controlmenu = false
boolean clientedge = true
boolean ib_sqluselike = true
boolean ib_selectrow = true
end type
global w_ricerca_associati_small w_ricerca_associati_small

type variables

end variables

on w_ricerca_associati_small.create
call super::create
end on

on w_ricerca_associati_small.destroy
call super::destroy
end on

event open;call super::open;s_session_s.context= "Ricerca"

dw_current.setColumn("cognome")
end event

type dw_current from w_ricerca_small`dw_current within w_ricerca_associati_small
integer height = 1512
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_current::doubleclicked;call super::doubleclicked;if this.getRow() <= 0 then return 0

is_ricerca_s.codice= this.getItemString(this.getRow(), "codice")
is_ricerca_s.struttura= this.getItemString(this.getRow(), "vc_parent")
is_ricerca_s.i_retcode= 1
closeWithReturn(parent, is_ricerca_s )
end event

type cb_importa from w_ricerca_small`cb_importa within w_ricerca_associati_small
integer x = 1733
integer y = 1528
integer width = 471
integer height = 108
string text = "Importa"
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_ricerca_associati_small
integer x = 1184
integer y = 1528
integer width = 535
integer height = 108
string text = "Interrompi l~'estrazione"
end type

type cb_query from w_ricerca_small`cb_query within w_ricerca_associati_small
integer x = 699
integer y = 1528
integer width = 471
integer height = 108
string text = "Estrazione"
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_ricerca_associati_small
integer x = 2350
integer y = 1528
integer width = 471
integer height = 108
string text = "Annulla"
end type

