$PBExportHeader$w_ricerca_associati_small.srw
forward
global type w_ricerca_associati_small from w_ricerca_small
end type
end forward

global type w_ricerca_associati_small from w_ricerca_small
integer width = 2944
integer height = 1692
string title = "Ricerca "
boolean clientedge = true
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

event open;call super::open;dw_current.setColumn("cognome")
end event

type dw_current from w_ricerca_small`dw_current within w_ricerca_associati_small
event ue_keyenter ( )
integer x = 0
integer y = 0
string dataobject = "dw_ricerca_associati"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_current::ue_keyenter();triggerEvent(doubleclicked!)
end event

event dw_current::doubleclicked;call super::doubleclicked;string ls_codice

if this.getRow() <= 0 or  this.Object.DataWindow.QueryMode = "yes"  then return -1

ls_codice= this.getItemString(this.getrow(), "codice")

closeWithReturn(parent, ls_codice)
end event

type cb_importa from w_ricerca_small`cb_importa within w_ricerca_associati_small
integer x = 1746
integer y = 1404
integer height = 112
string facename = "Arial"
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_ricerca_associati_small
integer x = 622
integer y = 1404
integer height = 112
string facename = "Arial"
end type

type cb_query from w_ricerca_small`cb_query within w_ricerca_associati_small
integer x = 1184
integer y = 1404
integer height = 112
string facename = "Arial"
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_ricerca_associati_small
integer x = 2309
integer y = 1404
integer height = 112
string facename = "Arial"
end type

