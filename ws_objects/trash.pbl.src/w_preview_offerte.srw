$PBExportHeader$w_preview_offerte.srw
forward
global type w_preview_offerte from w_preview
end type
end forward

global type w_preview_offerte from w_preview
integer width = 4768
end type
global w_preview_offerte w_preview_offerte

type variables
//boolean ib_showreservedfields
end variables

on w_preview_offerte.create
call super::create
end on

on w_preview_offerte.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_preview_offerte
integer width = 4695
string dataobject = "dw_queryofferte"
end type

