$PBExportHeader$rga.sra
$PBExportComments$Generated Application Object
forward
global type rga from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
/*
 * Oggetto connessione
 */
 
n_connection db_connection

 constant integer gc_DBCOGE= 1, gc_DBSEG= 2, gc_DBEDIZ= 3/*, DBCOGE= 1, DBSEG= 2, DBEDIZ= 3*/
 
 string gs_dip_operativa, gs_ambito, ls_parent, gs_news, gs_webuser="webseg", gs_webpw="assicurato"
s_session s_session_s

string ga_approle[]

s_utente s_utente_s

integer gi_classediutenza


end variables
global type rga from application
string appname = "rga"
end type
global rga rga

type variables

end variables

on rga.create
appname="rga"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on rga.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;environment env
string ls_rlogin, ls_rpwd, ls_rserver, ls_user, ls_pwd, ls_displayName, ls_ambito
long ll_row
int li_found, li_random, li_inisection
dataStore lds_getrole
s_connection s_connection_s

this.displayName= "Gestione remota associati"

//open(w_splash)

if ProfileString ( "connection.ini", "log", "manutenzione",	"N")= 'S' then
	
	open(w_manutenzione)
	
end if

/*
 *  Crea l'oggetto connessione
 */
 
 db_connection= create n_connection


// Assegnazione dell'ambito operativo

gs_dip_operativa= ProfileString ( "connection.ini", "localizzazione", "dipendenza", "")

// Esegue il login, acquisisce i dati utente e host dal registry...

s_session_s.context="Login"
Randomize(0)
li_random= rand(1000)
s_session_s.session= fill ( "0", 4 - len(string(li_random))) + string(li_random) // identificatore di sessione
//s_session_s.cod_dip= gs_dip_operativa

		//s_session_s.appname= "GA"

openWithParm(w_login, gc_DBSEG )

s_connection_s= message.powerObjectParm
s_utente_s= s_connection_s.as_utente_s

if s_utente_s.s_nome_esteso= "" then s_utente_s.s_nome_esteso= s_utente_s.s_nome

s_session_s.s_utente_s= s_utente_s
s_session_s.host= s_utente_s.s_host
s_session_s.cod_dip= s_utente_s.s_dip_operativa
gs_dip_operativa= s_utente_s.s_dip_operativa

db_connection= s_connection_s.an_connection

if s_utente_s.id_gruppo= -1 then HALT CLOSE

if s_utente_s.s_dip_operativa <> "" then gs_dip_operativa= s_utente_s.s_dip_operativa

this.microHelpDefault = ls_displayName

// ruolo associato all'utente
gi_classediutenza= s_utente_s.id_gruppo


				
				gs_ambito= f_parse_struttura_left(ls_parent,5 /* li_livello*/)
		
// Riempie un array con le sigle corrispondenti alle classi di utenza
if f_approle()= -1 then return
				

 this.microHelpDefault ="Utente "+f_iniziali(s_utente_s.s_nome_esteso)+", Gruppo: "+s_utente_s.s_gruppo+" - Collegato da "+s_session_s.cod_dip+" - Host: "+s_session_s.host

open(w_rga_membri)
//open(w_rilevamento_presenze)


end event

