$PBExportHeader$w_cerca_sessioni_esame.srw
forward
global type w_cerca_sessioni_esame from w_ricerca_small
end type
end forward

global type w_cerca_sessioni_esame from w_ricerca_small
integer width = 1874
integer height = 1616
boolean clientedge = true
end type
global w_cerca_sessioni_esame w_cerca_sessioni_esame

on w_cerca_sessioni_esame.create
call super::create
end on

on w_cerca_sessioni_esame.destroy
call super::destroy
end on

type dw_current from w_ricerca_small`dw_current within w_cerca_sessioni_esame
integer width = 1179
string dataobject = "dw_cercasessione"
borderstyle borderstyle = stylebox!
end type

type cb_importa from w_ricerca_small`cb_importa within w_cerca_sessioni_esame
integer x = 1253
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_cerca_sessioni_esame
integer x = 1253
end type

type cb_query from w_ricerca_small`cb_query within w_cerca_sessioni_esame
integer x = 1243
integer y = 16
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_cerca_sessioni_esame
integer x = 1253
end type

