$PBExportHeader$w_ricerca_struttura_sheet.srw
forward
global type w_ricerca_struttura_sheet from w_ricerca_sheet
end type
end forward

global type w_ricerca_struttura_sheet from w_ricerca_sheet
windowstate windowstate = normal!
end type
global w_ricerca_struttura_sheet w_ricerca_struttura_sheet

on w_ricerca_struttura_sheet.create
call super::create
end on

on w_ricerca_struttura_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_current from w_ricerca_sheet`dw_current within w_ricerca_struttura_sheet
integer x = 0
integer y = 0
string dataobject = "dw_ricerca_struttura"
end type

