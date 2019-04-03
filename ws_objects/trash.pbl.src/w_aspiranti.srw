$PBExportHeader$w_aspiranti.srw
forward
global type w_aspiranti from window
end type
type dw_header from datawindow within w_aspiranti
end type
type dw_current from datawindow within w_aspiranti
end type
end forward

global type w_aspiranti from window
integer width = 4379
integer height = 3100
boolean titlebar = true
string title = "Gestione cerimonie"
string menuname = "m_gestione_aspiranti_sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
string icon = "Form!"
toolbaralignment toolbaralignment = alignatleft!
event type integer ue_open ( )
dw_header dw_header
dw_current dw_current
end type
global w_aspiranti w_aspiranti

type variables
boolean ib_dbcancel= false
datastore ids_com
decimal id_cerimonia

string is_query, is_com, is_prov, is_cap, is_cod_com

s_cerimonia	is_cerimonia_s
s_evento is_evento_s
s_strade is_strade_s

s_parm s_parm_s
end variables

event type integer ue_open();long ll_row
openWithParm(w_gestione_cerimonie, 6)

is_evento_s= message.powerObjectParm

if isNull(is_evento_s.id) then
	close(this)
	return -1
end if

dw_current.setTransObject(sqlca)
dw_header.setTransObject(sqlca)

ll_row= dw_header.retrieve(is_evento_s.id)

return 0
end event

event resize;	dw_header.x= (this.workSpaceWidth()/2 - dw_header.width/2) -36
	dw_current.x= (this.workSpaceWidth()/2 - dw_current.width/2) -36
end event

on w_aspiranti.create
if this.MenuName = "m_gestione_aspiranti_sheet" then this.MenuID = create m_gestione_aspiranti_sheet
this.dw_header=create dw_header
this.dw_current=create dw_current
this.Control[]={this.dw_header,&
this.dw_current}
end on

on w_aspiranti.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_header)
destroy(this.dw_current)
end on

event open;event post ue_open()
end event

type dw_header from datawindow within w_aspiranti
integer x = 37
integer width = 4201
integer height = 348
string title = "none"
string dataobject = "dw_header_eventi"
boolean border = false
boolean livescroll = true
end type

type dw_current from datawindow within w_aspiranti
event type integer ue_aggiorna ( )
event type integer ue_modificheincorso ( )
event type long ue_insert ( )
event type long ue_esegui ( integer ai_opcode )
event type long ue_cercacerimonia ( )
integer x = 37
integer y = 340
integer width = 4201
integer height = 2076
integer taborder = 20
string title = "Gestione partecipanti alle cerimonie"
string dataobject = "dw_aspiranti"
boolean border = false
string icon = "Form!"
boolean livescroll = true
end type

event ue_aggiorna;if checknull(dw_current) < 0 then return -1

if dw_current.update()= 1 then
	commit using sqlca;
	if trap_sql(sqlca, "COMMITASP") < 0 then return -1
	// aggiorna anche la scheda dati + gestione errori
	open (w_message)
else
	rollback using sqlca;
	return -1
end if

return 0
end event

event ue_modificheincorso;dw_current.acceptText()

if dw_current.ModifiedCount() > 0 or dw_current.deletedCount() > 0 then
	
	if messageBox(parent.title, "Sono stati modificati dei dati: vuoi salvare?", question!, yesNo!, 1)= 1 then
		
		if event ue_aggiorna() < 0 then return -1
		
	end if
	
end if

return 0
end event

event ue_insert;long ll_row

ll_row= this.insertRow(0)

this.scrollToRow(ll_row)

this.setColumn("cognome")

this.setFocus()

return ll_row
end event

event ue_esegui;integer li_ret
long ll_row
string ls_codice

choose case ai_opcode
		
	case 1// inserimento...
		
		if event ue_modificheincorso() < 0 then return -1
		
		event ue_insert()
		
	case 2 // estrazione...
		
			ib_dbcancel= false
			
			this.acceptText()
			
				dw_current.Object.DataWindow.QueryMode= 'no'

				ll_row= dw_current.retrieve()
				
					if ll_row > 1 then
						
						messageBox(parent.title, "Attenzione: sono stati estratti "+string(ll_row)+ " partecipanti che rispondono ai criteri di ricerca impostati."+&
															"~nVerificare quale dei " +string(ll_row)+ " è quello di interesse o ripetere la ricerca con più elementi.", information!)
						
					end if
				
						if ll_row= 0 then
							
							messageBox(parent.title, "Nessun partecipante estratto.", information!)
							
							this.reset()
							
							this.setFocus()
							
							return -1
							
						else
							
							this.setFocus()
							
							return ll_row
							
						end if
		
		
	case 3 // cancella...
		
		// sei sicuro? ....
		
		if dw_current.deleteRow(0)= 1 then
			if event ue_aggiorna() < 0 then return -1
		else
			messageBox(parent.title, "Errore in cancellazione record.", exclamation!)
			return -1
		end if
		
//		event ue_insert()

case 4 // aggiorna...
	
		if this.getRow() > 0 then
		
				ls_codice= this.getItemString(this.getRow(), "codice")
				
				if ls_codice= "" or isNull(ls_codice) then
					
					ls_codice= string(gencod("RM") )+"RM"
				
					if this.setItem(this.getRow(), "codice", ls_codice)= -1 then
						messageBox(parent.title, "Errore in generazione codice.", exclamation!)
						return -1
					end if
					
					this.setItem(this.getRow(), "id", is_cerimonia_s.id)
					
				end if
				
		end if
			
		if event ue_aggiorna() < 0 then return -1
		
//		event ue_insert()

case 5 // annulla...
	
	ib_dbcancel= true

case 6 // reset...
		
		if event ue_modificheincorso() < 0 then return -1
		
//		event ue_insert()

		dw_header.reset()
		this.reset()
		
	case 7 // chiudi...
		
		if event ue_modificheincorso() < 0 then return -1
		
		close(parent)
		
	case 8 // va in ricerca...
		
			if event ue_modificheincorso() < 0 then return -1
		
				dw_current.reset()
				dw_current.Object.DataWindow.QueryClear= 'yes'
				dw_current.setTransObject(sqlca)
				dw_current.Object.DataWindow.QueryMode= 'yes'
				
				dw_current.setColumn("cognome")
				
	case 9 // cerca cerimonia
		
				if event ue_cercacerimonia() < 0 then return -1
		
end choose

return 0
end event

event ue_cercacerimonia;long ll_row

if event ue_modificheincorso() < 0 then return -1

openWithParm(w_gestione_cerimonie, "I")

is_cerimonia_s= message.powerObjectParm

if isNull(is_cerimonia_s.id) then return -1

dw_header.reset()

ll_row= dw_header.insertRow(0)

dw_header.setItem(ll_row, "data_cer", is_cerimonia_s.data_cer)
dw_header.setItem(ll_row, "luogo_cer", is_cerimonia_s.luogo_cer)
dw_header.setItem(ll_row, "turno", is_cerimonia_s.turno)
dw_header.setItem(ll_row, "tipo_cerimonia", is_cerimonia_s.tipo_cer)

return ll_row
end event

event sqlpreview;if sqlType= PreviewSelect! then
	
		f_sql_use_like(sqlType, sqlsyntax, dw_current, false)
		sqlsyntax+= " and aspiranti.id="+string(is_cerimonia_s.id)	
		SetSqlPreview ( sqlsyntax)		
		
end if
end event

event buttonclicked;integer li_ret
long ll_row
string ls_codice

choose case dwo.name
		
	case "b_struttura"
		s_struttura s_struttura_s
		
		s_struttura_s.vc_nodo= this.getItemString(row, "vc_parent")
		s_struttura_s.livello= MAX_LIVELLO

		openWithParm(w_assegna_struttura, s_struttura_s )
		
		s_struttura_s= message.powerObjectParm
		
		if s_struttura_s.livello= -1 then return -1
		
		this.setItem(row, "vc_parent", s_struttura_s.vc_nodo )
		
		this.setItem(row, "cdescrizione_struttura", f_descrizione_struttura_estesa(s_struttura_s.vc_nodo))
		
	case "b_cap"
		
		integer i_err, li_exists
		string ls_cap, ls_loc, ls_vercap
		
		ls_cap= this.getItemString(row, "cap_dom")
		ls_loc= this.getItemString(row, "comune")
		
		select cap into :ls_vercap from tab_comuni where comune= :ls_loc;
		
		select count(*)  into :li_exists from cap_generici where cap= :ls_vercap;
		
		if isNull(li_exists) or li_exists= 0 then // se non è un cap generico...
			if ls_vercap <> ls_cap then
				i_err= messageBox("Verifica C.A.P.", "Il C.A.P. corretto relativo alla località "+ls_loc+" è: "+ls_vercap+"~nVuoi eseguire la correzione?", question!, yesNo!, 1)
				if i_err= 2 then return
				i_err= dw_current.SetItem ( row, "cap_dom", ls_vercap )
			else
				messageBox("Verifica C.A.P.", "Il C.A.P. "+ls_vercap+ " relativo alla località "+ls_loc+" è corretto.")
			end if
		else // se è un cap generico...
			i_err= messageBox("Verifica C.A.P.", "Il C.A.P. relativo alla località "+ls_loc +" è un C.A.P. generico.~nVuoi cercare nell'archivio strade?", question!, yesNo!, 1)
			if i_err= 2 then return 
				// apre la finestra di ricerca strade...
				openWithParm(w_cerca_strade, this.getItemString(row, "cod_com"))
				is_strade_s= message.powerObjectParm
					
					if NOT isNull(is_strade_s.cap) then
						
						if is_strade_s.strada <> "" then dw_current.SetItem ( row, "ind_dom", trim(is_strade_s.tipo)+" "+is_strade_s.strada+" ")
						
						i_err= dw_current.SetItem ( row, "cap_dom", is_strade_s.cap)
				
					end if
				
		end if
		
end choose
end event

event itemchanged;integer i_err, li_exists
long ll_rows
boolean first_time = true
string ls_data, search_string, old_comune, ls_nuovaOrganizzazione

ids_com= create u_ds_com
ids_com.setTransObject(sqlca)

if row > 0 then
	
	data = trim ( data )
	
	old_comune= data

	CHOOSE CASE dwo.name
			
		CASE "cognome"
			
			if len ( trim ( data ) ) = 0 then
				this.SetItem ( 1, "cognome", this.GetItemString ( 1, "cognome" ) )
				return 1
			end if
			
			data= trim(data)
			
		CASE "nome"
			
			if len ( trim ( data ) ) = 0 then
				this.SetItem ( 1, "nome", this.GetItemString ( 1, "nome" ) )
				return 1
			end if
			
			data= trim(data)
			
		CASE "comune"
			
			s_localita s_localita_s
			
//			cerca:
			
			search_string = trim ( data )+"%"
			
			s_parm_s.v_ricerca_estesa= false

ricerca_estesa:			ll_rows = ids_com.Retrieve ( search_string )
			
			choose case ll_rows
					
				case is < 1
					
					if mid(search_string, 1, 1)= "%" then
						
						MessageBox (parent.title, "La località "+data+" non è stata trovata. Modificare la chiave di ricerca.", exclamation!)
						
					else
					
						if MessageBox (parent.title, "La località "+data+" non è stata trovata, vuoi eseguire una ricerca estesa?", question!, yesNo!, 1)= 1 then
							
							search_string= "%"+search_string
							
							s_parm_s.v_ricerca_estesa= true
							
							goto ricerca_estesa
							
						end if
						
					end if
						
// GdS - 24.11.00	this.SetItem ( 1, "comune", this.GetItemString ( 1, "comune" ) )
					this.setText(this.GetItemString ( 1, "comune" , primary!, true))
					this.setItem(row, "provincia", this.GetItemString ( 1, "provincia" , primary!, true))
					this.selectText(1, len(this.GetItemString ( 1, "comune" , primary!, true)))
					return 1
					
				case 1
					
					is_com = ids_com.GetItemString ( 1, "comune" )
					is_prov = ids_com.GetItemString ( 1, "provincia" )
					is_cod_com = ids_com.GetItemstring ( 1, "cod_com" )
					is_cap = ids_com.GetItemstring ( 1, "cap" )

					i_err= dw_current.SetItem ( row, "cod_com", is_cod_com )
					if i_err= -1 then 
						messageBox(parent.title, "Errore in inserimento codice comune", stopSign!)
						return 1
					end if
					
					i_err= dw_current.SetItem ( row, "comune", is_com )	
					i_err= dw_current.SetItem ( row, "provincia", is_prov )
					
					select count(*)  into :li_exists from cap_generici where cap= :is_cap;
					
						if isNull(li_exists) or li_exists= 0 then
							i_err= dw_current.SetItem ( row, "cap_dom", is_cap )
						else
														
							s_localita_s.cod_com= is_cod_com
							s_localita_s.comune= is_com
							s_localita_s.cap= is_cap
							
							messageBox(parent.title, "Il C.A.P. relativo alla località "+is_com +" è un C.A.P. generico.~nOccorre eseguire la ricerca del C.A.P. nell'archivio strade.", information!)
							
							OpenWithParm(w_cerca_strade, s_localita_s)
							is_strade_s= message.powerObjectParm
								
								if NOT isNull(is_strade_s.cap) then // 
									
										if is_strade_s.strada <> "" then dw_current.SetItem ( row, "ind_dom", trim(is_strade_s.tipo)+" "+is_strade_s.strada+" ")
										
										i_err= dw_current.SetItem ( row, "cap_dom", is_strade_s.cap)
										
		//								i_err= dw_dett.SelectText(len(trim(is_strade_s.tipo)+" "+is_strade_s.strada), 1)
	
									else
										
										return 2
							
								end if
								
						end if
	
					i_err= dw_current.setText ( is_com )
					return 2
					
				case is > 1
					
					s_parm_s.w_name = "w_aspiranti"
					search_string = trim ( data )+"%"
					s_parm_s.v_com = search_string
					
					OpenWithParm ( w_search_com, s_parm_s )
					
					choose case message.DoubleParm
							
						case -1 // annulla l'operazione
							
							messageBox(parent.title, "Ricerca nome località annullata.", exclamation!)
							
							return 2 // rigetta il valore inserito
							
//						case 1 // ha letto correttamente il codice comune con cap non generico			
							
						case 2 // il comune ha un cap generico
														
							s_localita_s.cod_com= is_cod_com
							s_localita_s.comune= is_com
							s_localita_s.cap= is_cap
							
							messageBox(parent.title, "Il C.A.P. relativo alla località "+is_com +" è un C.A.P. generico.~nOccorre eseguire la ricerca del C.A.P. nell'archivio strade.", information!)
							
							OpenWithParm(w_cerca_strade, s_localita_s)
							is_strade_s= message.powerObjectParm
							
							if NOT isNull(is_strade_s.cap) then
								
								is_cap= is_strade_s.cap
								
								if is_strade_s.strada<> "" then dw_current.SetItem ( row, "ind_dom", trim(is_strade_s.tipo)+" "+is_strade_s.strada+" ")

							else
								
								return 2
								
							end if
							
					end choose // message.doubleParm...
					
					i_err= dw_current.SetItem ( row, "provincia", is_prov )
					i_err= dw_current.SetItem ( row, "cod_com", is_cod_com )
					if i_err= -1 then 
						messageBox(parent.title, "Errore in inserimento codice comune", stopSign!)
						return 1
					end if
					i_err= dw_current.SetItem ( row, "cap_dom", is_cap )
					i_err= dw_current.SetItem ( row, "comune", is_com )
					i_err= dw_current.setText ( is_com )
					return 2
//					return 0
		
			end choose // ll_rows...
			
		CASE "data_nas"
			
			if f_min ( data ) = 1 then
				if MessageBox ( parent.title, "E' consentito inserire minorenni solo con il consenso dei genitori."+&
														"~nAbbiamo il modulo di consenso firmato da ambedue i genitori?" , question!, yesNo!, 2)= 2 then
					return 1
				else
					return 0
				end if
			end if
			
			this.setColumn ( "cod_div" )

	END CHOOSE

end if

return 0

end event

event itemerror;return 1
end event

event retrieverow;yield()

if ib_dbcancel then
	
	return 1 // blocca il retrieval
	
else
	
	return 0
	
end if
end event

event retrieveend;string ls_struttura

if rowcount <= 0 then return -1

ls_struttura= this.getItemString(this.getRow(), "vc_parent")

ls_struttura= f_descrizione_struttura_estesa(ls_struttura)

this.setItem(this.getRow(), "cdescrizione_struttura", ls_struttura)

this.ResetUpdate() // la riga estratta è come nuova anche dopo l'inserimento della descrizione estesa...
end event

event editchanged;if row <= 0 or lower(this.Object.DataWindow.QueryMode)= "yes" then return -1

m_gestione_aspiranti_sheet.m_gestionepartecipanti.m_salva.enabled= true
m_gestione_aspiranti_sheet.m_gestionepartecipanti.m_inserimentopartecipanti.enabled= false
m_gestione_aspiranti_sheet.m_gestionepartecipanti.m_ricerca.enabled= false
m_gestione_aspiranti_sheet.m_gestionepartecipanti.m_cancella.enabled= false
end event

