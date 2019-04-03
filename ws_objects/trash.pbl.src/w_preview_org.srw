$PBExportHeader$w_preview_org.srw
forward
global type w_preview_org from w_preview
end type
end forward

global type w_preview_org from w_preview
boolean ib_esportadw = true
end type
global w_preview_org w_preview_org

on w_preview_org.create
call super::create
end on

on w_preview_org.destroy
call super::destroy
end on

type uodw_current from w_preview`uodw_current within w_preview_org
boolean ib_readonly = true
boolean ib_append = true
end type

event uodw_current::buttonclicked;call super::buttonclicked;choose case dwo.name

	case "b_livelli"
	
		s_selezionalivelli s_selezionalivelli_s
		
		open(w_filtra_livelli)
		
		s_selezionalivelli_s= message.powerObjectParm
		
		if isNull(s_selezionalivelli_s.as_da) /*= ""*/  then
			
			uodw_current.setFilter("")
			
		else
		
			uodw_current.setFilter("att_ist_livello >= "+s_selezionalivelli_s.as_da+" and att_ist_livello <= "+s_selezionalivelli_s.as_a)
			
		end if
		
		uodw_current.filter()
	
	case "b_div"
	
		string ls_div
		
		open(w_seleziona_div)		
		
		ls_div= message.stringParm
		
		this.setFilter(ls_div)
		this.filter()
	
end choose


uodw_current.sort()	
	
end event

