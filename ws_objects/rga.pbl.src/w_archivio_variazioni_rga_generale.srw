$PBExportHeader$w_archivio_variazioni_rga_generale.srw
forward
global type w_archivio_variazioni_rga_generale from w_generica_sheet
end type
end forward

global type w_archivio_variazioni_rga_generale from w_generica_sheet
integer width = 4667
end type
global w_archivio_variazioni_rga_generale w_archivio_variazioni_rga_generale

on w_archivio_variazioni_rga_generale.create
call super::create
end on

on w_archivio_variazioni_rga_generale.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_generica_sheet`uodw_current within w_archivio_variazioni_rga_generale
integer width = 4558
string dataobject = "dw_rga_variazioni_rga_richieste"
boolean ib_dbcancel = true
boolean ib_sqluselike = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

