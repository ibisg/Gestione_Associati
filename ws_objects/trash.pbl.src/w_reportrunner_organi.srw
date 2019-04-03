$PBExportHeader$w_reportrunner_organi.srw
forward
global type w_reportrunner_organi from w_reportrunner
end type
end forward

global type w_reportrunner_organi from w_reportrunner
end type
global w_reportrunner_organi w_reportrunner_organi

on w_reportrunner_organi.create
call super::create
end on

on w_reportrunner_organi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_reportrunner`uodw_current within w_reportrunner_organi
string dataobject = "dw_consulta"
end type

event uodw_current::itemchanged;call super::itemchanged;//if dwo.name= "flag_cn" then
//	
//	insert into 
end event

