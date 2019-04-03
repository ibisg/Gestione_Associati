$PBExportHeader$w_consegnesostituzioni.srw
forward
global type w_consegnesostituzioni from window
end type
type tab_consegne from tab within w_consegnesostituzioni
end type
type tabpage_inserimento from userobject within tab_consegne
end type
type cb_ripristina from commandbutton within tabpage_inserimento
end type
type p_oma from picture within tabpage_inserimento
end type
type rb_oma_s from radiobutton within tabpage_inserimento
end type
type rb_oma_r from radiobutton within tabpage_inserimento
end type
type rb_oma_a from radiobutton within tabpage_inserimento
end type
type rb_tok_s from radiobutton within tabpage_inserimento
end type
type rb_tok_r from radiobutton within tabpage_inserimento
end type
type rb_tok_a from radiobutton within tabpage_inserimento
end type
type rb_oka_tok from radiobutton within tabpage_inserimento
end type
type rb_oka_s from radiobutton within tabpage_inserimento
end type
type rb_oka_r from radiobutton within tabpage_inserimento
end type
type rb_oka_a from radiobutton within tabpage_inserimento
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
type cb_save from commandbutton within tabpage_inserimento
end type
type dw_anag from datawindow within tabpage_inserimento
end type
type gb_ricerca from groupbox within tabpage_inserimento
end type
type p_oka from picture within tabpage_inserimento
end type
type p_tok from picture within tabpage_inserimento
end type
type uodw_inserimento from uodw_generica within tabpage_inserimento
end type
type gb_dett from groupbox within tabpage_inserimento
end type
type gb_okatagi from groupbox within tabpage_inserimento
end type
type gb_tokubetsu from groupbox within tabpage_inserimento
end type
type gb_omamori from groupbox within tabpage_inserimento
end type
type tabpage_inserimento from userobject within tab_consegne
cb_ripristina cb_ripristina
p_oma p_oma
rb_oma_s rb_oma_s
rb_oma_r rb_oma_r
rb_oma_a rb_oma_a
rb_tok_s rb_tok_s
rb_tok_r rb_tok_r
rb_tok_a rb_tok_a
rb_oka_tok rb_oka_tok
rb_oka_s rb_oka_s
rb_oka_r rb_oka_r
rb_oka_a rb_oka_a
st_oma st_oma
st_tok st_tok
st_oka st_oka
st_7 st_7
pb_nome pb_nome
cb_save cb_save
dw_anag dw_anag
gb_ricerca gb_ricerca
p_oka p_oka
p_tok p_tok
uodw_inserimento uodw_inserimento
gb_dett gb_dett
gb_okatagi gb_okatagi
gb_tokubetsu gb_tokubetsu
gb_omamori gb_omamori
end type
type tabpage_stampe from userobject within tab_consegne
end type
type uodw_stampa_sostituzioni from uodw_generica within tabpage_stampe
end type
type tabpage_stampe from userobject within tab_consegne
uodw_stampa_sostituzioni uodw_stampa_sostituzioni
end type
type tab_consegne from tab within w_consegnesostituzioni
tabpage_inserimento tabpage_inserimento
tabpage_stampe tabpage_stampe
end type
type hpb_conf from vprogressbar within w_consegnesostituzioni
end type
type st_modify from statictext within w_consegnesostituzioni
end type
type dw_header from uodw_header within w_consegnesostituzioni
end type
type gb_2 from groupbox within w_consegnesostituzioni
end type
end forward

global type w_consegnesostituzioni from window
integer x = 5
integer y = 4
integer width = 5006
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
boolean clientedge = true
event ue_open ( )
event chiudi ( )
event clear ( )
event ue_save ( )
event ue_aggiorna ( )
event query_on ( )
event query_off ( )
event query_start ( )
tab_consegne tab_consegne
hpb_conf hpb_conf
st_modify st_modify
dw_header dw_header
gb_2 gb_2
end type
global w_consegnesostituzioni w_consegnesostituzioni

type variables
dataWindowChild idwc_luoghi
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
public function integer dw_retrieve ()
public function string dw_status ()
public function integer query_mode ()
public function integer f_insert ()
public function integer check_goh (string flag_er)
public function integer f_clear_flags ()
public subroutine f_check_flags ()
public subroutine f_clear_rb ()
public subroutine wf_ena_oka (boolean ab_enable)
public subroutine wf_ena_tok (boolean ab_enable)
end prototypes

event ue_open();setRedraw(false)

//tab_consegne.tabpage_inserimento.uodw_inserimento.setRowFocusIndicator(hand!)

long ll_row

//openWithParm(w_gestione_cerimonie, 7)

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

	dw_header.setTransObject(sqlca)
	
	dw_header.GetChild('cod_luogo', idwc_luoghi)
	
	idwc_luoghi.setTransObject(sqlca)
	
	idwc_luoghi.retrieve(s_session_s.cod_dip)
	
	ll_row= dw_header.retrieve(is_evento_s.id)
	
	if ll_row > 0 then tab_consegne.tabpage_inserimento.pb_nome.enabled= true
	
	tab_consegne.tabpage_inserimento.uodw_inserimento.retrieve(is_evento_s.id)
	
	setRedraw(true)
end if

return 

end event

event chiudi;close ( this )

end event

event clear();f_clear_rb()

/* Reinizializza le variabili d'istanza... */

SetNull ( is_codice )
SetNull ( is_mem )
SetNull ( is_consegna_s.codice )
SetNull ( is_consegna_s.nominativo )
SetNull ( is_consegna_s.localita )
end event

event ue_save();long ll_row
string ls_msg

if tab_consegne.tabpage_inserimento.rb_oma_a.checked then
	is_consegna_s.tipo_goh = 'OMA'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.rb_oma_r.checked then
	is_consegna_s.tipo_goh = 'OMA'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.rb_oma_s.checked then
	is_consegna_s.tipo_goh = 'OMA'
	is_consegna_s.causale = 'RST'
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST'
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.rb_oka_a.checked then
	is_consegna_s.tipo_goh = 'OKA'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.rb_oka_r.checked then
	is_consegna_s.tipo_goh = 'OKA'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
	
end if

if tab_consegne.tabpage_inserimento.rb_oka_s.checked then
	is_consegna_s.tipo_goh = 'OKA'
	is_consegna_s.causale = 'RST' // reso per sostituzione
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST' // acquisito per sostituzione
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

// GdS
if tab_consegne.tabpage_inserimento.rb_oka_tok.checked then
	is_consegna_s.tipo_goh = 'OKA'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso per sostituzione con Tokubetsu'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.tipo_goh = 'TOK'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione Tokubetsu, reso Okatagi'
	if f_insert ( ) = -1 then goto errore
end if

// end GdS


if tab_consegne.tabpage_inserimento.rb_tok_a.checked then
	is_consegna_s.tipo_goh = 'TOK'
	is_consegna_s.causale = 'ACQ'
	is_consegna_s.descrizione_causale = 'Acquisizione'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.rb_tok_r.checked then
	is_consegna_s.tipo_goh = 'TOK'
	is_consegna_s.causale = 'RSO'
	is_consegna_s.descrizione_causale = 'Reso'
	if f_insert ( ) = -1 then goto errore
end if

if tab_consegne.tabpage_inserimento.rb_tok_s.checked then
	is_consegna_s.tipo_goh = 'TOK'
//	is_consegna_s.causale = 'RSO'
	is_consegna_s.causale = 'RST'
	is_consegna_s.descrizione_causale = 'Reso per sostituzione'
	if f_insert ( ) = -1 then goto errore
	is_consegna_s.causale = 'AST'
	is_consegna_s.descrizione_causale = 'Acquisizione per sostituzione'
	if f_insert ( ) = -1 then goto errore
end if

commit;
if trap_sql(sqlca, "COMMITSAVE01") < 0 then goto errore

open(w_message)

ll_row= tab_consegne.tabpage_inserimento.uodw_inserimento.Retrieve (is_evento_s.id) 

event clear ()

return

errore:

ROLLBACK;
trap_sql(sqlca, "COMMITSAVE02")
Event clear ( )
open(w_message_negative)
return

end event

event ue_aggiorna();long ll_row, row, ll_maxrow
datetime ldt_data
date ld_data
string ls_tipo, ls_causale, ls_field, ls_nome, ls_fam, ls_note, ls_codice, ls_luogo, ls_data
int li_ret

li_ret = MessageBox ( "Aggiornamento storico", "Confermi l'operazione?", Question!, YesNo!, 2 )

if li_ret = 2 then return

ds_storico = create uo_ds_stor

ds_storico.SetTransObject ( sqlca )
//ds_storico.Retrieve ( )
//commit;

ds_fam = create uo_ds_gen					/* datastore per la verifica degli stati di famiglia... */

ll_maxrow=  tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.RowCount ()

for row = 1 to ll_maxrow
	
	ls_codice= tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.GetItemString ( row, "codice" )
	
	ls_fam = tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.GetItemString ( row, "codice_fam" )
	
	ls_tipo= tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.GetItemString ( row, "tipo_goh" )
	
	ls_nome = trim ( tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.GetItemString ( row, "nome" ) ) + " " + &
				  trim ( tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.GetItemString ( row, "cognome" ) )
	
	if NOT isNull(ls_codice) and NOT isNull(ls_fam) and ls_codice <> "" and ls_fam <> "" and ls_tipo <> "OMA" then
		
		// Fa parte di un nucleo familiare,  ( eccetto caso di Omamori )

		li_ret= messageBox(this.title, "Attenzione: "+ls_nome+" fa parte di un nucleo familiare.~n"+&
													"Per poter procedere occorre prima sciogliere il nucleo.", exclamation!, ok!)
			
			return
			
		end if
	
	ll_row= ds_storico.InsertRow ( 0 )
	
	is_organizzazione= tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.getItemString(row, "vc_parent")
	ls_data = string(is_evento_s.data_evento, "dd.mm.yyyy")
	ls_causale = tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.GetItemString ( row, "cod_causale" )
	ls_luogo=  mid(tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.GetItemString ( row, "descrizione_evento" ), 1, 30)
	ls_note = tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.GetItemString ( row, "note" )
	
	// Ad evitare inconsistenze nello storico, prova ad eliminare prima eventuali duplicati	
		delete from gohonzon_storico
			where 	codice= :ls_codice and
						tipo_goh= :ls_tipo and
						data= convert(datetime, :ls_data+" 00:00:00") and
						cod_causale= :ls_causale;
						
		if trap_sql(sqlca, "CHECKSTORICO01") < 0 then goto errore		
		
		  INSERT INTO gohonzon_storico  
					(codice,   
					  tipo_goh,   
					  data,   
					  luogo,   
					  cod_causale,   
					  note )  
		  VALUES (
				  	   :ls_codice,   
					  :ls_tipo,   
					   convert(datetime, :ls_data+" 00:00:00"),   
					  :ls_luogo,   
					  :ls_causale,   
					  :ls_note )  ;
					  
			if trap_sql(sqlca, "CHECKSTORICO02") < 0 then goto errore						  

	
	choose case ls_tipo
			
		/*	 
			le causali iniziano per "A" se sono acquisizioni e per "R" se sono restituzioni; 
			le sostituzioni si gestiscono con due righe, una di restituzione e una di acquisizione, 
			è essenziale che le righe siano ordinate in modo che per ogni persona le righe di acquisizione vengano dopo le restituzioni.
		*/
		case 'OMA'
			
			if mid(ls_causale, 1, 1) = 'A' then
				update membri_gerarchica
				set flag_oma= 'S', u_ult_mod= :sqlca.logId, d_ult_mod= getDate() where codice= :ls_codice;
				
			else
				update membri_gerarchica
				set flag_oma= 'N', u_ult_mod= :sqlca.logId, d_ult_mod= getDate() where codice= :ls_codice;
				
				update membri_gerarchica
				set flag_oma= 'N', u_ult_mod= :sqlca.logId, d_ult_mod= getDate() where 
				flag_oma= 'F' and
				codice <> codice_fam and
				codice_fam= :ls_codice;
			end if
			
		case 'OKA'
			
			if mid(ls_causale, 1, 1) = 'A' then
				update membri_gerarchica
				set flag_goh= 'S', flag_tok= 'N', u_ult_mod= :sqlca.logId, d_ult_mod= getDate() where codice= :ls_codice;
			else
				update membri_gerarchica
				set flag_goh= 'N', flag_tok= 'N', u_ult_mod= :sqlca.logId, d_ult_mod= getDate() where codice= :ls_codice;
			end if
			
		case 'TOK'
			
			if mid(ls_causale, 1, 1) = 'A' then
				update membri_gerarchica
				set flag_tok= 'S', flag_goh= 'N', u_ult_mod= :sqlca.logId, d_ult_mod= getDate() where codice= :ls_codice;
			else
				update membri_gerarchica
				set flag_tok= 'N', flag_goh= 'N', u_ult_mod= :sqlca.logId, d_ult_mod= getDate() where codice= :ls_codice;
			end if
			
	end choose
	
	if sqlca.sqlcode < 0 then goto errore
	
	hpb_conf.position= (row*100) / ll_maxrow
	
next
	
		delete from eventi where id= :is_evento_s.id; // in cascata cancella gohonzon_consegne...
		if trap_sql(sqlca, "DELEVENTI01") < 0 then goto errore
	
		COMMIT;
		if trap_sql(sqlca, "COMMITSTORICO") < 0 then goto errore
		
		open(w_message)
		
		event clear ( )
		
		destroy ds_storico
		
		destroy ds_fam
		
		dw_header.reset()
		tab_consegne.tabpage_inserimento.uodw_inserimento.reset()
		tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.reset()
		
		close(this)
		
		return
	
errore:

	ROLLBACK;
	if trap_sql(sqlca, "ROLLBACKSTORICO") < 0 then return
	
	open(w_message_negative)
	
	destroy ds_storico
	
	destroy ds_fam
	
	return

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

public function integer f_insert ();integer li_ret
string ls_part = "S", ls_note=""

select count(*)
into :li_ret
from gohonzon_consegne
where id != :is_evento_s.id and codice= :is_codice;
if trap_sql(sqlca, "INSERTSOST") < 0 then return -1

if li_ret > 0 then
	messageBox(this.title, "Nome già presente in un'altra lista Sostituzioni/Consegne.~nVerificare le cerimonie già esistenti." , exclamation!)
	return -1
end if

INSERT INTO gohonzon_consegne  
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
	if trap_sql(sqlca, "INSERTSOST02") < 0 then return -1

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

tab_consegne.tabpage_inserimento.rb_oma_a.visible = false
tab_consegne.tabpage_inserimento.rb_oma_s.visible = false
tab_consegne.tabpage_inserimento.rb_oma_r.visible = false

tab_consegne.tabpage_inserimento.rb_oma_a.checked = false
tab_consegne.tabpage_inserimento.rb_oma_s.checked = false
tab_consegne.tabpage_inserimento.rb_oma_r.checked = false

choose case ls_oma
		
	case 'S'

		tab_consegne.tabpage_inserimento.p_oma.visible = true
		tab_consegne.tabpage_inserimento.st_oma.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_oma_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oma_s.visible = true
		else
			tab_consegne.tabpage_inserimento.rb_oma_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oma_s.visible = false			
		end if
		tab_consegne.tabpage_inserimento.rb_oma_r.visible = true

	case 'F'
		
		tab_consegne.tabpage_inserimento.p_oma.visible = true
		tab_consegne.tabpage_inserimento.st_oma.visible = true
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_oma_a.visible = true
			tab_consegne.tabpage_inserimento.rb_oma_s.visible = false
		else
			tab_consegne.tabpage_inserimento.rb_oma_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oma_s.visible = false			
		end if
		tab_consegne.tabpage_inserimento.rb_oma_r.visible = false
		
	case else /* cioè N */
		
		tab_consegne.tabpage_inserimento.p_oma.visible = false
		tab_consegne.tabpage_inserimento.st_oma.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_oma_a.visible = true
			tab_consegne.tabpage_inserimento.rb_oma_s.visible = false
		else
			tab_consegne.tabpage_inserimento.rb_oma_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oma_s.visible = false			
		end if
		tab_consegne.tabpage_inserimento.rb_oma_r.visible = false

		
end choose

tab_consegne.tabpage_inserimento.rb_oka_a.visible = false
tab_consegne.tabpage_inserimento.rb_oka_s.visible = false
tab_consegne.tabpage_inserimento.rb_oka_r.visible = false
tab_consegne.tabpage_inserimento.rb_oka_tok.visible= false

tab_consegne.tabpage_inserimento.rb_oka_a.checked = false
tab_consegne.tabpage_inserimento.rb_oka_s.checked = false
tab_consegne.tabpage_inserimento.rb_oka_r.checked = false
tab_consegne.tabpage_inserimento.rb_oka_tok.checked= false

choose case ls_oka
		
	case 'S'
		
		tab_consegne.tabpage_inserimento.p_oka.visible = true
		tab_consegne.tabpage_inserimento.st_oka.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_oka_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_s.visible = true
			tab_consegne.tabpage_inserimento.rb_oka_tok.visible = true
		else
			tab_consegne.tabpage_inserimento.rb_oka_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_s.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_tok.visible = false			
		end if
		
		tab_consegne.tabpage_inserimento.rb_oka_r.visible = true

	case 'F'
		
		tab_consegne.tabpage_inserimento.p_oka.visible = true
		tab_consegne.tabpage_inserimento.st_oka.visible = true
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_oka_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_s.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_tok.visible = false
		else
			tab_consegne.tabpage_inserimento.rb_oka_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_s.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_tok.visible = false
		end if
		
		tab_consegne.tabpage_inserimento.rb_oka_r.enabled = false
		
	case else
		
		tab_consegne.tabpage_inserimento.p_oka.visible = false
		tab_consegne.tabpage_inserimento.st_oka.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_oka_a.visible = true
			tab_consegne.tabpage_inserimento.rb_oka_s.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_tok.visible = false
		else
			tab_consegne.tabpage_inserimento.rb_oka_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_s.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_tok.visible = false
		end if
		
		tab_consegne.tabpage_inserimento.rb_oka_r.visible = false
		
		if ls_tok <> 'N'  then // se ho un TOK ...
			tab_consegne.tabpage_inserimento.rb_oka_a.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_s.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_tok.visible = false
			tab_consegne.tabpage_inserimento.rb_oka_r.visible = false
		end if
		
end choose

tab_consegne.tabpage_inserimento.rb_tok_a.visible = false
tab_consegne.tabpage_inserimento.rb_tok_r.visible = false
tab_consegne.tabpage_inserimento.rb_tok_s.visible = false

tab_consegne.tabpage_inserimento.rb_tok_a.checked = false
tab_consegne.tabpage_inserimento.rb_tok_r.checked = false
tab_consegne.tabpage_inserimento.rb_tok_s.checked = false

choose case ls_tok
		
	case 'S'
		
		tab_consegne.tabpage_inserimento.p_tok.visible = true
		tab_consegne.tabpage_inserimento.st_tok.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_tok_a.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_s.visible = true
		else
			tab_consegne.tabpage_inserimento.rb_tok_a.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_s.visible = false
		end if
		
		tab_consegne.tabpage_inserimento.rb_tok_r.visible = true
	/*	
		if ls_oka = 'N' then
			tab_consegne.tabpage_inserimento.rb_tok_a.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_r.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_s.visible = false
		end if
	*/
		
	case 'F'
		
		tab_consegne.tabpage_inserimento.p_tok.visible = true
		tab_consegne.tabpage_inserimento.st_tok.visible = true
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_tok_a.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_s.visible = false
		else
			tab_consegne.tabpage_inserimento.rb_tok_a.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_s.visible = false
		end if
		
		tab_consegne.tabpage_inserimento.rb_tok_r.visible = false
//		if ls_oka = 'N' then
//			tab_consegne.tabpage_inserimento.rb_tok_a.enabled = false
//			tab_consegne.tabpage_inserimento.rb_tok_r.enabled = false
//			tab_consegne.tabpage_inserimento.rb_tok_s.enabled = false
//		end if

	case else
		
		tab_consegne.tabpage_inserimento.p_tok.visible = false
		tab_consegne.tabpage_inserimento.st_tok.visible = false
		if flag_er= 'S' then
			tab_consegne.tabpage_inserimento.rb_tok_a.visible = true
			tab_consegne.tabpage_inserimento.rb_tok_s.visible = false
		else
			tab_consegne.tabpage_inserimento.rb_tok_a.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_s.visible = false
		end if
		
		tab_consegne.tabpage_inserimento.rb_tok_r.visible = false
		if ls_oka <> 'N' /*= 'F'*/ then
			tab_consegne.tabpage_inserimento.rb_tok_a.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_r.visible = false
			tab_consegne.tabpage_inserimento.rb_tok_s.visible = false
		end if
		
end choose

return 0

end function

public function integer f_clear_flags ();int field_tot, i
field_tot = UpperBound ( tab_consegne.tabpage_inserimento.control[]  )

CheckBox curr_cbx

for i = 1 to field_tot
	
	if TypeOf ( tab_consegne.tabpage_inserimento.control[i] ) = CheckBox! then
		
		curr_cbx = tab_consegne.tabpage_inserimento.control[i] 
		curr_cbx.checked= false
		
	end if

next

return 0

end function

public subroutine f_check_flags ();int field_tot, i
field_tot = UpperBound ( tab_consegne.tabpage_inserimento.control[]  )

radiobutton local_rb

for i = 1 to field_tot
	
	if TypeOf ( tab_consegne.tabpage_inserimento.control[i] ) = radiobutton! then
		
		local_rb = tab_consegne.tabpage_inserimento.control[i] 
		local_rb.checked= false
		local_rb.visible= false
		
	end if

next

return

end subroutine

public subroutine f_clear_rb ();int li_controls, li_idx
li_controls = UpperBound ( tab_consegne.tabpage_inserimento.control[]  )

radiobutton local_rb

for li_idx = 1 to li_controls
	
	if TypeOf ( tab_consegne.tabpage_inserimento.control[li_idx] ) = radiobutton! then
		
		local_rb = tab_consegne.tabpage_inserimento.control[li_idx] 
		local_rb.checked= false
		local_rb.visible= false
		
	end if

next

return
end subroutine

public subroutine wf_ena_oka (boolean ab_enable);tab_consegne.tabpage_inserimento.rb_oka_a.enabled= ab_enable
tab_consegne.tabpage_inserimento.rb_oka_r.enabled= ab_enable
tab_consegne.tabpage_inserimento.rb_oka_s.enabled= ab_enable
tab_consegne.tabpage_inserimento.rb_oka_tok.enabled= ab_enable
end subroutine

public subroutine wf_ena_tok (boolean ab_enable);tab_consegne.tabpage_inserimento.rb_tok_a.enabled= ab_enable
tab_consegne.tabpage_inserimento.rb_tok_r.enabled= ab_enable
tab_consegne.tabpage_inserimento.rb_tok_s.enabled= ab_enable
end subroutine

on w_consegnesostituzioni.create
this.tab_consegne=create tab_consegne
this.hpb_conf=create hpb_conf
this.st_modify=create st_modify
this.dw_header=create dw_header
this.gb_2=create gb_2
this.Control[]={this.tab_consegne,&
this.hpb_conf,&
this.st_modify,&
this.dw_header,&
this.gb_2}
end on

on w_consegnesostituzioni.destroy
destroy(this.tab_consegne)
destroy(this.hpb_conf)
destroy(this.st_modify)
destroy(this.dw_header)
destroy(this.gb_2)
end on

event open;im_preview= create m_preview

is_evento_s.id= message.doubleParm

PostEvent ( "ue_open" )

// N.B. la data window di inserimento deve avere update properties con "key modification"= update
end event

event closequery;if tab_consegne.tabpage_inserimento.uodw_inserimento.uof_modificheincorso()= 3 then return 1
end event

event resize;tab_consegne.height= this.height - tab_consegne.y - 180

tab_consegne.tabpage_inserimento.gb_dett.height= tab_consegne.height - tab_consegne.tabpage_inserimento.gb_dett.y -180

tab_consegne.tabpage_inserimento.uodw_inserimento.height= tab_consegne.tabpage_inserimento.gb_dett.height - 90
end event

type tab_consegne from tab within w_consegnesostituzioni
event create ( )
event destroy ( )
integer x = 55
integer y = 376
integer width = 4233
integer height = 2504
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 81324524
boolean fixedwidth = true
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

event selectionchanging;choose case newindex
		
	case 1
		
	case 2
		
		tab_consegne.tabpage_inserimento.uodw_inserimento.setFilter("crimuovi = '1' ")
		
		tab_consegne.tabpage_inserimento.uodw_inserimento.filter()
		
		if tab_consegne.tabpage_inserimento.uodw_inserimento.rowCount() > 0 then
			
			messageBox(parent.title, "Alcuni elementi della lista sono marcati per la cancellazione ma non sono stati rimossi.~n"+&
											"Rimuovere gli elementi prima dell'aggiornamento..", exclamation!)
											
			tab_consegne.tabpage_inserimento.uodw_inserimento.setFilter("")
			tab_consegne.tabpage_inserimento.uodw_inserimento.filter()
		
			return 1
			
		end if
	
		tab_consegne.tabpage_inserimento.uodw_inserimento.setFilter("")
		tab_consegne.tabpage_inserimento.uodw_inserimento.filter()
		
		if tab_consegne.tabpage_inserimento.uodw_inserimento.uof_modificheincorso()= 3 then return 1
		
		tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.retrieve(is_evento_s.id)
		tab_consegne.tabpage_stampe.uodw_stampa_sostituzioni.height= tab_consegne.tabpage_stampe.height - 120
		
end choose



end event

type tabpage_inserimento from userobject within tab_consegne
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 4197
integer height = 2376
long backcolor = 81324524
string text = "Inserimento"
long tabtextcolor = 8388608
long tabbackcolor = 81324524
string picturename = "Insert!"
long picturemaskcolor = 536870912
cb_ripristina cb_ripristina
p_oma p_oma
rb_oma_s rb_oma_s
rb_oma_r rb_oma_r
rb_oma_a rb_oma_a
rb_tok_s rb_tok_s
rb_tok_r rb_tok_r
rb_tok_a rb_tok_a
rb_oka_tok rb_oka_tok
rb_oka_s rb_oka_s
rb_oka_r rb_oka_r
rb_oka_a rb_oka_a
st_oma st_oma
st_tok st_tok
st_oka st_oka
st_7 st_7
pb_nome pb_nome
cb_save cb_save
dw_anag dw_anag
gb_ricerca gb_ricerca
p_oka p_oka
p_tok p_tok
uodw_inserimento uodw_inserimento
gb_dett gb_dett
gb_okatagi gb_okatagi
gb_tokubetsu gb_tokubetsu
gb_omamori gb_omamori
end type

on tabpage_inserimento.create
this.cb_ripristina=create cb_ripristina
this.p_oma=create p_oma
this.rb_oma_s=create rb_oma_s
this.rb_oma_r=create rb_oma_r
this.rb_oma_a=create rb_oma_a
this.rb_tok_s=create rb_tok_s
this.rb_tok_r=create rb_tok_r
this.rb_tok_a=create rb_tok_a
this.rb_oka_tok=create rb_oka_tok
this.rb_oka_s=create rb_oka_s
this.rb_oka_r=create rb_oka_r
this.rb_oka_a=create rb_oka_a
this.st_oma=create st_oma
this.st_tok=create st_tok
this.st_oka=create st_oka
this.st_7=create st_7
this.pb_nome=create pb_nome
this.cb_save=create cb_save
this.dw_anag=create dw_anag
this.gb_ricerca=create gb_ricerca
this.p_oka=create p_oka
this.p_tok=create p_tok
this.uodw_inserimento=create uodw_inserimento
this.gb_dett=create gb_dett
this.gb_okatagi=create gb_okatagi
this.gb_tokubetsu=create gb_tokubetsu
this.gb_omamori=create gb_omamori
this.Control[]={this.cb_ripristina,&
this.p_oma,&
this.rb_oma_s,&
this.rb_oma_r,&
this.rb_oma_a,&
this.rb_tok_s,&
this.rb_tok_r,&
this.rb_tok_a,&
this.rb_oka_tok,&
this.rb_oka_s,&
this.rb_oka_r,&
this.rb_oka_a,&
this.st_oma,&
this.st_tok,&
this.st_oka,&
this.st_7,&
this.pb_nome,&
this.cb_save,&
this.dw_anag,&
this.gb_ricerca,&
this.p_oka,&
this.p_tok,&
this.uodw_inserimento,&
this.gb_dett,&
this.gb_okatagi,&
this.gb_tokubetsu,&
this.gb_omamori}
end on

on tabpage_inserimento.destroy
destroy(this.cb_ripristina)
destroy(this.p_oma)
destroy(this.rb_oma_s)
destroy(this.rb_oma_r)
destroy(this.rb_oma_a)
destroy(this.rb_tok_s)
destroy(this.rb_tok_r)
destroy(this.rb_tok_a)
destroy(this.rb_oka_tok)
destroy(this.rb_oka_s)
destroy(this.rb_oka_r)
destroy(this.rb_oka_a)
destroy(this.st_oma)
destroy(this.st_tok)
destroy(this.st_oka)
destroy(this.st_7)
destroy(this.pb_nome)
destroy(this.cb_save)
destroy(this.dw_anag)
destroy(this.gb_ricerca)
destroy(this.p_oka)
destroy(this.p_tok)
destroy(this.uodw_inserimento)
destroy(this.gb_dett)
destroy(this.gb_okatagi)
destroy(this.gb_tokubetsu)
destroy(this.gb_omamori)
end on

type cb_ripristina from commandbutton within tabpage_inserimento
integer x = 2766
integer y = 644
integer width = 594
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Ripristina lo stato iniziale"
end type

event clicked;string ls_er

ls_er= dw_anag.getItemString(1, "flag_er")

this.enabled= false
cb_save.enabled= false

wf_ena_oka(true)
wf_ena_tok(true)

return check_goh (ls_er )


end event

type p_oma from picture within tabpage_inserimento
boolean visible = false
integer x = 3424
integer y = 64
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "checkgreen.png"
boolean focusrectangle = false
end type

type rb_oma_s from radiobutton within tabpage_inserimento
integer x = 3488
integer y = 352
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Sostituzione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled
end event

type rb_oma_r from radiobutton within tabpage_inserimento
integer x = 3488
integer y = 264
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Restituzione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled
end event

type rb_oma_a from radiobutton within tabpage_inserimento
integer x = 3488
integer y = 176
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Acquisizione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled
end event

type rb_tok_s from radiobutton within tabpage_inserimento
integer x = 2903
integer y = 356
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sostituzione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled

wf_ena_oka(false)
end event

type rb_tok_r from radiobutton within tabpage_inserimento
integer x = 2903
integer y = 268
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Restituzione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled

wf_ena_oka(false)
end event

type rb_tok_a from radiobutton within tabpage_inserimento
integer x = 2903
integer y = 180
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Acquisizione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled

wf_ena_oka(false)
end event

type rb_oka_tok from radiobutton within tabpage_inserimento
integer x = 1938
integer y = 444
integer width = 681
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
string text = "Sostituzione con Tokubetsu"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled

wf_ena_tok(false)
end event

type rb_oka_s from radiobutton within tabpage_inserimento
integer x = 2277
integer y = 356
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
string text = "Sostituzione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled

wf_ena_tok(false)

end event

type rb_oka_r from radiobutton within tabpage_inserimento
integer x = 2277
integer y = 268
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
string text = "Restituzione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled

wf_ena_tok(false)

end event

type rb_oka_a from radiobutton within tabpage_inserimento
integer x = 2277
integer y = 180
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 81324524
string text = "Acquisizione"
boolean lefttext = true
end type

event clicked;cb_save.enabled= this.enabled
cb_ripristina.enabled= this.enabled

wf_ena_tok(false)

end event

type st_oma from statictext within tabpage_inserimento
boolean visible = false
integer x = 3520
integer y = 64
integer width = 288
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "( di famiglia )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_tok from statictext within tabpage_inserimento
boolean visible = false
integer x = 2894
integer y = 72
integer width = 338
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "( di famiglia )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_oka from statictext within tabpage_inserimento
boolean visible = false
integer x = 2062
integer y = 64
integer width = 288
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 81324524
string text = "( di famiglia )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within tabpage_inserimento
integer x = 1349
integer y = 76
integer width = 201
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Cerca..."
boolean focusrectangle = false
end type

type pb_nome from picturebutton within tabpage_inserimento
integer x = 1554
integer y = 36
integer width = 206
integer height = 128
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "CERCA_bface.bmp"
alignment htextalign = left!
end type

event clicked;string ls_er
s_ricerca s_ricerca_s

//open(w_part)

open(w_ricerca_associati_small)

s_ricerca_s= message.powerObjectParm

//if s_ricerca_s.i_retcode= -1 then goto errore

is_codice= s_ricerca_s.codice

if dw_anag.retrieve(is_codice) <= 0 then return 

ls_er= dw_anag.getItemString(1, "flag_er")

if check_goh (ls_er ) = -1 then return -1

//f_check_flags ( )

return 0




end event

type cb_save from commandbutton within tabpage_inserimento
integer x = 2766
integer y = 756
integer width = 594
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "&Aggiungi alla lista"
end type

event clicked;w_consegnesostituzioni.event ue_save()

uodw_inserimento.enabled= true
dw_anag.reset()

tab_consegne.tabpage_stampe.enabled= true

uodw_inserimento.object.b_aggiorna.visible= true

this.enabled= false
cb_ripristina.enabled= false

f_clear_rb()

p_oka.visible= false
p_oma.visible= false
p_tok.visible= false

st_oka.visible= false
st_oma.visible= false
st_tok.visible= false


end event

type dw_anag from datawindow within tabpage_inserimento
string tag = "Dettaglio"
integer x = 23
integer y = 56
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
integer height = 932
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Dati anagrafici"
end type

type p_oka from picture within tabpage_inserimento
boolean visible = false
integer x = 1957
integer y = 64
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "checkgreen.png"
boolean focusrectangle = false
end type

type p_tok from picture within tabpage_inserimento
boolean visible = false
integer x = 2811
integer y = 72
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "checkgreen.png"
boolean focusrectangle = false
end type

type uodw_inserimento from uodw_generica within tabpage_inserimento
integer x = 18
integer y = 992
integer width = 4105
integer height = 1364
integer taborder = 60
string dataobject = "dw_consegne_goh"
boolean ib_isgrid = true
end type

event buttonclicked;call super::buttonclicked;long ll_ret
string ls_note, ls_note_old, ls_codice

if this.getRow() <= 0 then return -1

choose case dwo.name
		
	case "b_aggiornalista"
		
//		this.setFilter("crimuovi = '1' ")
//		this.filter()
//		
//			ll_ret= this.rowCount()
//		
//		this.setFilter("")
//		this.filter()
//		
//		if ll_ret > 0 then
//			
//			messageBox(parent.text, "Alcuni elementi della lista sono marcati per la cancellazione ma non sono stati rimossi.~n"+&
//											"Rimuovere gli elementi prima dell'aggiornamento.", exclamation!)
//			
//			return 0
//	
//		end if
//		
//		ll_ret= uof_esegui(ic_aggiornamento)
//		
//		if ll_ret > 0 then this.object.b_aggiornalista.visible= false
			
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
		
	case "b_rimuovi" // corrisponde al bottone normalmente chiamato b_m, in questo caso la gestione è diversa...
		
		this.setRedraw(false)
		
		this.setFilter("crimuovi= '1' ") // cioè devono essere visibili le righe da cancellare... 
		this.filter()
		
		if this.rowCount() = 0 then goto ritorna // se nessuna riga è stata marcata per la cancellazione...
				
		if messageBox(parent.text, "Confermi la cancellazione?", question!, yesNo!, 2)= 2 then goto ritorna

		this.RowsMove(1, this.rowCount(), Primary!, this, 1, Delete!)
		
		ll_ret= uof_esegui(ic_aggiornamento)
		
		if ll_ret > 0 then this.object.b_aggiorna.visible= false
		
	ritorna:
		
		this.setFilter("")
		
		this.filter()
		
		this.setRedraw(true)
	
end choose
	
end event

event retrieveend;call super::retrieveend;//commit;

tab_consegne.tabpage_stampe.enabled= false
if rowcount > 0 then tab_consegne.tabpage_stampe.enabled= true

this.object.b_aggiorna.visible= false
//if rowcount > 0 then this.object.b_aggiornalista.visible= true

//this.Object.DataWindow.ReadOnly= "Yes"
end event

event itemchanged;call super::itemchanged;long ll_idx
string ls_codice, ls_filter

choose case dwo.name
		
	case "crimuovi"
		
		ls_codice= this.getItemString(row, "codice")
		
		ls_filter= "codice = '"+ls_codice+"' "
		this.setFilter(ls_filter)
		
		this.filter()
		
		for ll_idx= 1 to this.rowCount()
			this.setItem(ll_idx, "crimuovi", data)
		next
		
		this.setFilter("")
		this.filter()
		
	case "cod_causale"
	
		integer li_ret
		long ll_row, ll_count
		string ls_find
		
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
		
		this.scrollToRow(row)
		
		this.setRedraw(true)
	
		return li_ret

end choose

//this.object.b_aggiorna.visible= '1'
end event

event updateend;// non deve eseguire la script ancestor...
end event

type gb_dett from groupbox within tabpage_inserimento
integer y = 940
integer width = 4151
integer height = 1432
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 81324524
string text = "Nominativi in lista"
end type

type gb_okatagi from groupbox within tabpage_inserimento
integer x = 1911
integer y = 4
integer width = 841
integer height = 600
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Okatagi"
end type

type gb_tokubetsu from groupbox within tabpage_inserimento
integer x = 2766
integer y = 4
integer width = 594
integer height = 600
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Tokubetsu"
end type

type gb_omamori from groupbox within tabpage_inserimento
integer x = 3374
integer y = 4
integer width = 594
integer height = 600
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Omamori"
end type

type tabpage_stampe from userobject within tab_consegne
integer x = 18
integer y = 112
integer width = 4197
integer height = 2376
long backcolor = 81324524
string text = "Lista consegne / resi"
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
integer width = 3493
integer height = 2352
integer taborder = 40
string dataobject = "dw_stampa_sostituzioni"
boolean ib_isgrid = true
end type

event rbuttondown;call super::rbuttondown;im_preview.iuodw_generica= uodw_stampa_sostituzioni

im_preview.m_aggiungi.enabled= false
im_preview.m_rimuovi.enabled= false
im_preview.m_salva.enabled= false

im_preview.PopMenu ( w_consegnesostituzioni.PointerX(), w_consegnesostituzioni.PointerY() )
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "b_storico" then 

	if tab_consegne.tabpage_inserimento.uodw_inserimento.modifiedCount() > 0 or tab_consegne.tabpage_inserimento.uodw_inserimento.deletedCount() > 0 then
		messageBox(parent.text, "Modifiche da confermare in lista nominativi.", information!)
		return 0
	end if
	
	w_consegnesostituzioni.event ue_aggiorna()
	
	
end if
end event

type hpb_conf from vprogressbar within w_consegnesostituzioni
boolean visible = false
integer x = 4119
integer y = 928
integer width = 78
integer height = 560
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type st_modify from statictext within w_consegnesostituzioni
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

type dw_header from uodw_header within w_consegnesostituzioni
integer x = 55
integer width = 4603
integer height = 368
integer taborder = 30
end type

type gb_2 from groupbox within w_consegnesostituzioni
integer x = 1911
integer width = 841
integer height = 1104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 81324524
string text = "Consegne/Sostituzioni"
end type

