$PBExportHeader$w_ricercanominativasmall.srw
forward
global type w_ricercanominativasmall from w_ricerca_small
end type
end forward

global type w_ricercanominativasmall from w_ricerca_small
integer width = 3451
string title = "Ricerca nominativa"
boolean controlmenu = false
boolean clientedge = true
boolean ib_sqluselike = true
end type
global w_ricercanominativasmall w_ricercanominativasmall

type variables
s_ricercanominativa is_ricercanominativa_s
s_evento is_evento_s
end variables

on w_ricercanominativasmall.create
call super::create
end on

on w_ricercanominativasmall.destroy
call super::destroy
end on

event open;call super::open;is_evento_s= message.PowerObjectParm

this.title= "Ricerca nominativa nelle liste dei partecipanti alla sessione del "+string(is_evento_s.tipo_evento)+"° livello"
end event

type dw_current from w_ricerca_small`dw_current within w_ricercanominativasmall
integer width = 3410
integer height = 1696
string dataobject = "dw_ricercanominativa"
boolean vscrollbar = true
end type

event dw_current::doubleclicked;call super::doubleclicked;if this.getRow() <= 0 then return 0

is_ricerca_s.id= this.getItemDecimal(this.getRow() , "id")
is_ricerca_s.codice= this.getItemString(this.getRow() , "codice")
is_ricerca_s.i_retcode= 1

closeWithReturn(parent, is_ricerca_s)

end event

event dw_current::sqlpreview;call super::sqlpreview;string ls_sql	
		
	if pos(sqlsyntax, "where") > 0 or pos(sqlsyntax, "WHERE") > 0 then
		ls_sql= " and eventi.tipo_evento="+string(is_evento_s.tipo_evento)
	else
		ls_sql= " where eventi.tipo_evento="+string(is_evento_s.tipo_evento)
	end if
	
	sqlsyntax+= ls_sql

f_sql_use_like(sqlType, sqlsyntax, dw_current, FALSE)
	
SetSqlPreview ( sqlsyntax )
end event

type cb_importa from w_ricerca_small`cb_importa within w_ricercanominativasmall
integer x = 1426
integer y = 1732
integer height = 112
string text = "Importa"
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_ricercanominativasmall
integer x = 864
integer y = 1732
integer height = 112
string text = "Interrompi l~'estrazione"
end type

type cb_query from w_ricerca_small`cb_query within w_ricercanominativasmall
integer x = 306
integer y = 1732
integer height = 112
string text = "Estrazione"
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_ricercanominativasmall
integer x = 2853
integer y = 1736
integer height = 112
boolean enabled = false
string text = "Annulla"
end type

