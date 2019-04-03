$PBExportHeader$uodw_sel_cerimonia.sru
forward
global type uodw_sel_cerimonia from uodw_generica
end type
end forward

global type uodw_sel_cerimonia from uodw_generica
integer width = 2336
integer height = 1388
string dataobject = "dw_sel_cerimonia"
boolean ib_isgrid = true
boolean ib_querymode = true
boolean ib_readonly = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type
global uodw_sel_cerimonia uodw_sel_cerimonia

on uodw_sel_cerimonia.create
call super::create
end on

on uodw_sel_cerimonia.destroy
call super::destroy
end on

