﻿$PBExportHeader$w_schede_dati_new.srw
forward
global type w_schede_dati_new from w_centered
end type
type tab_dati from tab within w_schede_dati_new
end type
type tabpage_ricerca from userobject within tab_dati
end type
type uo_ricerca from uodw_buttons within tabpage_ricerca
end type
type uo_dw_ricerca from uodw_anagrafica within tabpage_ricerca
end type
type pb_struttura from picturebutton within tabpage_ricerca
end type
type gb_buttons from groupbox within tabpage_ricerca
end type
type tabpage_ricerca from userobject within tab_dati
uo_ricerca uo_ricerca
uo_dw_ricerca uo_dw_ricerca
pb_struttura pb_struttura
gb_buttons gb_buttons
end type
type tabpage_dati from userobject within tab_dati
end type
type pb_scheda from picturebutton within tabpage_dati
end type
type pb_stampa_boll from picturebutton within tabpage_dati
end type
type pb_ldp from picturebutton within tabpage_dati
end type
type pb_cartellino from picturebutton within tabpage_dati
end type
type dw_dati from datawindow within tabpage_dati
end type
type tabpage_dati from userobject within tab_dati
pb_scheda pb_scheda
pb_stampa_boll pb_stampa_boll
pb_ldp pb_ldp
pb_cartellino pb_cartellino
dw_dati dw_dati
end type
type tabpage_aggiornamento from userobject within tab_dati
end type
type uodw_aggiornamento from uodw_anagrafica within tabpage_aggiornamento
end type
type tabpage_aggiornamento from userobject within tab_dati
uodw_aggiornamento uodw_aggiornamento
end type
type tabpage_edizioni from userobject within tab_dati
end type
type cbx_storico from checkbox within tabpage_edizioni
end type
type dw_pubblicazioni from datawindow within tabpage_edizioni
end type
type tabpage_edizioni from userobject within tab_dati
cbx_storico cbx_storico
dw_pubblicazioni dw_pubblicazioni
end type
type tabpage_storicogohonzon from userobject within tab_dati
end type
type uo_storicogohonzon from uodw_anagrafica within tabpage_storicogohonzon
end type
type tabpage_storicogohonzon from userobject within tab_dati
uo_storicogohonzon uo_storicogohonzon
end type
type tabpage_storicoesami from userobject within tab_dati
end type
type dw_storicoesami from datawindow within tabpage_storicoesami
end type
type tabpage_storicoesami from userobject within tab_dati
dw_storicoesami dw_storicoesami
end type
type tabpage_storicocontributi from userobject within tab_dati
end type
type cb_stampa from commandbutton within tabpage_storicocontributi
end type
type dw_storicocontributi from datawindow within tabpage_storicocontributi
end type
type cbx_importi from checkbox within tabpage_storicocontributi
end type
type tabpage_storicocontributi from userobject within tab_dati
cb_stampa cb_stampa
dw_storicocontributi dw_storicocontributi
cbx_importi cbx_importi
end type
type tabpage_visualizza from userobject within tab_dati
end type
type ole_viewer from olecustomcontrol within tabpage_visualizza
end type
type tabpage_visualizza from userobject within tab_dati
ole_viewer ole_viewer
end type
type tab_dati from tab within w_schede_dati_new
tabpage_ricerca tabpage_ricerca
tabpage_dati tabpage_dati
tabpage_aggiornamento tabpage_aggiornamento
tabpage_edizioni tabpage_edizioni
tabpage_storicogohonzon tabpage_storicogohonzon
tabpage_storicoesami tabpage_storicoesami
tabpage_storicocontributi tabpage_storicocontributi
tabpage_visualizza tabpage_visualizza
end type
end forward

global type w_schede_dati_new from w_centered
integer width = 5001
integer height = 3424
string title = "Gestione associati"
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Database!"
boolean clientedge = true
boolean ib_centered = false
event type long ue_estraidettaglio ( string as_codice )
event ue_open ( )
tab_dati tab_dati
end type
global w_schede_dati_new w_schede_dati_new

type variables
boolean ib_dbcancel, ib_squeeze_up
long il_dwy, il_dwh
string is_codice, is_cod_com, is_com, is_prov, is_cap, is_path_ldp
s_strade is_strade_s
s_parm s_parm_s

u_ds_com ids_com

nca_pdf inca_pdf
end variables

forward prototypes
public function integer wf_action (integer ai_action, long al_row)
end prototypes

event type long ue_estraidettaglio(string as_codice);is_codice= as_codice


tab_dati.SelectTab ( tab_dati.tabpage_dati )

return tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
end event

event ue_open();//tab_dati.tabpage_ricerca.cb_query.event clicked()
end event

public function integer wf_action (integer ai_action, long al_row);choose case ai_action
		
	case LPRESENTAZIONE
		
//		OpenWithParm ( w_lettere_auto, dw_dati.getItemString(dw_dati.getRow(), "codice" ) )
		
		is_path_ldp= inca_pdf.uof_test()
		tab_dati.tabpage_visualizza.ole_viewer.visible= true
		
//	case MAIL
//		
//			mailSession mSes
//
//			mailReturnCode mRet
//			
//			mailMessage mMsg
//			
//			// Create a mail session
//			
//			mSes = create mailSession
//			
//			// Log on to the session
//			
//			mRet = mSes.mailLogon(mailNewSession!)
//			
//			IF mRet <> mailReturnSuccess! THEN
//					MessageBox("Mail", 'Logon failed.')
//					RETURN
//			
//			END IF
//			
//			// Populate the mailMessage structure
//			
//			mMsg.Subject = "boh"
//			
//			mMsg.NoteText = 'Luncheon at 12:15'
//			
////			mMsg.Recipient[1].name = 'Smith, John'
////			
////			mMsg.Recipient[2].name = 'Shaw, Sue'
//
////			mMsg.Recipient[1].name = 'GdS, GdS'
//			mMsg.Recipient[1].address= trim(this.getItemString(row, "e_mail"))
//			
//			// Send the mail
//			
//			mRet = mSes.mailSend(mMsg)
//			
//			IF mRet <> mailReturnSuccess! THEN
//					MessageBox("Mail Send", 'Mail not sent')
//					RETURN
//			
//			END IF
//			
//			mSes.mailLogoff()
//			
//			DESTROY mSes
//					
//		
//		
//		
//		
//end choose
//		//////////
		
//	case INSERIMENTO
//		
//		if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(INSERIMENTO) <0 then return -1
//		
//		tab_dati.tabpage_aggiornamento.pb_reset.enabled= true
//		tab_dati.tabpage_aggiornamento.pb_ricerca.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_cancella.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_nuovo.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_aggiorna.enabled= true
////		tab_dati.tabpage_aggiornamento.pb_chiudi.enabled= true
//		tab_dati.tabpage_aggiornamento.pb_annullaestrazione.enabled= false
//		
//		tab_dati.tabpage_aggiornamento.text= "Inserimento"
//		
//	case RICERCA
//		
//		if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(RICERCA) <0 then return -1
//		
//		tab_dati.tabpage_aggiornamento.pb_reset.enabled= true
//		tab_dati.tabpage_aggiornamento.pb_ricerca.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_cancella.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_nuovo.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_aggiorna.enabled= false
////		tab_dati.tabpage_aggiornamento.pb_chiudi.enabled= true
//		tab_dati.tabpage_aggiornamento.pb_annullaestrazione.enabled= false
//		
//		tab_dati.tabpage_aggiornamento.text= "Ricerca"
//		
//	case ESTRAZIONE
//		
//		if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(ESTRAZIONE) <0 then return -1
//		
//		tab_dati.tabpage_aggiornamento.pb_reset.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_ricerca.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_cancella.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_nuovo.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_aggiorna.enabled= false
////		tab_dati.tabpage_aggiornamento.pb_chiudi.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_annullaestrazione.enabled= true
//		
//		tab_dati.tabpage_aggiornamento.text= "Estrazione... attendere"
//		
//	case AGGIORNAMENTO
//		
//		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(AGGIORNAMENTO)
//		
//	case CANCELLAZIONE
//		
//		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(CANCELLAZIONE)
//		
//	case CHIUSURA
//		
//		integer li_ret
//		
//		boolean lb_storicogohonzon, lb_storicoesami, lb_aggiornamento
//		
//		// inserire anche controllo su modifiche in storico goh. ed esami...
//		
//		if  tab_dati.tabpage_storicogohonzon.dw_storicogohonzon.modifiedCount() > 0 or &
//			tab_dati.tabpage_storicogohonzon.dw_storicogohonzon.deletedCount() > 0 then lb_storicogohonzon= true
//			
//		if tab_dati.tabpage_storicoesami.dw_storicoesami.modifiedCount() > 0 or &
//			tab_dati.tabpage_storicoesami.dw_storicoesami.deletedCount() > 0 then lb_storicoesami= true
//			
//		lb_aggiornamento= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_modificheincorso()
//						 
//		if lb_storicogohonzon OR lb_storicoesami OR lb_aggiornamento then
//			
//			li_ret= messageBox(this.title, "Sono stati modificati dei dati: vuoi salvare?", question!, yesNoCancel!, 1)			 
//			
//			choose case li_ret
//			
//			case 1
//				
//				 if lb_aggiornamento= true then
//					if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(AGGIORNAMENTO) < 0 then goto errore
//				end if
//				 if lb_storicogohonzon= true then
//					if tab_dati.tabpage_storicogohonzon.dw_storicogohonzon.update() < 0 then goto errore
//				end if
//				 if lb_storicoesami= true then
//					if tab_dati.tabpage_storicoesami.dw_storicoesami.update() < 0 then goto errore
//				end if
//				 
//				commit;
//				if trap_sql(sqlca, "ANAG.COMMIT") < 0 then return -1
//				 
//				 errore: 	rollback;
//				 			if trap_sql(sqlca, "ANAG.ROLLBACK") < 0 then return -1
//							 
//				lb_storicogohonzon= false
//				lb_storicoesami= false
//				lb_aggiornamento= false
//				 
//			case 2
//				
//				close(this)
//				
//			case 3
//				
//				return 0 // non esegue azioni
//				
//		end choose
//		
//	end if
//		
////	case "pb_struttura"
////		
////		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_struttura(al_row)
////		
//
////	case "pb_cap"
////		
////		integer i_err, li_exists
////		string ls_cap, ls_loc, ls_vercap
////		
////		ls_cap= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.getItemString(al_row, "cap_dom")
////		ls_loc= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.getItemString(al_row, "comune")
////		
////		select cap into :ls_vercap from tapb_comuni where comune= :ls_loc;
////		
////		select count(*)  into :li_exists from cap_generici where cap= :ls_vercap;
////		
////		if isNull(li_exists) or li_exists= 0 then // se non è un cap generico...
////			if ls_vercap <> ls_cap then
////				i_err= messageBox("Verifica C.A.P.", "Il C.A.P. corretto relativo alla località "+ls_loc+" è: "+ls_vercap+"~nVuoi eseguire la correzione?", question!, yesNo!, 1)
////				if i_err= 2 then return 0
////				i_err= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.SetItem ( al_row, "cap_dom", ls_vercap )
////			else
////				messageBox("Verifica C.A.P.", "Il C.A.P. "+ls_vercap+ " relativo alla località "+ls_loc+" è corretto.")
////			end if
////		else // se è un cap generico...
////			//	i_err= messageBox(parent.title, "Il C.A.P. relativo alla località "+ls_loc +" è un C.A.P. generico.~nVuoi cercare nell'archivio strade?", question!, yesNo!, 1)
////			//	if i_err= 2 then return 
////					// apre la finestra di ricerca strade...
////					s_localita s_localita_s
////					s_localita_s.cod_com=  tab_dati.tabpage_aggiornamento.uodw_aggiornamento.getItemString(al_row, "cod_com")
////					s_localita_s.comune= ls_loc
////					s_localita_s.cap= ls_vercap
////					
////					messageBox(tab_dati.tabpage_aggiornamento.text, "Il C.A.P. relativo alla località "+is_com +" è un C.A.P. generico.~nOccorre eseguire la ricerca del C.A.P. nell'archivio strade.", information!)
////					
////					OpenWithParm(w_cerca_strade, s_localita_s)
////					is_strade_s= message.powerObjectParm
////						
////						if NOT isNull(is_strade_s.cap) then
////							
////							if is_strade_s.strada <> "" then tab_dati.tabpage_aggiornamento.uodw_aggiornamento.SetItem ( al_row, "ind_dom", trim(is_strade_s.tipo)+" "+is_strade_s.strada+" ")
////							
////							i_err= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.SetItem ( al_row, "cap_dom", is_strade_s.cap)
////			
////			//				i_err= dw_dett.SelectText(len(trim(is_strade_s.tipo)+" "+is_strade_s.strada), 0)
////		
////			end if
////				
////		end if
//		
//	case RESET
//		
//		if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(RESET) < 0 then return -1
//		
//		tab_dati.tabpage_aggiornamento.pb_reset.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_ricerca.enabled= true
//		tab_dati.tabpage_aggiornamento.pb_cancella.enabled= false
//		tab_dati.tabpage_aggiornamento.pb_nuovo.enabled= true
//		tab_dati.tabpage_aggiornamento.pb_aggiorna.enabled= false
////		tab_dati.tabpage_aggiornamento.pb_chiudi.enabled= true
//		tab_dati.tabpage_aggiornamento.pb_annullaestrazione.enabled= false
//		
////		if uof_modificheincorso() < 0 then return -1
////
////		dw_header.reset()
////		this.reset()
//		
end choose

return 0

end function

on w_schede_dati_new.create
int iCurrent
call super::create
this.tab_dati=create tab_dati
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dati
end on

on w_schede_dati_new.destroy
call super::destroy
destroy(this.tab_dati)
end on

event open;call super::open;tab_dati.tabpage_dati.dw_dati.setTransObject(sqlca)

tab_dati.tabpage_dati.dw_dati.Object.DataWindow.Print.Preview= 'Yes' 

//tab_dati.tabpage_ricerca.uo_dw_ricerca.setTransObject(sqlca)

event post ue_open()




end event

event resize;call super::resize;tab_dati.width= this.width - 120
tab_dati.x= (this.workSpaceWidth()/2 - tab_dati.width/2)
tab_dati.height= this.height -180

end event

event clicked;call super::clicked;this.show()
end event

event closequery;call super::closequery;return wf_action(CHIUSURA, 0)
end event

type tab_dati from tab within w_schede_dati_new
integer width = 4919
integer height = 2432
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
boolean pictureonright = true
integer selectedtab = 1
tabpage_ricerca tabpage_ricerca
tabpage_dati tabpage_dati
tabpage_aggiornamento tabpage_aggiornamento
tabpage_edizioni tabpage_edizioni
tabpage_storicogohonzon tabpage_storicogohonzon
tabpage_storicoesami tabpage_storicoesami
tabpage_storicocontributi tabpage_storicocontributi
tabpage_visualizza tabpage_visualizza
end type

on tab_dati.create
this.tabpage_ricerca=create tabpage_ricerca
this.tabpage_dati=create tabpage_dati
this.tabpage_aggiornamento=create tabpage_aggiornamento
this.tabpage_edizioni=create tabpage_edizioni
this.tabpage_storicogohonzon=create tabpage_storicogohonzon
this.tabpage_storicoesami=create tabpage_storicoesami
this.tabpage_storicocontributi=create tabpage_storicocontributi
this.tabpage_visualizza=create tabpage_visualizza
this.Control[]={this.tabpage_ricerca,&
this.tabpage_dati,&
this.tabpage_aggiornamento,&
this.tabpage_edizioni,&
this.tabpage_storicogohonzon,&
this.tabpage_storicoesami,&
this.tabpage_storicocontributi,&
this.tabpage_visualizza}
end on

on tab_dati.destroy
destroy(this.tabpage_ricerca)
destroy(this.tabpage_dati)
destroy(this.tabpage_aggiornamento)
destroy(this.tabpage_edizioni)
destroy(this.tabpage_storicogohonzon)
destroy(this.tabpage_storicoesami)
destroy(this.tabpage_storicocontributi)
destroy(this.tabpage_visualizza)
end on

event selectionchanged;integer li_margine= 180, li_ret

	boolean lb_storicogohonzon, lb_storicoesami, lb_aggiornamento
	
	if  tab_dati.tabpage_storicogohonzon.uo_storicogohonzon.modifiedCount() > 0 or &
		tab_dati.tabpage_storicogohonzon.uo_storicogohonzon.deletedCount() > 0 then lb_storicogohonzon= true
		
	if tab_dati.tabpage_storicoesami.dw_storicoesami.modifiedCount() > 0 or &
		tab_dati.tabpage_storicoesami.dw_storicoesami.deletedCount() > 0 then lb_storicoesami= true
		
	lb_aggiornamento= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_modificheincorso()
					 
	if lb_storicogohonzon OR lb_storicoesami OR lb_aggiornamento then
		
		li_ret= messageBox(parent.title, "Sono stati modificati dei dati: vuoi salvare?", question!, okCancel!, 1)			 
		
		choose case li_ret
		
		case 1
			
			 if lb_aggiornamento= true then
				if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(AGGIORNAMENTO) < 0 then goto errore
			end if
			 if lb_storicogohonzon= true then
				if tab_dati.tabpage_storicogohonzon.uo_storicogohonzon.update() < 0 then goto errore
			end if
			 if lb_storicoesami= true then
				if tab_dati.tabpage_storicoesami.dw_storicoesami.update() < 0 then goto errore
			end if
			 
			commit;
			if trap_sql(sqlca, "ANAG.COMMIT") < 0 then return -1
			
			return 0
			 
			 errore: 	rollback;
						if trap_sql(sqlca, "ANAG.ROLLBACK") < 0 then return -1
						messageBox(parent.title, "Errore in salvataggio dati.", exclamation!)
						return -1
						
			lb_storicogohonzon= false
			lb_storicoesami= false
			lb_aggiornamento= false
			 
		case 2
			
			return 0 // non esegue azioni
			
	end choose
	
end if

choose case newindex
		
	case 1
		
		tabpage_ricerca.setRedraw(false)
		
		tabpage_ricerca.uo_dw_ricerca.height= this.tabpage_ricerca.height - 450
		
		tabpage_ricerca.uo_dw_ricerca.width= this.tabpage_ricerca.width - 20
		
		tabpage_ricerca.uo_ricerca.y= tabpage_ricerca.uo_dw_ricerca.height
		tabpage_ricerca.uo_ricerca.x= tabpage_ricerca.uo_dw_ricerca.width - tabpage_ricerca.uo_ricerca.width
		
		tabpage_ricerca.setRedraw(true)
		
	case 2 // Visualizza la scheda anagrafica (public)
		
		tabpage_dati.dw_dati.height= this.height - li_margine
		tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
		
	case 3 // Maschera di modifica dei dati (segreteria+superuser)
		
		tabpage_aggiornamento.uodw_aggiornamento.height= this.height - li_margine
		
//		tabpage_aggiornamento.uodw_aggiornamento.object.b_nuovo.visible= false
//		tabpage_aggiornamento.uodw_aggiornamento.object.b_ricerca.visible= false
//		tabpage_aggiornamento.uodw_aggiornamento.object.b_estrazione.visible= false
//		tabpage_aggiornamento.uodw_aggiornamento.object.b_salva.visible= false
//		tabpage_aggiornamento.uodw_aggiornamento.object.b_chiudi.visible= false
//		tabpage_aggiornamento.uodw_aggiornamento.object.b_reset.visible= false
		
//		tabpage_aggiornamento.uodw_aggiornamento.object.b_cancella.visible= false
//		if gi_classediutenza= DIREZIONESEGRETERIA then tabpage_aggiornamento.uodw_aggiornamento.object.b_cancella.visible= true
		
//		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.x= (this.Width/2 - tab_dati.tabpage_aggiornamento.uodw_aggiornamento.width/2) -tab_dati.tabpage_aggiornamento.uodw_aggiornamento.x
//		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.y= (this.height/2 - tab_dati.tabpage_aggiornamento.uodw_aggiornamento.height/2) -tab_dati.tabpage_aggiornamento.uodw_aggiornamento.y
		tabpage_aggiornamento.uodw_aggiornamento.setTransObject(sqlca)
		tabpage_aggiornamento.uodw_aggiornamento.retrieve(is_codice)
		
	case 4 // Visualizza i dati delle edizioni (public)
		
		tabpage_edizioni.dw_pubblicazioni.height= this.height - li_margine
		
		tabpage_edizioni.cbx_storico.checked= false
		tabpage_edizioni.cbx_storico.event clicked()
		
		tabpage_edizioni.dw_pubblicazioni.setTransObject(sqlca_ediz)
		tabpage_edizioni.dw_pubblicazioni.retrieve(long(left(is_codice, len(is_codice) - 2)), right(is_codice, 2) )
		
	case 5 // Visualizza lo storico Gohonzon  (segreteria+superuser)
		
		long ll_rows
		
			tabpage_storicogohonzon.uo_storicogohonzon.height= this.height - li_margine
		
			tabpage_storicogohonzon.uo_storicogohonzon.setRowFocusIndicator(focusRect!)
		
			tabpage_storicogohonzon.uo_storicogohonzon.SetTransObject ( sqlca )
		
			ll_rows = tabpage_storicogohonzon.uo_storicogohonzon.Retrieve ( is_codice )
		
//			cb_new.enabled= NOT is_cg
		
			choose case ll_rows
					
				case -1
			
				case is > 0
					
//					cb_canc.enabled= NOT is_cg
					
				case else
					
			end choose
		
			tab_dati.tabpage_storicogohonzon.uo_storicogohonzon.SetFocus ( )

		
	case 6 // Visualizza lo storico esami  (segreteria+superuser)
		
				tabpage_storicoesami.dw_storicoesami.height= this.height - li_margine
				
				tabpage_storicoesami.dw_storicoesami.setRowFocusIndicator(focusRect!)
				
				tabpage_storicoesami.dw_storicoesami.SetTransObject ( sqlca )
				
				ll_rows = tabpage_storicoesami.dw_storicoesami.Retrieve ( is_codice )
				
		//			cb_new.enabled= NOT is_cg
				
					choose case ll_rows
							
						case -1

						case is > 0
							
		//					cb_canc.enabled= NOT is_cg
							
						case else
							
					end choose
		
					 tab_dati.tabpage_storicoesami.dw_storicoesami.SetFocus ( )
		
	case 7 // Visualizza lo storico contributi (superuser)
		
				tabpage_storicocontributi.dw_storicocontributi.height= this.height - li_margine
		
				tabpage_storicocontributi.cbx_importi.enabled= false
				
				tabpage_storicocontributi.dw_storicocontributi.setTransObject(sqlca)
		
				tabpage_storicocontributi.dw_storicocontributi.setRedraw(false)
				
				ll_rows= tabpage_storicocontributi.dw_storicocontributi.retrieve(is_codice)
				
				tabpage_storicocontributi.dw_storicocontributi.Object.importo.Visible= 0
				
				if ll_rows > 0 and gi_classediutenza= DIREZIONESEGRETERIA then
						
						tabpage_storicocontributi.cb_stampa.enabled= true
						tabpage_storicocontributi.cbx_importi.enabled= true
						
				end if
				
				tabpage_storicocontributi.dw_storicocontributi.setRedraw(true)
				
	case 8 // Visualizza gli originali delle schede di adesione (segreteria+superuser)
		
			if isNull(is_path_ldp) or is_path_ldp= "" then return -1
			tab_dati.tabpage_visualizza.ole_viewer.object.SRC= is_path_ldp
			is_path_ldp= ""
			tabpage_visualizza.ole_viewer.height= this.height - li_margine
			tabpage_visualizza.ole_viewer.width= this.width - 120

end choose
end event

type tabpage_ricerca from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4882
integer height = 2304
long backcolor = 81324524
string text = "Ricerca"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
uo_ricerca uo_ricerca
uo_dw_ricerca uo_dw_ricerca
pb_struttura pb_struttura
gb_buttons gb_buttons
end type

on tabpage_ricerca.create
this.uo_ricerca=create uo_ricerca
this.uo_dw_ricerca=create uo_dw_ricerca
this.pb_struttura=create pb_struttura
this.gb_buttons=create gb_buttons
this.Control[]={this.uo_ricerca,&
this.uo_dw_ricerca,&
this.pb_struttura,&
this.gb_buttons}
end on

on tabpage_ricerca.destroy
destroy(this.uo_ricerca)
destroy(this.uo_dw_ricerca)
destroy(this.pb_struttura)
destroy(this.gb_buttons)
end on

type uo_ricerca from uodw_buttons within tabpage_ricerca
integer x = 1463
integer y = 1948
integer taborder = 60
boolean b_enabled_ricerca = true
boolean b_enabled_estrazione = true
boolean b_enabled_annulla = true
boolean b_enabled_reset = true
end type

event itemchanged;call super::itemchanged;uo_dw_ricerca.uof_esegui(integer(this.getText()))
end event

event constructor;call super::constructor;this.event buttonClicked(1, 0, uo_ricerca.object.b_ricerca)

uo_dw_ricerca.setColumn("cognome")

uo_dw_ricerca.setFocus()
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "b_reset" then setNull(is_codice)
end event

type uo_dw_ricerca from uodw_anagrafica within tabpage_ricerca
event ue_struttura ( )
event ue_keyenter pbm_dwnprocessenter
integer height = 1924
integer taborder = 30
string dataobject = "dw_ricerca_associati"
end type

event ue_struttura();s_struttura s_struttura_s

s_struttura_s.livello= MAX_LIVELLO

openWithParm(w_mostra_struttura, s_struttura_s)

s_struttura_s= message.powerObjectParm

this.setColumn("vc_parent")
this.setText(s_struttura_s.vc_nodo) 

return 
end event

event ue_keyenter;uo_ricerca.event buttonClicked(1, 0, uo_ricerca.object.b_estrazione)

end event

event doubleclicked;call super::doubleclicked;if lower(this.Object.DataWindow.QueryMode) = "yes" or row= 0 then return

tab_dati.selectTab( w_schede_dati.tab_dati.tabpage_dati ) 
end event

event retrieveend;call super::retrieveend;if rowCount > 0 then
	
	is_codice= this.getItemString(1, "codice")

//	w_schede_dati.tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
//	
//	w_schede_dati.is_codice= is_codice
	
end if
end event

event rowfocuschanged;call super::rowfocuschanged;if lower(this.Object.DataWindow.QueryMode)= 'no'  and this.getRow() > 0 then
	
	f_select_current_row(this)
	
	setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
	
//	w_schede_dati.tab_dati.selectTab(w_schede_dati.tab_dati.tabpage_dati)

	is_codice= this.getItemString(this.getRow(), "codice")

//	w_schede_dati.tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
//	
//	w_schede_dati.is_codice= is_codice
//	
//	w_schede_dati.tab_dati.tabpage_visualizza.ole_viewer.visible= false
	
//else
//	
//	w_schede_dati.tab_dati.tabpage_dati.dw_dati.reset()

end if
end event

event sqlpreview;call super::sqlpreview;f_sql_use_like(sqlType, sqlsyntax, uo_dw_ricerca, false)

SetSqlPreview ( sqlsyntax)
end event

type pb_struttura from picturebutton within tabpage_ricerca
integer x = 4562
integer y = 1448
integer width = 174
integer height = 136
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string picturename = "where.bmp"
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

event clicked;//uo_dw_buttons.event ue_struttura()
end event

type gb_buttons from groupbox within tabpage_ricerca
integer x = 4530
integer y = 1424
integer width = 247
integer height = 204
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type tabpage_dati from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4882
integer height = 2304
long backcolor = 81324524
string text = "Scheda anagrafica"
long tabtextcolor = 8388608
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
pb_scheda pb_scheda
pb_stampa_boll pb_stampa_boll
pb_ldp pb_ldp
pb_cartellino pb_cartellino
dw_dati dw_dati
end type

on tabpage_dati.create
this.pb_scheda=create pb_scheda
this.pb_stampa_boll=create pb_stampa_boll
this.pb_ldp=create pb_ldp
this.pb_cartellino=create pb_cartellino
this.dw_dati=create dw_dati
this.Control[]={this.pb_scheda,&
this.pb_stampa_boll,&
this.pb_ldp,&
this.pb_cartellino,&
this.dw_dati}
end on

on tabpage_dati.destroy
destroy(this.pb_scheda)
destroy(this.pb_stampa_boll)
destroy(this.pb_ldp)
destroy(this.pb_cartellino)
destroy(this.dw_dati)
end on

type pb_scheda from picturebutton within tabpage_dati
integer x = 3831
integer y = 860
integer width = 475
integer height = 224
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa scheda anagrafica"
boolean originalsize = true
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

event clicked;openWithParm(w_dw_print_options, tab_dati.tabpage_dati.dw_dati)
end event

type pb_stampa_boll from picturebutton within tabpage_dati
integer x = 3831
integer y = 612
integer width = 475
integer height = 224
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa bollettino"
boolean originalsize = true
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

type pb_ldp from picturebutton within tabpage_dati
integer x = 3831
integer y = 364
integer width = 475
integer height = 224
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lettera di presentazione"
boolean originalsize = true
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

event clicked;string ls_codice, &
lsa_resp[]= {"None", "Block", "District", "Chapter", "Headquarter", "Territory", "Area", "National", "Generale director"}, &
lsa_studio[]= {"None", "1° Level", "2° Level", "3° Level", "4° Level", "5° Level"}, &
lsa_div[]={"MD", "WD", "YMD", "YWD"}

// Recupera il jpg con la firma
if messageBox(parent.text, "Vuoi aggiungere una firma al documento?", question!, yesNo!, 2)= 1 then
	open(w_dirlist)
	inca_pdf.isa_valori[9]= message.stringParm
end if

ls_codice= dw_dati.getItemString(dw_dati.getRow(), "codice")


inca_pdf.isa_datipersonali[1]= 'nome'
inca_pdf.isa_datipersonali[2]= 'responsabilita'
inca_pdf.isa_datipersonali[3]= 'divisione'
inca_pdf.isa_datipersonali[4]= 'data_cerimonia'
inca_pdf.isa_datipersonali[5]= 'data_nascita'
inca_pdf.isa_datipersonali[6]= 'livello_studio'
inca_pdf.isa_datipersonali[7]= 'organizzazione'
inca_pdf.isa_datipersonali[8]= 'indirizzo'
inca_pdf.isa_datipersonali[9]= 'firma'
inca_pdf.isa_datipersonali[10]= 'data_odierna'

select nome+" "+cognome,
		cod_att_ist_1,
		cod_div,
		convert(varchar,  data_cer),
		convert(varchar, data_nas),
		cod_studio,
		vc_parent,
		ind_dom+"  -  "+cap_dom+" - "+comune
		into	:inca_pdf.isa_valori[1],
				:inca_pdf.isa_valori[2],
				:inca_pdf.isa_valori[3],
				:inca_pdf.isa_valori[4],
				:inca_pdf.isa_valori[5],
				:inca_pdf.isa_valori[6],
				:inca_pdf.isa_valori[7],
				:inca_pdf.isa_valori[8]
		from membri_gerarchica, tab_comuni
		where membri_gerarchica.cod_com= tab_comuni.cod_com and codice= :ls_codice;
		
		if trap_sql(sqlca, "LPRESENTAZIONE01") < 0 then return -1
		
inca_pdf.isa_valori[10]= string(today(), "dd.mm.yyyy")

inca_pdf.isa_valori[2]= lsa_resp[long(mid(inca_pdf.isa_valori[2], 1, 1) ) + 1 ] // responsabilità

inca_pdf.isa_valori[3]= lsa_div[long(inca_pdf.isa_valori[3] ) ] // divisione

inca_pdf.isa_valori[6]= lsa_studio[long(inca_pdf.isa_valori[6] ) + 1 ] // studio

if wf_action(LPRESENTAZIONE, 0) < 0 then return -1

return tab_dati.selectTab(tab_dati.tabpage_visualizza)
end event

type pb_cartellino from picturebutton within tabpage_dati
integer x = 3831
integer y = 116
integer width = 475
integer height = 224
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fa il badge"
boolean originalsize = true
alignment htextalign = left!
end type

type dw_dati from datawindow within tabpage_dati
integer width = 3790
integer height = 1616
integer taborder = 10
string dataobject = "dw_scheda_anagrafica_gerarchica"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;//choose case dwo.name
		
//	case "b_lettera_presentazione"
//		
////		OpenWithParm ( w_lettere_auto, dw_dati.getItemString(dw_dati.getRow(), "codice" ) )
//		nca_test lnca_test
//		
//		lnca_test.uof_test()
//		
//	case "b_mail"
//		
//			mailSession mSes
//
//			mailReturnCode mRet
//			
//			mailMessage mMsg
//			
//			// Create a mail session
//			
//			mSes = create mailSession
//			
//			// Log on to the session
//			
//			mRet = mSes.mailLogon(mailNewSession!)
//			
//			IF mRet <> mailReturnSuccess! THEN
//					MessageBox("Mail", 'Logon failed.')
//					RETURN
//			
//			END IF
//			
//			// Populate the mailMessage structure
//			
//			mMsg.Subject = "boh"
//			
//			mMsg.NoteText = 'Luncheon at 12:15'
//			
////			mMsg.Recipient[1].name = 'Smith, John'
////			
////			mMsg.Recipient[2].name = 'Shaw, Sue'
//
////			mMsg.Recipient[1].name = 'GdS, GdS'
//			mMsg.Recipient[1].address= trim(this.getItemString(row, "e_mail"))
//			
//			// Send the mail
//			
//			mRet = mSes.mailSend(mMsg)
//			
//			IF mRet <> mailReturnSuccess! THEN
//					MessageBox("Mail Send", 'Mail not sent')
//					RETURN
//			
//			END IF
//			
//			mSes.mailLogoff()
//			
//			DESTROY mSes
//					
//		
//		
//		
//		
//end choose

return 0
end event

event retrieveend;//	dw_current.setFocus()
//	dw_current.setColumn("cognome")
end event

type tabpage_aggiornamento from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4882
integer height = 2304
long backcolor = 67108864
string text = "Aggiornamento dati"
long tabtextcolor = 8388736
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
uodw_aggiornamento uodw_aggiornamento
end type

on tabpage_aggiornamento.create
this.uodw_aggiornamento=create uodw_aggiornamento
this.Control[]={this.uodw_aggiornamento}
end on

on tabpage_aggiornamento.destroy
destroy(this.uodw_aggiornamento)
end on

type uodw_aggiornamento from uodw_anagrafica within tabpage_aggiornamento
integer width = 4192
integer height = 2180
integer taborder = 40
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_dwtype = true
end type

event retrieveend;call super::retrieveend;string ls_struttura

if this.getRow() <= 0 then return -1

ls_struttura= this.getItemString(this.getRow(), "vc_parent")

ls_struttura= f_descrizione_struttura_estesa(ls_struttura)

this.setItem(this.getRow(), "cstruttura", ls_struttura)

//ls_struttura= f_global_replace(ls_struttura, ".", "~r")
//
//dw_current.Object.t_struttura.Text= ls_struttura

uodw_aggiornamento.ResetUpdate() // la riga estratta è come nuova anche dopo l'inserimento della descrizione estesa...
end event

event itemchanged;call super::itemchanged;integer i_err, li_exists
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
			
		CASE "cod_div"
			
//			f_log ( "Cambi di divisione", is_vecchiaOrganizzazione+" - "+is_cognome+ " "+is_nome+&
//									" - Da div. " + isa_cod_div[integer(is_cod_div)] + " a div. "+ isa_cod_div[integer(data)] )
			
		CASE "comune"
			
			s_strade s_strade_s
			
			s_strade_s.comune= trim(data)
			
			s_strade_s= f_cap(s_strade_s.comune)
			
			choose case s_strade_s.return_code
					
				case 0
					
					messageBox(this.title, "Operazione annullata.", information!)
					
				case -1
					
					return -1
					
				case 1
					
					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					i_err= this.SetItem ( row, "comune", s_strade_s.comune)
					
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.provincia)
					
					i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
								
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
				case 2
					
					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					i_err= this.SetItem ( row, "comune", s_strade_s.comune)
					
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
			end choose
		
						
		CASE "cod_att_ist_1"
			
//			f_log ( "Modica responsabilità principale", is_vecchiaOrganizzazione+" - "+is_cognome + " " + is_nome)
			
			if data = "000" then
				SetItem ( row, "cod_att_ist_2", "000" )
				this.Object.cod_att_ist_2.Protect='1'
			else
				this.Object.cod_att_ist_2.Protect='0'
			end if
			
		CASE "cod_att_ist_2"
			
//			f_log ( "Modica responsabilità secondaria", is_vecchiaOrganizzazione+" - "+is_cognome + " " + is_nome)
			
		CASE "data_nas"
			
//			if f_min ( data ) = 1 then
//				if MessageBox ( parent.title, "E' consentito inserire minorenni solo con il consenso dei genitori."+&
//														"~nAbbiamo il modulo di consenso firmato da ambedue i genitori?" , question!, yesNo!, 2)= 2 then
//					return 1
//				else
//					return 0
//				end if
//			end if
			
//			SetColumn ( "cod_div" )
			
		CASE "data_cer"
			
			if date ( mid ( data, 1, 10 ) ) > today ( ) then
				MessageBox ( "Attenzione", "Data posteriore a quella odierna.", exclamation! )
				return 1
			end if
			
			SetColumn ( "luogo_cer" )
			
		case "cod_dis"
			
			if (data = "ATT" or data= 'NRC') and this.getItemString(row, "flag_er") = 'S'  then
				SetItem ( row, "flag_dis", "N" ) 
			else
				SetItem ( row, "flag_dis", "S" )
			end if
			
//			f_log ( "Cambi di status", is_vecchiaOrganizzazione+" - "+is_cognome + " " + is_nome+" - da: "+is_cod_dis+" a: "+data )
			
			// Valorizzo a seconda del nuovo status una delle tre date possibili in modo da poter 
			// identificare il passaggio ad una delle tre fasce(1: ATT e NPA, 2: NOP e TAI, 3: DEC TFE e DIM)
			if data= 'ATT' or data= 'NRC' then
				setItem(row, "dt_attnpa", today() )
			elseif data= "TAI" then
				setItem(row, "dt_noptai", today() )
			else
				setItem(row, "dt_dectfedim", today() )
			end if
			
		case "flag_er"
			
			if (data = "N") then SetItem ( row, "flag_dis", "S" ) else SetItem ( row, "flag_dis", "N" )
		
//			f_log ( "Adesione E.R.", is_vecchiaOrganizzazione+" - "+is_cognome + " " + is_nome+" - "+"modificato in: "+data )
			
		case "codice_staff"
			
//				if data= "000" then
//					m_anag.m_principale.m_staff.enabled = false
//				else
//					m_anag.m_principale.m_staff.enabled = true		
//				end if
			
		CASE else

	END CHOOSE
	
		if this.object.b_salva.visible= '0' then
			if gi_classediutenza >= SEGRETERIA then this.object.b_salva.visible= '1'
		end if

end if

return 0

end event

event resize;call super::resize;//this.height= parent.height - 180
end event

type tabpage_edizioni from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4882
integer height = 2304
long backcolor = 81324524
string text = "Dati edizioni"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
cbx_storico cbx_storico
dw_pubblicazioni dw_pubblicazioni
end type

on tabpage_edizioni.create
this.cbx_storico=create cbx_storico
this.dw_pubblicazioni=create dw_pubblicazioni
this.Control[]={this.cbx_storico,&
this.dw_pubblicazioni}
end on

on tabpage_edizioni.destroy
destroy(this.cbx_storico)
destroy(this.dw_pubblicazioni)
end on

type cbx_storico from checkbox within tabpage_edizioni
integer x = 3497
integer y = 136
integer width = 919
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostra lo storico abbonamenti"
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked= true then
	dw_pubblicazioni.setFilter("")
else
	dw_pubblicazioni.setFilter("copie_residue> 0")
end if

dw_pubblicazioni.filter()
end event

type dw_pubblicazioni from datawindow within tabpage_edizioni
integer y = 12
integer width = 3397
integer height = 1764
integer taborder = 20
string title = "none"
string dataobject = "dw_pubblicazioni"
boolean vscrollbar = true
boolean border = false
string icon = "Report5!"
boolean livescroll = true
end type

type tabpage_storicogohonzon from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4882
integer height = 2304
long backcolor = 67108864
string text = "Storico Gohonzon"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uo_storicogohonzon uo_storicogohonzon
end type

on tabpage_storicogohonzon.create
this.uo_storicogohonzon=create uo_storicogohonzon
this.Control[]={this.uo_storicogohonzon}
end on

on tabpage_storicogohonzon.destroy
destroy(this.uo_storicogohonzon)
end on

type uo_storicogohonzon from uodw_anagrafica within tabpage_storicogohonzon
integer y = 8
integer width = 3081
integer height = 1948
integer taborder = 20
string dataobject = "d_storico_goh"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event resize;call super::resize;this.height= parent.height - 180
end event

type tabpage_storicoesami from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4882
integer height = 2304
long backcolor = 81324524
string text = "Storico esami"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_storicoesami dw_storicoesami
end type

on tabpage_storicoesami.create
this.dw_storicoesami=create dw_storicoesami
this.Control[]={this.dw_storicoesami}
end on

on tabpage_storicoesami.destroy
destroy(this.dw_storicoesami)
end on

type dw_storicoesami from datawindow within tabpage_storicoesami
integer width = 1678
integer height = 1776
integer taborder = 20
string title = "none"
string dataobject = "ds_curr_studio"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event dberror;//f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1
end event

event itemerror;return 3
end event

event resize;this.height= parent.height - 180
end event

type tabpage_storicocontributi from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4882
integer height = 2304
long backcolor = 81324524
string text = "Storico contributi"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_stampa cb_stampa
dw_storicocontributi dw_storicocontributi
cbx_importi cbx_importi
end type

on tabpage_storicocontributi.create
this.cb_stampa=create cb_stampa
this.dw_storicocontributi=create dw_storicocontributi
this.cbx_importi=create cbx_importi
this.Control[]={this.cb_stampa,&
this.dw_storicocontributi,&
this.cbx_importi}
end on

on tabpage_storicocontributi.destroy
destroy(this.cb_stampa)
destroy(this.dw_storicocontributi)
destroy(this.cbx_importi)
end on

type cb_stampa from commandbutton within tabpage_storicocontributi
integer x = 2697
integer y = 200
integer width = 334
integer height = 184
integer taborder = 12
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Stampa"
end type

event clicked;openWithParm(w_dw_print_options, tab_dati.tabpage_storicocontributi.dw_storicocontributi)
end event

type dw_storicocontributi from datawindow within tabpage_storicocontributi
integer y = 8
integer width = 2674
integer height = 1624
integer taborder = 10
string dataobject = "dw_info"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event sqlpreview;return 0
end event

event resize;this.height= parent.height - 180
end event

type cbx_importi from checkbox within tabpage_storicocontributi
integer x = 2697
integer y = 96
integer width = 594
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Visualizza importi"
end type

event clicked;integer i_ret

if this.checked= true then
	
	open(w_check_pw)
	
	i_ret= message.doubleParm
	
	if i_ret= 1 then
		
		//visualizza gli importi
		tab_dati.tabpage_storicocontributi.dw_storicocontributi.Object.importo.Visible= 1
		tab_dati.tabpage_storicocontributi.dw_storicocontributi.Object.importo_t.Visible= 1
		
	else
		
		this.checked= false
		
	end if
	
else
	
	tab_dati.tabpage_storicocontributi.dw_storicocontributi.Object.importo.Visible= 0
	tab_dati.tabpage_storicocontributi.dw_storicocontributi.Object.importo_t.Visible= 0
	
end if
end event

type tabpage_visualizza from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4882
integer height = 2304
long backcolor = 67108864
string text = "Visualizza"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
ole_viewer ole_viewer
end type

on tabpage_visualizza.create
this.ole_viewer=create ole_viewer
this.Control[]={this.ole_viewer}
end on

on tabpage_visualizza.destroy
destroy(this.ole_viewer)
end on

type ole_viewer from olecustomcontrol within tabpage_visualizza
integer width = 4279
integer height = 1816
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_schede_dati_new.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
03w_schede_dati_new.bin 
2700000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000070d7bd1001c6f38300000003000001400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000f400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003ca8a978011cf280d45444da2000054530000000070d7bd1001c6f38370d7bd1001c6f383000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000040000001100000000000000010000000200000003fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
23ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020105ca8a978011cf280d45444da20000545300000001fb8f0821101b01640008ed8413c72e2b00000030000000c400000006000001000000003800000101000000400000010200000048000001030000005000000104000000580000000000000064000000030005000000000003000060bd0000000300002eec00000003000000000000000800000001000000000000000600000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747804007974040000017300000000006372090000015f00000073726576006e6f6900700000006d00620075005f00050000000060bd00002eec00000000006c00000034003200700000006d00620075005f006e006f0078006500650074006e0072006c00610035003200700000006d00620076005f0078006200760065006e0065003000740000003100620070005f006d0062007600650078006500760074006e0032003000700000006d00620076005f0078006200760065006e0065003000740000003300620070005f006d0062007600650078006500760074006e0034003000700000006d00620076005f0078006200760065006e0065003000740000003500620070005f006d0062007600650078006500760074006e0036003000700000006d00620076005f00780062000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13w_schede_dati_new.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
