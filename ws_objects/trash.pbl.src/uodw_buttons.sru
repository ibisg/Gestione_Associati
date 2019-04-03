$PBExportHeader$uodw_buttons.sru
forward
global type uodw_buttons from datawindow
end type
end forward

global type uodw_buttons from datawindow
integer width = 2505
integer height = 360
string dataobject = "edw_buttons"
boolean border = false
end type
global uodw_buttons uodw_buttons

type variables
boolean b_enabled_nuovo, b_enabled_ricerca, b_enabled_estrazione, b_enabled_annulla, b_enabled_cancella, b_enabled_salva, b_enabled_reset
end variables

event buttonclicked;integer li_ret, li_action_code

// modalità operativa 
//constant integer  	INSERIMENTO= 1, &
//						ESTRAZIONE= 2, &
//						CANCELLAZIONE= 3, &
//						AGGIORNAMENTO= 4, &
//						ANNULLAESTRAZIONE= 5, &
//						RESET= 6, &
//						CHIUSURA= 7, &
//						RICERCA= 8, &
//						RICERCAEVENTO= 9, &
//						CARTELLINO= 10, &
//						LPRESENTAZIONE= 11, &
//						BOLLETTINO= 12, &
//						SKANAGRAFICA= 13, &
//						MAIL

if rowCount()= 0 then this.insertRow(0)

this.setText("")

choose case dwo.name
		
	case "b_nuovo"
		
		if b_enabled_nuovo then this.object.b_nuovo.visible= false
		if b_enabled_ricerca then this.object.b_ricerca.visible= false
		if b_enabled_estrazione then this.object.b_estrazione.visible= false
		if b_enabled_annulla then this.object.b_annulla.visible= false
		if b_enabled_cancella then this.object.b_cancella.visible= true
		if b_enabled_salva then this.object.b_salva.visible= true
		if b_enabled_reset then this.object.b_reset.visible= true
		
		li_action_code=  INSERIMENTO
		
	case "b_ricerca"
		
		if b_enabled_nuovo then this.object.b_nuovo.visible= false
		if b_enabled_ricerca then this.object.b_ricerca.visible= false
		if b_enabled_estrazione then this.object.b_estrazione.visible= true
		if b_enabled_annulla then this.object.b_annulla.visible= false
		if b_enabled_cancella then this.object.b_cancella.visible= false
		if b_enabled_salva then this.object.b_salva.visible= false
		if b_enabled_reset then this.object.b_reset.visible= true
		
		li_action_code= RICERCA
		
	case "b_estrazione"
		
		if b_enabled_nuovo then this.object.b_nuovo.visible= true
		if b_enabled_ricerca then this.object.b_ricerca.visible= true
		if b_enabled_estrazione then this.object.b_estrazione.visible= false
		if b_enabled_annulla then this.object.b_annulla.visible= true
		if b_enabled_cancella then this.object.b_cancella.visible= true
		if b_enabled_salva then this.object.b_salva.visible= true
		if b_enabled_reset then this.object.b_reset.visible= true
		
		li_action_code= ESTRAZIONE
		
	case "b_annulla"
		
		if b_enabled_annulla then this.object.b_annulla.visible= false
		
		li_action_code=  ANNULLAESTRAZIONE
		
	case "b_cancella"
		
		if b_enabled_nuovo then this.object.b_nuovo.visible= false
		if b_enabled_ricerca then this.object.b_ricerca.visible= false
		if b_enabled_estrazione then this.object.b_estrazione.visible= false
		if b_enabled_annulla then this.object.b_annulla.visible= false
		if b_enabled_cancella then this.object.b_cancella.visible= false
		if b_enabled_salva then this.object.b_salva.visible= true
		if b_enabled_reset then this.object.b_reset.visible= true
		
		li_action_code= CANCELLAZIONE
		
	case "b_salva"
		
		if b_enabled_nuovo then this.object.b_nuovo.visible= true
		if b_enabled_ricerca then this.object.b_ricerca.visible= true
		if b_enabled_estrazione then this.object.b_estrazione.visible= false
		if b_enabled_annulla then this.object.b_annulla.visible= false
		if b_enabled_cancella then this.object.b_cancella.visible= true
		if b_enabled_salva then this.object.b_salva.visible= true
		if b_enabled_reset then this.object.b_reset.visible= true
		
		li_action_code= AGGIORNAMENTO
		
	case "b_reset"
		
		if b_enabled_nuovo then this.object.b_nuovo.visible= true
		if b_enabled_ricerca then this.object.b_ricerca.visible= true
		if b_enabled_estrazione then this.object.b_estrazione.visible= false
		if b_enabled_annulla then this.object.b_annulla.visible= false
		if b_enabled_cancella then this.object.b_cancella.visible= true
		if b_enabled_salva then this.object.b_salva.visible= true
		if b_enabled_reset then this.object.b_reset.visible= true
		
		li_action_code= RESET
		
end choose
		

//li_ret= this.setItem(1, "action_code", li_action_code)
li_ret= this.setText(string(li_action_code))
li_ret= this.acceptText()
		
end event
on uodw_buttons.create
end on

on uodw_buttons.destroy
end on

event constructor;this.object.b_nuovo.visible= false
this.object.b_ricerca.visible= false
this.object.b_estrazione.visible= false
this.object.b_annulla.visible= false
this.object.b_cancella.visible= false
this.object.b_salva.visible= false
this.object.b_reset.visible= false

if b_enabled_nuovo then this.object.b_nuovo.visible= true
if b_enabled_ricerca then this.object.b_ricerca.visible= true
if b_enabled_estrazione then this.object.b_estrazione.visible= true
if b_enabled_annulla then this.object.b_annulla.visible= true
if b_enabled_cancella then this.object.b_cancella.visible= true
if b_enabled_salva then this.object.b_salva.visible= true
if b_enabled_reset then this.object.b_reset.visible= true

if rowCount()= 0 then insertRow(0)




end event

