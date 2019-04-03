$PBExportHeader$w_sostituzioni.srw
forward
global type w_sostituzioni from window
end type
type hpb_conf from vprogressbar within w_sostituzioni
end type
type dw_header from datawindow within w_sostituzioni
end type
type dw_elenco from datawindow within w_sostituzioni
end type
type st_sost_tok from statictext within w_sostituzioni
end type
type cbx_oka_tok from checkbox within w_sostituzioni
end type
type st_tok from statictext within w_sostituzioni
end type
type st_oka from statictext within w_sostituzioni
end type
type st_oma from statictext within w_sostituzioni
end type
type cb_save from commandbutton within w_sostituzioni
end type
type st_modify from statictext within w_sostituzioni
end type
type st_6 from statictext within w_sostituzioni
end type
type cbx_tok_s from checkbox within w_sostituzioni
end type
type cbx_oka_s from checkbox within w_sostituzioni
end type
type cbx_oma_s from checkbox within w_sostituzioni
end type
type dw_anag from datawindow within w_sostituzioni
end type
type p_tok from picture within w_sostituzioni
end type
type p_oka from picture within w_sostituzioni
end type
type p_oma from picture within w_sostituzioni
end type
type cbx_oma_r from checkbox within w_sostituzioni
end type
type cbx_oka_r from checkbox within w_sostituzioni
end type
type cbx_tok_r from checkbox within w_sostituzioni
end type
type cbx_tok_a from checkbox within w_sostituzioni
end type
type cbx_oka_a from checkbox within w_sostituzioni
end type
type cbx_oma_a from checkbox within w_sostituzioni
end type
type st_5 from statictext within w_sostituzioni
end type
type st_4 from statictext within w_sostituzioni
end type
type st_3 from statictext within w_sostituzioni
end type
type st_1 from statictext within w_sostituzioni
end type
type st_2 from statictext within w_sostituzioni
end type
type gb_part from groupbox within w_sostituzioni
end type
type cb_nome from commandbutton within w_sostituzioni
end type
type gb_options from groupbox within w_sostituzioni
end type
type dw_inserimento from uo_dwselect within w_sostituzioni
end type
type gb_dett from groupbox within w_sostituzioni
end type
type gb_ricerca from groupbox within w_sostituzioni
end type
end forward

global type w_sostituzioni from window
integer x = 5
integer y = 4
integer width = 4800
integer height = 3216
boolean titlebar = true
string title = "Cerimonie di consegna / sostituzione"
string menuname = "m_sostituzioni"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 81324524
toolbaralignment toolbaralignment = alignatleft!
event ue_open ( )
event search_name ( )
event chiudi ( )
event clear ( string ls_from )
event ue_save ( )
event ue_aggiorna ( )
event search_cer ( )
event query_on ( )
event query_off ( )
event query_start ( )
hpb_conf hpb_conf
dw_header dw_header
dw_elenco dw_elenco
st_sost_tok st_sost_tok
cbx_oka_tok cbx_oka_tok
st_tok st_tok
st_oka st_oka
st_oma st_oma
cb_save cb_save
st_modify st_modify
st_6 st_6
cbx_tok_s cbx_tok_s
cbx_oka_s cbx_oka_s
cbx_oma_s cbx_oma_s
dw_anag dw_anag
p_tok p_tok
p_oka p_oka
p_oma p_oma
cbx_oma_r cbx_oma_r
cbx_oka_r cbx_oka_r
cbx_tok_r cbx_tok_r
cbx_tok_a cbx_tok_a
cbx_oka_a cbx_oka_a
cbx_oma_a cbx_oma_a
st_5 st_5
st_4 st_4
st_3 st_3
st_1 st_1
st_2 st_2
gb_part gb_part
cb_nome cb_nome
gb_options gb_options
dw_inserimento dw_inserimento
gb_dett gb_dett
gb_ricerca gb_ricerca
end type
global w_sostituzioni w_sostituzioni

type variables
s_consegna is_consegna_s
//s_cerimonia is_cerimonia_s
s_evento is_evento_s
long il_code
string is_mem, is_dip, is_organizzazione, is_cognome, is_nome, is_codice
boolean ib_status[3,3]
boolean ib_closing = false
string ret_type = 'normal'
boolean modify = false
boolean saving = false
boolean searching = false
boolean calling = false
uo_ds_stor ds_storico
uo_ds_gen ds_fam

end variables

forward prototypes
public function integer query_mode ()
public function integer dw_retrieve ()
public function string dw_status ()
public function integer f_pop_ext (string codice)
public subroutine f_header ()
public function boolean f_check_flags ()
public function integer f_upd_flags (string v_field, string v_flag, string v_codice)
public function integer wf_family (string ls_fam)
public function integer check_goh (string flag_er)
public function integer f_insert ()
end prototypes

event ue_open();//dw_anag.SetRedraw ( false )
//dw_anag.Reset ( )
//dw_anag.InsertRow ( 0 )
//dw_anag.SetRedraw ( true )

//dw_elenco.SetTransObject ( sqlca )
//dw_inserimento.SetTransObject ( sqlca )

setRedraw(false)

dw_inserimento.setRowFocusIndicator(focusRect!)

long ll_row
openWithParm(w_gestione_cerimonie, 7)

is_evento_s= message.powerObjectParm

if isNull(is_evento_s.id) then
	close(this)
else
	dw_elenco.SetTransObject ( sqlca )
	dw_inserimento.SetTransObject ( sqlca )
	dw_header.setTransObject(sqlca)
	
	ll_row= dw_header.retrieve(is_evento_s.id)
	setRedraw(true)
end if

return 

end event

event search_name;int rec_found

if not modify then

	searching = true
	
	gb_dett.text = " Ricerca nome "
	
	dw_elenco.SetRedraw ( false )
	
	query_mode ( )
	
	dw_elenco.SetRedraw ( true )
	
	cb_nome.text = "&Estrai"
	
	dw_elenco.enabled= true
	
	dw_elenco.SetFocus ( )
	
	return
	
else
	
	goto ok
	
end if

errore:

is_mem = ""
modify = false
return

ok:

if check_goh (dw_inserimento.getItemString(dw_inserimento.getRow(), "membri_flag_er") ) = -1 then goto errore

is_mem = ""

if f_pop_ext ( is_codice ) = -1 then
	
	goto errore
	
else
	
	cb_nome.enabled = false
	m_sostituzioni.m_opzioni.m_aggiorna.enabled = false
//	dw_elenco.enabled = false
	if f_check_flags ( ) or modify then cb_save.enabled = true
	
end if

return

end event

event chiudi;close ( this )

end event

event clear;//call super::clear;call super::clear;/* --- ROUTINE DI REINIZIALIZZAZIONE MASCHERA --- */

int field_tot, i, b1, b2
field_tot = UpperBound ( control[] )

SingleLineEdit curr_sle
DataWindow curr_dw
CheckBox curr_cbx
EditMask curr_em
Picture curr_pict

if searching then
	
	cb_nome.text = "&Nuovo nominativo"
	searching = false
	
end if

/* Individua tutti gli oggetti modificabili e li inizializza... */

for i = 1 to field_tot
	
	choose case TypeOf ( control[i] )

		case SingleLineEdit!
			
			curr_sle = control[i]
			if ls_from <> "menu" then
				if curr_sle.tag <> "Turno" and curr_sle.tag <> "Citta" &
				and curr_sle.tag <> "Data" then curr_sle.text = ""
			else
				curr_sle.text = ""
			end if
			
		case EditMask!
			
			curr_em = control[i]
			if ls_from <> "menu" then
				if curr_em.tag <> 'Data' then curr_em.text = ""
			else
				curr_em.text = ""
			end if
			
//		case DataWindow!
//			
//			curr_dw = control[i]
////			if curr_dw.tag = 'Dettaglio' then
////				curr_dw.SetRedraw ( false )
//				curr_dw.reset ( )
////				curr_dw.InsertRow ( 0 )
////				curr_dw.setRedraw ( true )
////			end if
//			
		case CheckBox!
			
			curr_cbx = control[i]
			curr_cbx.checked = false
			curr_cbx.enabled = false
			
		case Picture!
			
			curr_pict = control[i]
			curr_pict.visible = false
			
		case else

	end choose

next

st_oma.visible = false
st_oka.visible = false
st_tok.visible = false

cb_nome.enabled = true
cb_save.enabled= false

/* Reinizializza l'array che mappa lo stato delle checkbox... */

for b1 = 1 to 3
	
	for b2 = 1 to 3
		
		ib_status[b1,b2] = false
		
	next
	
next

/* Reinizializza le variabili d'istanza... */

SetNull ( is_codice )
SetNull ( is_mem )
SetNull ( is_consegna_s.codice )
SetNull ( is_consegna_s.nominativo )
SetNull ( is_consegna_s.localita )

if modify then
	
	modify = false
	st_modify.visible = false
	cb_save.text = "Inserisci"
	dw_elenco.enabled = true
//	dw_inserimento.enabled= true
	
	if not saving then
		ROLLBACK;
	else
		saving = false
	end if
	
end if

//dw_elenco.enabled = true


if ls_from = "menu" then
	
	cb_save.enabled = false
	cb_nome.enabled= false
	
	SetNull ( is_consegna_s.data_cer )
	SetNull ( is_consegna_s.luogo_cer )
	SetNull ( is_consegna_s.turno )
	
	m_sostituzioni.m_opzioni.m_aggiorna.enabled = false
	m_sostituzioni.m_opzioni.m_aggiorna.enabled = false
	
	dw_inserimento.reset()
	dw_elenco.Reset ( )
	dw_anag.reset()
	
//	dw_inserimento.enabled= false
//	dw_elenco.enabled= false
	dw_header.enabled= true
	dw_header.reset()
	dw_header.insertRow(0)
	dw_header.SetFocus ( )
	
end if

//dw_inserimento.Retrieve ( )
//
//if dw_inserimento.RowCount ( ) > 0 then m_sostituzioni.m_opzioni.m_aggiorna.enabled = true

end event

event ue_save;string ls_msg

if cbx_oma_a.checked then
	is_consegna_s.tipo_goh = 'OMAMORI'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if cbx_oma_r.checked then
	is_consegna_s.tipo_goh = 'OMAMORI'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
end if

if cbx_oma_s.checked then
	is_consegna_s.tipo_goh = 'OMAMORI'
	is_consegna_s.causale = 'RST'
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST'
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

if cbx_oka_a.checked then
	is_consegna_s.tipo_goh = 'OKATAGI'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if cbx_oka_r.checked then
	is_consegna_s.tipo_goh = 'OKATAGI'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
	
end if

if cbx_oka_s.checked then
	is_consegna_s.tipo_goh = 'OKATAGI'
	is_consegna_s.causale = 'RST' // reso per sostituzione
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST' // acquisito per sostituzione
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

// GdS
if cbx_oka_tok.checked then
	is_consegna_s.tipo_goh = 'OKATAGI'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso per sostituzione con Tokubetsu'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.tipo_goh = 'TOKUBETSU'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione Tokubetsu, reso Okatagi'
	if f_insert ( ) = -1 then goto errore
end if

// end GdS


if cbx_tok_a.checked then
	is_consegna_s.tipo_goh = 'TOKUBETSU'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if cbx_tok_r.checked then
	is_consegna_s.tipo_goh = 'TOKUBETSU'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
end if

if cbx_tok_s.checked then
	is_consegna_s.tipo_goh = 'TOKUBETSU'
//	is_consegna_s.causale = 'RSO'
	is_consegna_s.causale = 'RST'
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST'
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

Ret_Type = "normal"

if not modify then ls_msg = "Registrazione effettuata." else ls_msg = "Modifiche effettuate."

//OpenWithParm ( w_msgauto, ls_msg )
timer ( 1 )
//dw_inserimento.SetRedraw ( false )

if dw_inserimento.Retrieve (is_evento_s.id) = 0 then
//	commit;
	event clear ( "menu" )
	goto ritorna
	
end if

//dw_inserimento.SetRedraw  ( true )
m_sostituzioni.m_opzioni.m_aggiorna.enabled = true
saving = true
Event clear ( "code" )
//commit;
if trap_sql(sqlca, "COMMITSAVE01") < 0 then goto errore
ritorna: return

errore:

ROLLBACK;
Event clear ( "code" )
saving = false
//OpenWithParm ( w_msgauto, "Registrazione annullata." )
return

end event

event ue_aggiorna;long ll_row, row
datetime ldt_data
string ls_tipo, ls_causale, ls_field, ls_nome, ls_fam, ls_note, ls_codice
int li_ret

li_ret = MessageBox ( "Aggiornamento storico", "Confermi operazione?", Question!, YesNo!, 2 )

if li_ret = 2 then return

ds_storico = create uo_ds_stor

ds_storico.SetTransObject ( sqlca )
//ds_storico.Retrieve ( )
//commit;

ds_fam = create uo_ds_gen					/* datastore per la verifica degli stati di famiglia... */
ds_fam.DataObject = "ds_famiglia"
ds_fam.SetTransObject ( sqlca )		

//searching= trueraw ( false )

for row = 1 to dw_inserimento.RowCount ()
	
	ll_row= ds_storico.InsertRow ( 0 )
	
	ls_codice= dw_inserimento.GetItemString ( row, "codice" )
	
	ls_nome = trim ( dw_inserimento.GetItemString ( row, "cognome" ) ) + " " + &
				 trim ( dw_inserimento.GetItemString ( row, "nome" ) )
	is_organizzazione= dw_inserimento.getItemString(row, "vc_parent")
	ls_tipo = dw_inserimento.GetItemString ( row, "tipo_goh" )
	ldt_data = is_evento_s.data_evento
	ls_causale = dw_inserimento.GetItemString ( row, "cod_causale" )
	ls_note = dw_inserimento.GetItemString ( row, "note" )
	
	ds_storico.SetItem ( ll_row, "codice", ls_codice )
	ds_storico.SetItem ( ll_row, "tipo_goh", ls_tipo )
	ds_storico.SetItem ( ll_row, "data", ldt_data )
	ds_storico.SetItem ( ll_row, "cod_causale", ls_causale )
	ds_storico.SetItem ( ll_row, "note", ls_note )
	
	choose case ls_tipo
			
		case 'OMAMORI'
			
			if mid(ls_causale, 1, 1) = 'A' then
				if f_upd_flags ( 'flag_oma', 'S', ls_codice ) = -1 then goto errore
//				f_log ( gs_context, is_organizzazione+" - "+ls_nome+ " - "+"riceve Omamori" )
			else
				if f_upd_flags ( 'flag_oma', 'N', ls_codice ) = -1 then goto errore
//				f_log ( gs_context, is_organizzazione+" - "+ls_nome + " - "+"rende Omamori" )
			end if
			
		case 'OKATAGI'
			
			if mid(ls_causale, 1, 1) = 'A' then
				if f_upd_flags ( 'flag_goh', 'S',ls_codice ) = -1 then goto errore
//				f_log ( gs_context, is_organizzazione+" - "+ls_nome + " - "+"riceve Okatagi" )
			else
				if f_upd_flags ( 'flag_goh', 'N', ls_codice ) = -1 then goto errore
//				f_log ( gs_context, is_organizzazione+" - "+ls_nome + " - "+"rende Okatagi" )
			end if
			
		case 'TOKUBETSU'
			
			if mid(ls_causale, 1, 1) = 'A' then
				if f_upd_flags ( 'flag_tok', 'S', ls_codice ) = -1 then goto errore
//				f_log ( gs_context, is_organizzazione+" - "+ls_nome + " - "+"riceve Tokubetsu" )
			else
				if f_upd_flags ( 'flag_tok', 'N', ls_codice ) = -1 then goto errore
//				f_log ( gs_context, is_organizzazione+" - "+ls_nome + " - "+"rende Tokubetsu" )
			end if
			
	end choose
	
	hpb_conf.position= (row*100)/dw_inserimento.RowCount()
	
next

if ds_storico.Update ( ) = -1 then goto errore

	for row = 1 to dw_inserimento.RowCount ()
		
		ls_fam = dw_inserimento.GetItemString ( row, "codice_fam" )
	
		if not IsNull ( ls_fam ) then
		
			if wf_family ( ls_fam ) = -1 then goto errore
			
		end if
	
	next

  	DELETE FROM eventi  WHERE ( eventi.id= :is_evento_s.id )   ;

	if sqlca.SqlCode = -1 then
	
	//	f_log_err ( gs_context, sqlca.SqlErrText )
		
		MessageBox ( "Errore " + string ( sqlca.SqlDbCode ), "Errore in cancellazione~n~n" + &
						 sqlca.SqlErrText, exclamation! )
						 
		goto errore
	
	end if

	COMMIT;
	if trap_sql(sqlca, "COMMITSTORICO") < 0 then return
	
	event clear ( "menu" )
	
	dw_elenco.SetRedraw ( true )
	
//	OpenWithParm ( w_msgauto, "Aggiornamento effettuato" )
	
	destroy ds_storico
	
	destroy ds_fam
	
	return
	
errore:

	ROLLBACK;
	if trap_sql(sqlca, "ROLLBACKSTORICO") < 0 then return
	
	MessageBox ( this.title, "Errore in aggiornamento storico~n" + &
					 		sqlca.SqlErrText, exclamation! )
	
	dw_elenco.SetRedraw ( true )
	
//	OpenWithParm ( w_msgauto, "Aggiornamento annullato" )
	
	destroy ds_storico
	
	destroy ds_fam
	
	return

end event

event search_cer;long ll_row

//select count ( * )
//into :ll_row
//from sostituzioni;
//
//if trap_sql ( sqlca, "controllo liste" ) = -1 then
////	f_log_err ( gs_context, sqlca.SqlErrText )
//	close ( this )
//	return
//end if
//
//if ll_row = 0 then 
//	MessageBox ( this.title, "Nessuna lista impostata..." )
//	return
//end if

openWithParm(w_gestione_cerimonie, 2)

is_evento_s= message.powerObjectParm

if isNull(is_evento_s.id) then return 

dw_header.setTransObject(sqlca)

ll_row= dw_header.retrieve(is_evento_s.id)

//ll_row= dw_header.insertRow(0)
//
//dw_header.setItem(ll_row, "data_cer", is_evento_s.data_evento)
//dw_header.setItem(ll_row, "luogo_cer", is_evento_s.luogo_evento)
//dw_header.setItem(ll_row, "turno", is_evento_s.turno)
//dw_header.setItem(ll_row, "tipo_cerimonia", is_evento_s.tipo_evento)
//dw_header.setItem(ll_row, "id", is_evento_s.id)

ret_type= "normal"

cb_nome.enabled= true

dw_inserimento.SetRedraw ( false )

ll_row= dw_inserimento.Retrieve (is_evento_s.id)
//	commit;
	
	choose case ll_row
		case -1
			messageBox(this.title, "Errore in estrazione dati.", exclamation!)
			return
		case 0
			m_sostituzioni.m_opzioni.m_aggiorna.enabled = false
//			cb_nome.triggerEvent(clicked!)
		case else
			m_sostituzioni.m_opzioni.m_aggiorna.enabled = true	
			dw_inserimento.enabled= true
	end choose
	
dw_inserimento.SetRedraw ( true )

end event

event query_on;int li_colnum
string ls_colname, ls_null

dw_elenco.SetRedraw ( false )

query_mode ( )

dw_elenco.SetRedraw ( true )

dw_elenco.enabled= true

dw_elenco.SetFocus ( )

cb_nome.text = "&Estrai"

end event

event query_off;int li_colnum
string ls_colname

dw_elenco.acceptText()

if dw_retrieve ( ) = 0 then
	
	MessageBox ( "Query", "Ricerca senza esito..." )
	TriggerEvent ( "query_on" )
	
	return
	
end if

dw_elenco.setFocus ( )

cb_nome.text = "&Cerca"

end event

event query_start;if dw_status ( ) = 'no' then
	TriggerEvent ( "query_on" )
else
	TriggerEvent ( "query_off" )
end if

end event

public function integer query_mode ();dw_elenco.Object.DataWindow.QueryClear = "yes"

dw_elenco.setTransObject ( sqlca )

dw_elenco.setRedraw ( false )

dw_elenco.modify ( "dataWindow.queryMode=YES" )

dw_elenco.Object.DataWindow.Footer.Height = 1

dw_elenco.setRedraw ( true )

//w_prelude.SetMicroHelp ( "Modalita' Ricerca: impostare i criteri di estrazione..." )

return 0

end function

public function integer dw_retrieve ();/*
 * estrazione dati in base a definiti criteri...
 */

long retrieved_rows

//w_prelude.SetMicroHelp ("Estrazione dati...")

dw_elenco.setRedraw(false)

dw_elenco.modify("dataWindow.queryMode=no")

dw_elenco.setTransObject(sqlca)

retrieved_rows= dw_elenco.retrieve ( )
//commit;

if retrieved_rows = 0 then return 0

dw_elenco.setRedraw(true)

dw_elenco.TriggerEvent ( GetFocus! )

//w_prelude.SetMicroHelp ("")

return 1

end function

public function string dw_status ();string stato

stato = dw_elenco.Describe ( "DataWindow.QueryMode" )

return stato

end function

public function integer f_pop_ext (string codice);select codice,
		 rtrim ( a.cognome ) + ' ' + a.nome,
		 rtrim ( b.comune ) + ' (' + b.provincia + ')',
		 a.flag_er
		 into
		 :is_consegna_s.codice,
		 :is_consegna_s.nominativo,
		 :is_consegna_s.localita,
		 :is_consegna_s.flag_er
  from membri_gerarchica a, tab_comuni b
 where a.codice = :codice
	and a.cod_com = b.cod_com;
	
if sqlca.SqlCode = -1 then
//	f_log_err ( gs_context, sqlca.SqlErrText )
	MessageBox ( "Errore " + string ( sqlca.SqlDbCode ), sqlca.SqlerrText, exclamation! )
	return -1
end if
	 
dw_anag.insertRow(0)
dw_anag.SetItem ( 1,1,is_consegna_s.codice )
dw_anag.SetItem ( 1,2,is_consegna_s.nominativo )
dw_anag.SetItem ( 1,3,is_consegna_s.localita )
dw_anag.SetItem ( 1,4,is_consegna_s.flag_er )

return 0

end function

public subroutine f_header ();string ls_citta, ls_turno
integer li_ret

li_ret= dw_header.acceptText()
ls_citta= dw_header.getItemString(1, "citta")
ls_turno= dw_header.getItemString(1, "turno")
if isNull(ls_citta) or isNull(ls_turno) then return

long ll_rows

is_consegna_s.data_cer= datetime(dw_header.getItemDate(1, "data"))
is_consegna_s.luogo_cer= ls_citta
is_consegna_s.turno= ls_turno

	cb_nome.enabled= true

	dw_inserimento.SetRedraw ( false )
	
	ll_rows= dw_inserimento.Retrieve ( )
//	commit;
	
	choose case ll_rows
		case -1
			close ( w_sostituzioni ) // cambiamo gestione di questo errore??????????????????
			return
		case 0
			m_sostituzioni.m_opzioni.m_aggiorna.enabled = false
//			cb_nome.triggerEvent(clicked!)
		case else
			m_sostituzioni.m_opzioni.m_aggiorna.enabled = true	
			dw_inserimento.enabled= true
	end choose
	
	dw_inserimento.SetRedraw ( true )
	
//end if

return

end subroutine

public function boolean f_check_flags ();/* Verifica lo stato delle CheckBox... Se almeno una è selezionata */
/* ritorna <true> altrimenti ritorna <false>. */

boolean l_status
int field_tot, i
field_tot = UpperBound ( control[] )

CheckBox curr_cbx

for i = 1 to field_tot
	
	if TypeOf ( control[i] ) = CheckBox! then
		
		curr_cbx = control[i]
		l_status = curr_cbx.checked
		if l_status then return true
		
	end if

next

return false

end function

public function integer f_upd_flags (string v_field, string v_flag, string v_codice);string ls_stat
datetime ld_data

ld_data = datetime ( today ( ), now ( ) )

ls_stat = "update membri_gerarchica set " + v_field + "= ?, u_ult_mod = ?, d_ult_mod = ? " + &
			 "where codice = ? "

prepare sqlsa from :ls_stat ;

execute sqlsa using :v_flag, :sqlca.logId, :ld_data, :v_codice ;

if sqlca.SqlCode = -1 then
	
//	f_log ( gs_context, sqlca.SqlErrText )
	MessageBox ( "Errore " + string ( sqlca.SqlDbCode ), "Errore in aggiornamento tabella membri~n~n" + &
					 sqlca.SqlErrText, exclamation! )

	return -1

end if

return 0

end function

public function integer wf_family (string ls_fam);long ll_rows, n, ll_found, ll_ret
string ls_oka, ls_oma, ls_tok, ls_oka_f, ls_oma_f, ls_tok_f, ls_cognome, ls_nome, ls_codice

ll_rows = ds_fam.Retrieve ( ls_fam )

ll_found = ds_fam.find ( "flag_goh = 'S'", 1, ll_rows )
if ll_found > 0 then ls_oka = "S" else ls_oka = "N"

ll_found = ds_fam.find ( "flag_oma = 'S'", 1, ll_rows )
if ll_found > 0 then ls_oma = "S" else ls_oma = "N"

ll_found = ds_fam.find ( "flag_tok = 'S'", 1, ll_rows )
if ll_found > 0 then ls_tok = "S" else ls_tok = "N"

for n = 1 to ll_rows
	
	ls_codice = ds_fam.GetItemString ( n, "codice" )
	
	if (ds_fam.GetItemString ( n, "flag_goh" ) = "N" OR &
		ds_fam.GetItemString ( n, "flag_goh" ) = "F") and ls_oka = 'S' then
		ls_oka_f = "F"
	elseif ds_fam.GetItemString ( n, "flag_goh" ) = "S" and ls_oka = 'S' then
		ls_oka_f = "S"
	else
		ls_oka_f = "N"
	end if
	
	if (ds_fam.GetItemString ( n, "flag_oma" ) = "N" OR &
		ds_fam.GetItemString ( n, "flag_oma" ) = "F") and ls_oma = 'S' then
		ls_oma_f = "F"
	elseif ds_fam.GetItemString ( n, "flag_oma" ) = "S" and ls_oma = 'S' then
		ls_oma_f = "S"
	else
		ls_oma_f = "N"
	end if
	
	if (ds_fam.GetItemString ( n, "flag_tok" ) = "N" OR &
		ds_fam.GetItemString ( n, "flag_tok" ) = "F") and ls_tok = 'S' then
		ls_tok_f = "F"
	elseif ds_fam.GetItemString ( n, "flag_tok" ) = "S" and ls_tok = 'S' then
		ls_tok_f = "S"
	else
		ls_tok_f = "N"
	end if
	
   UPDATE membri_gerarchica
      SET codice_fam = :ls_fam,   
			 flag_goh = :ls_oka_f,
			 flag_oma = :ls_oma_f,
			 flag_tok = :ls_tok_f
    WHERE ( codice = :ls_codice )   ;
			 
	if trap_sql ( sqlca, "aggiornamento Gohonzon famiglia" ) = -1 then
//		f_log_err ( gs_context, sqlca.SqlErrText )
		return -1
	end if
	
next
/*
if ds_fam.Update ( ) = -1 then
	ds_fam.Reset ( )
	rollback;
	return  -1
end if
*/

ds_fam.Reset ( )

return 0

end function

public function integer check_goh (string flag_er);string ls_oma, ls_oka, ls_tok

SELECT	flag_oma,   
		 	flag_goh,   
		 	flag_tok  
  INTO 	:ls_oma,   
		 	:ls_oka,   
		 	:ls_tok  
  FROM 	membri_gerarchica
 WHERE ( codice = :is_codice )  ;

if sqlca.SqlCode = -1 then
//	f_log_err ( gs_context, sqlca.SqlErrText )
	MessageBox ( "Errore database " + string ( sqlca.SqlDbCode ), sqlca.SqlErrText, exclamation! )
	return -1
end if

cbx_oma_a.enabled = false
cbx_oma_s.enabled = false
cbx_oma_r.enabled = false

choose case ls_oma
		
	case 'S'

		p_oma.visible = true
		st_oma.visible = false
		if flag_er= 'S' then
			cbx_oma_a.enabled = false
			cbx_oma_s.enabled = true
		end if
		cbx_oma_r.enabled = true

		
	case 'F'
		
		p_oma.visible = true
		st_oma.visible = true
		if flag_er= 'S' then
			cbx_oma_a.enabled = true
			cbx_oma_s.enabled = false
		end if
		cbx_oma_r.enabled = false
		
	case else
		
		p_oma.visible = false
		st_oma.visible = false
		if flag_er= 'S' then
			cbx_oma_a.enabled = true
			cbx_oma_s.enabled = false
		end if
		cbx_oma_r.enabled = false

		
end choose

cbx_oka_a.enabled = false
cbx_oka_s.enabled = false
cbx_oka_r.enabled = false
cbx_oka_tok.enabled= false

choose case ls_oka
		
	case 'S'
		
		p_oka.visible = true
		st_oka.visible = false
		if flag_er= 'S' then
			cbx_oka_a.enabled = false
			cbx_oka_s.enabled = true
			cbx_oka_tok.enabled = true
		end if
		cbx_oka_r.enabled = true

		
	case 'F'
		
		p_oka.visible = true
		st_oka.visible = true
		if flag_er= 'S' then
			cbx_oka_a.enabled = false
			cbx_oka_s.enabled = false
			cbx_oka_tok.enabled = false
		end if
		cbx_oka_r.enabled = false
		
	case else
		
		p_oka.visible = false
		st_oka.visible = false
		if flag_er= 'S' then
			cbx_oka_a.enabled = true
			cbx_oka_s.enabled = false
			cbx_oka_tok.enabled = false
		end if
		cbx_oka_r.enabled = false
		if ls_tok <> 'N'  then
			cbx_oka_a.enabled = false
			cbx_oka_s.enabled = false
			cbx_oka_tok.enabled = false
			cbx_oka_r.enabled = false
		end if
		
end choose

cbx_tok_a.enabled = false
cbx_tok_r.enabled = false
cbx_tok_s.enabled = false

choose case ls_tok
		
	case 'S'
		
		p_tok.visible = true
		st_tok.visible = false
		if flag_er= 'S' then
			cbx_tok_a.enabled = false
			cbx_tok_s.enabled = true
		end if
		cbx_tok_r.enabled = true
	/*	
		if ls_oka = 'N' then
			cbx_tok_a.enabled = false
			cbx_tok_r.enabled = false
			cbx_tok_s.enabled = false
		end if
	*/
		
	case 'F'
		
		p_tok.visible = true
		st_tok.visible = true
		if flag_er= 'S' then
			cbx_tok_a.enabled = false
			cbx_tok_s.enabled = false
		end if
		cbx_tok_r.enabled = false
		if ls_oka = 'N' then
			cbx_tok_a.enabled = false
			cbx_tok_r.enabled = false
			cbx_tok_s.enabled = false
		end if

	case else
		
		p_tok.visible = false
		st_tok.visible = false
		if flag_er= 'S' then
			cbx_tok_a.enabled = true
			cbx_tok_s.enabled = false
		end if
		cbx_tok_r.enabled = false
		if ls_oka <> 'N' /*= 'F'*/ then
			cbx_tok_a.enabled = false
			cbx_tok_r.enabled = false
			cbx_tok_s.enabled = false
		end if
		
end choose

ib_status[1,1] = cbx_oma_a.enabled
ib_status[1,2] = cbx_oma_r.enabled
ib_status[1,3] = cbx_oma_s.enabled
ib_status[2,1] = cbx_oka_a.enabled
ib_status[2,2] = cbx_oka_r.enabled
ib_status[2,3] = cbx_oka_s.enabled
ib_status[3,1] = cbx_tok_a.enabled
ib_status[3,2] = cbx_tok_r.enabled
ib_status[3,3] = cbx_tok_s.enabled

return 0

end function

public function integer f_insert ();integer li_ret
string ls_part = "S", ls_note=""

select count(*)
into :li_ret
from sostituzioni
where id != :is_evento_s.id and codice= :is_codice;
if trap_sql(sqlca, "INSERTSOST") < 0 then return -1

if li_ret > 0 then
	messageBox(this.title, "Nome già presente in un'altra lista Sostituzioni/Consegne.~nVerificare le cerimonie già esistenti." , exclamation!)
	return -1
end if

PREPARE SQLSA 
	FROM "INSERT INTO sostituzioni VALUES (?,?,?,?,?,?)" ;
EXECUTE SQLSA USING :is_codice, :is_evento_s.id, :is_consegna_s.causale, :is_consegna_s.tipo_goh, :ls_part, :ls_note;

if sqlca.SqlCode = -1 then
	
//	if sqlca.SqlDbCode = 2601/* il codice è diverso per MS SQL */  then
	
//	f_log_err ( gs_context, sqlca.SqlErrText )
	MessageBox ( "Errore " + string ( sqlca.SqlDbCode ), sqlca.SqlErrText,  exclamation! )
	return -1
//else
	
//f_log("Sostituzioni", is_cognome+" "+is_nome+" - "+is_organizzazione+" - "+str_cons.v_descr_causale+ " "+str_cons.v_tipo_goh)
	
end if

return 0

end function

on w_sostituzioni.create
if this.MenuName = "m_sostituzioni" then this.MenuID = create m_sostituzioni
this.hpb_conf=create hpb_conf
this.dw_header=create dw_header
this.dw_elenco=create dw_elenco
this.st_sost_tok=create st_sost_tok
this.cbx_oka_tok=create cbx_oka_tok
this.st_tok=create st_tok
this.st_oka=create st_oka
this.st_oma=create st_oma
this.cb_save=create cb_save
this.st_modify=create st_modify
this.st_6=create st_6
this.cbx_tok_s=create cbx_tok_s
this.cbx_oka_s=create cbx_oka_s
this.cbx_oma_s=create cbx_oma_s
this.dw_anag=create dw_anag
this.p_tok=create p_tok
this.p_oka=create p_oka
this.p_oma=create p_oma
this.cbx_oma_r=create cbx_oma_r
this.cbx_oka_r=create cbx_oka_r
this.cbx_tok_r=create cbx_tok_r
this.cbx_tok_a=create cbx_tok_a
this.cbx_oka_a=create cbx_oka_a
this.cbx_oma_a=create cbx_oma_a
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.st_2=create st_2
this.gb_part=create gb_part
this.cb_nome=create cb_nome
this.gb_options=create gb_options
this.dw_inserimento=create dw_inserimento
this.gb_dett=create gb_dett
this.gb_ricerca=create gb_ricerca
this.Control[]={this.hpb_conf,&
this.dw_header,&
this.dw_elenco,&
this.st_sost_tok,&
this.cbx_oka_tok,&
this.st_tok,&
this.st_oka,&
this.st_oma,&
this.cb_save,&
this.st_modify,&
this.st_6,&
this.cbx_tok_s,&
this.cbx_oka_s,&
this.cbx_oma_s,&
this.dw_anag,&
this.p_tok,&
this.p_oka,&
this.p_oma,&
this.cbx_oma_r,&
this.cbx_oka_r,&
this.cbx_tok_r,&
this.cbx_tok_a,&
this.cbx_oka_a,&
this.cbx_oma_a,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_1,&
this.st_2,&
this.gb_part,&
this.cb_nome,&
this.gb_options,&
this.dw_inserimento,&
this.gb_dett,&
this.gb_ricerca}
end on

on w_sostituzioni.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.hpb_conf)
destroy(this.dw_header)
destroy(this.dw_elenco)
destroy(this.st_sost_tok)
destroy(this.cbx_oka_tok)
destroy(this.st_tok)
destroy(this.st_oka)
destroy(this.st_oma)
destroy(this.cb_save)
destroy(this.st_modify)
destroy(this.st_6)
destroy(this.cbx_tok_s)
destroy(this.cbx_oka_s)
destroy(this.cbx_oma_s)
destroy(this.dw_anag)
destroy(this.p_tok)
destroy(this.p_oka)
destroy(this.p_oma)
destroy(this.cbx_oma_r)
destroy(this.cbx_oka_r)
destroy(this.cbx_tok_r)
destroy(this.cbx_tok_a)
destroy(this.cbx_oka_a)
destroy(this.cbx_oma_a)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_part)
destroy(this.cb_nome)
destroy(this.gb_options)
destroy(this.dw_inserimento)
destroy(this.gb_dett)
destroy(this.gb_ricerca)
end on

event open;gs_context = "Cerimonie consegna/sostituzione"
PostEvent ( "ue_open" )

end event

event closequery;ib_closing = true

end event

event timer;//timer ( 0 )
//close ( w_msgauto )

end event

event resize;gb_dett.height= this.height - gb_dett.y -180

dw_inserimento.height= gb_dett.height - 120
end event

type hpb_conf from vprogressbar within w_sostituzioni
boolean visible = false
integer x = 4119
integer y = 928
integer width = 78
integer height = 560
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type dw_header from datawindow within w_sostituzioni
integer x = 41
integer y = 8
integer width = 4178
integer height = 320
integer taborder = 10
string title = "Header"
string dataobject = "dw_header_eventi"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//if dwo.name= "data" then
//	if date(mid( data, 1, 10)) < today() then
//		messageBox(parent.title, "Data anteriore alla data odierna.", information!)
////		return 1
//	elseif date(mid( data, 1, 10)) >  today() then
//		messageBox(parent.title, "Data posteriore alla data odierna.", information!)
////		return 1
//	end if
//end if
//
//f_header()
//
//return 0
end event

event dberror;return 1
end event

event itemfocuschanged;//if dwo.name= "data" then selectText(1, 10)
end event

type dw_elenco from datawindow within w_sostituzioni
string tag = "Dettaglio"
integer x = 69
integer y = 384
integer width = 3090
integer height = 516
integer taborder = 30
string title = "none"
string dataobject = "dw_part"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;f_sql_use_like(sqlType, sqlsyntax, dw_elenco, false)
	
SetSqlPreview ( sqlsyntax )

end event

event doubleclicked;if dw_status ( ) = "no" then
	is_codice = dw_elenco.GetItemString ( row, "codice" )
	is_organizzazione= dw_elenco.getItemString(row, "vc_parent")
	is_cognome= dw_elenco.getItemString(row, "cognome")
	is_nome= dw_elenco.getItemString(row, "nome")
	
	if check_goh (dw_elenco.getItemString(row, "flag_er") ) = -1 then goto errore
		
		if f_pop_ext ( is_codice ) = -1 then
			
			goto errore
			
		else
			
			cb_nome.enabled = false
			m_sostituzioni.m_opzioni.m_aggiorna.enabled = false
			cb_nome.text = "&Nuovo nominativo"
			searching = false
			
			gb_dett.text = " Dettaglio "
			
//			dw_elenco.SetRedraw ( false )
//			dw_elenco.DataObject = "d_part"
//			dw_elenco.SetTransObject ( sqlca )
//			dw_elenco.Retrieve ( )
//			dw_elenco.SetRedraw ( true )
			
			if f_check_flags ( ) or modify then cb_save.enabled = true
			
			return
			
		end if
		
		errore:
		
		parent.event clear ( "cb" )
		return
			
end if
	
end event

event retrieveend;commit;
end event

type st_sost_tok from statictext within w_sostituzioni
integer x = 2011
integer y = 1388
integer width = 681
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Sostituzione con TOKUBETSU"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_oka_tok from checkbox within w_sostituzioni
integer x = 2779
integer y = 1380
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cbx_oka_r.enabled = false
	cbx_oka_s.enabled = false
	cbx_tok_a.enabled = false
	cbx_tok_r.enabled = false
	cbx_tok_s.enabled = false

	cbx_tok_a.checked = false
	cbx_tok_r.checked = false
	cbx_tok_s.checked = false
	
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
	cbx_oka_r.enabled = ib_status[2,2]
	cbx_oka_s.enabled = ib_status[2,2]
	cbx_tok_a.enabled = ib_status[3,1]
	cbx_tok_r.enabled = ib_status[3,2]
	cbx_tok_s.enabled = ib_status[3,3]
	
end if

end event

type st_tok from statictext within w_sostituzioni
boolean visible = false
integer x = 3365
integer y = 960
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 81324524
boolean enabled = false
string text = "(famiglia)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_oka from statictext within w_sostituzioni
boolean visible = false
integer x = 2546
integer y = 964
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 81324524
boolean enabled = false
string text = "(famiglia)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_oma from statictext within w_sostituzioni
boolean visible = false
integer x = 2949
integer y = 960
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 81324524
boolean enabled = false
string text = "(famiglia)"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_sostituzioni
integer x = 3378
integer y = 652
integer width = 439
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Inserisci"
end type

event clicked;if this.text <> "Inserisci" then
	delete from sostituzioni
	where codice = :is_codice
	  and id = :is_evento_s.id;
	  
	if trap_sql(sqlca, "Registrazione annullata.") < 0 then 
		rollback;
		return
	end if
else
	dw_elenco.reset() // clear della dw di ricerca nominativi...
end if

parent.TriggerEvent ( "ue_save" )

dw_inserimento.enabled= true
dw_anag.reset()

searching= true
//cb_nome.Event clicked()
//dw_elenco.enabled= true
//dw_elenco.setFocus()


end event

type st_modify from statictext within w_sostituzioni
boolean visible = false
integer x = 3378
integer y = 772
integer width = 439
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "MODIFICA"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_sostituzioni
integer x = 2414
integer y = 1296
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Sostituzione"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_tok_s from checkbox within w_sostituzioni
integer x = 3182
integer y = 1280
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then

	cbx_tok_r.enabled = false
	cbx_oka_a.enabled = false
	cbx_oka_r.enabled = false
	cbx_oka_s.enabled = false
	
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if

	cbx_tok_r.enabled = ib_status[3,2]
	cbx_oka_a.enabled = ib_status[2,1]
	cbx_oka_r.enabled = ib_status[2,2]
	cbx_oka_s.enabled = ib_status[2,3]
	
end if

end event

type cbx_oka_s from checkbox within w_sostituzioni
integer x = 2779
integer y = 1288
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cbx_oka_r.enabled = false
	cbx_tok_a.enabled = false
	cbx_tok_r.enabled = false
	cbx_tok_s.enabled = false
	cbx_tok_a.checked = false
	cbx_tok_r.checked = false
	cbx_tok_s.checked = false
	
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
	cbx_oka_r.enabled = ib_status[2,2]
	cbx_tok_a.enabled = ib_status[3,1]
	cbx_tok_r.enabled = ib_status[3,2]
	cbx_tok_s.enabled = ib_status[3,3]
	
end if

end event

type cbx_oma_s from checkbox within w_sostituzioni
integer x = 3593
integer y = 1284
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cbx_oma_r.enabled = false
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"
	
else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
	cbx_oma_r.enabled = ib_status[1,2]
	
end if

end event

type dw_anag from datawindow within w_sostituzioni
string tag = "Dettaglio"
integer x = 73
integer y = 980
integer width = 1824
integer height = 448
boolean enabled = false
string dataobject = "d_ext_nom"
boolean border = false
boolean livescroll = true
end type

type p_tok from picture within w_sostituzioni
boolean visible = false
integer x = 3195
integer y = 968
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_red.bmp"
boolean focusrectangle = false
end type

type p_oka from picture within w_sostituzioni
boolean visible = false
integer x = 2789
integer y = 968
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_red.bmp"
boolean focusrectangle = false
end type

type p_oma from picture within w_sostituzioni
boolean visible = false
integer x = 3607
integer y = 968
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "d_red.bmp"
boolean focusrectangle = false
end type

type cbx_oma_r from checkbox within w_sostituzioni
integer x = 3593
integer y = 1192
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cbx_oma_s.enabled = false
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
	cbx_oma_s.enabled = ib_status[1,3]
	
end if

end event

type cbx_oka_r from checkbox within w_sostituzioni
integer x = 2779
integer y = 1196
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cbx_oka_s.enabled = false
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
	cbx_oka_s.enabled = ib_status[2,3]
	
end if

end event

type cbx_tok_r from checkbox within w_sostituzioni
integer x = 3182
integer y = 1188
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cbx_tok_s.enabled = false
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
	cbx_tok_s.enabled = ib_status[3,3]
	
end if

end event

type cbx_tok_a from checkbox within w_sostituzioni
integer x = 3182
integer y = 1096
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cbx_oka_a.enabled = false
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
	cbx_oka_a.enabled = ib_status[2,1]
	
end if

end event

type cbx_oka_a from checkbox within w_sostituzioni
integer x = 2779
integer y = 1104
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cbx_tok_a.enabled = false
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
	cbx_tok_a.enabled = ib_status[3,1]
	
end if

end event

type cbx_oma_a from checkbox within w_sostituzioni
integer x = 3593
integer y = 1100
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
end type

event clicked;if this.checked then
	
	cb_save.enabled = true
	if modify then cb_save.text = "Modifica" else cb_save.text = "Inserisci"

else
	
	if not modify then
		
		if not f_check_flags ( ) then cb_save.enabled = false
		
	else
		
		cb_save.enabled = true
		
		if not f_check_flags ( ) then	cb_save.text = "Cancella" else cb_save.text = "Modifica"
			
	end if
	
end if

end event

type st_5 from statictext within w_sostituzioni
integer x = 2414
integer y = 1204
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Reso"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_sostituzioni
integer x = 2414
integer y = 1112
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Acquisizione"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_sostituzioni
integer x = 3090
integer y = 1028
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Tokubetsu"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_sostituzioni
integer x = 3511
integer y = 1028
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Omamori"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_sostituzioni
integer x = 2693
integer y = 1028
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Okatagi"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_part from groupbox within w_sostituzioni
integer x = 46
integer y = 916
integer width = 1893
integer height = 560
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 81324524
string text = "Dati personali"
borderstyle borderstyle = stylelowered!
end type

type cb_nome from commandbutton within w_sostituzioni
event clicked pbm_bnclicked
integer x = 3378
integer y = 524
integer width = 439
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Nuovo nominativo"
boolean default = true
end type

event clicked;dw_header.acceptText()
dw_header.enabled= false
dw_elenco.enabled= true

if searching then
	
//	dw_elenco.enabled= true
	parent.TriggerEvent ( "query_start" )
else
	parent.TriggerEvent ( "search_name" )
end if

//if /*len ( trim ( em_data.text ) ) = 0 or*/ len ( trim ( sle_loc.text ) ) = 0 or &
//	len ( trim ( sle_turno.text ) ) = 0 then
	
//	MessageBox ( "Cerimonia", "Immettere tutti i dati...", Exclamation! )
//	em_data.SetFocus ( )
//	return
	
//end if

return



end event

type gb_options from groupbox within w_sostituzioni
integer x = 1947
integer y = 916
integer width = 2162
integer height = 560
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 81324524
borderstyle borderstyle = stylelowered!
end type

type dw_inserimento from uo_dwselect within w_sostituzioni
integer x = 69
integer y = 1540
integer width = 3662
integer height = 732
integer taborder = 0
string dataobject = "dw_consegne"
end type

event sqlpreview;call super::sqlpreview;string ls_stat

if searching then
	
	f_sql_use_like(sqlType, sqlsyntax, dw_elenco, false)
	
	SetSqlPreview ( sqlsyntax )
	
else

//	if ret_type = "normal" then
//		
//		if SqlType = PreviewSelect! then
//
//			ls_stat = SqlSyntax + " and sostituzioni.data = '" + string (is_cerimonia_s.data_cer, "dd/mm/yyyy" ) + "'" + &
//							 " and sostituzioni.citta = '" + is_cerimonia_s.luogo_cer + "'" + &
//							 " and sostituzioni.turno = '" + is_cerimonia_s.turno + "'"
//							 
//			SetSqlPreview ( ls_stat )
//			
//		end if
		
	end if

//end if

end event

event getfocus;if not searching then
	
	SelectRow(0, false)
	SelectRow(1, true)
	
	il_rows = RowCount()
	
end if

end event

event dberror;call super::dberror;//f_log_err ( gs_context, SqlErrText )
MessageBox ( "Errore " + string ( SqlDbCode ), SqlErrText, exclamation! )

return 1

end event

event itemchanged;call super::itemchanged;choose case dwo.name

	case "cognome"
		
		is_cognome = f_replace_chars(this.getText(), "'", "''")

	case "cod_causale"
		
		is_codice= this.getItemString(row, "codice")
		
			update sostituzioni
				set cod_causale= :data
			where codice_membro = :is_codice
	  					and data = :is_consegna_s.data_cer
	  					and citta = :is_consegna_s.luogo_cer
	  					and turno = :is_consegna_s.turno;
	  
			if trap_sql(sqlca, "Registrazione annullata.") < 0 then 
				rollback;
			end if
			
end choose

return 0
end event

event retrieveend;call super::retrieveend;commit;
end event

event select_item;//int field_tot, i, b1, b2
//field_tot = UpperBound ( control[] )
//CheckBox curr_cbx
//
////if not searching then
//
//	if row < 1 then return
//		
//	for i = 1 to field_tot
//		
//		if TypeOf ( control[i] ) = CheckBox! then
//				
//			curr_cbx = control[i]
//			
//			if curr_cbx.tag <> 'Lock' then
//				curr_cbx.checked = false
//				curr_cbx.enabled = false
//			end if
//			
//		end if
//	
//	next
//	
//	il_code = this.GetItemNumber ( row, "sostituzioni_codice_membro" )
//	is_dip = this.GetItemString ( row, "sostituzioni_cod_dip" )
////	is_organizzazione= dw_elenco.getItemString(row, "membri_cod_area")+&
////								 dw_elenco.getItemString(row, "membri_cod_terr")+&
////								  dw_elenco.getItemString(row, "membri_cod_cen")+&
////								   dw_elenco.getItemString(row, "membri_cod_cap")+&
////									 dw_elenco.getItemString(row, "membri_cod_sett")+&
////									  dw_elenco.getItemString(row, "membri_cod_gru")
////	is_cognome= dw_elenco.getItemString(row, "membri_cognome")
////	is_nome= dw_elenco.getItemString(row, "membri_nome")
//	str_cons.v_data = dw_inserimento.GetItemDateTime ( row, "sostituzioni_data" )
//	str_cons.v_citta = dw_inserimento.GetItemString ( row, "sostituzioni_citta" )
//	str_cons.v_turno = dw_inserimento.GetItemString ( row, "sostituzioni_turno" )
//	
////	delete from sostituzioni
////	where codice_membro = :il_code
////	  and cod_dip = :is_dip
////	  and data = :str_cons.v_data
////	  and citta = :str_cons.v_citta
////	  and turno = :str_cons.v_turno;
////	  
////	if trap_sql(sqlca, "Registrazione annullata.") < 0 then 
////		rollback;
////		return
////	else
////		commit;
////	end if
//	
//	this.enabled = false
//	modify = true
//	st_modify.visible = true
//	cb_save.text = "Cancella"
//	
//	parent.TriggerEvent ( "search_name" )
//	
//	this.SetRedraw ( false )
//	this.retrieve ( )
//	this.SetRedraw ( true )
//	
//
//	
////end if
//
end event

event buttonclicked;call super::buttonclicked;string ls_note, ls_note_old

choose case dwo.name
		
	case 'b_note'
	
	ls_note=  this.getItemString(row, "note")
	
	openWithParm(w_note, ls_note)
	
	ls_note_old= ls_note
	
	ls_note= message.stringParm
	
	if ls_note <> ls_note_old or isNull(ls_note_old) then
		this.setItem(row, "note", ls_note)
	
		is_codice= this.getItemString(row, "codice")
		
			update sostituzioni
				set note= :ls_note
			where codice = :is_codice
	  					and data = :is_consegna_s.data_cer
	  					and citta = :is_consegna_s.luogo_cer
	  					and turno = :is_consegna_s.turno;
	  
			if trap_sql(sqlca, "Registrazione annullata.") < 0 then 
				rollback;
				return
			end if
	end if
	
case "b_cancella"
	
	string ls_codice
	
	if this.getRow() <= 0 then return -1
	
	if messageBox(parent.title, "Confermi la cancellazione di: "+ this.getItemString(this.getRow(), "cognome")+" "+ &
											this.getItemString(this.getRow(), "nome")+"?", question!, yesNo!, 2)= 2 then return 0
	
	ls_codice= this.getItemString(this.getRow(), "codice")
	
	delete from sostituzioni
	where codice = :ls_codice
	and id = :is_evento_s.id;
	  
	if trap_sql(sqlca, "CANCELLASOST01") < 0 then 
		rollback;
		trap_sql(sqlca, "CANCELLASOST02")
		return -1
	else
		commit;
		if trap_sql(sqlca, "CANCELLASOST03") < 0 then return -1
	end if
	
	this.retrieve(is_evento_s.id)
	
//	
//	this.enabled = false
//	modify = true
//	st_modify.visible = true
//	cb_save.text = "Cancella"
//	
//	parent.TriggerEvent ( "search_name" )
//	
//	this.SetRedraw ( false )
//	this.retrieve ( )
//	this.SetRedraw ( true )
	
end choose
	
end event

type gb_dett from groupbox within w_sostituzioni
integer x = 46
integer y = 1480
integer width = 4151
integer height = 808
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 81324524
string text = "Nominativi in lista"
borderstyle borderstyle = stylelowered!
end type

type gb_ricerca from groupbox within w_sostituzioni
integer x = 46
integer y = 332
integer width = 4151
integer height = 584
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33489024
long backcolor = 81324524
string text = "Ricerca nominativi"
borderstyle borderstyle = stylelowered!
end type

