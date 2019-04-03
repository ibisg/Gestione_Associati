$PBExportHeader$w_gestione_aspiranti_sheet.srw
forward
global type w_gestione_aspiranti_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_gestione_aspiranti_sheet from w_gestione_archivio_sheet
integer width = 4494
integer height = 2196
string menuname = "m_gestione_partecipanti_sheet"
windowstate windowstate = maximized!
end type
global w_gestione_aspiranti_sheet w_gestione_aspiranti_sheet

on w_gestione_aspiranti_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_gestione_partecipanti_sheet" then this.MenuID = create m_gestione_partecipanti_sheet
end on

on w_gestione_aspiranti_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_current from w_gestione_archivio_sheet`dw_current within w_gestione_aspiranti_sheet
integer width = 4306
integer height = 1896
string dataobject = "dw_aspiranti"
end type

event dw_current::updatestart;call super::updatestart;long ll_codice

ll_codice= gencod(gs_dip_operativa)

if ll_codice= -1 then return 1 // non esegue l'aggiornamento

if this.setItem(this.getRow(), "codice", string(ll_codice )+ gs_dip_operativa)= -1 then return 1
end event
