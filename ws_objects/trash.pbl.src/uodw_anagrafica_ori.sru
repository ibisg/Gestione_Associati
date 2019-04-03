$PBExportHeader$uodw_anagrafica_ori.sru
forward
global type uodw_anagrafica_ori from datawindow
end type
end forward

global type uodw_anagrafica_ori from datawindow
boolean visible = false
integer width = 4224
integer height = 2432
string title = "Gestione anagrafica"
string dataobject = "dw_anagrafica"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global uodw_anagrafica_ori uodw_anagrafica_ori

type variables
boolean ib_dbcancel, ib_dwtype /* se true= nuovi inserimenti, se false= aggiornamenti  */, ib_ricerca

end variables

forward prototypes
public function boolean uof_modificheincorso ()
public function integer uof_cancella ()
public function integer uof_inserimento ()
public function integer uof_esegui (integer ai_opcode)
public function integer uof_aggiorna ()
public function integer uof_struttura (long al_row)
end prototypes

public function boolean uof_modificheincorso ();this.acceptText()

if this.ModifiedCount() > 0 or this.deletedCount() > 0 then
	
//	li_ret= messageBox(this.title, "Sono stati modificati dei dati: vuoi salvare?", question!, yesNoCancel!, 1)
	
	return true
	
end if

return false
end function

public function integer uof_cancella ();return 0
end function

public function integer uof_inserimento ();long ll_row

ll_row= this.insertRow(0)

this.scrollToRow(ll_row)

//this.setColumn("cognome")

this.setFocus()

return ll_row
end function

public function integer uof_esegui (integer ai_opcode);integer li_ret
long ll_row
string ls_codice

choose case ai_opcode
		
	case INSERIMENTO
		
		if  uof_modificheincorso() = true then return -1
		
		if uof_inserimento() < 0 then return -1
		
	case ESTRAZIONE
		
			ib_dbcancel= false
			
			this.acceptText()
			
				this.Object.DataWindow.QueryMode= 'no'
				
				ib_ricerca= false
		
				ll_row= this.retrieve()
				
					if ll_row > 1 and ib_dwtype= false then
						
						messageBox(this.title, "Attenzione: sono stati estratti "+string(ll_row)+ " partecipanti che rispondono ai criteri di ricerca impostati."+&
															"~nVerificare quale dei " +string(ll_row)+ " è quello di interesse o ripetere la ricerca con più elementi.", information!)
															
						// Apre una finestra di tipo "response" di selezione
						
						
						
					end if
				
						if ll_row= 0 then
							
							messageBox(this.title, "Nessun partecipante estratto.", information!)
							
							this.reset()
							
							this.setFocus()
							
							return -1
							
						else
							
							this.setFocus()
							
							return ll_row
							
						end if
		
		
	case CANCELLAZIONE
		
		// sei sicuro? ....
		
		if this.deleteRow(0)= 1 then
			if uof_aggiorna() < 0 then return -1
		else
			messageBox(this.title, "Errore in cancellazione record.", exclamation!)
			return -1
		end if
		
//		event ue_insert()

case AGGIORNAMENTO
	
		if this.getRow() > 0 then
			
			if checkNull(this) < 0 then return -1
		
				ls_codice= this.getItemString(this.getRow(), "codice")
				
				if ls_codice= "" or isNull(ls_codice) then
					
					ls_codice= string(gencod("RM") )+"RM"
				
					if this.setItem(this.getRow(), "codice", ls_codice)= -1 then
						messageBox(this.title, "Errore in generazione codice.", exclamation!)
						return -1
					end if
					
//					this.setItem(this.getRow(), "id", is_cerimonia_s.id)
					
				end if
				
		end if
			
		if uof_aggiorna() < 0 then return -1
		
//		event ue_insert()

case ANNULLAESTRAZIONE
	
	ib_dbcancel= true

case RESET
		
		if uof_modificheincorso() = true then return -1
		
//		event ue_insert()

//		dw_header.reset()
		this.reset()
		
	case CHIUSURA
		
		if uof_modificheincorso() = true then return -1
		
//		close(w_entrata)
		
	case RICERCA
		
			if uof_modificheincorso() = true then return -1
		
				this.reset()
				this.Object.DataWindow.QueryClear= 'yes'
				ib_ricerca= true
				this.setTransObject(sqlca)
				this.Object.DataWindow.QueryMode= 'yes'
				
				this.setColumn("cognome")
				
	case RICERCAEVENTO
		
//				if uof_cercacerimonia() < 0 then return -1
		
end choose

return 0
end function

public function integer uof_aggiorna ();if checknull(this) < 0 then return -1

if this.update()= 1 then
	commit using sqlca;
	if trap_sql(sqlca, "COMMITASP") < 0 then return -1
	open (w_message)
else
	rollback using sqlca;
	return -1
end if

return 0
end function

public function integer uof_struttura (long al_row);s_struttura s_struttura_s

s_struttura_s.vc_nodo= this.getItemString(al_row, "vc_parent")
//s_struttura_s.livello= gi_maxlivello

openWithParm(w_assegna_struttura, s_struttura_s )

s_struttura_s= message.powerObjectParm

if s_struttura_s.livello= -1 then return -1

this.setItem(al_row, "vc_parent", s_struttura_s.vc_nodo )

this.setItem(al_row, "cstruttura", f_descrizione_struttura_estesa(s_struttura_s.vc_nodo))

return 0
end function

on uodw_anagrafica_ori.create
end on

on uodw_anagrafica_ori.destroy
end on

event dberror;long l_beforeRow

choose case sqldbcode

	case 2601

		messageBox(this.title+" - Errore DB: "+string(sqldbcode), &
					  "E' stato inserito un record gia' esistente in base dati~n~n"+&
					  sqlerrtext, &
					  stopsign! )
					  
	case 999

		messageBox(this.title, "L'operazione e' stata annullata")
				  
	case 547 

		messageBox(this.title+" - Codice DB: "+string(sqldbcode), &
					  "La cancellazione non e' possibile.~n"+&
					  "Cancellare prima le entita' dipendenti.",&
						exclamation! )
						
		l_beforeRow= this.getRow()
		
		if l_beforeRow= 0 then l_beforeRow= 1
						
		this.RowsMove(1, this.DeletedCount(), Delete!, this, l_beforeRow, Primary!)
					
	case 247

		messageBox(this.title+" - Codice DB: "+string(sqldbcode), &
					  "Formato dati non corretto,~n",&
						stopsign! )
						
	case is > 30000
		
		messageBox(this.title+" - Codice DB: "+string(sqldbcode), &
					  sqlerrtext, exclamation! )
					  
		l_beforeRow= this.getRow()
		
		if l_beforeRow= 0 then l_beforeRow= 1
					  
		this.RowsMove(1, this.DeletedCount(), Delete!, this, l_beforeRow, Primary!) 

	case else

		messageBox(this.title+" - Codice DB: "+string(sqldbcode), sqlerrtext, stopsign! )


end choose

rollback;

return 1
end event

event itemerror;return 1
end event

event buttonclicked;choose case dwo.name
		
	case "b_nuovo"
		
		if this.uof_esegui(INSERIMENTO) < 0 then return -1	
		
		this.Object.b_reset.visible= true
		this.Object.b_ricerca.visible= false
		this.Object.b_cancella.visible= false
		this.Object.b_nuovo.visible= false
		this.Object.b_salva.visible= true
		this.Object.b_chiudi.visible= true
//		this.Object.b_annullaestrazione.enabled= false
		
	case "b_ricerca"
		
		if this.uof_esegui(RICERCA) < 0 then return -1	
		
	case "b_estrazione"
		
		if this.uof_esegui(ESTRAZIONE) < 0 then return -1	
		
	case "b_salva"
		
		if this.uof_esegui(AGGIORNAMENTO) < 0 then return -1	
		
	case "b_cancella"
		
		if this.uof_esegui(CANCELLAZIONE) < 0 then return -1	
		
	case "b_chiudi"
		
		if this.uof_esegui(CHIUSURA) < 0 then return -1	
		
	case "b_reset"
		
		if this.uof_esegui(RESET) < 0 then return -1	
		
	case "b_annulla"
		
		if this.uof_esegui(ANNULLAESTRAZIONE) < 0 then return -1	
		
	case "b_forzailcap"
		
		messageBox("Attenzione", "Il C.A.P. inserito manualmente potrebbe essere scorretto.", information!)
		
		this.Object.cap_dom.Protect=0
		this.setColumn("cap_dom")
		
	case "b_corr"
		
		openWithParm(w_corrispondenza, this.getItemString(row, "codice") )
			
	case "b_struttura"
		
		if this.uof_struttura(row) < 0 then return -1
		this.object.b_salva.visible= '1'
		this.object.gb_struttura.text= "Struttura: "+this.getItemString(1, "vc_parent")

	case "b_cap"
		
		integer i_err
		string ls_cap, ls_loc
		
		s_strade s_strade_s
		
		s_strade_s.cap= this.getItemString(row, "cap_dom")
		s_strade_s.comune= this.getItemString(row, "comune")
		s_strade_s.cod_com= this.getItemString(row, "cod_com")
		s_strade_s.provincia= this.getItemString(row, "provincia")
		
		s_strade_s= f_vercap(s_strade_s)
		
		choose case s_strade_s.return_code
				
			case 0
				
				messageBox(this.title, "Operazione annullata.", information!)
				
			case -1
				
				return -1
				
			case 1
				
				i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
							
				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
				
			case 2
				
				i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
				
		end choose
		
		
end choose

return 0

end event

event itemfocuschanged;choose case dwo.name
		
	case "cap_dom"
		
		this.selectText(1, 5)
		
end choose
end event

event itemchanged;choose case dwo.name
		
	case "cap_dom"
		
		this.Object.cap_dom.Protect=1
		
end choose

this.object.b_salva.visible= '1'

end event

event updateend;this.Object.b_salva.visible= false
end event

event retrieverow;yield()

if ib_dbcancel then
	
	return 1 // blocca il retrieval
	
else
	
	return 0
	
end if
end event

event retrieveend;string ls_struttura

if this.getRow() <= 0 then return -1

ls_struttura= this.getItemString(this.getRow(), "vc_parent")

ls_struttura= f_descrizione_struttura_estesa(ls_struttura)

this.setItem(this.getRow(), "cstruttura", ls_struttura)

//ls_struttura= f_global_replace(ls_struttura, ".", "~r")
//
//dw_current.Object.t_struttura.Text= ls_struttura

this.object.b_salva.visible= '0'

this.ResetUpdate() // la riga estratta è come nuova anche dopo l'inserimento della descrizione estesa...
end event

