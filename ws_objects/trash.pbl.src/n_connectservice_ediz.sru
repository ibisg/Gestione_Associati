$PBExportHeader$n_connectservice_ediz.sru
$PBExportComments$Generated Database Connection Service
forward
global type n_connectservice_ediz from nonvisualobject
end type
end forward

global type n_connectservice_ediz from nonvisualobject
end type
global n_connectservice_ediz n_connectservice_ediz

type variables
string is_connectfrom = "1"

CONSTANT string IS_USE_INIFILE 	= "1"
CONSTANT string IS_USE_REGISTRY	= "2"
CONSTANT string IS_USE_SCRIPT 	= "3"
end variables

forward prototypes
public function integer of_connectdb ()
public function integer of_disconnectdb ()
public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit)
end prototypes

public function integer of_connectdb ();//*--------------------------------------------------------*/
//*  Make a connection to the database
//*--------------------------------------------------------*/
/*  Actual DB connection */
Connect using sqlca_ediz;

If sqlca_ediz.SQLCode <> 0 Then
	MessageBox ("Non riesco a connettermi al Database Edizioni", sqlca_ediz.SQLErrText )
End If

Return sqlca_ediz.SQLCode
end function

public function integer of_disconnectdb ();//*--------------------------------------------------------*/
//*  Disconnect from database
//*--------------------------------------------------------*/
/*  Actual DB disconnection */
Disconnect using sqlca_ediz;

If sqlca_ediz.SQLCode <> 0 Then
	MessageBox ("Cannot Disconnect to Database", sqlca_ediz.SQLErrText )
End If

Return sqlca_ediz.SQLCode
end function

public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit);//*--------------------------------------------------------*/
//*  The source of connection information can be changed by
//*  altering the value of the 'is_connectfrom' variable.
//*--------------------------------------------------------*/
Choose Case is_connectfrom
		
	Case IS_USE_INIFILE						/*  Populate Database Connection from INI file  */
		string ls_inifile = "connection.ini"
		
		as_dbms			= ProfileString ( ls_inifile, "DBEdizioni", "DBMS",			"SYC")
		as_database		= ProfileString ( ls_inifile, "DBEdizioni", "Database",		"db_ediz")
		as_userid		= ProfileString ( ls_inifile, "DBEdizioni", "UserID",		"")
		as_dbpass		= ProfileString ( ls_inifile, "DBEdizioni", "DBPass",		"")
		as_logid			= ProfileString ( ls_inifile, "DBEdizioni", "LogID",			"")
		as_logpass		= ProfileString ( ls_inifile, "DBEdizioni", "LogPassword",	"")
		as_server		= ProfileString ( ls_inifile, "DBEdizioni", "Servername",	"localhost")
		as_dbparm		= ProfileString ( ls_inifile, "DBEdizioni", "DBParm",		"CommitOnDisconnect='No',Async=1")
		as_lock			= ProfileString ( ls_inifile, "DBEdizioni", "Lock",			"")
		as_autocommit	= ProfileString ( ls_inifile, "DBEdizioni", "AutoCommit",	"false")

	Case IS_USE_REGISTRY						/*  Populate Database Connection from Registry  */
		string ls_registrykey = "" + "\DataBase"
		
		If RegistryGet ( ls_registrykey, "DBMS", 			RegString!, as_dbms ) <> 1 Then
			RegistrySet ( ls_registrykey, "DBMS", 			RegString!, "SYC" )
			RegistryGet ( ls_registrykey, "DBMS", 			RegString!, as_dbms )
		End If
		If RegistryGet ( ls_registrykey, "Database", 	RegString!, as_database ) <> 1 Then
			RegistrySet ( ls_registrykey, "Database", 	RegString!, "db_ediz" )
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
			RegistrySet ( ls_registrykey, "LogID", 		RegString!, "" )
			RegistryGet ( ls_registrykey, "LogID", 		RegString!, as_logid )
		End If
		If RegistryGet ( ls_registrykey, "LogPassword", RegString!, as_logpass ) <> 1 Then
			RegistrySet ( ls_registrykey, "LogPassword", RegString!, "" )
			RegistryGet ( ls_registrykey, "LogPassword", RegString!, as_logpass )
		End If
		If RegistryGet ( ls_registrykey, "Servername", 	RegString!, as_server ) <> 1 Then
			RegistrySet ( ls_registrykey, "Servername", 	RegString!, "localhost" )
			RegistryGet ( ls_registrykey, "Servername", 	RegString!, as_server )
		End If
		If RegistryGet ( ls_registrykey, "DBParm", 		RegString!, as_dbparm ) <> 1 Then
			RegistrySet ( ls_registrykey, "DBParm", 		RegString!, "CommitOnDisconnect='No',Async=1" )
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
		as_dbms			= "SYC"
		as_database		= "db_ediz"
		as_userid		= ""
		as_dbpass		= ""
		as_logid			= ""
		as_logpass		= ""
		as_server		= "localhost"
		as_dbparm		= "CommitOnDisconnect='No',Async=1"
		as_lock			= ""
		as_autocommit	= "false"

		
	Case Else
		
		Return -1
		
End Choose

Return 1
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

sqlca_ediz= create transaction

If of_GetConnectionInfo ( ls_dbms, ls_database, ls_userid, ls_dbpass, ls_logid, ls_logpass, ls_server, ls_dbparm, ls_lock, ls_autocommit ) = 1 Then
	
	sqlca_ediz.DBMS			= ls_dbms
	sqlca_ediz.Database		= ls_database
	sqlca_ediz.UserID		= ls_userid
	sqlca_ediz.DBPass		= ls_dbpass
	sqlca_ediz.LogID			= ls_logid
	sqlca_ediz.LogPass		= ls_logpass
	sqlca_ediz.ServerName	= ls_server
	sqlca_ediz.DBParm		= ls_dbparm
	sqlca_ediz.Lock			= ls_lock
	Choose Case Lower ( ls_autocommit ) 
		Case "1", "true", "on", "yes"
			sqlca_ediz.AutoCommit	= True
		Case "0", "false", "off", "no"
			sqlca_ediz.AutoCommit	= False
		Case Else
			sqlca_ediz.AutoCommit	= False
	End Choose
	
End If
end event

on n_connectservice_ediz.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_connectservice_ediz.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

