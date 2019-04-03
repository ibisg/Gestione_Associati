$PBExportHeader$w_lettereofferte.srw
forward
global type w_lettereofferte from w_preview
end type
end forward

global type w_lettereofferte from w_preview
end type
global w_lettereofferte w_lettereofferte

event open;call super::open;long ll_rows 

uodw_current.setTransObject(sqlca)

ll_rows= uodw_current.retrieve("609006TO", 2015)
end event

on w_lettereofferte.create
call super::create
end on

on w_lettereofferte.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_lettereofferte
string dataobject = "dw_letteraofferte_rotis"
end type

event uodw_current::printpage;call super::printpage;//integer li_detailheight

if pagenumber= 1 then
	
	//this.Object.DataWindow.Header.Height= 1888
	this.modify("Datawindow.Header.2.Height='1888'")
	
else
	
	//this.Object.DataWindow.Header.Height= 1104
	this.modify("Datawindow.Header.2.Height='1104'")
	
	//li_detailheight= 
	
end if
end event

