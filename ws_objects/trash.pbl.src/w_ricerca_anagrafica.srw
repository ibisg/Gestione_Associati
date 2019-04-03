$PBExportHeader$w_ricerca_anagrafica.srw
forward
global type w_ricerca_anagrafica from w_ricerca_small
end type
end forward

global type w_ricerca_anagrafica from w_ricerca_small
integer width = 3337
string title = ""
string menuname = "m_search_archivio_sheet"
boolean minbox = true
windowtype windowtype = popup!
boolean clientedge = true
end type
global w_ricerca_anagrafica w_ricerca_anagrafica

on w_ricerca_anagrafica.create
call super::create
if this.MenuName = "m_search_archivio_sheet" then this.MenuID = create m_search_archivio_sheet
end on

on w_ricerca_anagrafica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;dw_current.height= this.height - 180 - dw_current.y
end event

type dw_current from w_ricerca_small`dw_current within w_ricerca_anagrafica
integer y = 220
integer width = 3246
string dataobject = "dw_ricerca_associati"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event dw_current::doubleclicked;call super::doubleclicked;if lower(dw_current.Object.DataWindow.QueryMode)= 'no'  and row > 0 then w_schede_dati.event ue_estraidettaglio(dw_current.getItemString(row, "codice") )
end event

type cb_query from w_ricerca_small`cb_query within w_ricerca_anagrafica
integer x = 1376
integer y = 12
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_ricerca_anagrafica
boolean visible = false
integer x = 2651
integer y = 0
end type

