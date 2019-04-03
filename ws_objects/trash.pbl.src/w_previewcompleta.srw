$PBExportHeader$w_previewcompleta.srw
forward
global type w_previewcompleta from w_preview
end type
end forward

global type w_previewcompleta from w_preview
end type
global w_previewcompleta w_previewcompleta

on w_previewcompleta.create
call super::create
end on

on w_previewcompleta.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_previewcompleta
string dataobject = "dw_completa"
boolean ib_allowstop = true
boolean ib_isgrid = true
end type

event uodw_current::buttonclicked;call super::buttonclicked;if dwo.name= "b_dis" then
		
	if this.filteredCount() > 0 then
	
		this.setFilter("")
		
		this.Object.t_lista.text= "( completa )"
		
	else
		
		this.setFilter("flag_dis='N'")
		
		this.Object.t_lista.text= "( solo attivi )"	
		
	end if
		
	this.filter()
	
end if
end event

