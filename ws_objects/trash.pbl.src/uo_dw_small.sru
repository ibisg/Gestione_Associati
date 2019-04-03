$PBExportHeader$uo_dw_small.sru
forward
global type uo_dw_small from userobject
end type
type cb_estrazione from commandbutton within uo_dw_small
end type
type cb_salva from commandbutton within uo_dw_small
end type
type cb_cancella from commandbutton within uo_dw_small
end type
type cb_nuovo from commandbutton within uo_dw_small
end type
type dw_current from datawindow within uo_dw_small
end type
end forward

global type uo_dw_small from userobject
integer width = 2016
integer height = 1368
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_estrazione cb_estrazione
cb_salva cb_salva
cb_cancella cb_cancella
cb_nuovo cb_nuovo
dw_current dw_current
end type
global uo_dw_small uo_dw_small

type variables
boolean ib_dbcancel, ib_isgrid
end variables
forward prototypes
public function integer uof_cancella ()
public function long uof_inserisci ()
public function integer uof_modificheincorso ()
public function integer uof_esegui (integer ai_opcode)
public function integer uof_aggiorna ()
end prototypes

public function integer uof_cancella ();if messageBox("Cancellazione", "Confermi la cancellazione?", question!, yesNo!, 2)= 1 then
	if dw_current.deleteRow(0)= -1 then
		messageBox("Errore", "Errore in cancellazione", exclamation!)
		return -1
	end if
end if
return 0
end function
public function long uof_inserisci ();long ll_row

ll_row= dw_current.insertRow(0)

dw_current.scrollToRow(ll_row)

dw_current.setFocus()

return ll_row
end function
public function integer uof_modificheincorso ();dw_current.acceptText()

if dw_current.ModifiedCount() > 0 or dw_current.deletedCount() > 0 then
	
	if messageBox("Aggiornamento", "Sono stati modificati dei dati: vuoi salvare?", question!, yesNo!, 1)= 1 then
		
		return uof_aggiorna()
		
	end if
	
end if
end function
public function integer uof_esegui (integer ai_opcode);integer li_ret
long ll_row
string ls_codice

choose case ai_opcode
		
	case 1// inserimento...
		
		if  uof_modificheincorso() < 0 then return -1
		
		return uof_inserisci()
		
	case 2 // estrazione...
		
			ib_dbcancel= false
			
			dw_current.acceptText()
			
				dw_current.Object.DataWindow.QueryMode= 'no'

				ll_row= dw_current.retrieve()
				
					if ll_row > 1 and ib_isgrid= false then
						
						messageBox(dw_current.title, "Attenzione: sono stati estratti "+string(ll_row)+ " record che rispondono ai criteri di ricerca impostati."+&
															"~nVerificare quale dei " +string(ll_row)+ " è quello di interesse o ripetere la ricerca con più elementi.", information!)
						
					end if
				
						if ll_row= 0 then
							
							messageBox(dw_current.title, "Nessun record estratto.", information!)
							
							dw_current.reset()
							
							dw_current.setFocus()
							
							return -1
							
						else
							
							this.setFocus()
							
							return ll_row
							
						end if
		
		
	case 3 // cancella...
		
		return uof_cancella()

	case 4 // aggiorna...
				
			return uof_aggiorna()
	
	case 5 // annulla...
		
		ib_dbcancel= true
	
	case 6 // reset...
			
			if uof_modificheincorso() < 0 then return -1
			
			dw_current.reset()

			
		case 7 // va in ricerca...
			
				if uof_modificheincorso() < 0 then return -1
			
					dw_current.reset()
					dw_current.Object.DataWindow.QueryClear= 'yes'
					dw_current.setTransObject(sqlca)
					dw_current.Object.DataWindow.QueryMode= 'yes'
					
					dw_current.setFocus()
		
end choose

return 0
end function
public function integer uof_aggiorna ();if checknull(dw_current) < 0 then return -1

if dw_current.update()= 1 then
	commit using sqlca;
	if trap_sql(sqlca, "COMMIT") < 0 then return -1
	open (w_message)
else
	rollback using sqlca;
	return -1
end if

return 0
end function
on uo_dw_small.create
this.cb_estrazione=create cb_estrazione
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_nuovo=create cb_nuovo
this.dw_current=create dw_current
this.Control[]={this.cb_estrazione,&
this.cb_salva,&
this.cb_cancella,&
this.cb_nuovo,&
this.dw_current}
end on

on uo_dw_small.destroy
destroy(this.cb_estrazione)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_nuovo)
destroy(this.dw_current)
end on

type cb_estrazione from commandbutton within uo_dw_small
integer x = 251
integer y = 816
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Estrazione"
end type

event clicked;if this.text= "Estrazione" then
	return uof_esegui(ESTRAZIONE)
else
	return uof_esegui(RICERCA)
	this.text= "Ricerca"
end if
end event
type cb_salva from commandbutton within uo_dw_small
integer x = 1486
integer y = 816
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

type cb_cancella from commandbutton within uo_dw_small
integer x = 1074
integer y = 816
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

type cb_nuovo from commandbutton within uo_dw_small
integer x = 663
integer y = 816
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo"
end type

type dw_current from datawindow within uo_dw_small
integer width = 1915
integer height = 600
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

