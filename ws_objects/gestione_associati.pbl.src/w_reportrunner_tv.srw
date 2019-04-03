$PBExportHeader$w_reportrunner_tv.srw
forward
global type w_reportrunner_tv from w_reportrunner
end type
end forward

global type w_reportrunner_tv from w_reportrunner
end type
global w_reportrunner_tv w_reportrunner_tv

on w_reportrunner_tv.create
call super::create
end on

on w_reportrunner_tv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;call super::closequery;//if isValid(is_assegnastruttura_s.aw_struttura_tv) then
	
	//is_assegnastruttura_s.aw_struttura_tv.shl_altritipi.text= 'Vai ad altri tipi di ricerca'
	
//end if

if isValid(w_struttura_tv_tab) then w_struttura_tv_tab.shl_altritipi.text= 'Vai ad altri tipi di ricerca'
end event

type uodw_current from w_reportrunner`uodw_current within w_reportrunner_tv
string dataobject = "dw_data_responsabilita"
end type

event uodw_current::sqlpreview;integer li_idx, li_pos, li_pos_from
string ls_query
	
	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " vc_parent like  '"+gs_ambiti[li_idx]+"%') "
			
		else
			
			ls_query += " vc_parent like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next		
	
	
//li_pos_from= lastpos(lower(sqlsyntax), "from", 1)

li_pos= pos(lower(sqlsyntax), "where", 1)

if li_pos= 0 then
	sqlsyntax += " where ("+ls_query
else
	sqlsyntax += " and ("+ls_query
end if	

if ib_sqluselike then
	f_sql_use_like(sqlType, sqlsyntax, uodw_current, FALSE)
end if

SetSqlPreview ( sqlsyntax )
end event

