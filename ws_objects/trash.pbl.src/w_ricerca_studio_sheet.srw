$PBExportHeader$w_ricerca_studio_sheet.srw
forward
global type w_ricerca_studio_sheet from w_generica_sheet
end type
end forward

global type w_ricerca_studio_sheet from w_generica_sheet
string menuname = "m_genericoricerca_sheet"
end type
global w_ricerca_studio_sheet w_ricerca_studio_sheet

on w_ricerca_studio_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_genericoricerca_sheet" then this.MenuID = create m_genericoricerca_sheet
end on

on w_ricerca_studio_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_generica_sheet`uodw_current within w_ricerca_studio_sheet
end type

