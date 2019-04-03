$PBExportHeader$uo_dw_storicogoh.sru
forward
global type uo_dw_storicogoh from uo_dw_small
end type
end forward

global type uo_dw_storicogoh from uo_dw_small
integer width = 2290
end type
global uo_dw_storicogoh uo_dw_storicogoh

on uo_dw_storicogoh.create
call super::create
end on

on uo_dw_storicogoh.destroy
call super::destroy
end on

type cb_estrazione from uo_dw_small`cb_estrazione within uo_dw_storicogoh
integer x = 581
integer y = 648
end type

type cb_salva from uo_dw_small`cb_salva within uo_dw_storicogoh
integer x = 1815
integer y = 648
end type

type cb_cancella from uo_dw_small`cb_cancella within uo_dw_storicogoh
integer x = 1403
integer y = 648
end type

type cb_nuovo from uo_dw_small`cb_nuovo within uo_dw_storicogoh
integer x = 992
integer y = 648
end type

type dw_current from uo_dw_small`dw_current within uo_dw_storicogoh
integer width = 2226
string dataobject = "d_storico_goh"
end type

