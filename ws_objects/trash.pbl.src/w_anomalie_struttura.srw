$PBExportHeader$w_anomalie_struttura.srw
forward
global type w_anomalie_struttura from w_generica_sheet
end type
end forward

global type w_anomalie_struttura from w_generica_sheet
end type
global w_anomalie_struttura w_anomalie_struttura

on w_anomalie_struttura.create
call super::create
end on

on w_anomalie_struttura.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_generica_sheet`uodw_current within w_anomalie_struttura
end type

