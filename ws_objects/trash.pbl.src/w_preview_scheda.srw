$PBExportHeader$w_preview_scheda.srw
forward
global type w_preview_scheda from w_preview
end type
end forward

global type w_preview_scheda from w_preview
end type
global w_preview_scheda w_preview_scheda

on w_preview_scheda.create
call super::create
end on

on w_preview_scheda.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_preview_scheda
string dataobject = "dw_queryofferte"
end type

