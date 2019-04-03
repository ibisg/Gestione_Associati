$PBExportHeader$w_preview_cerimonie.srw
forward
global type w_preview_cerimonie from w_preview
end type
end forward

global type w_preview_cerimonie from w_preview
integer width = 4297
boolean ib_esportadw = true
end type
global w_preview_cerimonie w_preview_cerimonie

on w_preview_cerimonie.create
call super::create
end on

on w_preview_cerimonie.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_preview_cerimonie
string dataobject = "edw_reportcerimonie"
boolean ib_isgrid = true
boolean ib_append = true
end type

