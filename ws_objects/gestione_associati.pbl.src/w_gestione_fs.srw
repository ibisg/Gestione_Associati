$PBExportHeader$w_gestione_fs.srw
forward
global type w_gestione_fs from w_generica_sheet
end type
end forward

global type w_gestione_fs from w_generica_sheet
integer width = 5083
end type
global w_gestione_fs w_gestione_fs

type variables
m_preview_fs im_preview_fs
end variables

on w_gestione_fs.create
call super::create
end on

on w_gestione_fs.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;im_preview_fs= create m_preview_fs


end event

type uodw_current from w_generica_sheet`uodw_current within w_gestione_fs
integer width = 4594
string dataobject = "dw_gestione_fs"
boolean ib_readonly = true
boolean ib_allowrowselection = true
end type

event uodw_current::rbuttondown;if this.ib_queryMode= true then
	messageBox(parent.title, "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview_fs.iuodw_generica= this

im_preview_fs.m_aggiungi.visible= false
im_preview_fs.m_rimuovi.visible= false
im_preview_fs.m_salva.visible= false

im_preview_fs.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

event uodw_current::sqlpreview;call super::sqlpreview;f_sql_use_like(sqlType, sqlsyntax, uodw_current, FALSE)

sqlsyntax += " and cod_dis= '"+is_assegnastruttura_s.as_struttura_s.cod_dis+"'"

SetSqlPreview ( sqlsyntax )
end event

