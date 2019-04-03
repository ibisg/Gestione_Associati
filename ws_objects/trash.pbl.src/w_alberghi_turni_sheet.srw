$PBExportHeader$w_alberghi_turni_sheet.srw
forward
global type w_alberghi_turni_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_alberghi_turni_sheet from w_gestione_archivio_sheet
integer width = 3909
integer height = 1800
string title = "Associazione alberghi ai turni"
string menuname = "m_selezione_alberghi_turni"
boolean minbox = false
boolean maxbox = false
windowstate windowstate = maximized!
event type integer ue_genera_stanze ( )
event type integer ue_open ( )
end type
global w_alberghi_turni_sheet w_alberghi_turni_sheet

type variables
string is_corso, is_turno, is_albergo
end variables

event ue_genera_stanze;long ll_row

ll_row= dw_current.getRow()

if f_genera_stanze(dw_current.getItemString(ll_row, "cod_albergo") ) < 0 then
		messageBox(this.title, "Errore in generazione mappa stanze.", exclamation!)
		return 1
	end if
end event

event ue_open;m_selezione_alberghi_turni.m_gestionearchivio.m_ricerca.event  clicked()
if dw_current.rowCount() = 0 then m_selezione_alberghi_turni.m_gestionearchivio.m_selezionaalberghiperilturno.event  clicked()
return 0
end event

on w_alberghi_turni_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_selezione_alberghi_turni" then this.MenuID = create m_selezione_alberghi_turni
end on

on w_alberghi_turni_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;sqlca.autocommit= true

dw_current.setRowFocusIndicator(focusRect!)
dw_current.setTransObject(sqlca)

m_gestione_archivio_sheet.m_gestionearchivio.m_salva.enabled= false

//ib_dw_query_mode= true

m_selezione_alberghi_turni.ib_search= true
m_selezione_alberghi_turni.ib_only_once= true
//m_selezione_alberghi_turni.m_gestionearchivio.m_ricerca.event  post clicked()
//if dw_current.rowCount() = 0 then m_selezione_alberghi_turni.m_gestionearchivio.m_selezionaalberghiperilturno.event post clicked()

is_corso= mid(gs_corsocorrente, 1, 6)
is_turno= mid(gs_corsocorrente, 7, 10)

this.event post ue_open()
end event

event ue_delete;long ll_assegnate, ll_row

ll_row= dw_current.getRow()

if ll_row <= 0 then return -1

ll_assegnate= dw_current.getItemNumber(dw_current.getRow(), "cstanze_assegnate") 

if ll_assegnate > 0 then
	messageBox(this.title, "Non è possibile rimuovere l'albergo dal turno: alcuni posti sono già stati assegnati."+&
									"~nAnnullare prima le assegnazioni stanze.", exclamation!)
	return 0
end if

string ls_cod_albergo
ls_cod_albergo= dw_current.getItemString(dw_current.getRow(), "cod_albergo")


dw_current.deleteRow(0)
if dw_current.update() < 0 then
	rollback;
	if trap_sql(sqlca, "DELETE01") < 0 then return -1
	messageBox(this.title, "Errore in cancellazione dati.", exclamation!)
	return -1
else
	
	delete from stanze where cod_corso= :is_corso and cod_turno= :is_turno and cod_albergo= :ls_cod_albergo;
	if trap_sql(sqlca, "DELSTANZE01") < 0 then return -1
	
//	delete from mappe_stanze where cod_albergo= :ls_cod_albergo;
//	if trap_sql(sqlca, "DELMAPPESTANZE02") < 0 then return -1
	
end if

if dw_current.rowCount()= 0 then
	return 0
else
	return 1
end if
end event

event close;call super::close;sqlca.autocommit= false
end event

event ue_reset;call super::ue_reset;this.setRedraw(false)
ib_dw_query_mode= true
m_selezione_alberghi_turni.m_gestionearchivio.m_ricerca.event post clicked()
this.setRedraw(true)
end event

type dw_current from w_gestione_archivio_sheet`dw_current within w_alberghi_turni_sheet
integer x = 0
integer y = 0
integer width = 3808
integer height = 1508
string title = ""
string dataobject = "dw_alberghi_turni"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_current::sqlpreview;call super::sqlpreview;if request= PreviewFunctionRetrieve! then
	sqlsyntax += " and alberghi_turni.cod_corso+alberghi_turni.cod_turno= '"+gs_corsocorrente+"'"
	SetSqlPreview ( sqlsyntax)
end if
end event

event buttonclicked;call super::buttonclicked;if this.modifiedCount() > 0 or this.deletedCount() > 0 then
	if this.update() < 0 then
		rollback;
		if trap_sql(sqlca, "ROLLBACK01") < 0 then return -1
		messageBox(parent.title, "Errore in salvataggio dati.", exclamation!)
		return -1
	end if
end if

open(w_wait)
w_wait.st_wait.text= "Elaborazione in corso..."
if f_genera_stanze(this.getItemString(row, "cod_albergo")) < 0 then
		rollback;
		trap_sql(sqlca, "BUTTON01")
		messageBox(parent.title, "Errore in generazione stanze.", exclamation!)
	else
		commit;
		trap_sql(sqlca, "BUTTON02")	
		this.retrieve()
end if
	
close(w_wait)


end event

