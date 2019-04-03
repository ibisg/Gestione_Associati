$PBExportHeader$w_ricerca_sheet.srw
forward
global type w_ricerca_sheet from w_gestione_archivio_sheet
end type
end forward

global type w_ricerca_sheet from w_gestione_archivio_sheet
string menuname = "m_search_struttura_sheet"
windowstate windowstate = maximized!
string icon = "Query5!"
event type integer ue_open ( )
event ue_struttura ( )
event ue_select_all_rows ( )
end type
global w_ricerca_sheet w_ricerca_sheet

type variables
integer ii_dwid
boolean ib_selected
end variables

event type integer ue_open();m_search_struttura_sheet.m_gestionearchivio.m_ricerca.event clicked()

dw_current.setFocus()

return 0
end event

event ue_struttura();s_struttura s_struttura_s

s_struttura_s.livello= MAX_LIVELLO

openWithParm(w_mostra_struttura, s_struttura_s)

s_struttura_s= message.powerObjectParm

dw_current.setColumn("vc_parent")
dw_current.setText(s_struttura_s.vc_nodo) 

return 
end event

event ue_select_all_rows();ib_selected= NOT ib_selected

dw_current.selectRow(0, ib_selected)
end event

on w_ricerca_sheet.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_search_struttura_sheet" then this.MenuID = create m_search_struttura_sheet
end on

on w_ricerca_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;m_search_struttura_sheet.ib_search= false


ii_dwid= message.doubleParm

choose case ii_dwid

case 1
	
	dw_current.dataObject= "dw_ricerca_associati"
	
case 2
	
	dw_current.dataObject= "dw_sintetica"
	
case 3
	
	dw_current.dataObject= "dw_responsabili"
	
case 4
	
	dw_current.dataObject= "dw_ricerca_struttura"
	
case 5
	
	dw_current.dataObject= "dw_sel_diplomi"
	
end choose

event post ue_open()
end event

event ue_queryon;call super::ue_queryon;if ii_dwid < 4 then dw_current.setColumn("cognome")

dw_current.setFocus()
return 0
end event

type dw_current from w_gestione_archivio_sheet`dw_current within w_ricerca_sheet
event ue_keyenter pbm_dwnprocessenter
event ue_estraidettaglio ( long row )
integer x = 0
integer y = 0
string dataobject = "dw_ricerca_struttura"
end type

event dw_current::ue_keyenter;event ue_estraidettaglio(this.getRow())
end event

event dw_current::ue_estraidettaglio(long row);if lower(dw_current.Object.DataWindow.QueryMode)= 'no'  and row > 0 then openSheetWithParm(w_schede_dati, this.getItemString(row, "codice"), w_frame_gestioneassociati, 3, Original! )
this.deleteRow(row)
end event

event dw_current::rowfocuschanged;call super::rowfocuschanged;f_select_current_row (dw_current)
if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	parent.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
end if
end event

event dw_current::doubleclicked;call super::doubleclicked;event ue_estraidettaglio(row)
end event

event dw_current::clicked;call super::clicked;if keyDown(keycontrol!) then
	
	selectRow(row, NOT isSelected(row))
	
end if
end event

