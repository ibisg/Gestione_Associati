$PBExportHeader$w_sintetica_sheet.srw
forward
global type w_sintetica_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_sintetica_sheet from w_gestione_archivio_sheet
string title = "Sintetica "
string menuname = "m_search_archivio_sheet"
windowstate windowstate = maximized!
string icon = "Query5!"
end type
global w_sintetica_sheet w_sintetica_sheet

on w_sintetica_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_search_archivio_sheet" then this.MenuID = create m_search_archivio_sheet
end on

on w_sintetica_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_current from w_gestione_archivio_sheet`dw_current within w_sintetica_sheet
string dataobject = "dw_sintetica"
end type

