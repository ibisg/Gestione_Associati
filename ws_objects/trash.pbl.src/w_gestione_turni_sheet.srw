$PBExportHeader$w_gestione_turni_sheet.srw
forward
global type w_gestione_turni_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_gestione_turni_sheet from w_gestione_archivio_sheet
integer width = 3159
string title = "Gestione turni"
long backcolor = 12632256
end type
global w_gestione_turni_sheet w_gestione_turni_sheet

on w_gestione_turni_sheet.create
call super::create
end on

on w_gestione_turni_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;this.title += gs_title

m_gestione_archivio_sheet.ib_search= true
m_gestione_archivio_sheet.m_gestionearchivio.m_ricerca.event  post clicked()

end event

event ue_insertend;call super::ue_insertend;return dw_current.setItem(ll_newrow, "cod_corso", gs_corsocorrente)
end event

event ue_myretrieve;return dw_current.retrieve(gs_corsocorrente)
end event

type dw_current from w_gestione_archivio_sheet`dw_current within w_gestione_turni_sheet
integer width = 3035
string title = "Gestione turni"
string dataobject = "dw_aggiorna_turni"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_current::sqlpreview;call super::sqlpreview;//f_sql_use_like(sqlType, sqlsyntax, dw_current, false)
//
//if request= PreviewFunctionRetrieve! then
//			sqlsyntax += " where  turni.cod_corso= '"+mid(gs_corsocorrente+"'"
//			SetSqlPreview ( sqlsyntax)
//end if
end event

