$PBExportHeader$w_stampa-diplomi.srw
forward
global type w_stampa-diplomi from w_gestione_archivio_sheet
end type
end forward

global type w_stampa-diplomi from w_gestione_archivio_sheet
string menuname = "m_stampe_gen_diplomi"
end type
global w_stampa-diplomi w_stampa-diplomi

on w_stampa-diplomi.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_stampe_gen_diplomi" then this.MenuID = create m_stampe_gen_diplomi
end on

on w_stampa-diplomi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_current from w_gestione_archivio_sheet`dw_current within w_stampa-diplomi
integer x = 0
integer y = 0
string dataobject = "dw_sel_aventidiritto"
end type

