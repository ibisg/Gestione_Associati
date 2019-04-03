$PBExportHeader$w_ricerca_associati_sheet.srw
forward
global type w_ricerca_associati_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_ricerca_associati_sheet from w_gestione_archivio_sheet
string menuname = "m_search_struttura_sheet"
windowstate windowstate = maximized!
long backcolor = 12632256
string icon = "Query5!"
event type integer ue_open ( )
event ue_struttura ( )
end type
global w_ricerca_associati_sheet w_ricerca_associati_sheet

event ue_open;m_search_struttura_sheet.m_gestionearchivio.m_ricerca.event clicked()

dw_current.setFocus()
dw_current.setColumn("cognome")

return 0
end event

event ue_struttura();s_struttura s_struttura_s

s_struttura_s.livello= MAX_LIVELLO

openWithParm(w_mostra_struttura, s_struttura_s)

s_struttura_s= message.powerObjectParm

dw_current.setColumn(1)
dw_current.setText(s_struttura_s.vc_nodo) 

return 
	
end event

on w_ricerca_associati_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_search_struttura_sheet" then this.MenuID = create m_search_struttura_sheet
end on

on w_ricerca_associati_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;m_search_struttura_sheet.ib_search= false

event post ue_open()
end event

event ue_queryon;call super::ue_queryon;dw_current.setFocus()
dw_current.setColumn("cognome")
return 0
end event

type dw_current from w_gestione_archivio_sheet`dw_current within w_ricerca_associati_sheet
event ue_keyenter pbm_dwnprocessenter
event ue_estraidettaglio ( long row )
string dataobject = "dw_ricerca_associati"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_current::ue_keyenter;event ue_estraidettaglio(this.getRow())
end event

event dw_current::ue_estraidettaglio;if lower(dw_current.Object.DataWindow.QueryMode)= 'no'  and row > 0 then openWithParm(w_schede_dati, this.getItemString(row, "codice"))
//this.deleteRow(row)
end event

event dw_current::rowfocuschanged;call super::rowfocuschanged;f_select_current_row (dw_current)
if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	parent.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_nodo") ) )
end if
end event

event dw_current::doubleclicked;call super::doubleclicked;event ue_estraidettaglio(row)
end event

