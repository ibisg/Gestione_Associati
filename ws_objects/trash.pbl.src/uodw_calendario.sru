$PBExportHeader$uodw_calendario.sru
forward
global type uodw_calendario from datawindow
end type
end forward

global type uodw_calendario from datawindow
integer width = 571
integer height = 600
string title = "none"
string dataobject = "edw_datemese"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global uodw_calendario uodw_calendario

forward prototypes
public function integer uf_mese (integer ai_mese, integer ai_anno)
end prototypes

public function integer uf_mese (integer ai_mese, integer ai_anno);
integer li_mese, li_anno, li_idx, li_ret
long ll_row
string ls_data
s_daymonth s_daymonth_s

//li_mese= month(today())
//
//li_anno= year(today())

s_daymonth_s= f_dayMonth(ai_mese, ai_anno)

for li_idx= 1 to s_dayMonth_s.giorni
	
	ll_row= this.insertRow(0)
	
	li_ret= this.setItem(ll_row, "numerogiorno", li_idx)
	
	ls_data= string(li_idx, "00")+"/"+string(ai_mese)+"/"+string(ai_anno)
	li_ret= this.setItem(ll_row, "cdata", date(ls_data) )
	
next

return li_idx
end function

on uodw_calendario.create
end on

on uodw_calendario.destroy
end on

