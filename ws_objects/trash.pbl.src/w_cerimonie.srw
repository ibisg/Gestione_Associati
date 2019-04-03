$PBExportHeader$w_cerimonie.srw
forward
global type w_cerimonie from w_centered
end type
type tab_dati from tab within w_cerimonie
end type
type tabpage_5 from userobject within tab_dati
end type
type dw_dati from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_dati
dw_dati dw_dati
end type
type tabpage_2 from userobject within tab_dati
end type
type dw_current from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_dati
dw_current dw_current
end type
type tabpage_3 from userobject within tab_dati
end type
type dw_pubblicazioni from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_dati
dw_pubblicazioni dw_pubblicazioni
end type
type tabpage_1 from userobject within tab_dati
end type
type ole_1 from olecustomcontrol within tabpage_1
end type
type tabpage_1 from userobject within tab_dati
ole_1 ole_1
end type
type tabpage_4 from userobject within tab_dati
end type
type cb_new from commandbutton within tabpage_4
end type
type cb_ann from commandbutton within tabpage_4
end type
type cb_canc from commandbutton within tabpage_4
end type
type cb_save from commandbutton within tabpage_4
end type
type dw_storicogohonzon from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_dati
cb_new cb_new
cb_ann cb_ann
cb_canc cb_canc
cb_save cb_save
dw_storicogohonzon dw_storicogohonzon
end type
type tabpage_6 from userobject within tab_dati
end type
type cb_nuovo from commandbutton within tabpage_6
end type
type cb_cancella from commandbutton within tabpage_6
end type
type cb_salva from commandbutton within tabpage_6
end type
type cb_annulla from commandbutton within tabpage_6
end type
type dw_storicoesami from datawindow within tabpage_6
end type
type tabpage_6 from userobject within tab_dati
cb_nuovo cb_nuovo
cb_cancella cb_cancella
cb_salva cb_salva
cb_annulla cb_annulla
dw_storicoesami dw_storicoesami
end type
type tabpage_7 from userobject within tab_dati
end type
type cb_stampa from commandbutton within tabpage_7
end type
type cbx_importi from checkbox within tabpage_7
end type
type dw_storicocontributi from datawindow within tabpage_7
end type
type tabpage_7 from userobject within tab_dati
cb_stampa cb_stampa
cbx_importi cbx_importi
dw_storicocontributi dw_storicocontributi
end type
type tab_dati from tab within w_cerimonie
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_1 tabpage_1
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
end forward

global type w_cerimonie from w_centered
integer width = 4800
integer height = 2960
string title = "Gestione associati"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 81324524
string icon = "D:\svil\Svil7\Risorse\CharlieBrown.ico"
tab_dati tab_dati
end type
global w_cerimonie w_cerimonie

type variables
string is_codice, is_cod_com, is_com, is_prov, is_cap
s_strade is_strade_s
s_parm s_parm_s

u_ds_com ids_com
end variables

on w_cerimonie.create
int iCurrent
call super::create
this.tab_dati=create tab_dati
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dati
end on

on w_cerimonie.destroy
call super::destroy
destroy(this.tab_dati)
end on

event open;call super::open;is_codice= message.stringParm

tab_dati.tabpage_5.dw_dati.setTransObject(sqlca)
tab_dati.tabpage_5.dw_dati.retrieve(is_codice)
end event

event resize;call super::resize;		tab_dati.x= (this.workSpaceWidth()/2 - tab_dati.width/2) -36
end event

type tab_dati from tab within w_cerimonie
integer x = 27
integer y = 36
integer width = 4357
integer height = 2740
integer taborder = 10
integer textsize = -8
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
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_1 tabpage_1
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_dati.create
this.tabpage_5=create tabpage_5
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_1=create tabpage_1
this.tabpage_4=create tabpage_4
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_5,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_1,&
this.tabpage_4,&
this.tabpage_6,&
this.tabpage_7}
end on

on tab_dati.destroy
destroy(this.tabpage_5)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_1)
destroy(this.tabpage_4)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

event clicked;//string ls_boh
//
//ls_boh=  'c:\test.pdf'
//
//choose case index
//		
//	case 1 // Visualizza la scheda anagrafica (public)
//		
//	case 2 // Maschera di modifica dei dati (segreteria+superuser)
//		
//		tab_dati.tabpage_2.dw_current.setTransObject(sqlca)
//		tab_dati.tabpage_2.dw_current.retrieve(is_codice)
//		
//	case 3 // Visualizza i dati delle edizioni (public)
//		
//		tab_dati.tabpage_3.dw_pubblicazioni.setTransObject(sqlca_ediz)
//		tab_dati.tabpage_3.dw_pubblicazioni.retrieve(long(left(is_codice, len(is_codice) - 2)), right(is_codice, 2) )
//		
//	case 4 // Visualizza gli originali delle schede di adesione (segreteria+superuser)
//		
//			if tab_dati.tabpage_1.ole_1.object.SRC <> ls_boh then tab_dati.tabpage_1.ole_1.object.SRC= 'c:\test.pdf'
//		
//	case 5 // Visualizza lo storico Gohonzon  (segreteria+superuser)
//		
//	case 6 // Visualizza lo storico esami  (segreteria+superuser)
//		
//	case 7 // Visualizza lo storico contributi (superuser)
//
//end choose

end event

event selectionchanged;string ls_boh

ls_boh=  'c:\test.pdf'

choose case newindex
		
	case 1 // Visualizza la scheda anagrafica (public)
		
	case 2 // Maschera di modifica dei dati (segreteria+superuser)
		
		tab_dati.tabpage_2.dw_current.x= (this.Width/2 - tab_dati.tabpage_2.dw_current.width/2) -tab_dati.tabpage_2.dw_current.x
		tab_dati.tabpage_2.dw_current.y= (this.height/2 - tab_dati.tabpage_2.dw_current.height/2) -tab_dati.tabpage_2.dw_current.y
		tab_dati.tabpage_2.dw_current.setTransObject(sqlca)
		tab_dati.tabpage_2.dw_current.retrieve(is_codice)
		
	case 3 // Visualizza i dati delle edizioni (public)
		
		tab_dati.tabpage_3.dw_pubblicazioni.setTransObject(sqlca_ediz)
		tab_dati.tabpage_3.dw_pubblicazioni.retrieve(long(left(is_codice, len(is_codice) - 2)), right(is_codice, 2) )
		
	case 4 // Visualizza gli originali delle schede di adesione (segreteria+superuser)
		
		//	if tab_dati.tabpage_1.ole_1.object.SRC <> ls_boh then tab_dati.tabpage_1.ole_1.object.SRC= 'c:\test.pdf'
		
	case 5 // Visualizza lo storico Gohonzon  (segreteria+superuser)
		
		long ll_rows
		
			tab_dati.tabpage_4.dw_storicogohonzon.setRowFocusIndicator(focusRect!)
		
			tab_dati.tabpage_4.dw_storicogohonzon.SetTransObject ( sqlca )
		
			ll_rows = tab_dati.tabpage_4.dw_storicogohonzon.Retrieve ( is_codice )
		
//			cb_new.enabled= NOT is_cg
		
			choose case ll_rows
					
				case -1
			
				case is > 0
					
//					cb_canc.enabled= NOT is_cg
					
				case else
					
			end choose
		
			tab_dati.tabpage_4.dw_storicogohonzon.SetFocus ( )

		
	case 6 // Visualizza lo storico esami  (segreteria+superuser)
				
					 tab_dati.tabpage_6.dw_storicoesami.setRowFocusIndicator(focusRect!)
				
					 tab_dati.tabpage_6.dw_storicoesami.SetTransObject ( sqlca )
				
					ll_rows = tab_dati.tabpage_6.dw_storicoesami.Retrieve ( is_codice )
				
		//			cb_new.enabled= NOT is_cg
				
					choose case ll_rows
							
						case -1

						case is > 0
							
		//					cb_canc.enabled= NOT is_cg
							
						case else
							
					end choose
		
					 tab_dati.tabpage_6.dw_storicoesami.SetFocus ( )
		
	case 7 // Visualizza lo storico contributi (superuser)
		
		tab_dati.tabpage_7.dw_storicocontributi.setTransObject(sqlca)

		tab_dati.tabpage_7.dw_storicocontributi.setRedraw(false)
		
		ll_rows= tab_dati.tabpage_7.dw_storicocontributi.retrieve(is_codice)
		
		tab_dati.tabpage_7.dw_storicocontributi.Object.importo.Visible= 0
		
		if ll_rows > 0 /*and u_lev = 1*/ then
				
				tab_dati.tabpage_7.cb_stampa.enabled= true
				tab_dati.tabpage_7.cbx_importi.visible= true
				
		end if
		
		tab_dati.tabpage_7.dw_storicocontributi.setRedraw(true)

end choose
end event

type tabpage_5 from userobject within tab_dati
integer x = 18
integer y = 100
integer width = 4320
integer height = 2624
long backcolor = 81324524
string text = "Dati anagrafici"
long tabtextcolor = 8388608
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
dw_dati dw_dati
end type

on tabpage_5.create
this.dw_dati=create dw_dati
this.Control[]={this.dw_dati}
end on

on tabpage_5.destroy
destroy(this.dw_dati)
end on

type dw_dati from datawindow within tabpage_5
integer x = 18
integer y = 16
integer width = 3671
integer height = 2556
integer taborder = 10
string title = "none"
string dataobject = "dw_schedaanagrafica_nuova"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_dati
integer x = 18
integer y = 100
integer width = 4320
integer height = 2624
long backcolor = 67108864
string text = "Dati relativi all~'Istituto"
long tabtextcolor = 8388736
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
dw_current dw_current
end type

on tabpage_2.create
this.dw_current=create dw_current
this.Control[]={this.dw_current}
end on

on tabpage_2.destroy
destroy(this.dw_current)
end on

type dw_current from datawindow within tabpage_2
event type integer ue_salva ( )
integer x = 14
integer y = 12
integer width = 4201
integer height = 2536
integer taborder = 10
string title = "none"
string dataobject = "dw_anagrafica"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_salva;return 0
end event

event retrieveend;string ls_struttura

ls_struttura= this.getItemString(this.getRow(), "vc_parent")

ls_struttura= f_descrizione_struttura_estesa(ls_struttura)

this.setItem(this.getRow(), "cstruttura", ls_struttura)

//ls_struttura= f_global_replace(ls_struttura, ".", "~r")
//
//dw_current.Object.t_struttura.Text= ls_struttura

dw_current.ResetUpdate() // la riga estratta è come nuova anche dopo l'inserimento della descrizione estesa...
end event

event buttonclicked;integer li_ret

choose case dwo.name
		
	case "b_aggiorna"
		
		if checknull(dw_current) < 0 then return -1
		
		if dw_current.update()= 1 then
			commit using sqlca;
			// aggiorna anche la scheda dati + gestione errori
		else
			rollback using sqlca;
		end if
		
	case "b_cancella"
		
		// sei sicuro? ....
		
		if dw_current.deleteRow(0)= 1 then
			commit using sqlca;
			// aggiorna anche la scheda dati + gestione errori
		else
			rollback using sqlca;
		end if
		
		//chiudi la finestra
		
	case "b_chiudi"
		
		if dw_current.modifiedCount() > 0 then
			
			li_ret= messageBox(parent.text, "Sono state eseguite delle modifiche ai dati. Vuoi salvare?", question!, yesNo!, 1)
			
			if li_ret= 1 then
					if checknull(dw_current) < 0 then return -1
		
					if dw_current.update()= 1 then
						commit using sqlca;
						// aggiorna anche la scheda dati + gestione errori
					else
						rollback using sqlca;
					end if
					
				else
					
					rollback using sqlca;
					
			end if
			
		end if
			
			
				
		
	case "b_struttura"

		openWithParm(w_assegna_struttura, this.getItemString(row, "vc_parent") )
		
		string ls_struttura
		ls_struttura= message.stringParm
		
		if isNull(ls_struttura) or ls_struttura= "" then return -1
		
		this.setItem(row, "vc_parent", ls_struttura )
		
		ls_struttura= f_descrizione_struttura_estesa(ls_struttura)
		
		this.setItem(row, "cstruttura", ls_struttura)
		
		//ls_struttura= f_global_replace(ls_struttura, ":", ": ~t~t")
		
		//ls_struttura= f_global_replace(ls_struttura, ".", "~r")
		//
		//dw_current.Object.t_struttura.Text= ls_struttura
		
	case "b_cap"
		
		integer i_err, li_exists
		string ls_cap, ls_loc, ls_vercap
		
		ls_cap= this.getItemString(row, "cap_dom")
		ls_loc= this.getItemString(row, "comune")
		
		select cap into :ls_vercap from tab_comuni where comune= :ls_loc;
		
		select count(*)  into :li_exists from cap_generici where cap= :ls_vercap;
		
		if isNull(li_exists) or li_exists= 0 then // se non è un cap generico...
		//	select cap into :ls_vercap from tab_comuni where comune= :ls_loc;
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
		
		//				i_err= dw_dett.SelectText(len(trim(is_strade_s.tipo)+" "+is_strade_s.strada), 0)
				
					end if
				
		end if
		
end choose

return 0
end event

event dberror;//f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore DB " + string ( SqlDbCode ), SqlErrText, exclamation! )
rollback;

return 1
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
			
		CASE "cod_div"
			
//			f_log ( "Cambi di divisione", is_vecchiaOrganizzazione+" - "+is_cognome+ " "+is_nome+&
//									" - Da div. " + isa_cod_div[integer(is_cod_div)] + " a div. "+ isa_cod_div[integer(data)] )
			
		CASE "comune"
			
//			cerca:
			
			search_string = trim ( data )+"%"
			
			s_parm_s.v_ricerca_estesa= false

ricerca_estesa:			ll_rows = ids_com.Retrieve ( search_string )
			
			choose case ll_rows
					
				case is < 1
					
					if mid(search_string, 1, 1)= "%" then
						
						MessageBox (parent.text, "La località "+data+" non è stata trovata. Modificare la chiave di ricerca.", exclamation!)
						
					else
					
						if MessageBox (parent.text, "La località "+data+" non è stata trovata, vuoi eseguire una ricerca estesa?", question!, yesNo!, 1)= 1 then
							
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
						messageBox(parent.text, "Errore in inserimento codice comune", stopSign!)
						return 1
					end if
					
					i_err= dw_current.SetItem ( row, "comune", is_com )	
					i_err= dw_current.SetItem ( row, "provincia", is_prov )
					
					select count(*)  into :li_exists from cap_generici where cap= :is_cap;
					
						if isNull(li_exists) or li_exists= 0 then
							i_err= dw_current.SetItem ( row, "cap_dom", is_cap )
						else
							
							messageBox(parent.text, "Il C.A.P. relativo alla località "+is_com +" è un C.A.P. generico.~nOccorre eseguire la ricerca del C.A.P. nell'archivio strade.", information!)
							
							// apre la finestra di ricerca cap...
							openWithParm(w_cerca_strade, is_cod_com)
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
					
					s_parm_s.w_name = "w_anag"
					search_string = trim ( data )+"%"
					s_parm_s.v_com = search_string
					
					OpenWithParm ( w_search_com, s_parm_s )
					
					choose case message.DoubleParm
							
						case -1 // annulla l'operazione
							
							messageBox(parent.text, "Ricerca nome località annullata.", exclamation!)
							
							return 2 // rigetta il valore inserito
							
//						case 1 // ha letto correttamente il codice comune con cap non generico			
							
						case 2 // il comune ha un cap generico
							
							messageBox(parent.text, "Il C.A.P. relativo alla località "+is_com +" è un C.A.P. generico.~nOccorre eseguire la ricerca del C.A.P. nell'archivio strade.", information!)
							
							OpenWithParm(w_cerca_strade, is_cod_com)
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
						messageBox(parent.text, "Errore in inserimento codice comune", stopSign!)
						return 1
					end if
					i_err= dw_current.SetItem ( row, "cap_dom", is_cap )
					i_err= dw_current.SetItem ( row, "comune", is_com )
					i_err= dw_current.setText ( is_com )
					return 2
//					return 0
		
			end choose // ll_rows...
						
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

end if

return 0

end event

type tabpage_3 from userobject within tab_dati
integer x = 18
integer y = 100
integer width = 4320
integer height = 2624
long backcolor = 81324524
string text = "Dati edizioni"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
dw_pubblicazioni dw_pubblicazioni
end type

on tabpage_3.create
this.dw_pubblicazioni=create dw_pubblicazioni
this.Control[]={this.dw_pubblicazioni}
end on

on tabpage_3.destroy
destroy(this.dw_pubblicazioni)
end on

type dw_pubblicazioni from datawindow within tabpage_3
integer x = 14
integer y = 12
integer width = 3433
integer height = 2588
integer taborder = 20
string title = "none"
string dataobject = "dw_pubblicazioni"
boolean vscrollbar = true
string icon = "Report5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_1 from userobject within tab_dati
integer x = 18
integer y = 100
integer width = 4320
integer height = 2624
long backcolor = 67108864
string text = "Originale scheda"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
ole_1 ole_1
end type

on tabpage_1.create
this.ole_1=create ole_1
this.Control[]={this.ole_1}
end on

on tabpage_1.destroy
destroy(this.ole_1)
end on

type ole_1 from olecustomcontrol within tabpage_1
integer x = 443
integer y = 36
integer width = 3694
integer height = 2576
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_cerimonie.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type tabpage_4 from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4320
integer height = 2624
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

on tabpage_4.create
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

on tabpage_4.destroy
destroy(this.cb_new)
destroy(this.cb_ann)
destroy(this.cb_canc)
destroy(this.cb_save)
destroy(this.dw_storicogohonzon)
end on

type cb_new from commandbutton within tabpage_4
integer x = 3310
integer y = 20
integer width = 334
integer height = 96
integer taborder = 20
integer textsize = -8
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

type cb_ann from commandbutton within tabpage_4
integer x = 3310
integer y = 360
integer width = 334
integer height = 96
integer taborder = 30
integer textsize = -8
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

type cb_canc from commandbutton within tabpage_4
integer x = 3310
integer y = 132
integer width = 334
integer height = 96
integer taborder = 40
integer textsize = -8
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

type cb_save from commandbutton within tabpage_4
integer x = 3310
integer y = 244
integer width = 334
integer height = 96
integer taborder = 50
integer textsize = -8
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

type dw_storicogohonzon from datawindow within tabpage_4
integer x = 18
integer y = 20
integer width = 3177
integer height = 2576
integer taborder = 20
string dataobject = "d_storico_goh"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

type tabpage_6 from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4320
integer height = 2624
long backcolor = 12632256
string text = "Storico esami"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_nuovo cb_nuovo
cb_cancella cb_cancella
cb_salva cb_salva
cb_annulla cb_annulla
dw_storicoesami dw_storicoesami
end type

on tabpage_6.create
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

on tabpage_6.destroy
destroy(this.cb_nuovo)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.cb_annulla)
destroy(this.dw_storicoesami)
end on

type cb_nuovo from commandbutton within tabpage_6
integer x = 1829
integer y = 32
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Nuovo"
boolean cancel = true
end type

event clicked;long ll_row

ll_row= tab_dati.tabpage_6.dw_storicoesami.InsertRow (0)
tab_dati.tabpage_6.dw_storicoesami.ScrollToRow(ll_row)
tab_dati.tabpage_6.dw_storicoesami.SetItem (ll_row, "codice", is_codice)
tab_dati.tabpage_6.dw_storicoesami.SetColumn (1)

cb_cancella.enabled = true
end event

type cb_cancella from commandbutton within tabpage_6
integer x = 1829
integer y = 148
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Cancella"
boolean cancel = true
end type

event clicked;long ll_row

ll_row = tab_dati.tabpage_6.dw_storicoesami.GetRow ()

if ll_row > 0 then
	
	tab_dati.tabpage_6.dw_storicoesami.DeleteRow (ll_row)
	if tab_dati.tabpage_6.dw_storicoesami.RowCount () = 0 then this.enabled = false
	cb_annulla.enabled = true
	cb_salva.enabled = true
	tab_dati.tabpage_6.dw_storicoesami.SetFocus ()
	
end if
end event

type cb_salva from commandbutton within tabpage_6
integer x = 1829
integer y = 264
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Salva"
boolean cancel = true
end type

event clicked;long ll_row
string ls_nome

if checknull (tab_dati.tabpage_6.dw_storicoesami) < 0 then return -1

if tab_dati.tabpage_6.dw_storicoesami.Update ( ) = -1 then
	
	rollback;
	OpenWithParm ( w_msg, "Modifiche annullate" )
else
//	f_log ( gs_context, "Modifica manuale storico esami per " + trim ( str_parm.v_nome ) + " " + str_parm.v_cognome )
	commit;
	OpenWithParm ( w_msg, "Modifiche effettuate" )
end if

ll_row = tab_dati.tabpage_6.dw_storicoesami.Retrieve (is_codice )

choose case ll_row

	case is > 0
		
		cb_annulla.enabled = false
		cb_cancella.enabled = true
		cb_salva.enabled = false
		tab_dati.tabpage_6.dw_storicoesami.SetFocus ( )
		
	case else

		cb_annulla.enabled = false
		cb_cancella.enabled = false
		cb_salva.enabled = false
		
end choose

return 0

end event

type cb_annulla from commandbutton within tabpage_6
integer x = 1829
integer y = 380
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Annulla"
boolean cancel = true
end type

event clicked;int li_ret
long ll_row

if tab_dati.tabpage_6.dw_storicoesami.modifiedCount() > 0 or tab_dati.tabpage_6.dw_storicoesami.deletedCount() > 0 then

	li_ret = MessageBox (this.text, "Vuoi annullare le modifiche?", question!, YesNo!, 2 )
	
		if li_ret = 2 then return -1
		
			ll_row= dw_storicoesami.Retrieve (is_codice )
			
			choose case ll_row
					
				case is > 0
					
					cb_cancella.enabled = true
					tab_dati.tabpage_6.dw_storicoesami.SetFocus ( )
					
				case else
					
					cb_cancella.enabled = false
					
			end choose
		
		cb_annulla.enabled = false
		cb_salva.enabled = false
		
end if

return 0


end event

type dw_storicoesami from datawindow within tabpage_6
integer x = 41
integer y = 32
integer width = 1701
integer height = 2560
integer taborder = 20
string title = "none"
string dataobject = "ds_curr_studio"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

type tabpage_7 from userobject within tab_dati
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4320
integer height = 2624
long backcolor = 81324524
string text = "Storico contributi"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_stampa cb_stampa
cbx_importi cbx_importi
dw_storicocontributi dw_storicocontributi
end type

on tabpage_7.create
this.cb_stampa=create cb_stampa
this.cbx_importi=create cbx_importi
this.dw_storicocontributi=create dw_storicocontributi
this.Control[]={this.cb_stampa,&
this.cbx_importi,&
this.dw_storicocontributi}
end on

on tabpage_7.destroy
destroy(this.cb_stampa)
destroy(this.cbx_importi)
destroy(this.dw_storicocontributi)
end on

type cb_stampa from commandbutton within tabpage_7
integer x = 2629
integer y = 196
integer width = 288
integer height = 108
integer taborder = 12
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Stampa"
end type

event clicked;openWithParm(w_dw_print_options, tab_dati.tabpage_7.dw_storicocontributi)
end event

type cbx_importi from checkbox within tabpage_7
boolean visible = false
integer x = 2629
integer y = 480
integer width = 594
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 81324524
string text = "Visualizza importi"
end type

event clicked;integer i_ret

if this.checked= true then
	
	open(w_check_pw)
	
	i_ret= message.doubleParm
	
	if i_ret= 1 then
		
		//visualizza gli importi
		tab_dati.tabpage_7.dw_storicocontributi.Object.importo.Visible= 1
		tab_dati.tabpage_7.dw_storicocontributi.Object.importo_t.Visible= 1
		
	else
		
		this.checked= false
		
	end if
	
else
	
	tab_dati.tabpage_7.dw_storicocontributi.Object.importo.Visible= 0
	tab_dati.tabpage_7.dw_storicocontributi.Object.importo_t.Visible= 0
	
end if
end event

type dw_storicocontributi from datawindow within tabpage_7
integer x = 18
integer y = 12
integer width = 2555
integer height = 2580
integer taborder = 10
string dataobject = "dw_info"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_cerimonie.bin 
2C00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000682cdfc001c65e4a00000003000001400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000f400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003ca8a978011cf280d45444da20000545300000000682cdfc001c65e4a682cdfc001c65e4a000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000040000001100000000000000010000000200000003fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020105ca8a978011cf280d45444da20000545300000001fb8f0821101b01640008ed8413c72e2b00000030000000c40000000600000100000000380000010100000040000001020000004800000103000000500000010400000058000000000000006400000003000500000000000300005382000000030000428f00000003000000000000000800000001000000000000000600000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747804007974040000017300000000006372090000015f00000073726576006e6f69006c0064006e006f0020006700050000000053820000428f00000000006f00000067006e006c002000610070006100720020006d002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d0062006f005f00680074007200650000005d000024b800000000000024d600000000000024f00000000000002514000000000000252c0000000000002540000000000000255c000000000000257c00000000000025a200000000000025b600000000000025d80000000000002604000000000000262c000000000000264a000000000000266a000000000000269e00000000000026c200000000000026ea000000000000270e000000000000272800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_cerimonie.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
