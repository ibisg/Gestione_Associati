$PBExportHeader$uodw_anomalie_responsabilita.sru
forward
global type uodw_anomalie_responsabilita from uodw_generica
end type
end forward

global type uodw_anomalie_responsabilita from uodw_generica
string dataobject = "dw_anomalie_responsabilita"
end type
global uodw_anomalie_responsabilita uodw_anomalie_responsabilita

on uodw_anomalie_responsabilita.create
call super::create
end on

on uodw_anomalie_responsabilita.destroy
call super::destroy
end on

