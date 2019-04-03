$PBExportHeader$w_ricerca_associati_anagrafica.srw
forward
global type w_ricerca_associati_anagrafica from w_ricerca_associati_small
end type
end forward

global type w_ricerca_associati_anagrafica from w_ricerca_associati_small
integer width = 2981
string title = "Ricerca"
boolean controlmenu = false
boolean minbox = true
windowtype windowtype = child!
end type
global w_ricerca_associati_anagrafica w_ricerca_associati_anagrafica

type variables
string is_codice
end variables

on w_ricerca_associati_anagrafica.create
call super::create
end on

on w_ricerca_associati_anagrafica.destroy
call super::destroy
end on

type dw_current from w_ricerca_associati_small`dw_current within w_ricerca_associati_anagrafica
end type

event dw_current::retrieveend;call super::retrieveend;if rowCount > 0 then
	
	is_codice= this.getItemString(1, "codice")

	w_schede_dati.tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
	
	w_schede_dati.is_codice= is_codice
	
end if
end event

event dw_current::rowfocuschanged;call super::rowfocuschanged;if lower(dw_current.Object.DataWindow.QueryMode)= 'no'  and this.getRow() > 0 then
	
	f_select_current_row(this)
	
	parent.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
	
	w_schede_dati.tab_dati.selectTab(w_schede_dati.tab_dati.tabpage_dati)

	is_codice= this.getItemString(this.getRow(), "codice")

	w_schede_dati.tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
	
	w_schede_dati.is_codice= is_codice
	
	w_schede_dati.tab_dati.tabpage_visualizza.ole_viewer.visible= false
	
else
	
	w_schede_dati.tab_dati.tabpage_dati.dw_dati.reset()

end if
end event

event dw_current::doubleclicked;call super::doubleclicked;w_ricerca_associati_anagrafica.visible= false
end event

type cb_importa from w_ricerca_associati_small`cb_importa within w_ricerca_associati_anagrafica
boolean visible = false
end type

type cb_dbcancel from w_ricerca_associati_small`cb_dbcancel within w_ricerca_associati_anagrafica
end type

type cb_query from w_ricerca_associati_small`cb_query within w_ricerca_associati_anagrafica
end type

type cb_annulla from w_ricerca_associati_small`cb_annulla within w_ricerca_associati_anagrafica
end type

event cb_annulla::clicked;w_ricerca_associati_anagrafica.visible= false
end event

