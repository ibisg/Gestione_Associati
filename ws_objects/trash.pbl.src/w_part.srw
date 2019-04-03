$PBExportHeader$w_part.srw
forward
global type w_part from w_ricerca_associati_small
end type
end forward

global type w_part from w_ricerca_associati_small
integer width = 3369
end type
global w_part w_part

on w_part.create
call super::create
end on

on w_part.destroy
call super::destroy
end on

event open;call super::open;ib_sqluselike= true
end event

type dw_current from w_ricerca_associati_small`dw_current within w_part
integer width = 3328
string dataobject = "dw_part"
end type

event dw_current::doubleclicked;string ls_codice, ls_er

ls_er= this.getItemString(this.getrow(), "flag_er")

if ls_er= "N" then
	messageBox(parent.title,"La persona selezionata non ha firmato la scheda di adesione all'E.R.~nPotranno essere eseguite solo restituzioni", information!)
	is_ricerca_s.i_retcode= 2
else
	is_ricerca_s.i_retcode= 1
end if

is_ricerca_s.codice= this.getItemString(this.getRow(), "codice")

closeWithReturn(parent, is_ricerca_s )
end event

event dw_current::sqlpreview;call super::sqlpreview;if ib_sqluselike= true then
	
	f_sql_use_like(sqlType, sqlsyntax, dw_current, FALSE)
	SetSqlPreview ( sqlsyntax )
	
end if

if pos(lower(sqlsyntax), "where", 1)= 0 then
	sqlsyntax += " where vc_parent like '"+gs_ambito+"%'"
else
	sqlsyntax += " and vc_parent like '"+gs_ambito+"%'"
end if	

SetSqlPreview ( sqlsyntax )

end event

type cb_importa from w_ricerca_associati_small`cb_importa within w_part
integer x = 2770
integer y = 1420
end type

type cb_dbcancel from w_ricerca_associati_small`cb_dbcancel within w_part
integer x = 2203
integer y = 1420
end type

type cb_query from w_ricerca_associati_small`cb_query within w_part
integer x = 1070
integer y = 1420
end type

type cb_annulla from w_ricerca_associati_small`cb_annulla within w_part
integer x = 1637
integer y = 1420
end type

