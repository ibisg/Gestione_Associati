$PBExportHeader$w_dati_anagrafici.srw
forward
global type w_dati_anagrafici from w_centered
end type
type uodw_aggiornamento from uodw_anagrafica within w_dati_anagrafici
end type
end forward

global type w_dati_anagrafici from w_centered
integer width = 4553
integer height = 2340
string title = "Aggiornamento dati anagrafici"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "DataPipeline!"
boolean clientedge = true
uodw_aggiornamento uodw_aggiornamento
end type
global w_dati_anagrafici w_dati_anagrafici

on w_dati_anagrafici.create
int iCurrent
call super::create
this.uodw_aggiornamento=create uodw_aggiornamento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uodw_aggiornamento
end on

on w_dati_anagrafici.destroy
call super::destroy
destroy(this.uodw_aggiornamento)
end on

event open;call super::open;string ls_codice

ls_codice= message.stringParm

uodw_aggiornamento.setTransObject(sqlca)

uodw_aggiornamento.retrieve(ls_codice)
end event

event closequery;call super::closequery;if uodw_aggiornamento.modifiedCount() > 0 then
	choose case messageBox(this.title, "Sono stati modificati dei dati. Vuoi salvare?", question!, yesNoCancel!, 1)
			
		case 1
			
			uodw_aggiornamento.uof_aggiorna()
			
		case 2
			
			return 0
			
		case 3
			
			return 1
			
	end choose
end if
end event

type uodw_aggiornamento from uodw_anagrafica within w_dati_anagrafici
boolean visible = true
integer height = 2188
integer taborder = 10
end type

event retrieveend;call super::retrieveend;string ls_struttura

if this.getRow() <= 0 then return -1

ls_struttura= this.getItemString(this.getRow(), "vc_parent")

ls_struttura= f_descrizione_struttura_estesa(ls_struttura)

this.setItem(this.getRow(), "cstruttura", ls_struttura)

this.object.b_salva.visible= '0'

//ls_struttura= f_global_replace(ls_struttura, ".", "~r")
//
//dw_current.Object.t_struttura.Text= ls_struttura

uodw_aggiornamento.ResetUpdate() // la riga estratta è come nuova anche dopo l'inserimento della descrizione estesa...
end event

