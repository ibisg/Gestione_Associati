$PBExportHeader$gestione_associati.sra
$PBExportComments$Generated Application Object
forward
global type gestione_associati from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
transaction sqlca_cap, sqlca_rga

// Colori
constant long gc_buttonface= rgb(236,233,216), gc_bianco= rgb(255,255,255), gc_grigiotestata= rgb(128,128,128), gc_blutestata= rgb(128,128,255)
constant long gc_rigadispari= rgb(235,246,255), gc_rigapari= rgb(255,255,255), gc_rigagrigia= rgb(247,247,247)

boolean gb_showreservedfields= false
boolean gb_formato_ricevuta_A5= false // formato ricevute OpC A4
//// da togleiere al più presto
//integer u_lev
//environment env

/*
 * Oggetto connessione
 */
 
n_connection db_connection
 
long max_livello
// Per compatibilità...
string non_attiva, nome_host, nome_applicazione,  gs_context, v_null
s_sqllogin s_sqllogin_s
//////////////////////////////

//long op

transaction sqlca_seg, sqlca_ediz

s_connect_par s_connect_par_s

// Strutture che descrivono la sessione utente

s_session s_session_s

string ga_approle[]


// Contiene le credenziali di accesso al servizio e il nome del gateway sms
s_sms s_sms_s

//string gs_pass

//enumerationDefinition ge_ga

// Init code CutePdf

string gs_cutepdf

// ambito operativo

string	gs_ambito, gs_title, gs_docdir, gs_librarypath, gs_basedir, gs_librarydir, gs_pblpath, gs_reportpath, gs_customreportpath, gs_smsgateway, gs_mailuser, gs_mailpw
string gs_webuser, gs_webpw, gs_news, gs_ambiti[]
// Carriage retrurn/ Line feed
constant string gc_crlf=char(13)+char(10)

// Stato eventi

constant integer gc_programmato= 0, gc_corrente= 1, gc_chiuso= 2, gc_corso= 11

// classi di utenza
constant integer 	gc_consn= 6, &
						gc_cons= 5, &
						gc_webuser=4, &
						gc_op= 3, &
						gc_superv= 2, &
						gc_dirseg= 1
						
// massimo livello di struttura
 integer gi_maxlivello, gi_numerolivellivisualizzati
 
 // livello di riferimento in selezione utenti_web
 constant integer gc_webrif= 6
 
 // DB
 
 constant integer gc_DBCOGE= 1, gc_DBSEG= 2, gc_DBEDIZ= 3, gc_DBCAP= 4 /*, DBCOGE= 1, DBSEG= 2, DBEDIZ= 3, DBCAP= 4*/
 
// tipo evento
constant integer 	ESAMI=5, &
						ENTRATA= 6, &
						CONSEGNA_SOSTITUZIONE= 7, &
						RECITAZIONE=8, &
						RIUNIONE= 9, &
						FUNERALE= 10, &
						CORSO= 11
// modalità operativa 
/*constant integer  	gc_estrazione= 1, &
						gc_annullaestrazione= 2, &
						gc_ricerca= 3, &
						gc_aggiornamento= 4, &
						gc_cancellazione= 5, &
						gc_impostapagina= 6, &
						gc_inserimento= 7, &
						gc_layout= 8, &
						gc_modificheincorso= 9, &
						gc_next= 10, &
						gc_print= 11, &
						gc_prior= 12, &
						gc_reset= 13, &
						gc_struttura= 14, &
						gc_zoom= 15, &
						gc_aggiungi= 16*/
						
integer gi_maxlenstruttura, gi_classediutenza

string ragione_sociale, indirizzo, cap_citta, gs_nome_applicazione, gs_mailpath
end variables
global type gestione_associati from application
string appname = "gestione_associati"
string dwmessagetitle = "Gestione associati"
string displayname = "GA"
long richtextedittype = 0
long richtexteditversion = 0
string richtexteditkey = ""
end type
global gestione_associati gestione_associati

type prototypes
FUNCTION boolean SetCurrentDirectoryW(ref string cdir) LIBRARY "kernel32.dll"
Function long ShellExecuteA (ulong hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd) library "shell32.dll" alias for "ShellExecuteA;Ansi" 
FUNCTION long GetCurrentDirectoryW( long length , ref string path) LIBRARY "KERNEL32"
FUNCTION integer SendBlat( string sendString) LIBRARY "blat.dll" alias for "Send;Ansi"

Function ulong GetEnvironmentVariableW(string lpName, Ref string lpBuffer, ulong nSize) Library "kernel32.dll" /*Alias For "GetEnvironmentVariableW"*/



end prototypes

type variables


end variables

on gestione_associati.create
appname="gestione_associati"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on gestione_associati.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;environment env
string ls_rlogin, ls_rpwd, ls_rserver, ls_user, ls_pwd, ls_displayName, ls_ambito, ls_source, ls_sigla, ls_message
long ll_row= 1
int li_found, li_random, li_inisection, li_id= 1, li_ret
dataStore lds_getrole
s_connection s_connection_s

this.displayName= "Gestione associati"

//open(w_splash)

if ProfileString ( "connection.ini", "log", "manutenzione",	"N")= 'S' then
	
	open(w_manutenzione)
	
end if

/*
 *  Crea l'oggetto connessione
 */
 
 db_connection= create n_connection

// da inserire in .ini
gs_docdir = ProfileString ( "connection.ini", "percorsi", "basedir",	".\docs")

gs_cutepdf = ProfileString ( "connection.ini", "percorsi", "cutepdf", "")

gs_pblpath= ProfileString ( "connection.ini", "percorsi", "pblpath", "")

gs_reportpath= ProfileString ( "connection.ini", "percorsi", "reportpath", "")

gs_customreportpath= ProfileString ( "connection.ini", "percorsi", "customreportpath", "")

gs_mailpath=  ProfileString ( "connection.ini", "percorsi", "mailpath", "")

s_sms_s.as_smsgateway= ProfileString ( "connection.ini", "percorsi", "smsgateway", "")

s_sms_s.as_smtp= ProfileString ( "connection.ini", "percorsi", "smssmtp", "")

s_sms_s.as_mailuser= ProfileString ( "connection.ini", "percorsi", "mailuser", "")

s_sms_s.as_mailpw= ProfileString ( "connection.ini", "percorsi", "mailpw", "")

s_sms_s.as_mailfrom= ProfileString ( "connection.ini", "percorsi", "mailfrom", "")

s_sms_s.as_smsfrom= ProfileString ( "connection.ini", "percorsi", "smsfrom", "")

s_sms_s.as_smsuser= ProfileString ( "connection.ini", "percorsi", "smsuser", "")

s_sms_s.as_smspw= ProfileString ( "connection.ini", "percorsi", "smspw", "")

s_sms_s.ai_maxnames= integer(ProfileString ( "connection.ini", "percorsi", "maxnames", "") )

gs_webuser= ProfileString ( "connection.ini", "percorsi", "webuser", "")

gs_webpw= ProfileString ( "connection.ini", "percorsi", "webpw", "")

gs_news= ProfileString ( "connection.ini", "log", "news", 'N')

// Assegnazione dell'ambito operativo correlato alla dipendenza, 

s_session_s.cod_dip= ProfileString ( "connection.ini", "localizzazione", "dipendenza", "")

// Esegue il login, acquisisce i dati utente e host dal registry...

s_session_s.context="Login"
Randomize(0)
li_random= rand(1000)
s_session_s.session= fill ( "0", 4 - len(string(li_random))) + string(li_random) // identificatore di sessione

s_session_s.appname= "GA"
s_session_s.t_sqlca= sqlca

s_dbparms ls_dbparms
ls_dbparms.t_sqlca= sqlca
ls_dbparms.li_inisection= gc_DBSEG

openWithParm(w_login, ls_dbparms )

s_connection_s= message.powerObjectParm

if s_connection_s.ai_return= -1 then return // qualcosa non è andato bene nel login...

/*
 * inizio verifica nome host...
 */
	
	/*
	  * Se siamo in ambiente RDS il nome del client è in una variabile ambientale di nome CLIENTNAME...
	  * altrimenti è in una voce di registry, vedi la funzione f_getwinuser()...
	  */
	
		ContextKeyword lcxk_base
		string ls_var
		string ls_values[]
		
		this.GetContextService("Keyword", lcxk_base)
		lcxk_base.GetContextKeywords("clientname", ls_values)
		IF Upperbound(ls_values) > 0 THEN
			ls_var = ls_values[1]
		ELSE
			ls_var = "UNDEFINED"
		END IF
		
		if ls_var <> 'UNDEFINED' then
			s_session_s.host= ls_var
		end if

/*
 * fine verifica nome host...
 */
 
// Verifica che l'utente non sia già connesso all'applicazione

if f_verifica_sessioni() <> 0 then HALT CLOSE

if s_session_s.s_utente_s.s_nome_esteso= "" then s_session_s.s_utente_s.s_nome_esteso= s_session_s.s_utente_s.s_nome

//s_session_s.s_utente_s= s_utente_s

//s_session_s.host= s_utente_s.s_host

/*
 * qui controlla che ci siano le abilitazioni all'uso di GA...
 * Se l'utente non è abilitato per GA/RGA/OpC  esce...
 */

if s_session_s.s_utente_s.i_ruolo_ga= 0 then
	ls_message= s_session_s.causale+" - "+s_session_s.s_utente_s.s_nome_esteso+" L'utente non è abilitato per l'accesso al gestionale."
	messageBox("GA", "Utente non abilitato.")			
	HALT CLOSE
end if	

// Accettazione del regolamento trattamento dati...

li_ret= f_verificaaccettazione()

if li_ret <> 0 then HALT CLOSE

if f_approle()= -1 then return

//db_connection= s_connection_s.an_connection //?????

this.microHelpDefault = ls_displayName

// cioè il livello di gruppo...
select MAX(livello) into :gi_maxlivello from struttura_livelli;
if trap_sql(sqlca, "CONNECT05") < 0 then return

if s_session_s.s_utente_s.i_ruolo_ga > 0 then
		
	choose case s_session_s.s_utente_s.s_ambito
			
			/*
			 * La variabile s_session_s.s_utente_s.s_ambito corrispondente al campo di db flag_ambito nella tabella utenti_web
			 * può assumere i valori D/C/T dove:
			 * D indica che l'ambito operativo sarà quello indicato nella tabella dipendenze
			 * C indica che l'ambito operativo sarà quello corrispondente alla competenza istituzionale
			 * T tutta la struttura
			 *
			 */
	
		case "C" 	// competenza istituzionale
		
			string ls_parent
			integer li_livello
			
				select m.vc_parent, a.livello
				into :ls_parent, :li_livello
				from membri_gerarchica m, att_ist a
				where 
				m.cod_att_ist_1= a.cod_att_ist and
				m.codice=  :s_session_s.s_utente_s.s_logname; // s_nome corrisponde al codice personale...
				
				if trap_sql(sqlca, "CONNECT6.1") < 0 then return	
				
				if li_livello= 0 then
					
					messageBox("GA", "Non è possibile assegnare un ambito operativo all'utente", exclamation!)
					HALT CLOSE
					
				end if
				
				gs_ambito= f_parse_struttura_left(ls_parent, li_livello)
				gs_ambiti[1]= gs_ambito
				ls_ambito= "Ambito operativo: competenza"
				
				if trap_sql(sqlca, "CONNECT6.2") < 0 then return	
		
			case "D" // ambito della dipendenza
	
				select vc_nodo
				into :gs_ambito
				from dipendenze
				where cod_dip=  :s_session_s.cod_dip;
			
				if trap_sql(sqlca, "CONNECT07") < 0 then return
				
				ls_source= gs_ambito
				
				do while ls_source <> ""
				
					gs_ambiti[ll_row]= f_get_token(ls_source, ",")
					ll_row++
				
				loop				
				
				// Verifica l'esistenza della struttura che definisce l'ambito operativo
				
//				select vc_nodo
//				into :ls_ambito
//				from struttura
//				where vc_nodo= :gs_ambito;
//				
//				if trap_sql(sqlca, "CONNECT07.1") < 0 then return
//				
//				if sqlca.sqlcode= 100 then 
//				
//					messageBox("Attribuzione ambito operativo", "Struttura non esistente: "+gs_ambito)
//					return
//				
//			    end if
				 
				 ls_ambito= "Ambito operativo: dipendenza"
				 
			case "T" // tutta la struttura
				
				select vc_nodo into :gs_ambito  from struttura where livello= 1; // cioè il nodo root= 'IT'
				if trap_sql(sqlca, "CONNECT06.3") < 0 then return
				
				gs_ambiti[1]= gs_ambito
				
				ls_ambito= "Ambito operativo: tutta la struttura"
			
			case else
			
				messageBox("Attribuzione ambito operativo", "Valore non valido ambito operativo.")
				return
		
	end choose
	
end if

gs_title= " - Utente "+f_iniziali(s_session_s.s_utente_s.s_nome_esteso)+", Gruppo: "+s_session_s.s_utente_s.s_gruppo+" - "+ls_ambito+" - Collegato da "+s_session_s.cod_dip+" - Host: "+s_session_s.host

this.microHelpDefault = gs_title
open(w_frame_gestioneassociati)

m_frame_gestione_associati.m_eventi.m_pianificazioneeventi.enabled= f_has_p('O')
m_frame_gestione_associati.m_eventi.m_gestioneesami.m_gestionesessioni.enabled= f_has_p('O')
m_frame_gestione_associati.m_eventi.m_gestioneesami.m_stampadiplomi.enabled= f_has_p('O')
m_frame_gestione_associati.m_struttura.m_doppiinserimenti.enabled= f_has_p('O')
m_frame_gestione_associati.m_struttura.m_report.enabled= f_has_p('O')

if f_invio_liste_privilege()= TRUE OR (f_has_p('S') = true) then
	m_frame_gestione_associati.m_comunicazioni.enabled= true
else
	m_frame_gestione_associati.m_comunicazioni.enabled= false
end if

if f_invio_liste_privilege()= TRUE OR (f_has_p('S') = true) then
	m_frame_gestione_associati.m_comunicazioni.m_gestioneliste.enabled= true
else
	m_frame_gestione_associati.m_comunicazioni.m_gestioneliste.enabled= false
end if

if f_invio_liste_privilege()= TRUE OR (f_has_p('S') = true) then
	m_frame_gestione_associati.m_comunicazioni.m_invio.enabled= true
else
	m_frame_gestione_associati.m_comunicazioni.m_invio.enabled= false
end if

if f_invio_liste_privilege()= TRUE OR (f_has_p('S') = true) then
	m_frame_gestione_associati.m_comunicazioni.m_storicoinvii.enabled= true
else
	m_frame_gestione_associati.m_comunicazioni.m_storicoinvii.enabled= false
end if

if f_fs_privilege()= TRUE OR (f_has_p('S') = true) then
	m_frame_gestione_associati.m_amministrazione.m_gestionedimissionari.enabled= true
	m_frame_gestione_associati.m_amministrazione.m_gestionemembriisg.enabled= true
else
	m_frame_gestione_associati.m_amministrazione.m_gestionedimissionari.enabled= false
	m_frame_gestione_associati.m_amministrazione.m_gestionemembriisg.enabled= false
end if


m_frame_gestione_associati.m_amministrazione.enabled= f_has_p('O')
m_frame_gestione_associati.m_amministrazione.m_ambitooperativo.enabled= f_has_p('D')
m_frame_gestione_associati.m_amministrazione.m_gestionedeceduti.enabled= f_has_p('O')
m_frame_gestione_associati.m_amministrazione.m_gestionetrasferitidefinitivamenteallestero.enabled= FALSE //f_has_p('O')
m_frame_gestione_associati.m_amministrazione.m_gestionemembriisg.enabled= f_has_p('S')
m_frame_gestione_associati.m_amministrazione.m_gestionedepositogohonzon.enabled= f_has_p('S')
m_frame_gestione_associati.m_amministrazione.m_sessioniattive.enabled= f_has_p('S')
m_frame_gestione_associati.m_amministrazione.m_utenti_web.enabled= f_has_p('S')

if f_has_p('S') OR f_organi_privilege()= TRUE then
	m_frame_gestione_associati.m_organi.enabled= TRUE
else
	m_frame_gestione_associati.m_organi.enabled= FALSE
end if

return
end event

event close;if sqlca.dbhandle() > 0 then
		
	// connessione al db edizioni	
	db_connection.uof_disconnectdb(sqlca)
	
end if
	
return


end event

