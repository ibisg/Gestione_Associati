$PBExportHeader$w_event_log.srw
forward
global type w_event_log from w_generica_sheet
end type
end forward

global type w_event_log from w_generica_sheet
integer width = 3648
string menuname = "m_event_log_sheet"
end type
global w_event_log w_event_log

on w_event_log.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_event_log_sheet" then this.MenuID = create m_event_log_sheet
end on

on w_event_log.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_generica_sheet`uodw_current within w_event_log
string dataobject = "dw_event_log"
boolean ib_allowstop = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_reset = false
end type

