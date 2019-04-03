$PBExportHeader$w_pdsic.srw
forward
global type w_pdsic from w_centered
end type
type dw_current from datawindow within w_pdsic
end type
end forward

global type w_pdsic from w_centered
integer width = 2103
integer height = 1768
string title = "Lista partecipanti da sistemare"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
windowtype windowtype = child!
string icon = "LibraryOpen!"
event type long ue_aggiorna ( )
dw_current dw_current
end type
global w_pdsic w_pdsic

type variables
string is_cod_corso, is_cod_turno, is_albergo
end variables

event ue_aggiorna;return dw_current.retrieve(is_cod_corso, is_cod_turno)
end event

event resize;call super::resize;dw_current.height= this.height -180
dw_current.width= this.width - 60
end event

event open;call super::open;s_corso s_corso_s

s_corso_s= message.powerObjectParm

is_cod_corso= s_corso_s.ls_corso
is_cod_turno= s_corso_s.ls_turno
is_albergo= s_corso_s.ls_albergo

dw_current.setTransObject(sqlca)
dw_current.retrieve(is_cod_corso, is_cod_turno)

dw_current.setRowFocusIndicator(focusRect!)
end event

on w_pdsic.create
int iCurrent
call super::create
this.dw_current=create dw_current
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_current
end on

on w_pdsic.destroy
call super::destroy
destroy(this.dw_current)
end on

type dw_current from datawindow within w_pdsic
integer x = 18
integer y = 12
integer width = 2025
integer height = 1544
integer taborder = 10
string title = "none"
string dataobject = "dw_partecipanti_da_sistemare_in_camera"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;if row<= 0 then return

long ll_codice, ll_assegnato
string ls_agibile

ll_codice= this.getItemNumber(row, "codice_part")

if row <= 0 then return

ls_agibile= w_postistanze_in_manuale_sheet.dw_current.getItemString(w_postistanze_in_manuale_sheet.dw_current.getRow(), "flag_agibile")

if ls_agibile= '0' then
	messageBox(parent.title, "La stanza non è agibile.", information!)
	return
end if

ll_assegnato= w_postistanze_in_manuale_sheet.dw_current.getItemNumber(w_postistanze_in_manuale_sheet.dw_current.getRow(), "codice_part")

if ll_assegnato > 0 then
	messageBox(parent.title, "Il posto è già assegnato. Per riassegnarlo occorre cancellare prima l'attuale occupante della stanza.", information!)
	return
end if

if w_postistanze_in_manuale_sheet.dw_current.setItem(w_postistanze_in_manuale_sheet.dw_current.getRow(), "codice_part", ll_codice)= -1 then
	messageBox(parent.title, "Errore in inserimento codice partecipante", exclamation!)
else
	w_postistanze_in_manuale_sheet.dw_current.setItem(w_postistanze_in_manuale_sheet.dw_current.getRow(), "flg_man", "M")
	this.deleteRow(row)
	m_selezione_alberghi_stanze.m_gestionearchivio.m_salva.enabled= true
end if

return
end event

event rowfocuschanged;f_select_current_row(dw_current)
end event

