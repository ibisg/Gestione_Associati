$PBExportHeader$w_ricercanominativasmall.srw
forward
global type w_ricercanominativasmall from w_ricerca_small
end type
end forward

global type w_ricercanominativasmall from w_ricerca_small
integer width = 3369
string title = "Ricerca nominativa"
boolean clientedge = true
boolean ib_sqluselike = true
boolean ib_selectrow = true
end type
global w_ricercanominativasmall w_ricercanominativasmall

type variables
s_ricercanominativa is_ricercanominativa_s
end variables

on w_ricercanominativasmall.create
call super::create
end on

on w_ricercanominativasmall.destroy
call super::destroy
end on

type dw_current from w_ricerca_small`dw_current within w_ricercanominativasmall
integer width = 3319
integer height = 1696
string dataobject = "dw_ricercanominativa"
boolean vscrollbar = true
end type

event dw_current::doubleclicked;call super::doubleclicked;if row <= 0 then return 0

is_ricerca_s.id= this.getItemDecimal(row, "id")
is_ricerca_s.codice= this.getItemString(row, "codice")

closeWithReturn(parent, is_ricerca_s)

end event

type cb_importa from w_ricerca_small`cb_importa within w_ricercanominativasmall
integer x = 2629
integer y = 1732
integer height = 112
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_ricercanominativasmall
integer x = 2062
integer y = 1732
integer height = 112
end type

type cb_query from w_ricerca_small`cb_query within w_ricercanominativasmall
integer x = 928
integer y = 1732
integer height = 112
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_ricercanominativasmall
integer x = 1495
integer y = 1732
integer height = 112
end type

event cb_annulla::clicked;is_ricercanominativa_s.id= 0
closeWithReturn(parent, is_ricercanominativa_s)

end event

