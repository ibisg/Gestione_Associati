$PBExportHeader$w_reportrunner_tv.srw
forward
global type w_reportrunner_tv from w_generica_sheet
end type
end forward

global type w_reportrunner_tv from w_generica_sheet
string menuname = "m_reportrunner"
event type integer ue_liste_auto ( )
end type
global w_reportrunner_tv w_reportrunner_tv

type variables
string is_reportname
end variables

event type integer ue_liste_auto();s_lista s_lista_s

if uodw_current.rowCount() = 0 then
	messageBox(this.title, "Nessun record estratto: la lista non può essere generata.", information!)
	return 0
end if

openWithParm(w_liste_auto_tipo, is_reportname /*uodw_current.dataObject*/)

s_lista_s= message.powerObjectParm

if s_lista_s.cod_lista= "" then return -1

openWithParm(w_liste_auto_tab, s_lista_s)

return 0//close(this)
end event

on w_reportrunner_tv.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_reportrunner" then this.MenuID = create m_reportrunner
end on

on w_reportrunner_tv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;gs_context= "Report runner"
end event

type uodw_current from w_generica_sheet`uodw_current within w_reportrunner_tv
event type integer ue_report ( string as_reportname )
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
boolean ib_allowstop = true
boolean ib_sqluselike = true
boolean ib_readonly = true
end type

event type integer uodw_current::ue_report(string as_reportname);string ls_syntax, ls_errors, ls_path

if isNull(as_reportname) or as_reportname= "" then return -1

is_reportname= as_reportname

ls_path= gs_docdir+"\"+gs_customreportpath

ls_syntax= libraryExport(ls_path, as_reportname, exportDataWindow!)

if ls_syntax= "" then
	messageBox(parent.title, "Errore in esportazione datawindow", exclamation!)
	return -1
end if

this.create(ls_syntax, ls_errors)
if len(ls_errors) > 0 then
	messageBox(parent.title, ls_errors, exclamation!)
	return -1
end if

this.setRedraw(false)

this.setTransObject(sqlca)

ib_querymode= true
this.uof_ricerca()

this.setRedraw(true)

return 0
end event

event uodw_current::sqlpreview;call super::sqlpreview;if pos(lower(sqlsyntax), "where", 1)= 0 then
	sqlsyntax += " where vc_parent like '"+is_assegnastruttura_s.as_ambito+"%'"
else
	sqlsyntax += " and vc_parent like '"+is_assegnastruttura_s.as_ambito+"%'"
end if	

SetSqlPreview ( sqlsyntax )

if ib_sqluselike then
	f_sql_use_like(sqlType, sqlsyntax, uodw_current, FALSE)
	SetSqlPreview ( sqlsyntax )
end if
end event

event uodw_current::doubleclicked;string ls_struttura

if this.getRow() <= 0 or lower(this.Object.DataWindow.QueryMode)= 'yes'  then return

ls_struttura=trim(this.getItemString(this.getRow(), "vc_parent"))+"."+trim(this.getItemString(this.getRow(), "cognome"))	+" "+trim(this.getItemString(this.getRow(), "nome"))

SetPointer ( hourglass! )

if ls_struttura <> ""  then
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(false)		
	
		is_assegnastruttura_s.aw_struttura_tv.event ue_cercanodo(ls_struttura)

		is_assegnastruttura_s.aw_struttura_tv.bringToTop= true
		
		is_assegnastruttura_s.aw_struttura_tv.tv_struttura.setFocus()
		
		is_assegnastruttura_s.aw_struttura_tv.tv_struttura.ib_searchend= true

		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(true)			

		setPointer(arrow!)
	
end if
end event

