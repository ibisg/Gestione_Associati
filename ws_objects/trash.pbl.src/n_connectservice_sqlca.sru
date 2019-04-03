$PBExportHeader$n_connectservice_sqlca.sru
$PBExportComments$Generated Database Connection Service
forward
global type n_connectservice_sqlca from nonvisualobject
end type
end forward

global type n_connectservice_sqlca from nonvisualobject
end type
global n_connectservice_sqlca n_connectservice_sqlca

type variables
s_connection_parm is_connection_parm_s
string is_connectfrom = "1"

CONSTANT string IS_USE_INIFILE 	= "1"
CONSTANT string IS_USE_REGISTRY	= "2"
CONSTANT string IS_USE_SCRIPT 	= "3"
end variables

forward prototypes
public function integer of_disconnectdb ()
public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit)
public function integer of_connectdb ()
end prototypes

public function integer of_disconnectdb ();//*--------------------------------------------------------*/
//*  Disconnect from database
//*--------------------------------------------------------*/
/*  Actual DB disconnection */
Disconnect using SQLCA;

If SQLCA.SQLCode <> 0 Then
	MessageBox ("Cannot Disconnect to Database", SQLCA.SQLErrText )
End If

Return SQLCA.SQLCode
end function

public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit);////*--------------------------------------------------------*/
//*  The source of connection information can be changed by
//*  altering the value of the 'is_connectfrom' variable.
//*--------------------------------------------------------*/
Choose Case is_connectfrom
		
	Case IS_USE_INIFILE						/*  Populate Database Connection from INI file  */
		string ls_inifile = "connection.ini"
		
		as_dbms			= ProfileString ( ls_inifile, "DBSegreteria", "DBMS",			"MSS Microsoft SQL Server 6.x")
		as_database	= ProfileString ( ls_inifile, "DBSegreteria", "Database",		"ga")
		as_userid		= ProfileString ( ls_inifile, "DBSegreteria", "UserID",		"")
		as_dbpass		= ProfileString ( ls_inifile, "DBSegreteria", "DBPass",		"")
		as_logid			= ProfileString ( ls_inifile, "DBSegreteria", "LogID",			"")
		as_logpass		= ProfileString ( ls_inifile, "DBSegreteria", "LogPassword",	"")
		as_server		= ProfileString ( ls_inifile, "DBSegreteria", "Servername",	"")
		as_dbparm		= ProfileString ( ls_inifile, "DBSegreteria", "DBParm",		"Language='italiano',CommitOnDisconnect='No',Async=1")
		as_lock			= ProfileString ( ls_inifile, "DBSegreteria", "Lock",			"")
		as_autocommit	= ProfileString ( ls_inifile, "DBSegreteria", "AutoCommit",	"false")

	Case IS_USE_REGISTRY						/*  Populate Database Connection from Registry  */
		string ls_registrykey = "" + "\DataBase"
		
		If RegistryGet ( ls_registrykey, "DBMS", 			RegString!, as_dbms ) <> 1 Then
			RegistrySet ( ls_registrykey, "DBMS", 			RegString!, "MSS Microsoft SQL Server 6.x" )
			RegistryGet ( ls_registrykey, "DBMS", 			RegString!, as_dbms )
		End If
		If RegistryGet ( ls_registrykey, "Database", 	RegString!, as_database ) <> 1 Then
			RegistrySet ( ls_registrykey, "Database", 	RegString!, "ga" )
			RegistryGet ( ls_registrykey, "Database", 	RegString!, as_database )
		End If
		If RegistryGet ( ls_registrykey, "UserID", 		RegString!, as_userid ) <> 1 Then
			RegistrySet ( ls_registrykey, "UserID", 		RegString!, "" )
			RegistryGet ( ls_registrykey, "UserID", 		RegString!, as_userid )
		End If
		If RegistryGet ( ls_registrykey, "DBPass", 		RegString!, as_dbpass ) <> 1 Then
			RegistrySet ( ls_registrykey, "DBPass", 		RegString!, "" )
			RegistryGet ( ls_registrykey, "DBPass", 		RegString!, as_dbpass )
		End If
		If RegistryGet ( ls_registrykey, "LogID", 		RegString!, as_logid ) <> 1 Then
			RegistrySet ( ls_registrykey, "LogID", 		RegString!, "sa" )
			RegistryGet ( ls_registrykey, "LogID", 		RegString!, as_logid )
		End If
		If RegistryGet ( ls_registrykey, "LogPassword", RegString!, as_logpass ) <> 1 Then
			RegistrySet ( ls_registrykey, "LogPassword", RegString!, "assicurato" )
			RegistryGet ( ls_registrykey, "LogPassword", RegString!, as_logpass )
		End If
		If RegistryGet ( ls_registrykey, "Servername", 	RegString!, as_server ) <> 1 Then
			RegistrySet ( ls_registrykey, "Servername", 	RegString!, "localhost" )
			RegistryGet ( ls_registrykey, "Servername", 	RegString!, as_server )
		End If
		If RegistryGet ( ls_registrykey, "DBParm", 		RegString!, as_dbparm ) <> 1 Then
			RegistrySet ( ls_registrykey, "DBParm", 		RegString!, "Language='italiano',CommitOnDisconnect='No',Async=1" )
			RegistryGet ( ls_registrykey, "DBParm", 		RegString!, as_dbparm )
		End If
		If RegistryGet ( ls_registrykey, "Lock", 			RegString!, as_lock ) <> 1 Then
			RegistrySet ( ls_registrykey, "Lock", 			RegString!, "" )
			RegistryGet ( ls_registrykey, "Lock", 			RegString!, as_lock )
		End If
		If RegistryGet ( ls_registrykey, "AutoCommit", 	RegString!, as_autocommit ) <> 1 Then
			RegistrySet ( ls_registrykey, "AutoCommit", 	RegString!, "false" )
			RegistryGet ( ls_registrykey, "AutoCommit", 	RegString!, as_autocommit )
		End If

	Case IS_USE_SCRIPT							/*  Populate Database Connection from Script  */
		as_dbms			= "MSS Microsoft SQL Server 6.x"
		as_database		= "ga"
		as_userid		= ""
		as_dbpass		= ""
		as_logid			= "sa"
		as_logpass		= "assicurato"
		as_server		= "localhost"
		as_dbparm		= "Language='italiano',CommitOnDisconnect='No',Async=1"
		as_lock			= ""
		as_autocommit	= "false"

		
	Case Else
		
		Return -1
		
End Choose

Return 1
end function

public function integer of_connectdb ();//*--------------------------------------------------------*/
//*  Make a connection to the database
//*--------------------------------------------------------*/

// Assegna gli eventuali valori passati dalla linea di comando... ( vedi funzione f_cmdline )

if NOT isNull(is_connection_parm_s.dbms) then sqlca.dbms= is_connection_parm_s.dbms
if NOT isNull(is_connection_parm_s.database) then sqlca.database= is_connection_parm_s.database
if NOT isNull(is_connection_parm_s.server) then sqlca.serverName= is_connection_parm_s.server
if NOT isNull(is_connection_parm_s.dip) then gs_dip_operativa= is_connection_parm_s.dip
if NOT isNull(is_connection_parm_s.lock) then sqlca.lock= is_connection_parm_s.lock
if NOT isNull(is_connection_parm_s.dbParm) then sqlca.dbParm= is_connection_parm_s.dbParm


/*  Actual DB connection */

CONNECT USING SQLCA;

If SQLCA.SQLCode <> 0 Then
	MessageBox (" Errore SQL: "+string(sqlca.sqlcode), "Non riesco a connettermi al Database: "+upper(sqlca.database)+'~n'+SQLCA.SQLErrText )
	return -1
End If

Return 0
end function

event constructor;//*--------------------------------------------------------*/
//*  Connection Information is obtained from either:
//*			- An INI File
//*			- The Windows Registry
//*			- Script
//*
//*  The source of connection information can be changed by
//*  altering the value of the 'is_connectfrom' variable.
//*--------------------------------------------------------*/
string ls_dbms, ls_database, ls_userid, ls_dbpass, ls_logid, ls_logpass
string ls_server, ls_dbparm, ls_lock, ls_autocommit
string ls_cmdline

If of_GetConnectionInfo ( ls_dbms, ls_database, ls_userid, ls_dbpass, ls_logid, ls_logpass, ls_server, ls_dbparm, ls_lock, ls_autocommit ) = 1 Then
	
	SQLCA.DBMS			= ls_dbms
	SQLCA.Database		= ls_database
	SQLCA.UserID			= ls_userid
	SQLCA.DBPass		= ls_dbpass
	SQLCA.LogID			= ls_logid
	SQLCA.LogPass		= ls_logpass
	SQLCA.ServerName	= ls_server
	SQLCA.DBParm		= ls_dbparm
	SQLCA.Lock			= ls_lock
	Choose Case Lower ( ls_autocommit ) 
		Case "1", "true", "on", "yes"
			SQLCA.AutoCommit	= True
		Case "0", "false", "off", "no"
			SQLCA.AutoCommit	= False
		Case Else
			SQLCA.AutoCommit	= False
	End Choose
	
End If



end event

on n_connectservice_sqlca.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_connectservice_sqlca.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

