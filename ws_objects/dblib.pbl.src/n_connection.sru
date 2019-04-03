$PBExportHeader$n_connection.sru
forward
global type n_connection from nonvisualobject
end type
end forward

global type n_connection from nonvisualobject
end type
global n_connection n_connection

type variables
s_connectionparm is_connectionparm_s
end variables

forward prototypes
public subroutine uof_cmdline (string as_cmdline)
public function integer uof_disconnectdb (transaction asqlca)
public subroutine uof_getinipar (integer ai_db)
public function integer uof_connectdb (ref transaction asqlca)
end prototypes

public subroutine uof_cmdline (string as_cmdline);integer li_count
string ls_switch, ls_token, ls_cmd

setNull(is_connectionparm_s.dbms)
setNull(is_connectionparm_s.database)
setNull(is_connectionparm_s.server)
setNull(is_connectionparm_s.dbtype)
setNull(is_connectionparm_s.dbParm)			
setNull(is_connectionparm_s.dip)

// GdS 03.06.2005: legge la linea di comando per ricavare i parametri di connessione di default...

do while as_cmdline <> ""
	
	ls_token= trim(f_get_token(as_cmdline, "-"))
	
	if ls_token= "" then continue
	
	ls_switch= mid(ls_token, 1, 1)
	ls_cmd= mid(ls_token, 2, len(ls_token) - 1 )

	choose case ls_switch
			
		case 's' // DBMS
			
			is_connectionparm_s.dbms= ls_cmd
			
		case 'd' // DATABASE
			
			is_connectionparm_s.database= ls_cmd
			
		case 'v' // SERVER
			
			is_connectionparm_s.server= ls_cmd
			
		case 't' // DBTYPE
			
			is_connectionparm_s.dbtype= ls_cmd	
			
		case 'p' // DBPARM
			
			is_connectionparm_s.dbParm= ls_cmd				
			
		case 'o' // DIPENDENZA OPERATIVA
			
			is_connectionparm_s.dip= ls_cmd
			
			
	end choose

loop

return
end subroutine

public function integer uof_disconnectdb (transaction asqlca);/* 
 * DB disconnection 
 */
Disconnect using asqlca;

If asqlca.SQLCode <> 0 Then
	MessageBox ("Errore in disconnessione dal DB", asqlca.SQLErrText )
End If

Return asqlca.SQLCode
end function

public subroutine uof_getinipar (integer ai_db);boolean lb_primarydb
string ls_inifile = "connection.ini", ls_db

/*
 * Se i parametri letti da linea di comando sono nulli, utilizza quelli definiti nel file .ini
 */
 
choose case ai_db
		
	case gc_DBCOGE
		
		ls_db= "DBCOGE"
		
	case gc_DBSEG
		
		ls_db= "DBSEG"
		
	case gc_DBEDIZ
		
		ls_db= "DBEDIZ"
		
end choose

Choose Case Lower ( ProfileString ( ls_inifile, ls_db, "primarydb",	"false") ) 
	Case "1", "true", "on", "yes"
		lb_primarydb= True
	Case "0", "false", "off", "no"
		lb_primarydb= False
	Case Else
		lb_primarydb= False
End Choose

setNull(is_connectionparm_s.dbms)			
setNull(is_connectionparm_s.database)
setNull(is_connectionparm_s.server)
setNull(is_connectionparm_s.dbtype)
setNull(is_connectionparm_s.dbparm)	
setNull(is_connectionparm_s.lock)
setNull(is_connectionparm_s.autocommit) 

if isNull(is_connectionparm_s.dbms)			then is_connectionparm_s.dbms			= ProfileString ( ls_inifile, ls_db, "DBMS", "")
if isNull(is_connectionparm_s.database)	then is_connectionparm_s.database 	= ProfileString ( ls_inifile, ls_db, "Database","")
if isNull(is_connectionparm_s.server)		then is_connectionparm_s.server		= ProfileString ( ls_inifile, ls_db, "Servername",	"")
if isNull(is_connectionparm_s.dbtype) 		then is_connectionparm_s.dbtype		= ProfileString ( ls_inifile, ls_db, "DBTYPE",	"")
if isNull(is_connectionparm_s.dbparm)		then is_connectionparm_s.dbparm		= ProfileString ( ls_inifile, ls_db, "DBParm", "Database='"+is_connectionparm_s.database+"','Language='italiano',CommitOnDisconnect='No',Async=1")
		
is_connectionparm_s.dbparm = "Database='"+is_connectionparm_s.database+"', "+is_connectionparm_s.dbparm
	
if isNull(is_connectionparm_s.lock) 			then is_connectionparm_s.lock			= ProfileString ( ls_inifile, ls_db, "Lock",	"RU")
if isNull(is_connectionparm_s.autocommit) then is_connectionparm_s.autocommit	= ProfileString ( ls_inifile, ls_db, "AutoCommit",	"false")


if isNull(is_connectionparm_s.dip) 			then is_connectionparm_s.dip				= ProfileString ( ls_inifile, "LOCALIZZAZIONE", "DIPENDENZA",	"")

return 
end subroutine

public function integer uof_connectdb (ref transaction asqlca);// messageBox("Connection",  is_connectionparm_s.dbtype)

choose case  is_connectionparm_s.dbtype
		
	case "MSS"

		asqlca.dbms= is_connectionparm_s.dbms
		asqlca.database= is_connectionparm_s.database
		asqlca.servername= is_connectionparm_s.server
		asqlca.dbparm= is_connectionparm_s.dbparm
		asqlca.lock= is_connectionparm_s.lock
		asqlca.logid= is_connectionparm_s.logid
		asqlca.logpass= is_connectionparm_s.logpass
		
		Choose Case Lower ( is_connectionparm_s.autocommit ) 
			Case "1", "true", "on", "yes"
				asqlca.AutoCommit	= True
			Case "0", "false", "off", "no"
				asqlca.AutoCommit	= False
			Case Else
				asqlca.AutoCommit	= False
		End Choose
		
	case "ODBC"
		
	case "SYBASE"
		
		asqlca.dbms= is_connectionparm_s.dbms
		asqlca.database= is_connectionparm_s.database
		asqlca.servername= is_connectionparm_s.server
		asqlca.dbparm= is_connectionparm_s.dbparm
		asqlca.lock= is_connectionparm_s.lock
		asqlca.logid= is_connectionparm_s.logid
		asqlca.logpass= is_connectionparm_s.logpass
		
		Choose Case Lower ( is_connectionparm_s.autocommit ) 
			Case "1", "true", "on", "yes"
				asqlca.AutoCommit	= True
			Case "0", "false", "off", "no"
				asqlca.AutoCommit	= False
			Case Else
				asqlca.AutoCommit	= False
		End Choose

end choose

/* 
 * DB connection 
 */
Connect using asqlca;

If asqlca.SQLCode <> 0 Then
	MessageBox ("Errore in connessione al DB: "+is_connectionparm_s.database, asqlca.SQLErrText )
End If

Return asqlca.SQLCode
end function

on n_connection.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_connection.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

