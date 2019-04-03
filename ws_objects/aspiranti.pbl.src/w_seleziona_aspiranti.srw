$PBExportHeader$w_seleziona_aspiranti.srw
forward
global type w_seleziona_aspiranti from w_ricerca_associati_small
end type
end forward

global type w_seleziona_aspiranti from w_ricerca_associati_small
integer width = 3086
integer height = 1828
end type
global w_seleziona_aspiranti w_seleziona_aspiranti

type variables
decimal{0} id_id
end variables

on w_seleziona_aspiranti.create
call super::create
end on

on w_seleziona_aspiranti.destroy
call super::destroy
end on

event open;call super::open;id_id= message.doubleParm

cb_query.PostEvent ( clicked! )
end event

type dw_current from w_ricerca_associati_small`dw_current within w_seleziona_aspiranti
integer width = 3054
integer height = 1560
string dataobject = "dw_seleziona_aspiranti"
end type

event dw_current::sqlpreview;string ls_sql

if pos(sqlsyntax, "where") > 0 or pos(sqlsyntax, "WHERE") > 0 then
	ls_sql= " and eventi.id= "+string(id_id)
else
	ls_sql= " where eventi.id= "+string(id_id)
end if

sqlsyntax+= ls_sql

f_sql_use_like(sqlType, sqlsyntax, dw_current, FALSE)
	
SetSqlPreview ( sqlsyntax )
end event

type cb_importa from w_ricerca_associati_small`cb_importa within w_seleziona_aspiranti
integer x = 1874
integer y = 1588
string text = "&Importa"
end type

type cb_dbcancel from w_ricerca_associati_small`cb_dbcancel within w_seleziona_aspiranti
boolean visible = false
integer x = 750
integer y = 1588
string text = "&Annulla l~'estrazione"
end type

type cb_query from w_ricerca_associati_small`cb_query within w_seleziona_aspiranti
boolean visible = false
integer x = 1312
integer y = 1588
string text = "&Estrazione"
end type

type cb_annulla from w_ricerca_associati_small`cb_annulla within w_seleziona_aspiranti
integer x = 2441
integer y = 1588
string text = "&Chiudi"
end type

