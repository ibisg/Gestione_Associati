$PBExportHeader$w_schede_dati.srw
forward
global type w_schede_dati from w_centered
end type
type tab_dati from tab within w_schede_dati
end type
type tabpage_ricerca from userobject within tab_dati
end type
type st_3 from statictext within tabpage_ricerca
end type
type cb_ordina from commandbutton within tabpage_ricerca
end type
type pb_struttura from picturebutton within tabpage_ricerca
end type
type cb_query from commandbutton within tabpage_ricerca
end type
type cb_dbcancel from commandbutton within tabpage_ricerca
end type
type dw_current from datawindow within tabpage_ricerca
end type
type gb_buttons from groupbox within tabpage_ricerca
end type
type tabpage_ricerca from userobject within tab_dati
st_3 st_3
cb_ordina cb_ordina
pb_struttura pb_struttura
cb_query cb_query
cb_dbcancel cb_dbcancel
dw_current dw_current
gb_buttons gb_buttons
end type
type tabpage_dati from userobject within tab_dati
end type
type pb_mail from picturebutton within tabpage_dati
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
pb_mail pb_mail
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
type gb_pubblicazioni from groupbox within tabpage_edizioni
end type
type gb_testata from groupbox within tabpage_edizioni
end type
type tabpage_edizioni from userobject within tab_dati
cbx_storico cbx_storico
dw_pubblicazioni dw_pubblicazioni
gb_pubblicazioni gb_pubblicazioni
gb_testata gb_testata
end type
type tabpage_storico from userobject within tab_dati
end type
type cb_salva_se from commandbutton within tabpage_storico
end type
type cb_rimuovi_sg from commandbutton within tabpage_storico
end type
type cb_aggiungi_sg from commandbutton within tabpage_storico
end type
type uo_dw_se from uodw_generica within tabpage_storico
end type
type uo_dw_sg from uodw_generica within tabpage_storico
end type
type cb_rimuovi_se from commandbutton within tabpage_storico
end type
type cb_aggiungi_se from commandbutton within tabpage_storico
end type
type gb_1 from groupbox within tabpage_storico
end type
type cb_salva_sg from commandbutton within tabpage_storico
end type
type gb_sg from groupbox within tabpage_storico
end type
type tabpage_storico from userobject within tab_dati
cb_salva_se cb_salva_se
cb_rimuovi_sg cb_rimuovi_sg
cb_aggiungi_sg cb_aggiungi_sg
uo_dw_se uo_dw_se
uo_dw_sg uo_dw_sg
cb_rimuovi_se cb_rimuovi_se
cb_aggiungi_se cb_aggiungi_se
gb_1 gb_1
cb_salva_sg cb_salva_sg
gb_sg gb_sg
end type
type tabpage_storicocontributi from userobject within tab_dati
end type
type cb_stampa from commandbutton within tabpage_storicocontributi
end type
type cbx_importi from checkbox within tabpage_storicocontributi
end type
type dw_storicocontributi from datawindow within tabpage_storicocontributi
end type
type gb_offerte from groupbox within tabpage_storicocontributi
end type
type tabpage_storicocontributi from userobject within tab_dati
cb_stampa cb_stampa
cbx_importi cbx_importi
dw_storicocontributi dw_storicocontributi
gb_offerte gb_offerte
end type
type tabpage_visualizza from userobject within tab_dati
end type
type ole_viewer from olecustomcontrol within tabpage_visualizza
end type
type tabpage_visualizza from userobject within tab_dati
ole_viewer ole_viewer
end type
type tabpage_liste from userobject within tab_dati
end type
type dw_cod_lista from datawindow within tabpage_liste
end type
type cb_rimuovi from commandbutton within tabpage_liste
end type
type cb_aggiungi from commandbutton within tabpage_liste
end type
type dw_dettaglio_liste from datawindow within tabpage_liste
end type
type gb_2 from groupbox within tabpage_liste
end type
type tabpage_liste from userobject within tab_dati
dw_cod_lista dw_cod_lista
cb_rimuovi cb_rimuovi
cb_aggiungi cb_aggiungi
dw_dettaglio_liste dw_dettaglio_liste
gb_2 gb_2
end type
type tab_dati from tab within w_schede_dati
tabpage_ricerca tabpage_ricerca
tabpage_dati tabpage_dati
tabpage_aggiornamento tabpage_aggiornamento
tabpage_edizioni tabpage_edizioni
tabpage_storico tabpage_storico
tabpage_storicocontributi tabpage_storicocontributi
tabpage_visualizza tabpage_visualizza
tabpage_liste tabpage_liste
end type
end forward

global type w_schede_dati from w_centered
integer width = 5001
integer height = 3424
string title = "Gestione associati"
long backcolor = 81324524
string icon = "Database!"
boolean clientedge = true
event type long ue_estraidettaglio ( string as_codice )
event ue_open ( )
event type integer ue_cerca ( string as_searchstring )
tab_dati tab_dati
end type
global w_schede_dati w_schede_dati

type variables
boolean ib_dbcancel
dataWindowChild idwc_liste
long il_dwy, il_dwh
string is_codice, is_cod_com, is_com, is_prov, is_cap, is_path_ldp
s_strade is_strade_s
s_parm s_parm_s
s_struttura is_struttura_s

u_ds_com ids_com

nca_pdf inca_pdf
end variables

forward prototypes
public function integer wf_action (integer ai_action, long al_row)
end prototypes

event type long ue_estraidettaglio(string as_codice);is_codice= as_codice


tab_dati.SelectTab ( tab_dati.tabpage_aggiornamento )

return tab_dati.tabpage_aggiornamento.uodw_aggiornamento.retrieve(is_codice)
end event

event ue_open();is_codice= message.stringParm

tab_dati.setRedraw(false)

if is_codice= "" then
	
	tab_dati.tabpage_ricerca.cb_query.event clicked()
	
else
	
	tab_dati.tabpage_ricerca.visible= false
	
	tab_dati.SelectTab ( 3 )
	
	tab_dati.tabpage_aggiornamento.uodw_aggiornamento.setTransObject(sqlca)

	tab_dati.tabpage_aggiornamento.uodw_aggiornamento.retrieve(is_codice)
	
end if

tab_dati.setRedraw(true)
end event

event type integer ue_cerca(string as_searchstring);//long ll_rows
//string ls_struttura
//
//ids_struttura.reset()
//
//SetPointer ( hourglass! )
//w_frame_gestioneassociati.SetRedraw ( false )
//
//ll_rows= ids_struttura.retrieve("%"+sle_cerca.text+"%")
//
//choose case ll_rows
//		
//	case 0
//		
//		messageBox(this.title, "Struttura non trovata.", exclamation!)
//		
//		goto notfound
//		
//	case 1
//		
//		ls_struttura= ids_struttura.getItemString(1, "vc_nodo")
//		
//	case is > 1
//
//		if OpenWithParm (w_ricerca_struttura, "%"+sle_cerca.text+"%") < 0 then return -1
//
//		ls_struttura= message.stringParm
//		
//end choose
//
//if ls_struttura <> ""  then
//
//	tv_struttura.uf_cerca_nodo(ls_struttura)
//	
//end if
//
//notfound: 
//
//sle_cerca.selectText(1, len(sle_cerca.text) )
//sle_cerca.setFocus()
//
//w_frame_gestioneassociati.SetRedraw ( true )

return 0
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

on w_schede_dati.create
int iCurrent
call super::create
this.tab_dati=create tab_dati
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dati
end on

on w_schede_dati.destroy
call super::destroy
destroy(this.tab_dati)
end on

event open;call super::open;//test

//enumerationDefinition myEnum
//EnumerationItemDefinition	myEnumItem[]
////myEnum.category= enumeratedType!
////myEnum.DataTypeOf= string
//
//myEnum.myEnumItem[1, 1]= "RIGACELESTE"
//myEnum.myEnumItem[1, 2]= rgb(235,246,255)


//

tab_dati.tabpage_dati.dw_dati.setTransObject(sqlca)

tab_dati.tabpage_dati.dw_dati.Object.DataWindow.Print.Preview= 'Yes' 

tab_dati.tabpage_ricerca.dw_current.setTransObject(sqlca)

tab_dati.tabpage_aggiornamento.uodw_aggiornamento.setTransObject(sqlca)
	
event  post ue_open()






end event

event resize;call super::resize;tab_dati.width= this.width - 120
tab_dati.x= (this.workSpaceWidth()/2 - tab_dati.width/2)
tab_dati.height= this.height - 180

////		tab_dati.tabpage_ricerca.dw_current.height= t - 180
////		tab_dati.tabpage_originali.ole_1.height= tab_dati.height - 180

end event

event clicked;call super::clicked;this.show()
end event

event closequery;call super::closequery;return wf_action(CHIUSURA, 0)
end event

type tab_dati from tab within w_schede_dati
integer width = 4791
integer height = 2512
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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
tabpage_storico tabpage_storico
tabpage_storicocontributi tabpage_storicocontributi
tabpage_visualizza tabpage_visualizza
tabpage_liste tabpage_liste
end type

on tab_dati.create
this.tabpage_ricerca=create tabpage_ricerca
this.tabpage_dati=create tabpage_dati
this.tabpage_aggiornamento=create tabpage_aggiornamento
this.tabpage_edizioni=create tabpage_edizioni
this.tabpage_storico=create tabpage_storico
this.tabpage_storicocontributi=create tabpage_storicocontributi
this.tabpage_visualizza=create tabpage_visualizza
this.tabpage_liste=create tabpage_liste
this.Control[]={this.tabpage_ricerca,&
this.tabpage_dati,&
this.tabpage_aggiornamento,&
this.tabpage_edizioni,&
this.tabpage_storico,&
this.tabpage_storicocontributi,&
this.tabpage_visualizza,&
this.tabpage_liste}
end on

on tab_dati.destroy
destroy(this.tabpage_ricerca)
destroy(this.tabpage_dati)
destroy(this.tabpage_aggiornamento)
destroy(this.tabpage_edizioni)
destroy(this.tabpage_storico)
destroy(this.tabpage_storicocontributi)
destroy(this.tabpage_visualizza)
destroy(this.tabpage_liste)
end on

event selectionchanged;integer li_margine= 350, li_ret
long ll_rows

choose case newindex
		
	case 1
		
		tabpage_ricerca.dw_current.height= this.height - li_margine
		
//		tabpage_ricerca.gb_buttons.y= tabpage_ricerca.dw_current.height// + 15
//		
//		tabpage_ricerca.cb_dbcancel.y= tabpage_ricerca.gb_buttons.y + 45
//		
//		tabpage_ricerca.cb_query.y= tabpage_ricerca.cb_dbcancel.y
//		
//		tabpage_ricerca.pb_struttura.y= tabpage_ricerca.cb_dbcancel.y
//		
//		tabpage_ricerca.cb_ordina.y= tabpage_ricerca.cb_dbcancel.y
		
	case 2 // Visualizza la scheda anagrafica (public)
		
		tabpage_dati.dw_dati.height= this.height - li_margine
		
//		tabpage_dati.gb_trova.y= tabpage_dati.dw_dati.height
//		
//		tabpage_dati.sle_codice.y= tabpage_dati.gb_trova.y + 75
//		tabpage_dati.em_cognome.y= tabpage_dati.sle_codice.y
//		tabpage_dati.pb_trova.y= tabpage_dati.sle_codice.y
		
		
		if NOT isNull(is_codice) then tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
		
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
		if NOT isNull(is_codice) then 
			ll_rows= tabpage_aggiornamento.uodw_aggiornamento.retrieve(is_codice)
		end if
	case 4 // Visualizza i dati delle edizioni (public)
		
		tabpage_edizioni.gb_pubblicazioni.height= this.height - li_margine /*- tabpage_edizioni.gb_testata.height*/
		tabpage_edizioni.dw_pubblicazioni.height= this.height - li_margine - 120
		tabpage_edizioni.cbx_storico.checked= false
		tabpage_edizioni.cbx_storico.event clicked()
		
		tabpage_edizioni.dw_pubblicazioni.setTransObject(sqlca_ediz)
		if NOT isNull(is_codice) then tabpage_edizioni.dw_pubblicazioni.retrieve(long(left(is_codice, len(is_codice) - 2)), right(is_codice, 2) )
		
	case 5 // Visualizza lo storico Gohonzon  (segreteria+superuser)
		
//			tabpage_storico.uo_dw_sg.height= this.height - li_margine
		
			tabpage_storico.uo_dw_sg.setRowFocusIndicator(focusRect!)
		
			tabpage_storico.uo_dw_sg.SetTransObject ( sqlca )
		
			if  isNull(is_codice) then return 
			
			ll_rows = tabpage_storico.uo_dw_sg.Retrieve ( is_codice )
		
//			cb_new.enabled= NOT is_cg
		
			choose case ll_rows
					
				case -1
			
				case is > 0
					
//					cb_canc.enabled= NOT is_cg
					
				case else
					
			end choose
		
			tab_dati.tabpage_storico.uo_dw_sg.SetFocus ( )
		
//				tabpage_storico.uo_dw_se.height= this.height - li_margine
				
				tabpage_storico.uo_dw_se.setRowFocusIndicator(focusRect!)
				
				tabpage_storico.uo_dw_se.SetTransObject ( sqlca )
				
				if  isNull(is_codice) then return 
				
				ll_rows = tabpage_storico.uo_dw_se.Retrieve ( is_codice )
				
		//			cb_new.enabled= NOT is_cg
				
					choose case ll_rows
							
						case -1

						case is > 0
							
		//					cb_canc.enabled= NOT is_cg
							
						case else
							
					end choose
		
					  tabpage_storico.uo_dw_se.SetFocus ( )
		
	case 6 // Visualizza lo storico contributi (superuser)
		
				tabpage_storicocontributi.dw_storicocontributi.height= this.height - li_margine
		
				tabpage_storicocontributi.cbx_importi.enabled= false
				
				tabpage_storicocontributi.dw_storicocontributi.setTransObject(sqlca)
		
				tabpage_storicocontributi.dw_storicocontributi.setRedraw(false)
				
				if  isNull(is_codice) then return
				
				ll_rows= tabpage_storicocontributi.dw_storicocontributi.retrieve(is_codice)
				
				tabpage_storicocontributi.dw_storicocontributi.Object.importo.Visible= 0
				
				if ll_rows > 0 and gi_classediutenza= DIREZIONESEGRETERIA then
						
						tabpage_storicocontributi.cb_stampa.enabled= true
						tabpage_storicocontributi.cbx_importi.enabled= true
						
				end if
				
				tabpage_storicocontributi.dw_storicocontributi.setRedraw(true)
				
	case 7 // Visualizza gli originali delle schede di adesione (segreteria+superuser)
		
		string is_path_ldp_old
		
//		ls_boh= tab_dati.tabpage_visualizza.ole_viewer.object.SRC
		
			if isNull(is_path_ldp) or is_path_ldp= "" then return -1
			if is_path_ldp_old= is_path_ldp then return 0
			tab_dati.tabpage_visualizza.ole_viewer.object.SRC=""
			tab_dati.tabpage_visualizza.ole_viewer.object.SRC= is_path_ldp
			is_path_ldp_old= is_path_ldp
//			is_path_ldp= ""
			tabpage_visualizza.ole_viewer.height= this.height - li_margine
			tabpage_visualizza.ole_viewer.width= this.width - 120
			
	case 8
		
		tabpage_liste.dw_dettaglio_liste.Object.DataWindow.ReadOnly="Yes"
		
		if tabpage_liste.dw_cod_lista.rowCount() = 0 then 
			tabpage_liste.dw_cod_lista.setTransObject(sqlca)
			tabpage_liste.dw_dettaglio_liste.setTransObject(sqlca)
			tabpage_liste.dw_cod_lista.retrieve()
			tabpage_liste.dw_dettaglio_liste.retrieve(is_codice)
//			tabpage_liste.dw_liste.getChild( "cod_lista", idwc_liste)
//			tabpage_liste.idwc_liste.setTransObject(sqlca)
//			tabpage_liste.idwc_liste.retrieve()
		end if




end choose
end event

event selectionchanging;boolean lb_storicogohonzon, lb_storicoesami, lb_aggiornamento
integer li_ret

if  tab_dati.tabpage_storico.uo_dw_sg.modifiedCount() > 0 or &
tab_dati.tabpage_storico.uo_dw_sg.deletedCount() > 0 then lb_storicogohonzon= true

if tab_dati.tabpage_storico.uo_dw_se.modifiedCount() > 0 or &
tab_dati.tabpage_storico.uo_dw_se.deletedCount() > 0 then lb_storicoesami= true

lb_aggiornamento= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_modificheincorso()
			 
if lb_storicogohonzon OR lb_storicoesami OR lb_aggiornamento then

li_ret= messageBox(parent.title, "Sono stati modificati dei dati: vuoi salvare?", question!, okCancel!, 1)			 

choose case li_ret

	case 1
		
		 if lb_aggiornamento= true then
			if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(AGGIORNAMENTO) < 0 then goto errore
		end if
		 if lb_storicogohonzon= true then
			if tab_dati.tabpage_storico.uo_dw_sg.update() < 0 then goto errore
		end if
		 if lb_storicoesami= true then
			if tab_dati.tabpage_storico.uo_dw_se.update() < 0 then goto errore
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
end event

type tabpage_ricerca from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4754
integer height = 2384
long backcolor = 81324524
string text = "Ricerca"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
st_3 st_3
cb_ordina cb_ordina
pb_struttura pb_struttura
cb_query cb_query
cb_dbcancel cb_dbcancel
dw_current dw_current
gb_buttons gb_buttons
end type

on tabpage_ricerca.create
this.st_3=create st_3
this.cb_ordina=create cb_ordina
this.pb_struttura=create pb_struttura
this.cb_query=create cb_query
this.cb_dbcancel=create cb_dbcancel
this.dw_current=create dw_current
this.gb_buttons=create gb_buttons
this.Control[]={this.st_3,&
this.cb_ordina,&
this.pb_struttura,&
this.cb_query,&
this.cb_dbcancel,&
this.dw_current,&
this.gb_buttons}
end on

on tabpage_ricerca.destroy
destroy(this.st_3)
destroy(this.cb_ordina)
destroy(this.pb_struttura)
destroy(this.cb_query)
destroy(this.cb_dbcancel)
destroy(this.dw_current)
destroy(this.gb_buttons)
end on

type st_3 from statictext within tabpage_ricerca
integer x = 1961
integer y = 80
integer width = 274
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Struttura:"
boolean focusrectangle = false
end type

type cb_ordina from commandbutton within tabpage_ricerca
integer x = 2469
integer y = 52
integer width = 558
integer height = 124
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordina"
boolean cancel = true
end type

event clicked;string ls_sort

openWithParm(w_ordina, dw_current)

ls_sort= message.stringParm

dw_current.setSort(ls_sort)
dw_current.Sort()
end event

type pb_struttura from picturebutton within tabpage_ricerca
integer x = 2240
integer y = 44
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

event clicked;dw_current.event ue_struttura()
end event

type cb_query from commandbutton within tabpage_ricerca
integer x = 3675
integer y = 52
integer width = 558
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Estrazione"
boolean default = true
end type

event clicked;long ll_rows

setPointer(hourGlass!)

ricerca:	if dw_current.Object.DataWindow.QueryMode= 'yes' then
			
				dw_current.acceptText()
				dw_current.Object.DataWindow.QueryMode= 'no' 
				cb_dbcancel.enabled= true
				pb_struttura.enabled= false
				dw_current.setRedraw(false)
				ll_rows= dw_current.retrieve(is_strade_s.cod_com)
				dw_current.setRedraw(true)
				cb_dbcancel.enabled= false
				cb_query.text= "Ricerca"
				if ll_rows = 0 then
					messageBox(parent.text, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
					dw_current.Object.DataWindow.QueryMode= 'no'
					goto ricerca
				end if
				
			else
			//	dw_current.reset()
				cb_query.text= "Estrazione"
				dw_current.setRedraw(false)
				dw_current.Object.DataWindow.QueryClear= 'yes'
				dw_current.Object.DataWindow.QueryMode= 'yes' 
				dw_current.setRedraw(true)
				
				cb_dbcancel.enabled= false
				pb_struttura.enabled= true
				
				dw_current.setColumn("cognome")
				
		end if

dw_current.setFocus()

end event

type cb_dbcancel from commandbutton within tabpage_ricerca
integer x = 3072
integer y = 52
integer width = 558
integer height = 124
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Annulla l~'estrazione"
boolean cancel = true
end type

event clicked;ib_dbcancel= true
end event

type dw_current from datawindow within tabpage_ricerca
event ue_struttura ( )
integer y = 212
integer width = 4302
integer height = 2136
integer taborder = 50
string title = "none"
string dataobject = "dw_ricerca_associati"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_struttura();s_struttura s_struttura_s

s_struttura_s.livello= MAX_LIVELLO

openWithParm(w_mostra_struttura, s_struttura_s)

s_struttura_s= message.powerObjectParm

dw_current.setColumn("vc_parent")
dw_current.setText(s_struttura_s.vc_nodo) 

return 
end event

event retrieverow;yield()

if ib_dbcancel then
	
	return 1 // blocca il retrieval
	
else
	
	return 0
	
end if
end event

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, false)

SetSqlPreview ( sqlsyntax)
end event

event retrieveend;if rowCount > 0 then
	
	is_codice= this.getItemString(1, "codice")

//	w_schede_dati.tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
//	
//	w_schede_dati.is_codice= is_codice
	
end if
end event

event rowfocuschanged;if lower(dw_current.Object.DataWindow.QueryMode)= 'no'  and this.getRow() > 0 then
	
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

event doubleclicked;if lower(this.Object.DataWindow.QueryMode) = "yes" or row= 0 then return

tab_dati.selectTab( w_schede_dati.tab_dati.tabpage_dati ) 
end event

type gb_buttons from groupbox within tabpage_ricerca
integer width = 4302
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
integer width = 4754
integer height = 2384
long backcolor = 81324524
string text = "Scheda anagrafica"
long tabtextcolor = 8388608
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
pb_mail pb_mail
pb_scheda pb_scheda
pb_stampa_boll pb_stampa_boll
pb_ldp pb_ldp
pb_cartellino pb_cartellino
dw_dati dw_dati
end type

on tabpage_dati.create
this.pb_mail=create pb_mail
this.pb_scheda=create pb_scheda
this.pb_stampa_boll=create pb_stampa_boll
this.pb_ldp=create pb_ldp
this.pb_cartellino=create pb_cartellino
this.dw_dati=create dw_dati
this.Control[]={this.pb_mail,&
this.pb_scheda,&
this.pb_stampa_boll,&
this.pb_ldp,&
this.pb_cartellino,&
this.dw_dati}
end on

on tabpage_dati.destroy
destroy(this.pb_mail)
destroy(this.pb_scheda)
destroy(this.pb_stampa_boll)
destroy(this.pb_ldp)
destroy(this.pb_cartellino)
destroy(this.dw_dati)
end on

type pb_mail from picturebutton within tabpage_dati
integer x = 3831
integer y = 1108
integer width = 475
integer height = 224
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Invia e-mail"
boolean originalsize = true
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

event clicked;string ls_mail

if dw_dati.getRow() <= 0 then return 0

ls_mail= dw_dati.getItemString(dw_dati.getRow(), "e_mail")

return dw_dati.event ue_mail(ls_mail)
end event

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

event clicked;s_bollettini s_bollettini_s

s_bollettini_s.tipo_stampa= "N"
s_bollettini_s.criterio= dw_dati.getItemString(dw_dati.getRow(), "codice")

openWithParm(w_bollettini,  s_bollettini_s)
end event

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

//is_path_ldp= inca_pdf.uof_test()
//tab_dati.tabpage_visualizza.ole_viewer.visible= true

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
event type integer ue_mail ( string as_mail )
integer width = 3790
integer height = 1616
integer taborder = 10
string dataobject = "dw_scheda_anagrafica_gerarchica"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type integer ue_mail(string as_mail);mailSession mSes

mailReturnCode mRet

mailMessage mMsg

if isNull(as_mail) or as_mail= "" then
	messageBox(parent.text, "Indirizzo e-mail non presente.", information!)
	return 0
end if

setPointer(hourGlass!)

// Create a mail session

mSes = create mailSession

// Log on to the session

mRet = mSes.mailLogon(mailNewSession!)

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon fallito.')
		return -1

END IF

// Populate the mailMessage structure

//mMsg.Subject = "boh"
//
//mMsg.NoteText = 'Luncheon at 12:15'

//			mMsg.Recipient[1].name = 'Smith, John'
//			
//			mMsg.Recipient[2].name = 'Shaw, Sue'

//			mMsg.Recipient[1].name = 'GdS, GdS'

mMsg.Recipient[1].address= trim(as_mail)

// Send the mail

mRet = mSes.mailSend(mMsg) // +cc

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail Send", 'Mail non inviata')
		return -1

END IF

mSes.mailLogoff()

DESTROY mSes

return 0
		

end event

event buttonclicked;choose case dwo.name
		
//	case "b_lettera_presentazione"
//		
////		OpenWithParm ( w_lettere_auto, dw_dati.getItemString(dw_dati.getRow(), "codice" ) )
//		nca_test lnca_test
//		
//		lnca_test.uof_test()
//		
	case "b_mail"
		
			mailSession mSes

			mailReturnCode mRet
			
			mailMessage mMsg
			
			// Create a mail session
			
			mSes = create mailSession
			
			// Log on to the session
			
			mRet = mSes.mailLogon(mailNewSession!)
			
			IF mRet <> mailReturnSuccess! THEN
					MessageBox("Mail", 'Logon failed.')
					RETURN
			
			END IF
			
			// Populate the mailMessage structure
			
			mMsg.Subject = "boh"
			
			mMsg.NoteText = 'Luncheon at 12:15'
			
//			mMsg.Recipient[1].name = 'Smith, John'
//			
//			mMsg.Recipient[2].name = 'Shaw, Sue'

//			mMsg.Recipient[1].name = 'GdS, GdS'
			mMsg.Recipient[1].address= trim(this.getItemString(row, "e_mail"))
			
			// Send the mail
			
			mRet = mSes.mailSend(mMsg)
			
			IF mRet <> mailReturnSuccess! THEN
					MessageBox("Mail Send", 'Mail not sent')
					RETURN
			
			END IF
			
			mSes.mailLogoff()
			
			DESTROY mSes
		
end choose

return 0
end event

event retrieveend;//	dw_current.setFocus()
//	dw_current.setColumn("cognome")
if rowcount > 0 then
	this.setItem(this.getRow(), "cstruttura", f_descrizione_struttura_estesa(this.getItemString(this.getRow(), "vc_parent") ) )
	
end if
end event

event clicked;//integer li_col
//string ls_mail
//
//if this.getRow() <= 0 then return 0
//
//li_col= this.getClickedColumn()
//
//if this.getClickedColumn()= 39 then /* il campo e-mail... */
//	
//	ls_mail= this.getItemString(this.getRow(), "e_mail")
//
//	event ue_mail(ls_mail)
//	
//end if
//	
//return
//
end event

event sqlpreview;//string ls_cerca, ls_where
//
//ls_cerca= sle_cerca.text
//
//if isNumber(mid(ls_cerca, 1, len(ls_cerca) - 2)) then
//	
//	// where codice= ....
//	
//	ls_where= " and codice= '"+ls_cerca+"'"
//	
//else
//	
//	// where cognome...
//	
//	ls_where= " and cognome like= '%"+ls_cerca+"%'"
//	
//end if
end event

type tabpage_aggiornamento from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4754
integer height = 2384
long backcolor = 67108864
string text = "Aggiornamento"
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
boolean visible = true
integer width = 4178
integer height = 2120
integer taborder = 40
boolean bringtotop = true
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

this.object.b_salva.visible= '0'

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
					
					return 1
					
				case 1
					
					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					i_err= this.SetItem ( row, "comune", s_strade_s.comune )
					i_err= this.setText ( s_strade_s.comune )
					
					i_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
					
					i_err= this.SetItem ( row, "ind_dom", trim(s_strade_s.tipo)+" "+s_strade_s.strada+" ")
								
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
					return 2
					
				case 2
					
					i_err= this.SetItem ( row, "cod_com", s_strade_s.cod_com)
					
					i_err= this.SetItem ( row, "comune", s_strade_s.comune )
					i_err= this.setText ( s_strade_s.comune )
					
					i_err= this.SetItem ( row, "provincia", s_strade_s.provincia)
					
					i_err= this.SetItem ( row, "cap_dom", s_strade_s.cap)
					
					return 2
					
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

type tabpage_edizioni from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4754
integer height = 2384
long backcolor = 81324524
string text = "Dati edizioni"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
cbx_storico cbx_storico
dw_pubblicazioni dw_pubblicazioni
gb_pubblicazioni gb_pubblicazioni
gb_testata gb_testata
end type

on tabpage_edizioni.create
this.cbx_storico=create cbx_storico
this.dw_pubblicazioni=create dw_pubblicazioni
this.gb_pubblicazioni=create gb_pubblicazioni
this.gb_testata=create gb_testata
this.Control[]={this.cbx_storico,&
this.dw_pubblicazioni,&
this.gb_pubblicazioni,&
this.gb_testata}
end on

on tabpage_edizioni.destroy
destroy(this.cbx_storico)
destroy(this.dw_pubblicazioni)
destroy(this.gb_pubblicazioni)
destroy(this.gb_testata)
end on

type cbx_storico from checkbox within tabpage_edizioni
integer x = 2651
integer y = 72
integer width = 887
integer height = 96
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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
integer x = 41
integer y = 256
integer width = 3497
integer height = 1668
integer taborder = 20
string title = "none"
string dataobject = "dw_pubblicazioni"
boolean vscrollbar = true
string icon = "Report5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_pubblicazioni from groupbox within tabpage_edizioni
integer y = 192
integer width = 3584
integer height = 1800
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 81324524
string text = "Pubblicazioni"
borderstyle borderstyle = stylelowered!
end type

type gb_testata from groupbox within tabpage_edizioni
integer width = 3584
integer height = 188
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 81324524
borderstyle borderstyle = stylelowered!
end type

type tabpage_storico from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4754
integer height = 2384
long backcolor = 67108864
string text = "Storico"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_salva_se cb_salva_se
cb_rimuovi_sg cb_rimuovi_sg
cb_aggiungi_sg cb_aggiungi_sg
uo_dw_se uo_dw_se
uo_dw_sg uo_dw_sg
cb_rimuovi_se cb_rimuovi_se
cb_aggiungi_se cb_aggiungi_se
gb_1 gb_1
cb_salva_sg cb_salva_sg
gb_sg gb_sg
end type

on tabpage_storico.create
this.cb_salva_se=create cb_salva_se
this.cb_rimuovi_sg=create cb_rimuovi_sg
this.cb_aggiungi_sg=create cb_aggiungi_sg
this.uo_dw_se=create uo_dw_se
this.uo_dw_sg=create uo_dw_sg
this.cb_rimuovi_se=create cb_rimuovi_se
this.cb_aggiungi_se=create cb_aggiungi_se
this.gb_1=create gb_1
this.cb_salva_sg=create cb_salva_sg
this.gb_sg=create gb_sg
this.Control[]={this.cb_salva_se,&
this.cb_rimuovi_sg,&
this.cb_aggiungi_sg,&
this.uo_dw_se,&
this.uo_dw_sg,&
this.cb_rimuovi_se,&
this.cb_aggiungi_se,&
this.gb_1,&
this.cb_salva_sg,&
this.gb_sg}
end on

on tabpage_storico.destroy
destroy(this.cb_salva_se)
destroy(this.cb_rimuovi_sg)
destroy(this.cb_aggiungi_sg)
destroy(this.uo_dw_se)
destroy(this.uo_dw_sg)
destroy(this.cb_rimuovi_se)
destroy(this.cb_aggiungi_se)
destroy(this.gb_1)
destroy(this.cb_salva_sg)
destroy(this.gb_sg)
end on

type cb_salva_se from commandbutton within tabpage_storico
integer x = 3945
integer y = 1596
integer width = 402
integer height = 112
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salva"
end type

event clicked;if uo_dw_se.update() < 0 then
	rollback;
else
	commit;
end if

this.enabled= false
end event

type cb_rimuovi_sg from commandbutton within tabpage_storico
integer x = 1751
integer y = 1596
integer width = 402
integer height = 112
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rimuovi"
end type

event clicked;if messageBox(parent.text, "Confermi la cancellazione?", question!, yesNo!, 2)= 1 then
	uo_dw_sg.deleteRow(0)
	cb_salva_sg.enabled= true
end if
end event

type cb_aggiungi_sg from commandbutton within tabpage_storico
integer x = 1339
integer y = 1596
integer width = 402
integer height = 112
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi"
end type

event clicked;long ll_row

ll_row= uo_dw_sg.insertRow(0)

uo_dw_sg.setItem(ll_row, "codice", is_codice)
end event

type uo_dw_se from uodw_generica within tabpage_storico
integer x = 2651
integer y = 72
integer width = 1696
integer height = 1484
integer taborder = 40
string dataobject = "ds_curr_studio"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;cb_salva_se.enabled= true
end event

type uo_dw_sg from uodw_generica within tabpage_storico
integer x = 27
integer y = 72
integer width = 2542
integer height = 1484
integer taborder = 40
string dataobject = "d_storico_goh"
boolean vscrollbar = true
end type

event buttonclicked;call super::buttonclicked;long ll_codice
string ls_note, ls_note_old, ls_dip

ls_note=  this.getItemString(row, "note")

if dwo.name= 'b_note' then
	openWithParm(w_note, ls_note)
	
	ls_note_old= ls_note
	
	ls_note= message.stringParm
	
	if ls_note <> ls_note_old or isNull(ls_note_old) then
		this.setItem(row, "note", ls_note)
	end if
	
end if
end event

event itemchanged;call super::itemchanged;cb_salva_sg.enabled= true
end event

type cb_rimuovi_se from commandbutton within tabpage_storico
integer x = 3534
integer y = 1596
integer width = 402
integer height = 112
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rimuovi"
end type

event clicked;if messageBox(parent.text, "Confermi la cancellazione?", question!, yesNo!, 2)= 1 then
	uo_dw_se.deleteRow(0)
	cb_salva_se.enabled= true
end if
end event

type cb_aggiungi_se from commandbutton within tabpage_storico
integer x = 3127
integer y = 1596
integer width = 402
integer height = 112
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi"
end type

event clicked;long ll_row

ll_row= uo_dw_se.insertRow(0)

uo_dw_se.setItem(ll_row, "codice", is_codice)
end event

type gb_1 from groupbox within tabpage_storico
integer x = 2629
integer width = 1746
integer height = 1744
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Storico esami"
end type

type cb_salva_sg from commandbutton within tabpage_storico
integer x = 2167
integer y = 1596
integer width = 402
integer height = 112
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salva"
end type

event clicked;if uo_dw_sg.update() < 0 then
	rollback;
else
	commit;
end if

this.enabled= false
end event

type gb_sg from groupbox within tabpage_storico
integer width = 2597
integer height = 1744
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Storico gohonzon"
end type

type tabpage_storicocontributi from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4754
integer height = 2384
long backcolor = 81324524
string text = "Offerte"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_stampa cb_stampa
cbx_importi cbx_importi
dw_storicocontributi dw_storicocontributi
gb_offerte gb_offerte
end type

on tabpage_storicocontributi.create
this.cb_stampa=create cb_stampa
this.cbx_importi=create cbx_importi
this.dw_storicocontributi=create dw_storicocontributi
this.gb_offerte=create gb_offerte
this.Control[]={this.cb_stampa,&
this.cbx_importi,&
this.dw_storicocontributi,&
this.gb_offerte}
end on

on tabpage_storicocontributi.destroy
destroy(this.cb_stampa)
destroy(this.cbx_importi)
destroy(this.dw_storicocontributi)
destroy(this.gb_offerte)
end on

type cb_stampa from commandbutton within tabpage_storicocontributi
integer x = 2907
integer y = 276
integer width = 334
integer height = 112
integer taborder = 12
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Stampa"
end type

event clicked;openWithParm(w_dw_print_options, tab_dati.tabpage_storicocontributi.dw_storicocontributi)
end event

type cbx_importi from checkbox within tabpage_storicocontributi
integer x = 2798
integer y = 156
integer width = 535
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

type dw_storicocontributi from datawindow within tabpage_storicocontributi
integer x = 32
integer y = 60
integer width = 2725
integer height = 1700
integer taborder = 10
string dataobject = "dw_info"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;return 0
end event

type gb_offerte from groupbox within tabpage_storicocontributi
integer width = 3365
integer height = 1792
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 81324524
string text = "Offerte"
borderstyle borderstyle = stylelowered!
end type

type tabpage_visualizza from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4754
integer height = 2384
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
string binarykey = "w_schede_dati.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type tabpage_liste from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4754
integer height = 2384
long backcolor = 81324524
string text = "Liste"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
dw_cod_lista dw_cod_lista
cb_rimuovi cb_rimuovi
cb_aggiungi cb_aggiungi
dw_dettaglio_liste dw_dettaglio_liste
gb_2 gb_2
end type

on tabpage_liste.create
this.dw_cod_lista=create dw_cod_lista
this.cb_rimuovi=create cb_rimuovi
this.cb_aggiungi=create cb_aggiungi
this.dw_dettaglio_liste=create dw_dettaglio_liste
this.gb_2=create gb_2
this.Control[]={this.dw_cod_lista,&
this.cb_rimuovi,&
this.cb_aggiungi,&
this.dw_dettaglio_liste,&
this.gb_2}
end on

on tabpage_liste.destroy
destroy(this.dw_cod_lista)
destroy(this.cb_rimuovi)
destroy(this.cb_aggiungi)
destroy(this.dw_dettaglio_liste)
destroy(this.gb_2)
end on

type dw_cod_lista from datawindow within tabpage_liste
integer x = 78
integer y = 80
integer width = 1586
integer height = 120
integer taborder = 90
string title = "none"
string dataobject = "dw_cod_lista"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_rimuovi from commandbutton within tabpage_liste
integer x = 846
integer y = 240
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rimuovi"
end type

event clicked;tab_dati.tabpage_liste.dw_dettaglio_liste.deleteRow(0)

if tab_dati.tabpage_liste.dw_dettaglio_liste.update() < 0 then
	messageBox(parent.text, "Aggiornamento fallito.", exclamation!)
	rollback;
	if trap_sql(sqlca, "LISTERIM01") < 0 then return -1
else
	commit;
	if trap_sql(sqlca, "LISTERIM02") < 0 then return -1
end if
end event

type cb_aggiungi from commandbutton within tabpage_liste
integer x = 434
integer y = 240
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi"
end type

event clicked;long ll_row

if dw_dettaglio_liste.Find ( "cod_lista='"+dw_cod_lista.getItemString(dw_cod_lista.getRow(), "cod_lista")+"'", 1, dw_dettaglio_liste.rowCount() ) > 0 then
	
	messageBox(parent.text, "Lista già inserita.", information!)
	return
	
end if

ll_row= dw_dettaglio_liste.insertRow(0)

dw_dettaglio_liste.setItem(ll_row, "cod_lista", dw_cod_lista.getItemString(dw_cod_lista.getRow(), "cod_lista") )

dw_dettaglio_liste.setItem(ll_row, "codice", is_codice)

//dw_dettaglio_liste.setItem(ll_row, "liste_descrizione", dw_cod_lista.getItemString(dw_cod_lista.getRow(), "descrizione") )

if tab_dati.tabpage_liste.dw_dettaglio_liste.update() < 0 then
	messageBox(parent.text, "Aggiornamento fallito.", exclamation!)
	rollback;
	if trap_sql(sqlca, "LISTEADD01") < 0 then return -1
else
	commit;
	if trap_sql(sqlca, "LISTEADD02") < 0 then return -1
end if

end event

type dw_dettaglio_liste from datawindow within tabpage_liste
integer x = 32
integer y = 392
integer width = 1678
integer height = 1544
integer taborder = 30
string title = "none"
string dataobject = "dw_liste_dettaglio"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;f_select_current_row(this)
end event

type gb_2 from groupbox within tabpage_liste
integer width = 1742
integer height = 1968
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Inserimento in liste"
borderstyle borderstyle = StyleLowered!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Aw_schede_dati.bin 
2300000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000a281b1d001c729d500000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000010c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003ca8a978011cf280d45444da20000545300000000a27ccfd001c729d5a281b1d001c729d5000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000005000000290000000000000001000000020000000300000004fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020105ca8a978011cf280d45444da20000545300000001fb8f0821101b01640008ed8413c72e2b00000030000000dc0000000600000100000000380000010100000040000001020000004800000103000000500000010400000058000000000000007c000000030005000000000003000060bd0000000300002eec00000003000000000000000800000019735c3a445c6c69765c6664707474656c316172656664702e000000000000000600000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747804007974040000017300000000006372090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050000000060bd00002eec000000005c3a44186c6976736664705c74656c5c6172657464702e310000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Aw_schede_dati.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
