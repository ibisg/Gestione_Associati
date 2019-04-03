$PBExportHeader$w_report_sheet.srw
forward
global type w_report_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_report_sheet from w_gestione_archivio_sheet
string menuname = "m_report_sheet"
windowstate windowstate = maximized!
string icon = "Query5!"
boolean ib_dw_query_mode = true
event ue_report ( string as_reportname )
event ue_struttura ( )
end type
global w_report_sheet w_report_sheet

event ue_report(string as_reportname);dw_current.DataObject = as_reportname


end event

event ue_struttura();s_struttura s_struttura_s

s_struttura_s.livello= gi_maxlivello

openWithParm(w_mostra_struttura, s_struttura_s)

s_struttura_s= message.powerObjectParm

dw_current.setColumn("vc_parent")
dw_current.setText(s_struttura_s.vc_nodo) 

return 
end event

on w_report_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_report_sheet" then this.MenuID = create m_report_sheet
end on

on w_report_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;//string ls_reportname
//
//open(w_listObjects)
//
//ls_reportname= message.stringParm
//
//event ue_report(ls_reportname)

end event

type dw_current from w_gestione_archivio_sheet`dw_current within w_report_sheet
integer x = 0
integer y = 0
integer width = 2629
integer height = 1172
string dataobject = "dw_sintetica"
boolean hscrollbar = true
end type

event dw_current::rowfocuschanged;call super::rowfocuschanged;f_select_current_row (dw_current)
end event

