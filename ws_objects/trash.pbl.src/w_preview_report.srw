$PBExportHeader$w_preview_report.srw
forward
global type w_preview_report from w_preview
end type
end forward

global type w_preview_report from w_preview
end type
global w_preview_report w_preview_report

on w_preview_report.create
call super::create
end on

on w_preview_report.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_preview_report
string dataobject = "dw_completa"
boolean ib_append = true
end type

event uodw_current::buttonclicked;call super::buttonclicked;if dwo.name= "b_dis" then
	
	setPointer(hourGlass!)
		
	if this.filteredCount() > 0 then
	
		this.setFilter("")
		
		this.Object.t_lista.text= "( completa )"
		
	else
		
		this.setFilter("flag_dis='N'")
		
		this.Object.t_lista.text= "( solo attivi )"	
		
	end if
	
	this.sort()
		
	this.filter()
	
end if
end event

