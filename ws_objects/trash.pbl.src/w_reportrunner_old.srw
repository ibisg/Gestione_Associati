$PBExportHeader$w_reportrunner_old.srw
forward
global type w_reportrunner_old from w_generica_sheet
end type
end forward

global type w_reportrunner_old from w_generica_sheet
string menuname = "m_reportrunner"
event type integer ue_liste_auto ( )
event ue_postopen ( )
event ue_open ( )
end type
global w_reportrunner_old w_reportrunner_old

type variables
string is_reportname
end variables

event type integer ue_liste_auto();integer li_ret
s_lista s_lista_s
s_reportpath ls_reportpath_s

if uodw_current.rowCount() = 0 then
	messageBox(this.title, "Nessun record estratto: la lista non può essere generata.", information!)
	return 0
end if

ls_reportpath_s.as_reportname= is_reportname
ls_reportpath_s.as_path= is_assegnastruttura_s.as_reportpath
ls_reportpath_s.aw_parentwindow= this

openWithParm(w_liste_auto_tipo, ls_reportpath_s /*uodw_current.dataObject*/)

s_lista_s= message.powerObjectParm

if s_lista_s.idx= 0 then return -1

li_ret= openWithParm(w_liste_auto_tab, s_lista_s)

return 0//close(this)
end event

event ue_open();if this.uodw_current.event ue_report(is_assegnastruttura_s )= 0 then

	m_reportrunner.m_gestionearchivio.m_ricerca.enabled= true
	m_reportrunner.m_gestionearchivio.m_ricercastruttura.enabled= true
	m_reportrunner.m_gestionearchivio.m_selezionareport.enabled= is_assegnastruttura_s.ab_vedielencodw		

end if
end event

on w_reportrunner_old.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_reportrunner" then this.MenuID = create m_reportrunner
end on

on w_reportrunner_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;gs_context= "Report runner"

post event ue_open()
end event

type uodw_current from w_generica_sheet`uodw_current within w_reportrunner_old
event type integer ue_report ( s_assegnastruttura as_assegnastruttura_s )
boolean hsplitscroll = true
boolean ib_allowstop = true
boolean ib_allowrowselection = true
boolean ib_stampatoda = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event type integer uodw_current::ue_report(s_assegnastruttura as_assegnastruttura_s);string ls_syntax, ls_errors, ls_path

// if isNull(this.DataObject) or this.DataObject= "" then is_reportname= as_assegnastruttura_s.as_first_dw

if as_assegnastruttura_s.as_first_dw= "" or isNull(as_assegnastruttura_s.as_first_dw) then return 0

 is_reportname= as_assegnastruttura_s.as_first_dw

this.DataObject= is_reportname

ls_path= is_assegnastruttura_s.as_reportpath

ls_syntax= libraryExport(ls_path, is_reportname, exportDataWindow!)

if ls_syntax= "" then
	messageBox(parent.title, "Errore in esportazione datawindow", exclamation!)
	return -1
end if

parent.setRedraw(false)

	this.create(ls_syntax, ls_errors)
	if len(ls_errors) > 0 then
		messageBox(parent.title, ls_errors, exclamation!)
		return -1
	end if
	
	this.setTransObject(sqlca)
	
	this.ib_readonly=  is_assegnastruttura_s.ab_readonly
	this.ib_aggiorna=  is_assegnastruttura_s.ab_aggiorna
	this.ib_querymode= true
	if this.DataObject <> "" then this.uof_ricerca()
	
	//this.uof_ricerca()

parent.setRedraw(true)

return 0
end event

event uodw_current::sqlpreview;call super::sqlpreview;integer li_idx, li_pos
string ls_query
	
	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " vc_parent like  '"+gs_ambiti[li_idx]+"%') "
			
		else
			
			ls_query += " vc_parent like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next		
	
li_pos= pos(lower(sqlsyntax), "where", 1)

if li_pos= 0 then
	sqlsyntax += " where ("+ls_query
else
	sqlsyntax += " and ("+ls_query
end if	

SetSqlPreview ( sqlsyntax )

if ib_sqluselike then
	f_sql_use_like(sqlType, sqlsyntax, uodw_current, FALSE)
	SetSqlPreview ( sqlsyntax )
end if


end event

event uodw_current::doubleclicked;call super::doubleclicked;string ls_struttura

if this.getRow() <= 0 or lower(this.Object.DataWindow.QueryMode)= 'yes'  then return

//if this.getItemString(this.getRow(), "cognome")= "" then
	
//	ls_struttura=trim(this.getItemString(this.getRow(), "vc_parent"))

//else

	ls_struttura=trim(this.getItemString(this.getRow(), "vc_parent"))+"."+trim(this.getItemString(this.getRow(), "cognome"))	+" "+trim(this.getItemString(this.getRow(), "nome"))

//end if

SetPointer ( hourglass! )

if ls_struttura <> "" and isValid(is_assegnastruttura_s.aw_struttura_tv) then
		
		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(false)		
	
		is_assegnastruttura_s.aw_struttura_tv.event ue_cercanodo(ls_struttura)

		is_assegnastruttura_s.aw_struttura_tv.bringToTop= true
		
		is_assegnastruttura_s.aw_struttura_tv.tv_struttura.setFocus()
		
		is_assegnastruttura_s.aw_struttura_tv.tv_struttura.ib_searchend= true

		is_assegnastruttura_s.aw_struttura_tv.parentWindow().setRedraw(true)			

		setPointer(arrow!)
	
end if
end event

event uodw_current::retrieveend;call super::retrieveend;m_reportrunner.m_gestionearchivio.m_selezionareport.enabled= is_assegnastruttura_s.ab_vedielencodw

end event

