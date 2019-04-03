$PBExportHeader$w_esami_tab.srw
forward
global type w_esami_tab from window
end type
type dw_header from datawindow within w_esami_tab
end type
type tab_esami from tab within w_esami_tab
end type
type tabpage_inserimento from userobject within tab_esami
end type
type st_1 from statictext within tabpage_inserimento
end type
type pb_struttura from picturebutton within tabpage_inserimento
end type
type cb_importa from commandbutton within tabpage_inserimento
end type
type cb_annullafiltro from commandbutton within tabpage_inserimento
end type
type cb_filtra from commandbutton within tabpage_inserimento
end type
type em_filtra from editmask within tabpage_inserimento
end type
type st_filtra from statictext within tabpage_inserimento
end type
type dw_import from datawindow within tabpage_inserimento
end type
type cb_estrazione from commandbutton within tabpage_inserimento
end type
type tabpage_inserimento from userobject within tab_esami
st_1 st_1
pb_struttura pb_struttura
cb_importa cb_importa
cb_annullafiltro cb_annullafiltro
cb_filtra cb_filtra
em_filtra em_filtra
st_filtra st_filtra
dw_import dw_import
cb_estrazione cb_estrazione
end type
type tabpage_lista from userobject within tab_esami
end type
type dw_lista from datawindow within tabpage_lista
end type
type tabpage_lista from userobject within tab_esami
dw_lista dw_lista
end type
type tabpage_esito from userobject within tab_esami
end type
type pb_1 from picturebutton within tabpage_esito
end type
type rb_tutti from radiobutton within tabpage_esito
end type
type rb_respinti from radiobutton within tabpage_esito
end type
type rb_promossi from radiobutton within tabpage_esito
end type
type rb_assenti from radiobutton within tabpage_esito
end type
type cb_aggiorna from commandbutton within tabpage_esito
end type
type cb_salva from commandbutton within tabpage_esito
end type
type dw_esito from datawindow within tabpage_esito
end type
type gb_vis from groupbox within tabpage_esito
end type
type tabpage_esito from userobject within tab_esami
pb_1 pb_1
rb_tutti rb_tutti
rb_respinti rb_respinti
rb_promossi rb_promossi
rb_assenti rb_assenti
cb_aggiorna cb_aggiorna
cb_salva cb_salva
dw_esito dw_esito
gb_vis gb_vis
end type
type tab_esami from tab within w_esami_tab
tabpage_inserimento tabpage_inserimento
tabpage_lista tabpage_lista
tabpage_esito tabpage_esito
end type
type s_cons from structure within w_esami_tab
end type
end forward

type s_cons from structure
	string		v_codice
	string		v_nomin
	string		v_loc
	datetime		v_data
	string		v_citta
	string		v_turno
	string		v_causale
	string		v_tipo_goh
end type

global type w_esami_tab from window
integer x = 5
integer y = 4
integer width = 5527
integer height = 2356
boolean titlebar = true
string title = "Esami di studio"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event type integer ue_open ( )
event uscita ( )
event clear ( string ls_from )
event type integer save ( )
event search_ses ( )
event query_on ( )
event query_off ( )
event query_start ( )
event ordina ( )
event importa ( )
event stampa ( )
event type integer ue_salva_come ( )
dw_header dw_header
tab_esami tab_esami
end type
global w_esami_tab w_esami_tab

type variables
boolean ib_closing = false
boolean calling = false

s_esami str_es
uo_ds_gen ds_lista

string c_area, c_terr, c_cen, c_cap, c_sett, c_gru
string is_liv, status

DataWindowChild idwc_liv
DataWindowChild idwc_area, idwc_terr, idwc_cen
DataWindowChild idwc_cap, idwc_sett, idwc_gru

s_evento is_evento_s

end variables

forward prototypes
public function integer f_canc_lista ()
public function string dw_status ()
public function integer query_mode ()
public subroutine f_header (integer li_operation)
public function integer dw_retrieve ()
end prototypes

event type integer ue_open();long ll_row

openWithParm(w_gestione_cerimonie, ESAMI)

is_evento_s= message.powerObjectParm

if isNull(is_evento_s.id) then
	close(this)
	return -1
end if

tab_esami.tabpage_inserimento.dw_import.setTransObject(sqlca)

dw_header.setTransObject(sqlca)

ll_row= dw_header.retrieve(is_evento_s.id)

/////////

choose case is_evento_s.tipo_evento
		
	case 1
		
		is_liv = "00"
	
	case 2
		
		is_liv = "01"
		
	case 3
		
		is_liv = "02"
		
	case 4
		
		is_liv = "03"
		
	case 5
		
		is_liv= "04"
		
end choose

tab_esami.tabpage_lista.dw_lista.setTransObject(sqlca)

if tab_esami.tabpage_lista.dw_lista.retrieve(is_evento_s.id)= 0 then
	
	messageBox(this.title, "Nessuna lista è stata ancora generata per questo evento.", information!)
	
	tab_esami.tabpage_inserimento.cb_estrazione.event clicked()
	
	tab_esami.tabpage_inserimento.cb_estrazione.enabled= true
	tab_esami.tabpage_inserimento.pb_struttura.enabled= true
	
else
	
	tab_esami.tabpage_inserimento.enabled= false
	tab_esami.tabpage_lista.enabled= true
	tab_esami.tabpage_esito.enabled= true
	tab_esami.selectTab(tab_esami.tabpage_lista)
	
end if



return 0
end event

event uscita;ib_closing = true

close ( this )

end event

event clear;//if dw_elenco.DataObject = "dw_lista" then
//
//	int li_ret
//	
//	dw_elenco.AcceptText ( )
//	
//	if dw_elenco.ModifiedCount ( ) > 0 then
//		
//		li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
//									 question!, YesNoCancel!, 1 )
//																					
//		choose case li_ret
//				
//			case 1
//				
//				if event save ( ) = -1 then return
//				
//			case 2
//				
//			case 3
//				
//				return
//				
//		end choose
//		
//	end if
//	
//end if
//
//dw_elenco.SetRedraw ( false )
//dw_elenco.DataObject = "dw_lista"
//dw_elenco.SetTransObject ( sqlca )
//SetRedraw ( dw_elenco, true )
//
//dw_elenco.visible = false
//
//cb_estrai.visible = false
//cb_save.visible = false
//cb_annulla.visible = false
//
//cb_estrai.enabled = false
//cb_save.enabled = false
//cb_annulla.enabled = false
//
//st_filtra.visible= false
//em_filtra.visible= false
//cb_filtra.visible= false
//cb_annullafiltro.visible= false
//
//cb_estrai.text = ""
//cb_save.text = ""
//cb_annulla.text = ""
//
//cb_estrai.visible= false
//cb_save.visible= false
//cb_annulla.visible= false
//
//m_esami.m_opzioni.m_sessione.enabled = true
//m_esami.m_opzioni.m_ordina.enabled = false
//m_esami.m_opzioni.m_stampa.enabled = false
//m_esami.m_opzioni.m_salvacome.enabled = false
//
//SetNull ( status )
//
//gb_dett.text = ""
//
end event

event save;//dw_elenco.SetRedraw ( false )
//
//if dw_elenco.Update ( ) = -1 then
//	
//	if dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv ) < 1 then
//		MessageBox ( "Errore grave", "Programma terminato", StopSign! )
//		halt close
//	end if
//	
//	f_log_err ( gs_context, sqlca.SqlErrText )
//	rollback;
//	
//	OpenWithParm ( w_msgauto, "Modifiche annullate" )
//	
//	dw_elenco.SetRedraw ( true )
//	
//	return -1
//	
//else
//	
//	commit;
//	
//	if dw_elenco.Retrieve ( str_es.v_data, str_es.v_sede, str_es.v_liv ) < 1 then
//		MessageBox ( "Errore grave", "Programma terminato", StopSign! )
//		halt close
//	end if
//
//	OpenWithParm ( w_msgauto, "Modifiche effettuate" )
//	
//	dw_elenco.SetRedraw ( true )
//	
//	cb_save.enabled = false
//	
//end if

return 0

end event

event search_ses();//long ll_rows
//
//select count ( * )
//into :ll_rows
//from esami;
//
//if trap_sql ( sqlca, "controllo liste" ) = -1 then
//	f_log_err ( gs_context, sqlca.SqlErrText )
//	close ( this )
//	return
//end if
//
//if ll_rows = 0 then 
//	MessageBox ( "Esami", "Nessuna lista impostata..." )
//	return
//end if
//
//OpenWithParm ( w_sel_sessione, "esami" )
//
//if message.DoubleParm = -1 then return
//
//choose case str_es.v_liv
//		
//	case "01"
//		
//		SetNull ( is_liv )
//		
//	case "02"
//		
//		is_liv = "01"
//		
//	case "03"
//		
//		is_liv = "02"
//		
//	case "04"
//		
//		is_liv = "03"
//		
//	case "05"
//		
//		is_liv = "04"
//		
//end choose
//
//f_header ( 1 ) // 1 significa che deve estrarre dati già inseriti
//
end event

event query_on;//int li_colnum
//string ls_colname, ls_null
//
//dw_elenco.SetRedraw ( false )
//
////for li_colnum = 3 to 10
////	
////	ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
////	dw_elenco.Modify(ls_colname+".Protect=0")
////
////next
//
//dw_elenco.modify ( "flag_ok.visible=0" )
//dw_elenco.modify ( "conf_t.visible=0" )
////dw_elenco.Modify ( "DataWindow.Footer.Height='1'" )
//
//query_mode ( )
//
//dw_elenco.SetRedraw ( true )
//
//dw_elenco.SetFocus ( )
//
//cb_estrai.text = "&Estrai"
//cb_save.enabled = false
//if status = "crea" then cb_annulla.enabled = false
//
//m_esami.m_opzioni.m_ordina.enabled = false
//m_esami.m_opzioni.m_stampa.enabled = false
//m_esami.m_opzioni.m_salvacome.enabled = false
//
end event

event query_off;//int li_colnum
//string ls_colname
//
//if dw_retrieve ( ) = 0 then
//	
//	MessageBox ( "Query", "Ricerca senza esito..." )
//	TriggerEvent ( "query_on" )
//	
//	return
//	
//end if
//
//dw_elenco.SetRedraw ( false )
//
//if dw_elenco.RowCount ( ) > 0 then
//	
//	for li_colnum = 3 to 10
//		
//		ls_colname = dw_elenco.Describe("#"+string(li_colnum)+".Name")
//		dw_elenco.Modify(ls_colname+".Protect=1")
//		
//	next
//	
//	dw_elenco.modify ( "flag_ok.visible=1" )
//	dw_elenco.modify ( "conf_t.visible=1" )
////	dw_elenco.Modify ( "DataWindow.Footer.Height='92'" )
//	
//end if
//
//dw_elenco.SetRedraw ( true )
//dw_elenco.setFocus ( )
//
//cb_estrai.text = "&Cerca"
//cb_save.enabled = true
//if status = "crea" then cb_annulla.visible = false
//
//m_esami.m_opzioni.m_ordina.enabled = true
//m_esami.m_opzioni.m_stampa.enabled = true
//m_esami.m_opzioni.m_salvacome.enabled = true
//
end event

event query_start;if dw_status ( ) = 'no' then
	TriggerEvent ( "query_on" )
else
	TriggerEvent ( "query_off" )
end if

end event

event ordina;//OpenWithParm ( w_ordina, dw_elenco )
//dw_elenco.SetSort ( message.StringParm )
//dw_elenco.Sort ( )
//
end event

event importa();long ll_rows, ll_count, ll_row

ds_lista = create uo_ds_gen
ds_lista.DataObject = "ds_lista"
ds_lista.SetTransObject ( sqlca )

for ll_count = 1 to tab_esami.tabpage_inserimento.dw_import.RowCount ()
	
	if tab_esami.tabpage_inserimento.dw_import.GetItemString ( ll_count, "flag_ok" ) = "S" then
	
		ll_row= ds_lista.InsertRow ( 0 )
		
		ds_lista.SetItem ( ll_row, "id", is_evento_s.id )
		ds_lista.SetItem ( ll_row, "codice", tab_esami.tabpage_inserimento.dw_import.GetItemString ( ll_count, "codice" ) )
		ds_lista.SetItem ( ll_row, "cod_studio", is_liv )
		ds_lista.SetItem ( ll_row, "esito", "" )
		ds_lista.SetItem ( ll_row, "flag_ok", "S" )
		
//		messageBox("test", tab_esami.tabpage_inserimento.dw_import.GetItemString ( ll_count, "codice" ) )
		
	end if
	
next

if ds_lista.Update ( ) = -1 then
	
	rollback;
	destroy ds_lista
	OpenWithParm ( w_msg, "Importazione annullata" )
	
	return
	
end if

commit;

//ds_lista.reset ( )
destroy ds_lista

OpenWithParm ( w_msg, "Importazione effettuata" )

tab_esami.tabpage_lista.dw_lista.SetRedraw ( false )
tab_esami.tabpage_lista.dw_lista.Retrieve ( is_evento_s.id )
//tab_esami.tabpage_lista.dw_lista.Object.DataWindow.Print.Preview= 'yes'
tab_esami.tabpage_lista.dw_lista.SetRedraw ( true )

//cb_estrai.text = "Aggiorna lista"
//cb_save.enabled = false
//cb_annulla.text = "Cancella lista"
//cb_annulla.enabled = true
//

tab_esami.selectTab(tab_esami.tabpage_lista)
tab_esami.tabpage_lista.enabled= true
tab_esami.tabpage_inserimento.enabled= false
tab_esami.tabpage_esito.enabled= true

return

end event

event stampa;//dw_elenco.SetRedraw ( false )
////dw_elenco.Object.n_pag.visible = 1
////dw_elenco.Object.DataWindow.Footer.Height = 165
//
//OpenWithParm ( w_dw_print_options, this.dw_elenco )
//
////dw_elenco.Object.n_pag.visible = 0
////dw_elenco.Object.DataWindow.Footer.Height = 85
//dw_elenco.SetRedraw ( true )
//
end event

event ue_salva_come;////int li_colnum
//string ls_colname, ls_msg
//
//open ( w_aut_print )
//
//if Message.DoubleParm = -1 then return -1
//
//ls_msg = "Salvato su file per " + Message.StringParm
//
//if dw_elenco.SaveAs()= -1 then return -1
//
//f_log ( gs_context, ls_msg )
//
return 0
end event

public function integer f_canc_lista ();open ( w_wait )

delete from esami
 where data_esame = :str_es.v_data
	and sede = :str_es.v_sede
	and cod_studio = :str_es.v_liv;

close ( w_wait )
	
if trap_sql ( sqlca, "cancellazione lista candidati" ) = -1 then
	f_log_err ( gs_context, sqlca.SqlErrText )
	rollback;
	return -1
else
	commit;
	return 0
end if

return 0

end function

public function string dw_status ();string stato

//stato = dw_elenco.Describe ( "DataWindow.QueryMode" )

return stato

end function

public function integer query_mode ();//dw_elenco.dataObject= dw_elenco.dataObject
//
//dw_elenco.setTransObject ( sqlca )
//
//dw_elenco.setRedraw ( false )
//
//dw_elenco.modify ( "dataWindow.queryMode=YES" )
//
////dw_elenco.Object.DataWindow.Footer.Height = 1
//
//dw_elenco.setRedraw ( true )
//
////w_prelude.SetMicroHelp ( "Modalita' Ricerca: impostare i criteri di estrazione..." )

return 0

end function

public subroutine f_header (integer li_operation);//long ll_found
//
////if not IsNull ( str_es.v_data ) and not IsNull ( str_es.v_sede ) &
////and not IsNull ( str_es.v_liv ) then
//
//if li_operation= 1 then
//	dw_elenco.DataObject = "dw_lista"
//	dw_elenco.setTransObject(sqlca)
//	dw_elenco.SetRedraw ( false )
//	ll_found = dw_elenco.Retrieve ( is_evento_s.id )
//	dw_elenco.SetRedraw ( true )
//	
//	if ll_found = -1 then
//		
//		OpenWithParm ( w_msgauto, "Operazione annullata" )
//		TriggerEvent ( "clear" )
//		return
//		
//	end if
//		
//end if
//
////long ll_quanti
////	select count (*) 
////	into :ll_quanti
////	from esami
////	where data_esame= :str_es.v_data and sede= :str_es.v_sede and cod_studio= :str_es.v_liv;
////	
////	if ll_quanti > 0 then
////		messageBox(this.title, "Sessione di esame già esistente", exclamation!)
////		return
////	end if
//	
//
//	cb_save.visible = true
//	
//	dw_elenco.visible = true
//
//	if ll_found > 0 then
//		
//		gb_dett.Text = " Lista candidati "
//		
//		status = "modifica"
//		
//		cb_estrai.text = "Aggiorna lista"
//		cb_annulla.visible = true
//		cb_annulla.text = "Cancella lista"
//		cb_annulla.enabled = true
//		
//		m_esami.m_opzioni.m_ordina.enabled = true
//		m_esami.m_opzioni.m_stampa.enabled = true
//		m_esami.m_opzioni.m_salvacome.enabled = true
//		
//	else
//		
//		gb_dett.Text = " Nuova sessione - Creazione lista (sono esclusi automaticamente dalle liste i DEC, TAI, DIM e i TFE)"
//		
//		dw_elenco.SetRedraw ( false )
//		dw_elenco.DataObject = "d_import"
//		dw_elenco.SetTransObject ( sqlca )
//		TriggerEvent ( "query_on" )
//		dw_elenco.SetRedraw ( true )
//		
//		status = "crea"
//		
//		cb_estrai.text = "&Estrai"
//		
//		m_esami.m_opzioni.m_ordina.enabled = false
//		m_esami.m_opzioni.m_stampa.enabled = false
//		m_esami.m_opzioni.m_salvacome.enabled = false
//		
//	end if
//	
//	m_esami.m_opzioni.m_sessione.enabled = false
//	
//	cb_estrai.enabled = true
//	cb_save.text = "Ins. in lista"
//
end subroutine

public function integer dw_retrieve ();//long ll_rows
///*
// * estrazione dati in base a definiti criteri...
// */
//dw_elenco.acceptText()
//
////w_prelude.SetMicroHelp ( "Estrazione dati..." )
//
//dw_elenco.setRedraw ( false )
//
//dw_elenco.modify ( "dataWindow.queryMode=no" )
//
////dw_elenco.setTransObject ( sqlca )
//
//ll_rows= dw_elenco.retrieve ( )
//
//// GdS
//commit using sqlca;
//
//if ll_rows = 0 then return 0
//
//dw_elenco.setRedraw ( true )
//
//dw_elenco.TriggerEvent ( GetFocus! )
//
////w_prelude.SetMicroHelp ( "" )
//
return 1
end function

event dw_retrieve;//int li_colnum
//string ls_colname, ls_msg
//
//open ( w_aut_print )
//
////if Message.DoubleParm = -1 then return -1
//
//ls_msg = "Salvato su file per " + Message.StringParm
//
////if dw_elenco.SaveAs()= -1 then return -1
//
//f_log ( gs_context, ls_msg )
//
////return 0
end event

on w_esami_tab.create
this.dw_header=create dw_header
this.tab_esami=create tab_esami
this.Control[]={this.dw_header,&
this.tab_esami}
end on

on w_esami_tab.destroy
destroy(this.dw_header)
destroy(this.tab_esami)
end on

event open;PostEvent ( "ue_open" )

end event

event closequery;//if dw_elenco.DataObject = "d_lista" then
//
//	int li_ret
//	
//	dw_elenco.AcceptText ( )
//	
//	if dw_elenco.ModifiedCount ( ) > 0 then
//		
//		li_ret = MessageBox ( "Attenzione", "Sono stati modificati dei dati...~nSalvare?", &
//									 question!, YesNoCancel!, 1 )
//																					
//		choose case li_ret
//				
//			case 1
//				
//				if event save ( ) = -1 then
//					ib_closing = false
//					return 1
//				else
//					return 0
//				end if
//				
//			case 2
//				
//				return 0
//				
//			case 3
//				
//				ib_closing = false
//				return 1
//				
//		end choose
//		
//	end if
//	
//end if
//
end event

event activate;gs_context = "Esami di studio"

end event

event resize;//gb_dett.width= this.width - 90
//dw_elenco.width= gb_dett.width - 400
//cb_estrai.x= dw_elenco.width + 80
//cb_save.x= dw_elenco.width + 80
//cb_annulla.x= dw_elenco.width + 80
//
//
//gb_dett.height= this.height - 200 - gb_dett.y
//
//dw_elenco.height= gb_dett.height -240
//

tab_esami.height= this.height - 180 - tab_esami.y
tab_esami.tabpage_inserimento.dw_import.height= tab_esami.height - 120 - tab_esami.tabpage_inserimento.dw_import.y

tab_esami.tabpage_lista.dw_lista.height= tab_esami.height - 120 - tab_esami.tabpage_lista.dw_lista.y
tab_esami.tabpage_esito.dw_esito.height= tab_esami.height - 120 - tab_esami.tabpage_esito.dw_esito.y
end event

type dw_header from datawindow within w_esami_tab
integer x = 14
integer y = 20
integer width = 4219
integer height = 364
integer taborder = 10
string title = "none"
string dataobject = "dw_header_eventi"
boolean border = false
boolean livescroll = true
end type

type tab_esami from tab within w_esami_tab
event create ( )
event destroy ( )
integer x = 23
integer y = 384
integer width = 5111
integer height = 1344
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_inserimento tabpage_inserimento
tabpage_lista tabpage_lista
tabpage_esito tabpage_esito
end type

on tab_esami.create
this.tabpage_inserimento=create tabpage_inserimento
this.tabpage_lista=create tabpage_lista
this.tabpage_esito=create tabpage_esito
this.Control[]={this.tabpage_inserimento,&
this.tabpage_lista,&
this.tabpage_esito}
end on

on tab_esami.destroy
destroy(this.tabpage_inserimento)
destroy(this.tabpage_lista)
destroy(this.tabpage_esito)
end on

event selectionchanged;choose case newindex
		
	case 2
		
		tab_esami.tabpage_lista.dw_lista.setTransObject(sqlca)
		tab_esami.tabpage_lista.dw_lista.SetRedraw ( false )
		tab_esami.tabpage_lista.dw_lista.Retrieve ( is_evento_s.id )
//		tab_esami.tabpage_lista.dw_lista.Object.DataWindow.Print.Preview= 'yes'
//		tab_esami.tabpage_lista.dw_lista.Object.DataWindow.Print.Buttons = 'yes'
		tab_esami.tabpage_lista.dw_lista.SetRedraw ( true )	
		
	case 3
		
		tab_esami.tabpage_esito.dw_esito.setTransObject(sqlca)
		tab_esami.tabpage_esito.dw_esito.SetRedraw ( false )
		tab_esami.tabpage_esito.dw_esito.Retrieve ( is_evento_s.id )
		tab_esami.tabpage_esito.dw_esito.SetRedraw ( true )	
		
		
end choose
end event

type tabpage_inserimento from userobject within tab_esami
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5074
integer height = 1228
long backcolor = 12632256
string text = "Inserimento partecipanti"
long tabtextcolor = 16711680
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_1 st_1
pb_struttura pb_struttura
cb_importa cb_importa
cb_annullafiltro cb_annullafiltro
cb_filtra cb_filtra
em_filtra em_filtra
st_filtra st_filtra
dw_import dw_import
cb_estrazione cb_estrazione
end type

on tabpage_inserimento.create
this.st_1=create st_1
this.pb_struttura=create pb_struttura
this.cb_importa=create cb_importa
this.cb_annullafiltro=create cb_annullafiltro
this.cb_filtra=create cb_filtra
this.em_filtra=create em_filtra
this.st_filtra=create st_filtra
this.dw_import=create dw_import
this.cb_estrazione=create cb_estrazione
this.Control[]={this.st_1,&
this.pb_struttura,&
this.cb_importa,&
this.cb_annullafiltro,&
this.cb_filtra,&
this.em_filtra,&
this.st_filtra,&
this.dw_import,&
this.cb_estrazione}
end on

on tabpage_inserimento.destroy
destroy(this.st_1)
destroy(this.pb_struttura)
destroy(this.cb_importa)
destroy(this.cb_annullafiltro)
destroy(this.cb_filtra)
destroy(this.em_filtra)
destroy(this.st_filtra)
destroy(this.dw_import)
destroy(this.cb_estrazione)
end on

type st_1 from statictext within tabpage_inserimento
integer x = 3081
integer y = 368
integer width = 407
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Seleziona struttura"
boolean focusrectangle = false
end type

type pb_struttura from picturebutton within tabpage_inserimento
integer x = 3195
integer y = 436
integer width = 174
integer height = 136
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string picturename = "where.bmp"
alignment htextalign = left!
end type

event clicked;s_struttura s_struttura_s

s_struttura_s.livello= MAX_LIVELLO

openWithParm(w_mostra_struttura, s_struttura_s )

s_struttura_s= message.powerObjectParm

if s_struttura_s.livello= -1 then return -1

tab_esami.tabpage_inserimento.dw_import.setColumn(1)

tab_esami.tabpage_inserimento.dw_import.setText(s_struttura_s.vc_nodo) 
end event

type cb_importa from commandbutton within tabpage_inserimento
integer x = 3113
integer y = 188
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Genera lista"
end type

event clicked;w_esami_tab.event importa()
end event

type cb_annullafiltro from commandbutton within tabpage_inserimento
boolean visible = false
integer x = 2409
integer y = 108
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Annulla il filtro"
end type

event clicked;//string ls_filtra
//
//ls_filtra= ""
//em_filtra.text= ""
//
//dw_elenco.setFilter(ls_filtra)
//
//dw_elenco.filter()
end event

type cb_filtra from commandbutton within tabpage_inserimento
boolean visible = false
integer x = 2021
integer y = 108
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Filtra"
end type

event clicked;//string ls_filtra
//
//ls_filtra= " data_esame < date('"+em_filtra.text+"')  or isNull(data_esame)"
//
//dw_elenco.setFilter(ls_filtra)
//
//dw_elenco.filter()
end event

type em_filtra from editmask within tabpage_inserimento
boolean visible = false
integer x = 1495
integer y = 100
integer width = 471
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 65535
long backcolor = 0
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd.mm.yyyy"
boolean spin = true
end type

type st_filtra from statictext within tabpage_inserimento
boolean visible = false
integer x = 352
integer y = 128
integer width = 1129
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
string text = "Escludi le persone che hanno sostenuto l~'esame il: "
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_import from datawindow within tabpage_inserimento
integer y = 280
integer width = 3013
integer height = 720
integer taborder = 20
string title = "none"
string dataobject = "dw_import"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_import, false)

if(pos(lower(sqlsyntax), "where")) >0 then
	sqlsyntax+= " and membri_gerarchica.cod_studio= '"+is_liv+"'"
else
		sqlsyntax+= " where membri_gerarchica.cod_studio= '"+is_liv+"'"
end if

SetSqlPreview ( sqlsyntax)
end event

event rowfocuschanged;f_select_current_row (dw_import)
if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	w_frame_gestioneassociati.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
end if
end event

type cb_estrazione from commandbutton within tabpage_inserimento
integer x = 3113
integer y = 72
integer width = 343
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Estrazione"
end type

event clicked;long ll_rows

dw_import.setRedraw(false)

ricerca:	if dw_import.Object.DataWindow.QueryMode= 'yes' then
	
//				cb_annulla.enabled= false
			
				dw_import.acceptText()
				dw_import.Object.DataWindow.QueryMode= 'no' 
				ll_rows= dw_import.retrieve()
				cb_estrazione.text= "Ricerca"
				if ll_rows > 0 then
					tab_esami.tabpage_inserimento.cb_importa.enabled= true
					tab_esami.tabpage_inserimento.pb_struttura.enabled= false
				else
					messageBox(parent.text, "Non sono stati trovati record rispondenti a questi criteri di ricerca.", exclamation!)
					dw_import.Object.DataWindow.QueryMode= 'no'
					goto ricerca
				end if
				
			else
				dw_import.reset()
				cb_estrazione.text= "Estrazione"
				tab_esami.tabpage_inserimento.cb_importa.enabled= false
				tab_esami.tabpage_inserimento.pb_struttura.enabled= true
				dw_import.Object.DataWindow.QueryClear= 'yes'
				dw_import.Object.DataWindow.QueryMode= 'yes' 
		end if

dw_import.setRedraw(true)

//cb_annulla.enabled= true

dw_import.setFocus()

end event

type tabpage_lista from userobject within tab_esami
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5074
integer height = 1228
boolean enabled = false
long backcolor = 12632256
string text = "Lista esami"
long tabtextcolor = 8388608
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_lista dw_lista
end type

on tabpage_lista.create
this.dw_lista=create dw_lista
this.Control[]={this.dw_lista}
end on

on tabpage_lista.destroy
destroy(this.dw_lista)
end on

type dw_lista from datawindow within tabpage_lista
integer width = 5051
integer height = 1044
integer taborder = 60
string title = "Lista esami"
string dataobject = "dw_lista"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;choose case dwo.name
		
	case "b_cancella" 
	
		delete from esami where id= :is_evento_s.id;
		
		if trap_sql(sqlca, "DELETE_ESAMI01") < 0 then
			rollback;
		else
			commit;
				if trap_sql(sqlca, "DELETE_ESAMI02") < 0 then
					messageBox(tab_esami.tabpage_lista.text, "Salvataggio fallito", exclamation!)
					return -1
				end if
			dw_lista.reset()
			tab_esami.tabpage_lista.enabled= false
			tab_esami.tabpage_esito.enabled= false
			tab_esami.selectTab(tab_esami.tabpage_inserimento)
			tab_esami.tabpage_inserimento.enabled= true
			
			tab_esami.tabpage_inserimento.cb_estrazione.enabled= true
			tab_esami.tabpage_inserimento.pb_struttura.enabled= true
			
		end if
	
case "b_stampa"
	
	openWithParm(w_dw_print_options, dw_lista)
	
end choose
end event

type tabpage_esito from userobject within tab_esami
integer x = 18
integer y = 100
integer width = 5074
integer height = 1228
boolean enabled = false
long backcolor = 12632256
string text = "Esito"
long tabtextcolor = 8388736
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
pb_1 pb_1
rb_tutti rb_tutti
rb_respinti rb_respinti
rb_promossi rb_promossi
rb_assenti rb_assenti
cb_aggiorna cb_aggiorna
cb_salva cb_salva
dw_esito dw_esito
gb_vis gb_vis
end type

on tabpage_esito.create
this.pb_1=create pb_1
this.rb_tutti=create rb_tutti
this.rb_respinti=create rb_respinti
this.rb_promossi=create rb_promossi
this.rb_assenti=create rb_assenti
this.cb_aggiorna=create cb_aggiorna
this.cb_salva=create cb_salva
this.dw_esito=create dw_esito
this.gb_vis=create gb_vis
this.Control[]={this.pb_1,&
this.rb_tutti,&
this.rb_respinti,&
this.rb_promossi,&
this.rb_assenti,&
this.cb_aggiorna,&
this.cb_salva,&
this.dw_esito,&
this.gb_vis}
end on

on tabpage_esito.destroy
destroy(this.pb_1)
destroy(this.rb_tutti)
destroy(this.rb_respinti)
destroy(this.rb_promossi)
destroy(this.rb_assenti)
destroy(this.cb_aggiorna)
destroy(this.cb_salva)
destroy(this.dw_esito)
destroy(this.gb_vis)
end on

type pb_1 from picturebutton within tabpage_esito
integer x = 3355
integer y = 928
integer width = 398
integer height = 232
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Stampa"
string picturename = "PRINTER2.BMP"
alignment htextalign = left!
end type

event clicked;openWithParm(w_dw_print_options, dw_esito)
end event

type rb_tutti from radiobutton within tabpage_esito
integer x = 3383
integer y = 576
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Tutti"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_esito.setFilter("")
dw_esito.filter()
end event

type rb_respinti from radiobutton within tabpage_esito
integer x = 3383
integer y = 488
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Solo respinti"
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_esito.setFilter("esito='R' ")
dw_esito.filter()
end event

type rb_promossi from radiobutton within tabpage_esito
integer x = 3383
integer y = 400
integer width = 498
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Solo promossi"
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_esito.setFilter("esito='P' ")
dw_esito.filter()
end event

type rb_assenti from radiobutton within tabpage_esito
integer x = 3383
integer y = 312
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Solo assenti"
borderstyle borderstyle = stylelowered!
end type

event clicked;dw_esito.setFilter("esito='A' ")
dw_esito.filter()
end event

type cb_aggiorna from commandbutton within tabpage_esito
integer x = 3214
integer y = 788
integer width = 677
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Aggiorna anagrafica e storico"
end type

event clicked;long ll_idx
string ls_codice, ls_esito
datetime ldt_data

for ll_idx= 1 to dw_esito.rowCount()
	
	ls_codice= dw_esito.getItemString(ll_idx, "codice")
	ldt_data= dw_esito.getItemDateTime(ll_idx, "data_evento")
	ls_esito= dw_esito.getItemString(ll_idx, "esito")
	
	if ls_esito = "P" then
	
		update membri_gerarchica
		set cod_studio= :is_liv
		where codice= :ls_codice;
		if trap_sql(sqlca, "UPDATESTUDIO01") < 0 then goto sqlerror
		
	end if
	
		  insert into curr_studio  
				( codice,   
				  cod_studio,   
				  data_esame,   
				  esito )  
			values ( :ls_codice,   
					   :is_liv,   
					   :ldt_data,   
					   :ls_esito ) ;
					  
			if trap_sql(sqlca, "UPDATESTUDIO02") < 0 then goto sqlerror
	
next

commit;
if trap_sql(sqlca, "UPDATESTUDIO03") < 0 then goto sqlerror
return 0

sqlerror:

rollback;
if trap_sql(sqlca, "UPDATESTUDIO04") < 0 then return -1
end event

type cb_salva from commandbutton within tabpage_esito
integer x = 3383
integer y = 28
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Salva"
boolean default = true
end type

event clicked;if dw_esito.update() < 0 then
	
	rollback;
	if trap_sql(sqlca, "COMMITESITOESAMI01") < 0 then return -1
	
	messageBox(tab_esami.tabpage_esito.text, "Salvataggio non riuscito.", exclamation!)
	
else
	
	commit;
	if trap_sql(sqlca, "COMMITESITOESAMI02") < 0 then return -1
	
end if
end event

type dw_esito from datawindow within tabpage_esito
integer width = 3191
integer height = 1040
integer taborder = 20
string title = "none"
string dataobject = "dw_esito_esami"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;f_select_current_row (dw_esito)
if lower(this.Object.DataWindow.QueryMode) = 'no'  and this.getRow() > 0 then
	w_frame_gestioneassociati.setMicroHelp(f_descrizione_struttura(this.getItemString(this.getRow(), "vc_parent") ) )
end if
end event

type gb_vis from groupbox within tabpage_esito
integer x = 3214
integer y = 216
integer width = 677
integer height = 468
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 12632256
string text = "Modalità di visualizzazione"
borderstyle borderstyle = stylelowered!
end type

