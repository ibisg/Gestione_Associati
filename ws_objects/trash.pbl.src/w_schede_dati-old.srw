$PBExportHeader$w_schede_dati-old.srw
forward
global type w_schede_dati-old from w_centered
end type
type pb_squeeze_up from picturebutton within w_schede_dati-old
end type
type pb_dbcancel from picturebutton within w_schede_dati-old
end type
type pb_query from picturebutton within w_schede_dati-old
end type
type dw_current from datawindow within w_schede_dati-old
end type
type tab_dati from tab within w_schede_dati-old
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
type pb_annullaestrazione from picturebutton within tabpage_aggiornamento
end type
type pb_chiudi from picturebutton within tabpage_aggiornamento
end type
type pb_aggiorna from picturebutton within tabpage_aggiornamento
end type
type pb_nuovo from picturebutton within tabpage_aggiornamento
end type
type pb_cancella from picturebutton within tabpage_aggiornamento
end type
type pb_ricerca from picturebutton within tabpage_aggiornamento
end type
type pb_reset from picturebutton within tabpage_aggiornamento
end type
type uodw_aggiornamento from uodw_anagrafica within tabpage_aggiornamento
end type
type tabpage_aggiornamento from userobject within tab_dati
pb_annullaestrazione pb_annullaestrazione
pb_chiudi pb_chiudi
pb_aggiorna pb_aggiorna
pb_nuovo pb_nuovo
pb_cancella pb_cancella
pb_ricerca pb_ricerca
pb_reset pb_reset
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
type tabpage_visualizza from userobject within tab_dati
end type
type ole_viewer from olecustomcontrol within tabpage_visualizza
end type
type tabpage_visualizza from userobject within tab_dati
ole_viewer ole_viewer
end type
type tabpage_storicogohonzon from userobject within tab_dati
end type
type cb_new from commandbutton within tabpage_storicogohonzon
end type
type cb_ann from commandbutton within tabpage_storicogohonzon
end type
type cb_canc from commandbutton within tabpage_storicogohonzon
end type
type cb_save from commandbutton within tabpage_storicogohonzon
end type
type dw_storicogohonzon from datawindow within tabpage_storicogohonzon
end type
type tabpage_storicogohonzon from userobject within tab_dati
cb_new cb_new
cb_ann cb_ann
cb_canc cb_canc
cb_save cb_save
dw_storicogohonzon dw_storicogohonzon
end type
type tabpage_storicoesami from userobject within tab_dati
end type
type cb_nuovo from commandbutton within tabpage_storicoesami
end type
type cb_cancella from commandbutton within tabpage_storicoesami
end type
type cb_salva from commandbutton within tabpage_storicoesami
end type
type cb_annulla from commandbutton within tabpage_storicoesami
end type
type dw_storicoesami from datawindow within tabpage_storicoesami
end type
type tabpage_storicoesami from userobject within tab_dati
cb_nuovo cb_nuovo
cb_cancella cb_cancella
cb_salva cb_salva
cb_annulla cb_annulla
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
type tab_dati from tab within w_schede_dati-old
tabpage_dati tabpage_dati
tabpage_aggiornamento tabpage_aggiornamento
tabpage_edizioni tabpage_edizioni
tabpage_visualizza tabpage_visualizza
tabpage_storicogohonzon tabpage_storicogohonzon
tabpage_storicoesami tabpage_storicoesami
tabpage_storicocontributi tabpage_storicocontributi
end type
end forward

global type w_schede_dati-old from w_centered
integer width = 5001
integer height = 3424
string title = "Gestione associati"
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Database!"
boolean clientedge = true
boolean ib_centered = false
event type long ue_estraidettaglio ( string as_codice )
pb_squeeze_up pb_squeeze_up
pb_dbcancel pb_dbcancel
pb_query pb_query
dw_current dw_current
tab_dati tab_dati
end type
global w_schede_dati-old w_schede_dati-old

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
		
	case INSERIMENTO
		
		if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(INSERIMENTO) <0 then return -1
		
		tab_dati.tabpage_aggiornamento.pb_reset.enabled= true
		tab_dati.tabpage_aggiornamento.pb_ricerca.enabled= false
		tab_dati.tabpage_aggiornamento.pb_cancella.enabled= false
		tab_dati.tabpage_aggiornamento.pb_nuovo.enabled= false
		tab_dati.tabpage_aggiornamento.pb_aggiorna.enabled= true
		tab_dati.tabpage_aggiornamento.pb_chiudi.enabled= true
		tab_dati.tabpage_aggiornamento.pb_annullaestrazione.enabled= false
		
		tab_dati.tabpage_aggiornamento.text= "Inserimento"
		
	case RICERCA
		
		if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(RICERCA) <0 then return -1
		
		tab_dati.tabpage_aggiornamento.pb_reset.enabled= true
		tab_dati.tabpage_aggiornamento.pb_ricerca.enabled= false
		tab_dati.tabpage_aggiornamento.pb_cancella.enabled= false
		tab_dati.tabpage_aggiornamento.pb_nuovo.enabled= false
		tab_dati.tabpage_aggiornamento.pb_aggiorna.enabled= false
		tab_dati.tabpage_aggiornamento.pb_chiudi.enabled= true
		tab_dati.tabpage_aggiornamento.pb_annullaestrazione.enabled= false
		
		tab_dati.tabpage_aggiornamento.text= "Ricerca"
		
	case ESTRAZIONE
		
		if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(ESTRAZIONE) <0 then return -1
		
		tab_dati.tabpage_aggiornamento.pb_reset.enabled= false
		tab_dati.tabpage_aggiornamento.pb_ricerca.enabled= false
		tab_dati.tabpage_aggiornamento.pb_cancella.enabled= false
		tab_dati.tabpage_aggiornamento.pb_nuovo.enabled= false
		tab_dati.tabpage_aggiornamento.pb_aggiorna.enabled= false
		tab_dati.tabpage_aggiornamento.pb_chiudi.enabled= false
		tab_dati.tabpage_aggiornamento.pb_annullaestrazione.enabled= true
		
		tab_dati.tabpage_aggiornamento.text= "Estrazione... attendere"
		
	case AGGIORNAMENTO
		
		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(AGGIORNAMENTO)
		
	case CANCELLAZIONE
		
		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(CANCELLAZIONE)
		
	case CHIUSURA
		
		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_modificheincorso()
		
//	case "pb_struttura"
//		
//		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_struttura(al_row)
//		

//	case "pb_cap"
//		
//		integer i_err, li_exists
//		string ls_cap, ls_loc, ls_vercap
//		
//		ls_cap= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.getItemString(al_row, "cap_dom")
//		ls_loc= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.getItemString(al_row, "comune")
//		
//		select cap into :ls_vercap from tapb_comuni where comune= :ls_loc;
//		
//		select count(*)  into :li_exists from cap_generici where cap= :ls_vercap;
//		
//		if isNull(li_exists) or li_exists= 0 then // se non è un cap generico...
//			if ls_vercap <> ls_cap then
//				i_err= messageBox("Verifica C.A.P.", "Il C.A.P. corretto relativo alla località "+ls_loc+" è: "+ls_vercap+"~nVuoi eseguire la correzione?", question!, yesNo!, 1)
//				if i_err= 2 then return 0
//				i_err= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.SetItem ( al_row, "cap_dom", ls_vercap )
//			else
//				messageBox("Verifica C.A.P.", "Il C.A.P. "+ls_vercap+ " relativo alla località "+ls_loc+" è corretto.")
//			end if
//		else // se è un cap generico...
//			//	i_err= messageBox(parent.title, "Il C.A.P. relativo alla località "+ls_loc +" è un C.A.P. generico.~nVuoi cercare nell'archivio strade?", question!, yesNo!, 1)
//			//	if i_err= 2 then return 
//					// apre la finestra di ricerca strade...
//					s_localita s_localita_s
//					s_localita_s.cod_com=  tab_dati.tabpage_aggiornamento.uodw_aggiornamento.getItemString(al_row, "cod_com")
//					s_localita_s.comune= ls_loc
//					s_localita_s.cap= ls_vercap
//					
//					messageBox(tab_dati.tabpage_aggiornamento.text, "Il C.A.P. relativo alla località "+is_com +" è un C.A.P. generico.~nOccorre eseguire la ricerca del C.A.P. nell'archivio strade.", information!)
//					
//					OpenWithParm(w_cerca_strade, s_localita_s)
//					is_strade_s= message.powerObjectParm
//						
//						if NOT isNull(is_strade_s.cap) then
//							
//							if is_strade_s.strada <> "" then tab_dati.tabpage_aggiornamento.uodw_aggiornamento.SetItem ( al_row, "ind_dom", trim(is_strade_s.tipo)+" "+is_strade_s.strada+" ")
//							
//							i_err= tab_dati.tabpage_aggiornamento.uodw_aggiornamento.SetItem ( al_row, "cap_dom", is_strade_s.cap)
//			
//			//				i_err= dw_dett.SelectText(len(trim(is_strade_s.tipo)+" "+is_strade_s.strada), 0)
//		
//			end if
//				
//		end if
		
	case RESET
		
		if tab_dati.tabpage_aggiornamento.uodw_aggiornamento.uof_esegui(RESET) < 0 then return -1
		
		tab_dati.tabpage_aggiornamento.pb_reset.enabled= false
		tab_dati.tabpage_aggiornamento.pb_ricerca.enabled= true
		tab_dati.tabpage_aggiornamento.pb_cancella.enabled= false
		tab_dati.tabpage_aggiornamento.pb_nuovo.enabled= true
		tab_dati.tabpage_aggiornamento.pb_aggiorna.enabled= false
		tab_dati.tabpage_aggiornamento.pb_chiudi.enabled= true
		tab_dati.tabpage_aggiornamento.pb_annullaestrazione.enabled= false
		
//		if uof_modificheincorso() < 0 then return -1
//
//		dw_header.reset()
//		this.reset()
		
end choose

return 0

end function

on w_schede_dati-old.create
int iCurrent
call super::create
this.pb_squeeze_up=create pb_squeeze_up
this.pb_dbcancel=create pb_dbcancel
this.pb_query=create pb_query
this.dw_current=create dw_current
this.tab_dati=create tab_dati
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_squeeze_up
this.Control[iCurrent+2]=this.pb_dbcancel
this.Control[iCurrent+3]=this.pb_query
this.Control[iCurrent+4]=this.dw_current
this.Control[iCurrent+5]=this.tab_dati
end on

on w_schede_dati-old.destroy
call super::destroy
destroy(this.pb_squeeze_up)
destroy(this.pb_dbcancel)
destroy(this.pb_query)
destroy(this.dw_current)
destroy(this.tab_dati)
end on

event open;call super::open;tab_dati.tabpage_dati.dw_dati.setTransObject(sqlca)

tab_dati.tabpage_dati.dw_dati.Object.DataWindow.Print.Preview= 'Yes' 

dw_current .setTransObject(sqlca)

pb_query.event clicked()



end event

event resize;call super::resize;		tab_dati.x= (this.workSpaceWidth()/2 - tab_dati.width/2) -36
		
		dw_current.x= tab_dati.x
		
//		pb_query.x= dw_current.x + dw_current.width + 60
//		pb_dbcancel.x= pb_query.x
		
		dw_current.height= this .height - 180 - dw_current.y
		dw_current.width= tab_dati.width
		
//		pb_squeeze_up.x= pb_query.x
//		tab_dati.tabpage_originali.ole_1.width= tab_dati.width - 180
//		tab_dati.tabpage_originali.ole_1.height= tab_dati.height - 180
end event

event clicked;call super::clicked;this.show()
end event

type pb_squeeze_up from picturebutton within w_schede_dati-old
integer x = 3781
integer y = 1976
integer width = 101
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "AR_DOWN.bmp"
alignment htextalign = left!
end type

event clicked;parent.setRedraw(false)

if ib_squeeze_up= false then
	
	il_dwh= dw_current.height
	il_dwy= dw_current.y
	dw_current.height= 160
	dw_current.y= tab_dati.y + tab_dati.height + 20
	
	this.y= dw_current.y + 10
	this.x= pb_query.x
	
	pb_squeeze_up.PictureName = "AR_UP.bmp"
	
else

	dw_current.height= il_dwh
	dw_current.y= tab_dati.y + tab_dati.height + 20
	
	pb_squeeze_up.y= dw_current.y + 10
	pb_squeeze_up.x= pb_query.x
	
	pb_squeeze_up.PictureName = "AR_DOWN.bmp"
	
end if

ib_squeeze_up= NOT ib_squeeze_up

pb_query.y= dw_current.y + 200
pb_dbcancel.y= pb_query.y + pb_query.height + 12

parent.setRedraw(true)


end event

type pb_dbcancel from picturebutton within w_schede_dati-old
integer x = 3781
integer y = 2284
integer width = 334
integer height = 184
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Annulla estrazione"
boolean originalsize = true
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

event clicked;ib_dbcancel= true
end event

type pb_query from picturebutton within w_schede_dati-old
integer x = 3781
integer y = 2088
integer width = 334
integer height = 184
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;long ll_rows

setPointer(hourGlass!)

this.enabled= false

dw_current.setRedraw(false)

ricerca:	if dw_current.Object.DataWindow.QueryMode= 'yes' then
	
				pb_dbcancel.enabled= true
				tab_dati.enabled= false
			
				dw_current.acceptText()
				dw_current.Object.DataWindow.QueryMode= 'no' 
				ll_rows= dw_current.retrieve(is_strade_s.cod_com)
				pb_query.text= "Ricerca"
				pb_dbcancel.enabled= false
				tab_dati.enabled= true
				if ll_rows = 0 then
					messageBox(parent.title, "Non sono stati trovati dati corrispondenti ai criteri di ricerca.", information!)
					dw_current.Object.DataWindow.QueryMode= 'no'
					goto ricerca
				end if
				
				tab_dati.tabpage_dati.dw_dati.setFocus()
				
			else

				tab_dati.selectTab(tab_dati.tabpage_dati)
				
				pb_query.text= "Estrazione"
				dw_current.Object.DataWindow.QueryClear= 'yes'
				dw_current.Object.DataWindow.QueryMode= 'yes' 
				
				tab_dati.tabpage_dati.dw_dati.reset()
				is_codice= ""
				
				dw_current.setFocus()
				dw_current.setColumn("cognome")
				
		end if

dw_current.setRedraw(true)

this.enabled= true

end event

type dw_current from datawindow within w_schede_dati-old
integer x = 18
integer y = 1956
integer width = 3739
integer height = 600
integer taborder = 20
string title = "none"
string dataobject = "dw_ricerca_associati"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if lower(dw_current.Object.DataWindow.QueryMode)= 'no'  and this.getRow() > 0 then
	
	f_select_current_row(this)
	
	parent.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )

	is_codice= this.getItemString(this.getRow(), "codice")
	
	
	tab_dati.selectTab(tab_dati.tabpage_dati)

	tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
	
	tab_dati.tabpage_visualizza.ole_viewer.visible= false

end if
end event

event retrieveend;
if rowCount > 0 then
	
	is_codice= this.getItemString(1, "codice")

	tab_dati.tabpage_dati.dw_dati.retrieve(is_codice)
	
end if
end event

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_current, FALSE)
	
SetSqlPreview ( sqlsyntax )
end event

event retrieverow;if ib_dbcancel= true then
	return 1
else
	return 0
end if
end event

event resize;integer li_margine= 160

this.setRedraw(false)

pb_query.x= dw_current.x + dw_current.width + 60
pb_dbcancel.x= pb_query.x

pb_query.y= dw_current.y + 200
pb_dbcancel.y= pb_query.y + pb_query.height + 12

pb_squeeze_up.x= pb_query.x
pb_squeeze_up.y= dw_current.y + 10
		
tab_dati.height= parent.height - this.height -180 -20

tab_dati.tabpage_dati.dw_dati.height= tab_dati.height - li_margine
		
tab_dati.tabpage_aggiornamento.uodw_aggiornamento.height= tab_dati.height - li_margine
		
tab_dati.tabpage_edizioni.dw_pubblicazioni.height= tab_dati.height - li_margine

tab_dati.tabpage_visualizza.ole_viewer.width= tab_dati.width - 180
tab_dati.tabpage_visualizza.ole_viewer.height= tab_dati.height - 180

tab_dati.tabpage_storicocontributi.dw_storicocontributi.height= tab_dati.height - li_margine

this.setRedraw(true)
end event

type tab_dati from tab within w_schede_dati-old
integer x = 18
integer width = 4590
integer height = 1944
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
tabpage_dati tabpage_dati
tabpage_aggiornamento tabpage_aggiornamento
tabpage_edizioni tabpage_edizioni
tabpage_visualizza tabpage_visualizza
tabpage_storicogohonzon tabpage_storicogohonzon
tabpage_storicoesami tabpage_storicoesami
tabpage_storicocontributi tabpage_storicocontributi
end type

on tab_dati.create
this.tabpage_dati=create tabpage_dati
this.tabpage_aggiornamento=create tabpage_aggiornamento
this.tabpage_edizioni=create tabpage_edizioni
this.tabpage_visualizza=create tabpage_visualizza
this.tabpage_storicogohonzon=create tabpage_storicogohonzon
this.tabpage_storicoesami=create tabpage_storicoesami
this.tabpage_storicocontributi=create tabpage_storicocontributi
this.Control[]={this.tabpage_dati,&
this.tabpage_aggiornamento,&
this.tabpage_edizioni,&
this.tabpage_visualizza,&
this.tabpage_storicogohonzon,&
this.tabpage_storicoesami,&
this.tabpage_storicocontributi}
end on

on tab_dati.destroy
destroy(this.tabpage_dati)
destroy(this.tabpage_aggiornamento)
destroy(this.tabpage_edizioni)
destroy(this.tabpage_visualizza)
destroy(this.tabpage_storicogohonzon)
destroy(this.tabpage_storicoesami)
destroy(this.tabpage_storicocontributi)
end on

event selectionchanged;integer li_margine= 180

choose case newindex
		
	case 1 // Visualizza la scheda anagrafica (public)
		
		tabpage_dati.dw_dati.height= this.height - li_margine
		
	case 2 // Maschera di modifica dei dati (segreteria+superuser)
		
		tabpage_aggiornamento.uodw_aggiornamento.height= this.height - li_margine
		
		tabpage_aggiornamento.pb_cancella.enabled= false
		if gi_classediutenza= DIREZIONESEGRETERIA then tab_dati.tabpage_aggiornamento.pb_cancella.enabled= true
		
//		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.x= (this.Width/2 - tab_dati.tabpage_aggiornamento.uodw_aggiornamento.width/2) -tab_dati.tabpage_aggiornamento.uodw_aggiornamento.x
//		tab_dati.tabpage_aggiornamento.uodw_aggiornamento.y= (this.height/2 - tab_dati.tabpage_aggiornamento.uodw_aggiornamento.height/2) -tab_dati.tabpage_aggiornamento.uodw_aggiornamento.y
		tabpage_aggiornamento.uodw_aggiornamento.setTransObject(sqlca)
		tabpage_aggiornamento.uodw_aggiornamento.retrieve(is_codice)
		
	case 3 // Visualizza i dati delle edizioni (public)
		
		tabpage_edizioni.dw_pubblicazioni.height= this.height - li_margine
		
		tabpage_edizioni.cbx_storico.checked= false
		tabpage_edizioni.cbx_storico.event clicked()
		
		tabpage_edizioni.dw_pubblicazioni.setTransObject(sqlca_ediz)
		tabpage_edizioni.dw_pubblicazioni.retrieve(long(left(is_codice, len(is_codice) - 2)), right(is_codice, 2) )
		
	case 4 // Visualizza gli originali delle schede di adesione (segreteria+superuser)
		
			if isNull(is_path_ldp) or is_path_ldp= "" then return -1
			tab_dati.tabpage_visualizza.ole_viewer.object.SRC= is_path_ldp
			is_path_ldp= ""
		
	case 5 // Visualizza lo storico Gohonzon  (segreteria+superuser)
		
		long ll_rows
		
			tabpage_storicogohonzon.dw_storicogohonzon.height= this.height - li_margine
		
			tabpage_storicogohonzon.dw_storicogohonzon.setRowFocusIndicator(focusRect!)
		
			tabpage_storicogohonzon.dw_storicogohonzon.SetTransObject ( sqlca )
		
			ll_rows = tabpage_storicogohonzon.dw_storicogohonzon.Retrieve ( is_codice )
		
//			cb_new.enabled= NOT is_cg
		
			choose case ll_rows
					
				case -1
			
				case is > 0
					
//					cb_canc.enabled= NOT is_cg
					
				case else
					
			end choose
		
			tab_dati.tabpage_storicogohonzon.dw_storicogohonzon.SetFocus ( )

		
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

end choose
end event

type tabpage_dati from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4553
integer height = 1816
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
integer x = 3639
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

type pb_stampa_boll from picturebutton within tabpage_dati
integer x = 3639
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
integer x = 3639
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
integer x = 3639
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
integer width = 3607
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
integer width = 4553
integer height = 1816
long backcolor = 67108864
string text = "Aggiornamento dati"
long tabtextcolor = 8388736
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
pb_annullaestrazione pb_annullaestrazione
pb_chiudi pb_chiudi
pb_aggiorna pb_aggiorna
pb_nuovo pb_nuovo
pb_cancella pb_cancella
pb_ricerca pb_ricerca
pb_reset pb_reset
uodw_aggiornamento uodw_aggiornamento
end type

on tabpage_aggiornamento.create
this.pb_annullaestrazione=create pb_annullaestrazione
this.pb_chiudi=create pb_chiudi
this.pb_aggiorna=create pb_aggiorna
this.pb_nuovo=create pb_nuovo
this.pb_cancella=create pb_cancella
this.pb_ricerca=create pb_ricerca
this.pb_reset=create pb_reset
this.uodw_aggiornamento=create uodw_aggiornamento
this.Control[]={this.pb_annullaestrazione,&
this.pb_chiudi,&
this.pb_aggiorna,&
this.pb_nuovo,&
this.pb_cancella,&
this.pb_ricerca,&
this.pb_reset,&
this.uodw_aggiornamento}
end on

on tabpage_aggiornamento.destroy
destroy(this.pb_annullaestrazione)
destroy(this.pb_chiudi)
destroy(this.pb_aggiorna)
destroy(this.pb_nuovo)
destroy(this.pb_cancella)
destroy(this.pb_ricerca)
destroy(this.pb_reset)
destroy(this.uodw_aggiornamento)
end on

type pb_annullaestrazione from picturebutton within tabpage_aggiornamento
boolean visible = false
integer x = 4192
integer y = 1200
integer width = 334
integer height = 184
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla estrazione"
boolean originalsize = true
alignment htextalign = left!
vtextalign vtextalign = multiline!
end type

event clicked;return wf_action(ANNULLAESTRAZIONE, 0)
end event

type pb_chiudi from picturebutton within tabpage_aggiornamento
integer x = 4192
integer y = 1004
integer width = 334
integer height = 184
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;return wf_action(CHIUSURA, 0)
end event

type pb_aggiorna from picturebutton within tabpage_aggiornamento
integer x = 4192
integer y = 808
integer width = 334
integer height = 184
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Aggiorna"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;return wf_action(AGGIORNAMENTO, 0)
end event

type pb_nuovo from picturebutton within tabpage_aggiornamento
boolean visible = false
integer x = 4192
integer y = 612
integer width = 334
integer height = 184
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;return wf_action(INSERIMENTO, 0)
end event

type pb_cancella from picturebutton within tabpage_aggiornamento
integer x = 4192
integer y = 416
integer width = 334
integer height = 184
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;return wf_action(CANCELLAZIONE, 0)
end event

type pb_ricerca from picturebutton within tabpage_aggiornamento
boolean visible = false
integer x = 4192
integer y = 220
integer width = 334
integer height = 184
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;return wf_action(RICERCA, 0)
end event

type pb_reset from picturebutton within tabpage_aggiornamento
boolean visible = false
integer x = 4192
integer y = 24
integer width = 334
integer height = 184
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset"
alignment htextalign = left!
end type

event clicked;return wf_action(RESET, 0)
end event

type uodw_aggiornamento from uodw_anagrafica within tabpage_aggiornamento
integer width = 4183
integer height = 1592
integer taborder = 40
string dataobject = "dw_anagrafica"
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
	
		if parent.pb_aggiorna.enabled= false then
			if gi_classediutenza >= SEGRETERIA then parent.pb_aggiorna.enabled= true
		end if

end if

return 0

end event

event buttonclicked;call super::buttonclicked;if ancestorReturnValue>= 0 then parent.pb_aggiorna.enabled= true
end event

type tabpage_edizioni from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4553
integer height = 1816
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

type tabpage_visualizza from userobject within tab_dati
integer x = 18
integer y = 112
integer width = 4553
integer height = 1816
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
integer width = 1317
integer height = 768
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_schede_dati-old.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type tabpage_storicogohonzon from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4553
integer height = 1816
long backcolor = 67108864
string text = "Storico Gohonzon"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_new cb_new
cb_ann cb_ann
cb_canc cb_canc
cb_save cb_save
dw_storicogohonzon dw_storicogohonzon
end type

on tabpage_storicogohonzon.create
this.cb_new=create cb_new
this.cb_ann=create cb_ann
this.cb_canc=create cb_canc
this.cb_save=create cb_save
this.dw_storicogohonzon=create dw_storicogohonzon
this.Control[]={this.cb_new,&
this.cb_ann,&
this.cb_canc,&
this.cb_save,&
this.dw_storicogohonzon}
end on

on tabpage_storicogohonzon.destroy
destroy(this.cb_new)
destroy(this.cb_ann)
destroy(this.cb_canc)
destroy(this.cb_save)
destroy(this.dw_storicogohonzon)
end on

type cb_new from commandbutton within tabpage_storicogohonzon
integer x = 3168
integer y = 96
integer width = 334
integer height = 184
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Nuovo"
end type

event clicked;long ll_row

ll_row= dw_storicogohonzon.InsertRow (0)
dw_storicogohonzon.SetFocus ( )

dw_storicogohonzon.ScrollToRow (ll_row)
dw_storicogohonzon.SetItem (ll_row, "codice", is_codice )

cb_canc.enabled = true

end event

type cb_ann from commandbutton within tabpage_storicogohonzon
integer x = 3168
integer y = 684
integer width = 334
integer height = 184
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Annulla"
end type

event clicked;int li_ret
long ll_rows

li_ret = MessageBox (this.text, "Vuoi annullare le modifiche?", question!, YesNo!, 2 )

if li_ret = 2 then return 0

	ll_rows = dw_storicogohonzon.Retrieve ( is_codice )
	
	choose case ll_rows
			
		case -1
			
		case is > 0
			
			cb_canc.enabled = true
			dw_storicogohonzon.SetFocus ()
			
		case else
			
			cb_canc.enabled = false
			
	end choose

cb_ann.enabled = false
cb_save.enabled = false

end event

type cb_canc from commandbutton within tabpage_storicogohonzon
integer x = 3168
integer y = 292
integer width = 334
integer height = 184
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Cancella"
end type

event clicked;long ll_row

ll_row = dw_storicogohonzon.GetRow ()

if ll_row > 0 then
	
	dw_storicogohonzon.DeleteRow (ll_row)
	if dw_storicogohonzon.RowCount () = 0 then this.enabled = false
	cb_ann.enabled = true
	cb_save.enabled = true
	dw_storicogohonzon.SetFocus ()
	
end if

end event

type cb_save from commandbutton within tabpage_storicogohonzon
integer x = 3168
integer y = 488
integer width = 334
integer height = 184
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Salva"
end type

event clicked;long ll_rows
string ls_nome

if checknull (dw_storicogohonzon) < 0 then return -1

if dw_storicogohonzon.Update () = -1 then
	
	rollback;
	OpenWithParm ( w_msg, "Modifiche annullate" )
	
else
	
//	f_log ( gs_context, "Modifica manuale storico Gohonzon." )
	commit;
	OpenWithParm ( w_msg, "Modifiche effettuate" )
	
end if

ll_rows = dw_storicogohonzon.Retrieve ( is_codice )

choose case ll_rows
		
	case -1
		
	case is > 0
		
		cb_ann.enabled = false
		cb_canc.enabled = true
		cb_save.enabled = false
		dw_storicogohonzon.SetFocus ()
		
	case else

		cb_ann.enabled = false
		cb_canc.enabled = false
		cb_save.enabled = false
		
end choose

return 0

end event

type dw_storicogohonzon from datawindow within tabpage_storicogohonzon
integer width = 3150
integer height = 1772
integer taborder = 20
string dataobject = "d_storico_goh"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event buttonclicked;long ll_codice
string ls_note, ls_note_old, ls_dip

ls_note=  this.getItemString(row, "note")

if dwo.name= 'b_note' then
	openWithParm(w_note, ls_note)
	
	ls_note_old= ls_note
	
	ls_note= message.stringParm
	
	if ls_note <> ls_note_old or isNull(ls_note_old) then
		this.setItem(row, "note", ls_note)
		this.triggerEvent("itemChanged")
	end if
	
end if
end event

event dberror;//f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )
//
return 1

end event

event editchanged;//if dwo.name = "data" then f_checkdate ( dw_storicogohonzon )


end event

event itemchanged;//modify = true

//if dwo.name = "data" then SetColumn ( "cod_causale" )

cb_ann.enabled = true
cb_canc.enabled = true
cb_save.enabled = true

end event

event itemerror;return 3

end event

type tabpage_storicoesami from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4553
integer height = 1816
long backcolor = 81324524
string text = "Storico esami"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_nuovo cb_nuovo
cb_cancella cb_cancella
cb_salva cb_salva
cb_annulla cb_annulla
dw_storicoesami dw_storicoesami
end type

on tabpage_storicoesami.create
this.cb_nuovo=create cb_nuovo
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.cb_annulla=create cb_annulla
this.dw_storicoesami=create dw_storicoesami
this.Control[]={this.cb_nuovo,&
this.cb_cancella,&
this.cb_salva,&
this.cb_annulla,&
this.dw_storicoesami}
end on

on tabpage_storicoesami.destroy
destroy(this.cb_nuovo)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.cb_annulla)
destroy(this.dw_storicoesami)
end on

type cb_nuovo from commandbutton within tabpage_storicoesami
integer x = 1710
integer y = 96
integer width = 334
integer height = 184
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Nuovo"
boolean cancel = true
end type

event clicked;long ll_row

ll_row= tab_dati.tabpage_storicoesami.dw_storicoesami.InsertRow (0)
tab_dati.tabpage_storicoesami.dw_storicoesami.ScrollToRow(ll_row)
tab_dati.tabpage_storicoesami.dw_storicoesami.SetItem (ll_row, "codice", is_codice)
tab_dati.tabpage_storicoesami.dw_storicoesami.SetColumn (1)

cb_cancella.enabled = true
end event

type cb_cancella from commandbutton within tabpage_storicoesami
integer x = 1710
integer y = 292
integer width = 334
integer height = 184
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Cancella"
boolean cancel = true
end type

event clicked;long ll_row

ll_row = tab_dati.tabpage_storicoesami.dw_storicoesami.GetRow ()

if ll_row > 0 then
	
	tab_dati.tabpage_storicoesami.dw_storicoesami.DeleteRow (ll_row)
	if tab_dati.tabpage_storicoesami.dw_storicoesami.RowCount () = 0 then this.enabled = false
	cb_annulla.enabled = true
	cb_salva.enabled = true
	tab_dati.tabpage_storicoesami.dw_storicoesami.SetFocus ()
	
end if
end event

type cb_salva from commandbutton within tabpage_storicoesami
integer x = 1710
integer y = 488
integer width = 334
integer height = 184
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Salva"
boolean cancel = true
end type

event clicked;long ll_row
string ls_nome

if checknull (tab_dati.tabpage_storicoesami.dw_storicoesami) < 0 then return -1

if tab_dati.tabpage_storicoesami.dw_storicoesami.Update ( ) = -1 then
	
	rollback;
	OpenWithParm ( w_msg, "Modifiche annullate" )
else
//	f_log ( gs_context, "Modifica manuale storico esami per " + trim ( str_parm.v_nome ) + " " + str_parm.v_cognome )
	commit;
	OpenWithParm ( w_msg, "Modifiche effettuate" )
end if

ll_row = tab_dati.tabpage_storicoesami.dw_storicoesami.Retrieve (is_codice )

choose case ll_row

	case is > 0
		
		cb_annulla.enabled = false
		cb_cancella.enabled = true
		cb_salva.enabled = false
		tab_dati.tabpage_storicoesami.dw_storicoesami.SetFocus ( )
		
	case else

		cb_annulla.enabled = false
		cb_cancella.enabled = false
		cb_salva.enabled = false
		
end choose

return 0

end event

type cb_annulla from commandbutton within tabpage_storicoesami
integer x = 1710
integer y = 684
integer width = 334
integer height = 184
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Annulla"
boolean cancel = true
end type

event clicked;int li_ret
long ll_row

if tab_dati.tabpage_storicoesami.dw_storicoesami.modifiedCount() > 0 or tab_dati.tabpage_storicoesami.dw_storicoesami.deletedCount() > 0 then

	li_ret = MessageBox (this.text, "Vuoi annullare le modifiche?", question!, YesNo!, 2 )
	
		if li_ret = 2 then return -1
		
			ll_row= dw_storicoesami.Retrieve (is_codice )
			
			choose case ll_row
					
				case is > 0
					
					cb_cancella.enabled = true
					tab_dati.tabpage_storicoesami.dw_storicoesami.SetFocus ( )
					
				case else
					
					cb_cancella.enabled = false
					
			end choose
		
		cb_annulla.enabled = false
		cb_salva.enabled = false
		
end if

return 0


end event

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

event itemchanged;//modify = true

cb_annulla.enabled = true
cb_cancella.enabled = true
cb_salva.enabled = true

end event

event itemerror;return 3
end event

type tabpage_storicocontributi from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4553
integer height = 1816
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


Start of PowerBuilder Binary Data Section : Do NOT Edit
06w_schede_dati-old.bin 
2400000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000095a54de001c6ec8200000003000001400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000f400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003ca8a978011cf280d45444da2000054530000000095a092f001c6ec8295a303f001c6ec82000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000040000001100000000000000010000000200000003fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020105ca8a978011cf280d45444da20000545300000001fb8f0821101b01640008ed8413c72e2b00000030000000c40000000600000100000000380000010100000040000001020000004800000103000000500000010400000058000000000000006400000003000500000000000300001dc400000003000013d800000003000000000000000800000001000000000000000600000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747804007974040000017300000000006372090000015f00000073726576006e6f690000000000000000000000000005000000001dc4000013d800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
16w_schede_dati-old.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
