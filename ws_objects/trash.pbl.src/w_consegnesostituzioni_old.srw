$PBExportHeader$w_consegnesostituzioni_old.srw
forward
global type w_consegnesostituzioni_old from window
end type
type tab_consegne from tab within w_consegnesostituzioni_old
end type
type tabpage_inserimento from userobject within tab_consegne
end type
type cb_storico from commandbutton within tabpage_inserimento
end type
type cb_rimuovi from commandbutton within tabpage_inserimento
end type
type st_oma from statictext within tabpage_inserimento
end type
type st_tok from statictext within tabpage_inserimento
end type
type st_oka from statictext within tabpage_inserimento
end type
type st_7 from statictext within tabpage_inserimento
end type
type pb_nome from picturebutton within tabpage_inserimento
end type
type st_2 from statictext within tabpage_inserimento
end type
type st_1 from statictext within tabpage_inserimento
end type
type st_3 from statictext within tabpage_inserimento
end type
type st_4 from statictext within tabpage_inserimento
end type
type st_5 from statictext within tabpage_inserimento
end type
type cbx_oma_a from checkbox within tabpage_inserimento
end type
type cbx_oka_a from checkbox within tabpage_inserimento
end type
type cbx_tok_a from checkbox within tabpage_inserimento
end type
type cbx_tok_r from checkbox within tabpage_inserimento
end type
type cbx_oka_r from checkbox within tabpage_inserimento
end type
type cbx_oma_r from checkbox within tabpage_inserimento
end type
type cbx_oma_s from checkbox within tabpage_inserimento
end type
type cbx_oka_s from checkbox within tabpage_inserimento
end type
type cbx_tok_s from checkbox within tabpage_inserimento
end type
type st_6 from statictext within tabpage_inserimento
end type
type cb_save from commandbutton within tabpage_inserimento
end type
type cbx_oka_tok from checkbox within tabpage_inserimento
end type
type st_sost_tok from statictext within tabpage_inserimento
end type
type dw_anag from datawindow within tabpage_inserimento
end type
type gb_ricerca from groupbox within tabpage_inserimento
end type
type gb_1 from groupbox within tabpage_inserimento
end type
type p_oka from picture within tabpage_inserimento
end type
type p_tok from picture within tabpage_inserimento
end type
type p_oma from picture within tabpage_inserimento
end type
type uodw_inserimento from uodw_generica within tabpage_inserimento
end type
type gb_dett from groupbox within tabpage_inserimento
end type
type gb_lista from groupbox within tabpage_inserimento
end type
type tabpage_inserimento from userobject within tab_consegne
cb_storico cb_storico
cb_rimuovi cb_rimuovi
st_oma st_oma
st_tok st_tok
st_oka st_oka
st_7 st_7
pb_nome pb_nome
st_2 st_2
st_1 st_1
st_3 st_3
st_4 st_4
st_5 st_5
cbx_oma_a cbx_oma_a
cbx_oka_a cbx_oka_a
cbx_tok_a cbx_tok_a
cbx_tok_r cbx_tok_r
cbx_oka_r cbx_oka_r
cbx_oma_r cbx_oma_r
cbx_oma_s cbx_oma_s
cbx_oka_s cbx_oka_s
cbx_tok_s cbx_tok_s
st_6 st_6
cb_save cb_save
cbx_oka_tok cbx_oka_tok
st_sost_tok st_sost_tok
dw_anag dw_anag
gb_ricerca gb_ricerca
gb_1 gb_1
p_oka p_oka
p_tok p_tok
p_oma p_oma
uodw_inserimento uodw_inserimento
gb_dett gb_dett
gb_lista gb_lista
end type
type tabpage_stampe from userobject within tab_consegne
end type
type uodw_stampa_sostituzioni from uodw_generica within tabpage_stampe
end type
type tabpage_stampe from userobject within tab_consegne
uodw_stampa_sostituzioni uodw_stampa_sostituzioni
end type
type tab_consegne from tab within w_consegnesostituzioni_old
tabpage_inserimento tabpage_inserimento
tabpage_stampe tabpage_stampe
end type
type hpb_conf from vprogressbar within w_consegnesostituzioni_old
end type
type dw_header from datawindow within w_consegnesostituzioni_old
end type
type st_modify from statictext within w_consegnesostituzioni_old
end type
end forward

global type w_consegnesostituzioni_old from window
integer x = 5
integer y = 4
integer width = 4558
integer height = 3216
boolean titlebar = true
string title = "Cerimonie di consegna / sostituzione"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Library5!"
toolbaralignment toolbaralignment = alignatleft!
event ue_open ( )
event chiudi ( )
event clear ( )
event ue_save ( )
event ue_aggiorna ( )
event search_cer ( )
event query_on ( )
event query_off ( )
event query_start ( )
tab_consegne tab_consegne
hpb_conf hpb_conf
dw_header dw_header
st_modify st_modify
end type
global w_consegnesostituzioni_old w_consegnesostituzioni_old

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
m_preview im_preview

end variables

forward prototypes
public function integer f_upd_flags (string v_field, string v_flag, string v_codice)
public function integer wf_family (string ls_fam)
public subroutine f_header ()
public function integer f_pop_ext (string codice)
public function boolean f_check_flags ()
public function integer dw_retrieve ()
public function string dw_status ()
public function integer query_mode ()
public function integer check_goh (string flag_er)
public function integer f_insert ()
end prototypes

event ue_open();setRedraw(false)

//tab_consegne.tabpage_inserimento.dw_inserimento.setRowFocusIndicator(focusRect!)

long ll_row

openWithParm(w_gestione_cerimonie, 7)

is_evento_s= message.powerObjectParm

if isNull(is_evento_s.id) then
	setRedraw(true)
	close(this)
else
//	tab_consegne.tabpage_inserimento.dw_elenco.SetTransObject ( sqlca )
	tab_consegne.tabpage_inserimento.uodw_inserimento.SetTransObject ( sqlca )
	tab_consegne.tabpage_inserimento.dw_anag.setTransObject(sqlca)
	dw_header.setTransObject(sqlca)
	tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.SetTransObject ( sqlca )

	ll_row= dw_header.retrieve(is_evento_s.id)
	
	if ll_row > 0 then tab_consegne.tabpage_inserimento.pb_nome.enabled= true
	
	tab_consegne.tabpage_inserimento.uodw_inserimento.retrieve(is_evento_s.id)
	
	setRedraw(true)
end if

return 

end event

event chiudi;close ( this )

end event

event clear();tab_consegne.tabpage_inserimento.st_oma.visible = false
tab_consegne.tabpage_inserimento.st_oka.visible = false
tab_consegne.tabpage_inserimento.st_tok.visible = false

tab_consegne.tabpage_inserimento.pb_nome.enabled = true
tab_consegne.tabpage_inserimento.cb_save.enabled= false

tab_consegne.tabpage_inserimento.cbx_oma_a.checked = false
tab_consegne.tabpage_inserimento.cbx_oma_s.checked = false
tab_consegne.tabpage_inserimento.cbx_oma_r.checked = false

tab_consegne.tabpage_inserimento.cbx_oka_a.checked = false
tab_consegne.tabpage_inserimento.cbx_oka_s.checked = false
tab_consegne.tabpage_inserimento.cbx_oka_r.checked = false

tab_consegne.tabpage_inserimento.cbx_oka_tok.checked= false

tab_consegne.tabpage_inserimento.cbx_tok_a.enabled = false
tab_consegne.tabpage_inserimento.cbx_tok_s.enabled = false
tab_consegne.tabpage_inserimento.cbx_tok_r.enabled = false

tab_consegne.tabpage_inserimento.cbx_oma_a.enabled = false
tab_consegne.tabpage_inserimento.cbx_oma_s.enabled = false
tab_consegne.tabpage_inserimento.cbx_oma_r.enabled = false

tab_consegne.tabpage_inserimento.cbx_oka_a.enabled = false
tab_consegne.tabpage_inserimento.cbx_oka_s.enabled = false
tab_consegne.tabpage_inserimento.cbx_oka_r.enabled = false

tab_consegne.tabpage_inserimento.cbx_tok_a.enabled = false
tab_consegne.tabpage_inserimento.cbx_tok_s.enabled = false
tab_consegne.tabpage_inserimento.cbx_tok_r.enabled = false

tab_consegne.tabpage_inserimento.cbx_oka_tok.enabled= false

/* Reinizializza le variabili d'istanza... */

SetNull ( is_codice )
SetNull ( is_mem )
SetNull ( is_consegna_s.codice )
SetNull ( is_consegna_s.nominativo )
SetNull ( is_consegna_s.localita )
end event

event ue_save();string ls_msg

if tab_consegne.tabpage_inserimento.cbx_oma_a.checked then
	is_consegna_s.tipo_goh = 'OMAMORI'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.cbx_oma_r.checked then
	is_consegna_s.tipo_goh = 'OMAMORI'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.cbx_oma_s.checked then
	is_consegna_s.tipo_goh = 'OMAMORI'
	is_consegna_s.causale = 'RST'
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST'
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.cbx_oka_a.checked then
	is_consegna_s.tipo_goh = 'OKATAGI'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.cbx_oka_r.checked then
	is_consegna_s.tipo_goh = 'OKATAGI'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
	
end if

if tab_consegne.tabpage_inserimento.cbx_oka_s.checked then
	is_consegna_s.tipo_goh = 'OKATAGI'
	is_consegna_s.causale = 'RST' // reso per sostituzione
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST' // acquisito per sostituzione
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

// GdS
if tab_consegne.tabpage_inserimento.cbx_oka_tok.checked then
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


if tab_consegne.tabpage_inserimento.cbx_tok_a.checked then
	is_consegna_s.tipo_goh = 'TOKUBETSU'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.cbx_tok_r.checked then
	is_consegna_s.tipo_goh = 'TOKUBETSU'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.cbx_tok_s.checked then
	is_consegna_s.tipo_goh = 'TOKUBETSU'
//	is_consegna_s.causale = 'RSO'
	is_consegna_s.causale = 'RST'
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST'
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.uodw_inserimento.Retrieve (is_evento_s.id) = 0 then
	event clear ()
	goto ritorna
end if

//dw_inserimento.SetRedraw  ( true )
//m_sostituzioni.m_opzioni.m_aggiorna.enabled = true
Event clear ( )
//commit;
if trap_sql(sqlca, "COMMITSAVE01") < 0 then goto errore

open(w_message)

ritorna: return

errore:

ROLLBACK;
trap_sql(sqlca, "COMMITSAVE02")
Event clear ( )
open(w_message_negative)
return

end event

event ue_aggiorna();long ll_row, row
datetime ldt_data
string ls_tipo, ls_causale, ls_field, ls_nome, ls_fam, ls_note, ls_codice
int li_ret

li_ret = MessageBox ( "Aggiornamento storico", "Confermi l'operazione?", Question!, YesNo!, 2 )

if li_ret = 2 then return

ds_storico = create uo_ds_stor

ds_storico.SetTransObject ( sqlca )
//ds_storico.Retrieve ( )
//commit;

ds_fam = create uo_ds_gen					/* datastore per la verifica degli stati di famiglia... */
ds_fam.DataObject = "ds_famiglia"
ds_fam.SetTransObject ( sqlca )		

//searching= trueraw ( false )

for row = 1 to tab_consegne.tabpage_inserimento.uodw_inserimento.RowCount ()
	
	ll_row= ds_storico.InsertRow ( 0 )
	
	ls_codice= tab_consegne.tabpage_inserimento.uodw_inserimento.GetItemString ( row, "codice" )
	
	ls_nome = trim ( tab_consegne.tabpage_inserimento.uodw_inserimento.GetItemString ( row, "cognome" ) ) + " " + &
				  trim ( tab_consegne.tabpage_inserimento.uodw_inserimento.GetItemString ( row, "nome" ) )
	is_organizzazione= tab_consegne.tabpage_inserimento.uodw_inserimento.getItemString(row, "vc_parent")
	ls_tipo = tab_consegne.tabpage_inserimento.uodw_inserimento.GetItemString ( row, "tipo_goh" )
	ldt_data = is_evento_s.data_evento
	ls_causale = tab_consegne.tabpage_inserimento.uodw_inserimento.GetItemString ( row, "cod_causale" )
	ls_note = tab_consegne.tabpage_inserimento.uodw_inserimento.GetItemString ( row, "note" )
	
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
	
	hpb_conf.position= (row*100)/tab_consegne.tabpage_inserimento.uodw_inserimento.RowCount()
	
next

if ds_storico.Update ( ) = -1 then goto errore

	for row = 1 to tab_consegne.tabpage_inserimento.uodw_inserimento.RowCount ()
		
		ls_fam = tab_consegne.tabpage_inserimento.uodw_inserimento.GetItemString ( row, "codice_fam" )
	
		if not IsNull ( ls_fam ) then
		
			if wf_family ( ls_fam ) = -1 then goto errore
			
		end if
	
	next

		DELETE FROM sostituzioni  WHERE ( sostituzioni.id= :is_evento_s.id );
		if trap_sql(sqlca, "COMMITSTORICO01") < 0 then goto errore
	
		update eventi set stato= :gc_chiuso where eventi.id= :is_evento_s.id;
		if trap_sql(sqlca, "COMMITSTORICO02") < 0 then goto errore

		COMMIT;
		if trap_sql(sqlca, "COMMITSTORICO") < 0 then goto errore
		
		open(w_message)
		
		event clear ( )
		
		destroy ds_storico
		
		destroy ds_fam
		
		return
	
errore:

	ROLLBACK;
	if trap_sql(sqlca, "ROLLBACKSTORICO") < 0 then return
	
	open(w_message_negative)
	
	destroy ds_storico
	
	destroy ds_fam
	
	return

end event

event search_cer();long ll_row

openWithParm(w_gestione_cerimonie, 2)

is_evento_s= message.powerObjectParm

if isNull(is_evento_s.id) then return 

dw_header.setTransObject(sqlca)

ll_row= dw_header.retrieve(is_evento_s.id)

ret_type= "normal"

tab_consegne.tabpage_inserimento.pb_nome.enabled= true

tab_consegne.tabpage_inserimento.uodw_inserimento.SetRedraw ( false )

ll_row= tab_consegne.tabpage_inserimento.uodw_inserimento.Retrieve (is_evento_s.id)
//	commit;
	
	choose case ll_row
		case -1
			messageBox(this.title, "Errore in estrazione dati.", exclamation!)
			return
		case 0
			m_sostituzioni.m_opzioni.m_aggiorna.enabled = false
			tab_consegne.tabpage_inserimento.pb_nome.triggerEvent(clicked!)
		case else
			m_sostituzioni.m_opzioni.m_aggiorna.enabled = true	
			tab_consegne.tabpage_inserimento.uodw_inserimento.enabled= true
	end choose
	
tab_consegne.tabpage_inserimento.uodw_inserimento.SetRedraw ( true )

end event

event query_on();int li_colnum
string ls_colname, ls_null

//tab_consegne.tabpage_inserimento.dw_elenco.SetRedraw ( false )
//
//query_mode ( )
//
//tab_consegne.tabpage_inserimento.dw_elenco.SetRedraw ( true )
//
//tab_consegne.tabpage_inserimento.dw_elenco.enabled= true
//
//tab_consegne.tabpage_inserimento.dw_elenco.SetFocus ( )
//
//tab_consegne.tabpage_inserimento.cb_nome.text = "&Estrai"

end event

event query_off();int li_colnum
string ls_colname

//tab_consegne.tabpage_inserimento.dw_elenco.acceptText()
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
//tab_consegne.tabpage_inserimento.dw_elenco.setFocus ( )
//
//tab_consegne.tabpage_inserimento.cb_nome.text = "&Cerca"

end event

event query_start();//if tab_consegne.tabpage_inserimento.dw_elenco.Object.DataWindow.QueryMode = "no" then
//	TriggerEvent ( "query_on" )
//else
//	TriggerEvent ( "query_off" )
//end if
//
end event

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

public subroutine f_header ();//string ls_citta, ls_turno
//integer li_ret
//
//li_ret= dw_header.acceptText()
//ls_citta= dw_header.getItemString(1, "citta")
//ls_turno= dw_header.getItemString(1, "turno")
//if isNull(ls_citta) or isNull(ls_turno) then return
//
//long ll_rows
//
//is_consegna_s.data_cer= datetime(dw_header.getItemDate(1, "data"))
//is_consegna_s.luogo_cer= ls_citta
//is_consegna_s.turno= ls_turno
//
//	cb_nome.enabled= true
//
//	dw_inserimento.SetRedraw ( false )
//	
//	ll_rows= dw_inserimento.Retrieve ( )
////	commit;
//	
//	choose case ll_rows
//		case -1
//			close ( w_sostituzioni ) // cambiamo gestione di questo errore??????????????????
//			return
//		case 0
//			m_sostituzioni.m_opzioni.m_aggiorna.enabled = false
////			cb_nome.triggerEvent(clicked!)
//		case else
//			m_sostituzioni.m_opzioni.m_aggiorna.enabled = true	
//			dw_inserimento.enabled= true
//	end choose
//	
//	dw_inserimento.SetRedraw ( true )
//	
////end if
//
return

end subroutine

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
	 
tab_consegne.tabpage_inserimento.dw_anag.insertRow(0)
tab_consegne.tabpage_inserimento.dw_anag.SetItem ( 1,1,is_consegna_s.codice )
tab_consegne.tabpage_inserimento.dw_anag.SetItem ( 1,2,is_consegna_s.nominativo )
tab_consegne.tabpage_inserimento.dw_anag.SetItem ( 1,3,is_consegna_s.localita )
tab_consegne.tabpage_inserimento.dw_anag.SetItem ( 1,4,is_consegna_s.flag_er )

return 0

end function

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

public function integer dw_retrieve ();/*
 * estrazione dati in base a definiti criteri...
 */

//long retrieved_rows
//
////w_prelude.SetMicroHelp ("Estrazione dati...")
//
//tab_consegne.tabpage_inserimento.dw_elenco.setRedraw(false)
//
//tab_consegne.tabpage_inserimento.dw_elenco.modify("dataWindow.queryMode=no")
//
//tab_consegne.tabpage_inserimento.dw_elenco.setTransObject(sqlca)
//
//retrieved_rows= tab_consegne.tabpage_inserimento.dw_elenco.retrieve ( )
////commit;
//
//if retrieved_rows = 0 then return 0
//
//tab_consegne.tabpage_inserimento.dw_elenco.setRedraw(true)
//
//tab_consegne.tabpage_inserimento.dw_elenco.TriggerEvent ( GetFocus! )
//
////w_prelude.SetMicroHelp ("")

return 1

end function

public function string dw_status ();string stato

//stato = tab_consegne.tabpage_inserimento.dw_elenco.Describe ( "DataWindow.QueryMode" )

return stato

end function

public function integer query_mode ();//tab_consegne.tabpage_inserimento.dw_elenco.Object.DataWindow.QueryClear = "yes"
//
//tab_consegne.tabpage_inserimento.dw_elenco.setTransObject ( sqlca )
//
//tab_consegne.tabpage_inserimento.dw_elenco.setRedraw ( false )
//
//tab_consegne.tabpage_inserimento.dw_elenco.modify ( "dataWindow.queryMode=YES" )
//
//tab_consegne.tabpage_inserimento.dw_elenco.Object.DataWindow.Footer.Height = 1
//
//tab_consegne.tabpage_inserimento.dw_elenco.setRedraw ( true )
//
////w_prelude.SetMicroHelp ( "Modalita' Ricerca: impostare i criteri di estrazione..." )

return 0

end function

public function integer check_goh (string flag_er);string ls_oma, ls_oka, ls_tok

select 	flag_oma,   
		 	flag_goh,   
		 	flag_tok  
  	into     :ls_oma,   
		 	 :ls_oka,   
		 	 :ls_tok  
  from 	membri_gerarchica
 where codice= :is_codice;

if trap_sql(sqlca, "RETRIEVEGOH.01") < 0 then return -1

tab_consegne.tabpage_inserimento.cbx_oma_a.enabled = false
tab_consegne.tabpage_inserimento.cbx_oma_s.enabled = false
tab_consegne.tabpage_inserimento.cbx_oma_r.enabled = false

choose case ls_oma
		
	case 'S'

		tab_consegne.tabpage_inserimento.p_oma.visible = true
		tab_consegne.tabpage_inserimento.st_oma.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_oma_a.enabled = false
			tab_consegne.tabpage_inserimento.cbx_oma_s.enabled = true
		end if
		tab_consegne.tabpage_inserimento.cbx_oma_r.enabled = true

		
	case 'F'
		
		tab_consegne.tabpage_inserimento.p_oma.visible = true
		tab_consegne.tabpage_inserimento.st_oma.visible = true
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_oma_a.enabled = true
			tab_consegne.tabpage_inserimento.cbx_oma_s.enabled = false
		end if
		tab_consegne.tabpage_inserimento.cbx_oma_r.enabled = false
		
	case else /* cioè N */
		
		tab_consegne.tabpage_inserimento.p_oma.visible = false
		tab_consegne.tabpage_inserimento.st_oma.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_oma_a.enabled = true
			tab_consegne.tabpage_inserimento.cbx_oma_s.enabled = false
		end if
		tab_consegne.tabpage_inserimento.cbx_oma_r.enabled = false

		
end choose

tab_consegne.tabpage_inserimento.cbx_oka_a.enabled = false
tab_consegne.tabpage_inserimento.cbx_oka_s.enabled = false
tab_consegne.tabpage_inserimento.cbx_oka_r.enabled = false
tab_consegne.tabpage_inserimento.cbx_oka_tok.enabled= false

choose case ls_oka
		
	case 'S'
		
		tab_consegne.tabpage_inserimento.p_oka.visible = true
		tab_consegne.tabpage_inserimento.st_oka.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_oka_a.enabled = false
			tab_consegne.tabpage_inserimento.cbx_oka_s.enabled = true
			tab_consegne.tabpage_inserimento.cbx_oka_tok.enabled = true
		end if
		tab_consegne.tabpage_inserimento.cbx_oka_r.enabled = true

		
	case 'F'
		
		tab_consegne.tabpage_inserimento.p_oka.visible = true
		tab_consegne.tabpage_inserimento.st_oka.visible = true
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_oka_a.enabled = false
			tab_consegne.tabpage_inserimento.cbx_oka_s.enabled = false
			tab_consegne.tabpage_inserimento.cbx_oka_tok.enabled = false
		end if
		tab_consegne.tabpage_inserimento.cbx_oka_r.enabled = false
		
	case else
		
		tab_consegne.tabpage_inserimento.p_oka.visible = false
		tab_consegne.tabpage_inserimento.st_oka.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_oka_a.enabled = true
			tab_consegne.tabpage_inserimento.cbx_oka_s.enabled = false
			tab_consegne.tabpage_inserimento.cbx_oka_tok.enabled = false
		end if
		tab_consegne.tabpage_inserimento.cbx_oka_r.enabled = false
		
		if ls_tok <> 'N'  then // se ho un TOK ...
			tab_consegne.tabpage_inserimento.cbx_oka_a.enabled = false
			tab_consegne.tabpage_inserimento.cbx_oka_s.enabled = false
			tab_consegne.tabpage_inserimento.cbx_oka_tok.enabled = false
			tab_consegne.tabpage_inserimento.cbx_oka_r.enabled = false
		end if
		
end choose

tab_consegne.tabpage_inserimento.cbx_tok_a.enabled = false
tab_consegne.tabpage_inserimento.cbx_tok_r.enabled = false
tab_consegne.tabpage_inserimento.cbx_tok_s.enabled = false

choose case ls_tok
		
	case 'S'
		
		tab_consegne.tabpage_inserimento.p_tok.visible = true
		tab_consegne.tabpage_inserimento.st_tok.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_tok_a.enabled = false
			tab_consegne.tabpage_inserimento.cbx_tok_s.enabled = true
		end if
		tab_consegne.tabpage_inserimento.cbx_tok_r.enabled = true
	/*	
		if ls_oka = 'N' then
			tab_consegne.tabpage_inserimento.cbx_tok_a.visible = false
			tab_consegne.tabpage_inserimento.cbx_tok_r.visible = false
			tab_consegne.tabpage_inserimento.cbx_tok_s.visible = false
		end if
	*/
		
	case 'F'
		
		tab_consegne.tabpage_inserimento.p_tok.visible = true
		tab_consegne.tabpage_inserimento.st_tok.visible = true
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_tok_a.enabled = false
			tab_consegne.tabpage_inserimento.cbx_tok_s.enabled = false
		end if
		tab_consegne.tabpage_inserimento.cbx_tok_r.enabled = false
//		if ls_oka = 'N' then
//			tab_consegne.tabpage_inserimento.cbx_tok_a.enabled = false
//			tab_consegne.tabpage_inserimento.cbx_tok_r.enabled = false
//			tab_consegne.tabpage_inserimento.cbx_tok_s.enabled = false
//		end if

	case else
		
		tab_consegne.tabpage_inserimento.p_tok.visible = false
		tab_consegne.tabpage_inserimento.st_tok.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.cbx_tok_a.enabled = true
			tab_consegne.tabpage_inserimento.cbx_tok_s.enabled = false
		end if
		tab_consegne.tabpage_inserimento.cbx_tok_r.enabled = false
		if ls_oka <> 'N' /*= 'F'*/ then
			tab_consegne.tabpage_inserimento.cbx_tok_a.enabled = false
			tab_consegne.tabpage_inserimento.cbx_tok_r.enabled = false
			tab_consegne.tabpage_inserimento.cbx_tok_s.enabled = false
		end if
		
end choose

//ib_status[1,1] = tab_consegne.tabpage_inserimento.cbx_oma_a.enabled
//ib_status[1,2] = tab_consegne.tabpage_inserimento.cbx_oma_r.enabled
//ib_status[1,3] = tab_consegne.tabpage_inserimento.cbx_oma_s.enabled
//ib_status[2,1] = tab_consegne.tabpage_inserimento.cbx_oka_a.enabled
//ib_status[2,2] = tab_consegne.tabpage_inserimento.cbx_oka_r.enabled
//ib_status[2,3] = tab_consegne.tabpage_inserimento.cbx_oka_s.enabled
//ib_status[3,1] = tab_consegne.tabpage_inserimento.cbx_tok_a.enabled
//ib_status[3,2] = tab_consegne.tabpage_inserimento.cbx_tok_r.enabled
//ib_status[3,3] = tab_consegne.tabpage_inserimento.cbx_tok_s.enabled

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

INSERT INTO sostituzioni  
         ( codice,   
           id,   
           cod_causale,   
           tipo_goh,   
           flag_part,   
           note )  
  VALUES ( 	:is_codice,   
          		:is_evento_s.id,   
           		:is_consegna_s.causale,   
           		:is_consegna_s.tipo_goh,   
           		:ls_part,   
           		:ls_note )  ;
	if sqlca.SqlCode = -1 then
	
end if

return 0

end function

on w_consegnesostituzioni_old.create
this.tab_consegne=create tab_consegne
this.hpb_conf=create hpb_conf
this.dw_header=create dw_header
this.st_modify=create st_modify
this.Control[]={this.tab_consegne,&
this.hpb_conf,&
this.dw_header,&
this.st_modify}
end on

on w_consegnesostituzioni_old.destroy
destroy(this.tab_consegne)
destroy(this.hpb_conf)
destroy(this.dw_header)
destroy(this.st_modify)
end on

event open;im_preview= create m_preview

PostEvent ( "ue_open" )

end event

event closequery;
if tab_consegne.tabpage_inserimento.uodw_inserimento.uof_modificheincorso()= 3 then return 1
end event

event timer;//timer ( 0 )
//close ( w_msgauto )

end event

event resize;tab_consegne.height= this.height - tab_consegne.y - 180

tab_consegne.tabpage_inserimento.gb_dett.height= tab_consegne.height - tab_consegne.tabpage_inserimento.gb_dett.y -180

tab_consegne.tabpage_inserimento.uodw_inserimento.height= tab_consegne.tabpage_inserimento.gb_dett.height - 90
end event

type tab_consegne from tab within w_consegnesostituzioni_old
event create ( )
event destroy ( )
integer x = 55
integer y = 348
integer width = 4224
integer height = 2504
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 81324524
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_inserimento tabpage_inserimento
tabpage_stampe tabpage_stampe
end type

on tab_consegne.create
this.tabpage_inserimento=create tabpage_inserimento
this.tabpage_stampe=create tabpage_stampe
this.Control[]={this.tabpage_inserimento,&
this.tabpage_stampe}
end on

on tab_consegne.destroy
destroy(this.tabpage_inserimento)
destroy(this.tabpage_stampe)
end on

event selectionchanged;choose case newindex
		
	case 1
		
	case 2
		
		tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.retrieve(is_evento_s.id)
		
		
end choose
end event

type tabpage_inserimento from userobject within tab_consegne
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4187
integer height = 2376
long backcolor = 81324524
string text = "Inserimento"
long tabtextcolor = 8388608
long tabbackcolor = 81324524
string picturename = "Insert!"
long picturemaskcolor = 536870912
cb_storico cb_storico
cb_rimuovi cb_rimuovi
st_oma st_oma
st_tok st_tok
st_oka st_oka
st_7 st_7
pb_nome pb_nome
st_2 st_2
st_1 st_1
st_3 st_3
st_4 st_4
st_5 st_5
cbx_oma_a cbx_oma_a
cbx_oka_a cbx_oka_a
cbx_tok_a cbx_tok_a
cbx_tok_r cbx_tok_r
cbx_oka_r cbx_oka_r
cbx_oma_r cbx_oma_r
cbx_oma_s cbx_oma_s
cbx_oka_s cbx_oka_s
cbx_tok_s cbx_tok_s
st_6 st_6
cb_save cb_save
cbx_oka_tok cbx_oka_tok
st_sost_tok st_sost_tok
dw_anag dw_anag
gb_ricerca gb_ricerca
gb_1 gb_1
p_oka p_oka
p_tok p_tok
p_oma p_oma
uodw_inserimento uodw_inserimento
gb_dett gb_dett
gb_lista gb_lista
end type

on tabpage_inserimento.create
this.cb_storico=create cb_storico
this.cb_rimuovi=create cb_rimuovi
this.st_oma=create st_oma
this.st_tok=create st_tok
this.st_oka=create st_oka
this.st_7=create st_7
this.pb_nome=create pb_nome
this.st_2=create st_2
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.cbx_oma_a=create cbx_oma_a
this.cbx_oka_a=create cbx_oka_a
this.cbx_tok_a=create cbx_tok_a
this.cbx_tok_r=create cbx_tok_r
this.cbx_oka_r=create cbx_oka_r
this.cbx_oma_r=create cbx_oma_r
this.cbx_oma_s=create cbx_oma_s
this.cbx_oka_s=create cbx_oka_s
this.cbx_tok_s=create cbx_tok_s
this.st_6=create st_6
this.cb_save=create cb_save
this.cbx_oka_tok=create cbx_oka_tok
this.st_sost_tok=create st_sost_tok
this.dw_anag=create dw_anag
this.gb_ricerca=create gb_ricerca
this.gb_1=create gb_1
this.p_oka=create p_oka
this.p_tok=create p_tok
this.p_oma=create p_oma
this.uodw_inserimento=create uodw_inserimento
this.gb_dett=create gb_dett
this.gb_lista=create gb_lista
this.Control[]={this.cb_storico,&
this.cb_rimuovi,&
this.st_oma,&
this.st_tok,&
this.st_oka,&
this.st_7,&
this.pb_nome,&
this.st_2,&
this.st_1,&
this.st_3,&
this.st_4,&
this.st_5,&
this.cbx_oma_a,&
this.cbx_oka_a,&
this.cbx_tok_a,&
this.cbx_tok_r,&
this.cbx_oka_r,&
this.cbx_oma_r,&
this.cbx_oma_s,&
this.cbx_oka_s,&
this.cbx_tok_s,&
this.st_6,&
this.cb_save,&
this.cbx_oka_tok,&
this.st_sost_tok,&
this.dw_anag,&
this.gb_ricerca,&
this.gb_1,&
this.p_oka,&
this.p_tok,&
this.p_oma,&
this.uodw_inserimento,&
this.gb_dett,&
this.gb_lista}
end on

on tabpage_inserimento.destroy
destroy(this.cb_storico)
destroy(this.cb_rimuovi)
destroy(this.st_oma)
destroy(this.st_tok)
destroy(this.st_oka)
destroy(this.st_7)
destroy(this.pb_nome)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.cbx_oma_a)
destroy(this.cbx_oka_a)
destroy(this.cbx_tok_a)
destroy(this.cbx_tok_r)
destroy(this.cbx_oka_r)
destroy(this.cbx_oma_r)
destroy(this.cbx_oma_s)
destroy(this.cbx_oka_s)
destroy(this.cbx_tok_s)
destroy(this.st_6)
destroy(this.cb_save)
destroy(this.cbx_oka_tok)
destroy(this.st_sost_tok)
destroy(this.dw_anag)
destroy(this.gb_ricerca)
destroy(this.gb_1)
destroy(this.p_oka)
destroy(this.p_tok)
destroy(this.p_oma)
destroy(this.uodw_inserimento)
destroy(this.gb_dett)
destroy(this.gb_lista)
end on

type cb_storico from commandbutton within tabpage_inserimento
integer x = 3415
integer y = 944
integer width = 562
integer height = 128
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiorna lo storico"
end type

event clicked;if tab_consegne.tabpage_inserimento.uodw_inserimento.modifiedCount() > 0 or tab_consegne.tabpage_inserimento.uodw_inserimento.deletedCount() > 0 then
	messageBox(parent.text, "Modifiche da confermare in lista nominativi.", information!)
	return 0
end if

w_consegnesostituzioni.event ue_aggiorna()
end event

type cb_rimuovi from commandbutton within tabpage_inserimento
integer x = 2519
integer y = 944
integer width = 562
integer height = 128
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Rimuovi dalla lista"
end type

event clicked;if uodw_inserimento.getRow() <= 0 then return 

if messageBox(parent.text, "Confermi la cancellazione di: "+ uodw_inserimento.getItemString(uodw_inserimento.getRow(), "cognome")+" "+ &
									uodw_inserimento.getItemString(uodw_inserimento.getRow(), "nome")+"?", question!, yesNo!, 2)= 2 then return 0

	uodw_inserimento.deleteRow(0)
	
	if uodw_inserimento.update() < 0 then
	rollback;
	trap_sql(sqlca, "CANCELLASOST01")
	open(w_message_negative)
	return -1
	else
	commit;
	if trap_sql(sqlca, "CANCELLASOST02") < 0 then return -1
	open(w_message)
	end if
	
	tab_consegne.tabpage_stampe.enabled= false
	if uodw_inserimento.rowCount() > 0 then tab_consegne.tabpage_stampe.enabled= true

return 0
end event

type st_oma from statictext within tabpage_inserimento
boolean visible = false
integer x = 3653
integer y = 116
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 81324524
string text = "(famiglia)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_tok from statictext within tabpage_inserimento
boolean visible = false
integer x = 3241
integer y = 116
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 81324524
string text = "(famiglia)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_oka from statictext within tabpage_inserimento
boolean visible = false
integer x = 2839
integer y = 116
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 81324524
string text = "(famiglia)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_inserimento
integer x = 1335
integer y = 76
integer width = 224
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
string text = "Cerca..."
boolean focusrectangle = false
end type

type pb_nome from picturebutton within tabpage_inserimento
integer x = 1573
integer y = 56
integer width = 197
integer height = 120
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "D:\svil\Svil7\Risorse\CERCA_bface.bmp"
alignment htextalign = left!
end type

event clicked;string ls_er

open(w_part)
is_codice= message.stringParm

if dw_anag.retrieve(is_codice)= 0 then goto errore

ls_er= dw_anag.getItemString(1, "flag_er")

if check_goh (ls_er ) = -1 then goto errore

f_check_flags ( )

return 0

errore:

return -1




end event

type st_2 from statictext within tabpage_inserimento
integer x = 2830
integer y = 248
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Okatagi"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_inserimento
integer x = 3643
integer y = 248
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Omamori"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_inserimento
integer x = 3200
integer y = 248
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Tokubetsu"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_inserimento
integer x = 2208
integer y = 348
integer width = 699
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Acquisizione"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_inserimento
integer x = 2208
integer y = 448
integer width = 699
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Restituzione"
alignment alignment = right!
end type

type cbx_oma_a from checkbox within tabpage_inserimento
integer x = 3739
integer y = 348
integer width = 59
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked then
	
	cb_save.enabled = true
	
end if

end event

type cbx_oka_a from checkbox within tabpage_inserimento
integer x = 2926
integer y = 348
integer width = 59
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked then
	
//	cbx_tok_a.enabled = false
	cb_save.enabled = true
	
end if

end event

type cbx_tok_a from checkbox within tabpage_inserimento
integer x = 3328
integer y = 348
integer width = 59
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
	
end if

end event

type cbx_tok_r from checkbox within tabpage_inserimento
integer x = 3328
integer y = 448
integer width = 59
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
	
end if

end event

type cbx_oka_r from checkbox within tabpage_inserimento
integer x = 2926
integer y = 448
integer width = 59
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked then
	
	cbx_oka_s.enabled = false
	cb_save.enabled = true
	
end if

end event

type cbx_oma_r from checkbox within tabpage_inserimento
integer x = 3739
integer y = 448
integer width = 59
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked then
	
	cbx_oma_s.enabled = false
	cb_save.enabled = true
	
end if

end event

type cbx_oma_s from checkbox within tabpage_inserimento
integer x = 3739
integer y = 552
integer width = 59
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

event clicked;if this.checked then
	
	cbx_oma_r.enabled = false
	cb_save.enabled = true
	
end if

end event

type cbx_oka_s from checkbox within tabpage_inserimento
integer x = 2926
integer y = 552
integer width = 59
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
borderstyle borderstyle = stylelowered!
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
	
end if

end event

type cbx_tok_s from checkbox within tabpage_inserimento
integer x = 3328
integer y = 552
integer width = 59
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
	
end if

end event

type st_6 from statictext within tabpage_inserimento
integer x = 2208
integer y = 552
integer width = 699
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Sostituzione"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_save from commandbutton within tabpage_inserimento
integer x = 1943
integer y = 944
integer width = 562
integer height = 128
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Aggiungi alla lista"
end type

event clicked;w_consegnesostituzioni.event ue_save()

uodw_inserimento.enabled= true
dw_anag.reset()
tab_consegne.tabpage_stampe.enabled= true

uodw_inserimento.object.b_aggiorna.visible= true


end event

type cbx_oka_tok from checkbox within tabpage_inserimento
integer x = 2926
integer y = 664
integer width = 59
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
boolean enabled = false
borderstyle borderstyle = stylelowered!
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
	
end if

end event

type st_sost_tok from statictext within tabpage_inserimento
integer x = 2062
integer y = 664
integer width = 846
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean enabled = false
string text = "Sostituzione con TOKUBETSU"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_anag from datawindow within tabpage_inserimento
string tag = "Dettaglio"
integer x = 23
integer y = 200
integer width = 1824
integer height = 868
integer taborder = 40
boolean enabled = false
string dataobject = "dw_part_nominativa"
boolean border = false
boolean livescroll = true
end type

type gb_ricerca from groupbox within tabpage_inserimento
integer width = 1893
integer height = 1104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
string text = "Dati anagrafici"
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within tabpage_inserimento
integer x = 1911
integer width = 2208
integer height = 880
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
string text = "Consegne/Sostituzioni"
borderstyle borderstyle = stylelowered!
end type

type p_oka from picture within tabpage_inserimento
boolean visible = false
integer x = 2926
integer y = 188
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "D:\svil\Svil7\Risorse\D_RED.BMP"
boolean focusrectangle = false
end type

type p_tok from picture within tabpage_inserimento
boolean visible = false
integer x = 3328
integer y = 188
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "D:\svil\Svil7\Risorse\D_RED.BMP"
boolean focusrectangle = false
end type

type p_oma from picture within tabpage_inserimento
boolean visible = false
integer x = 3739
integer y = 192
integer width = 59
integer height = 52
boolean bringtotop = true
boolean originalsize = true
string picturename = "D:\svil\Svil7\Risorse\D_RED.BMP"
boolean focusrectangle = false
end type

type uodw_inserimento from uodw_generica within tabpage_inserimento
integer x = 18
integer y = 1152
integer width = 4073
integer height = 1196
integer taborder = 60
string dataobject = "dw_consegne"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event buttonclicked;call super::buttonclicked;string ls_note, ls_note_old

if this.getRow() <= 0 then return -1

choose case dwo.name
		
	case 'b_note'
	
		ls_note=  this.getItemString(row, "note")
		
		openWithParm(w_note, ls_note)
		
		ls_note_old= ls_note
		
		ls_note= message.stringParm
		
		if ls_note <> ls_note_old or isNull(ls_note_old) then
		
			this.setItem(row, "note", ls_note)

				if this.update() < 0 then
		  			rollback;
					trap_sql(sqlca, "INSNOTE02")
					return -1
				else
					commit;
					if trap_sql(sqlca, "INSNOTE03") < 0 then return -1
				end if
				
		end if
	
end choose
	
end event

event retrieveend;call super::retrieveend;//commit;

tab_consegne.tabpage_stampe.enabled= false
if rowcount > 0 then tab_consegne.tabpage_stampe.enabled= true

this.object.b_aggiorna.visible= false
end event

event itemchanged;call super::itemchanged;
if dwo.name= "cod_causale" then
	
	integer li_ret
	long ll_row, ll_count
	string ls_filter, ls_find
	
	this.setRedraw(false)
	
	ls_filter= "codice= '"+this.getItemString(row, "codice")+"' and cod_causale= '"+data+"'"
	
	setFilter(ls_filter)
	filter()

	if this.rowCount() > 1 then
		messageBox(parent.text, "Causale già inserita per questo nominativo.", exclamation!)
		this.object.b_aggiorna.visible= false
		li_ret= 1
	else
		li_ret= 0
	end if
	
	setFilter("" )
	filter()
	
	this.setRedraw(true)
	
	this.scrollToRow(row)

	return li_ret

end if
end event

type gb_dett from groupbox within tabpage_inserimento
integer y = 1104
integer width = 4114
integer height = 1260
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 81324524
string text = "Nominativi in lista"
borderstyle borderstyle = stylelowered!
end type

type gb_lista from groupbox within tabpage_inserimento
integer x = 1911
integer y = 880
integer width = 2203
integer height = 224
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 81324524
string text = "Gestione nominativi in lista"
borderstyle borderstyle = stylelowered!
end type

type tabpage_stampe from userobject within tab_consegne
integer x = 18
integer y = 112
integer width = 4187
integer height = 2376
long backcolor = 81324524
string text = "Stampe"
long tabtextcolor = 16711680
long tabbackcolor = 81324524
string picturename = "SelectReturn!"
long picturemaskcolor = 553648127
uodw_stampa_sostituzioni uodw_stampa_sostituzioni
end type

on tabpage_stampe.create
this.uodw_stampa_sostituzioni=create uodw_stampa_sostituzioni
this.Control[]={this.uodw_stampa_sostituzioni}
end on

on tabpage_stampe.destroy
destroy(this.uodw_stampa_sostituzioni)
end on

type uodw_stampa_sostituzioni from uodw_generica within tabpage_stampe
integer width = 4119
integer height = 2352
integer taborder = 40
string dataobject = "dw_stampa_sostituzioni"
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_stampa_sostituzioni

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_consegnesostituzioni.PointerX(), w_consegnesostituzioni.PointerY() )
end event

type hpb_conf from vprogressbar within w_consegnesostituzioni_old
boolean visible = false
integer x = 4119
integer y = 928
integer width = 78
integer height = 560
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type dw_header from datawindow within w_consegnesostituzioni_old
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

event dberror;return 1
end event

type st_modify from statictext within w_consegnesostituzioni_old
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
long backcolor = 12632256
boolean enabled = false
string text = "MODIFICA"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

