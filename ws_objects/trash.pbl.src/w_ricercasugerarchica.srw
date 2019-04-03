$PBExportHeader$w_ricercasugerarchica.srw
forward
global type w_ricercasugerarchica from w_gestione_archivio_sheet
end type
end forward

global type w_ricercasugerarchica from w_gestione_archivio_sheet
integer width = 3173
string menuname = "m_search_archivio_sheet"
windowstate windowstate = maximized!
end type
global w_ricercasugerarchica w_ricercasugerarchica

on w_ricercasugerarchica.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_search_archivio_sheet" then this.MenuID = create m_search_archivio_sheet
end on

on w_ricercasugerarchica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_current from w_gestione_archivio_sheet`dw_current within w_ricercasugerarchica
string dataobject = "dw_ricercasugerarchica"
end type

