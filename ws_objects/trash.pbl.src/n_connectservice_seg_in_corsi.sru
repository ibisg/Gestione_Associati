$PBExportHeader$n_connectservice_seg_in_corsi.sru
$PBExportComments$Generated Database Connection Service
forward
global type n_connectservice_seg_in_corsi from nonvisualobject
end type
end forward

global type n_connectservice_seg_in_corsi from nonvisualobject
end type
global n_connectservice_seg_in_corsi n_connectservice_seg_in_corsi

type variables
string is_connectfrom = "1"

CONSTANT string IS_USE_INIFILE 	= "1"
CONSTANT string IS_USE_REGISTRY	= "2"
CONSTANT string IS_USE_SCRIPT 	= "3"
end variables

forward prototypes
public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit)
public function integer of_connectdb ()
public function integer of_disconnectdb ()
end prototypes

public function integer of_getconnectioninfo (ref string as_dbms, ref string as_database, ref string as_userid, ref string as_dbpass, ref string as_logid, ref string as_logpass, ref string as_server, ref string as_dbparm, ref string as_lock, ref string as_autocommit);////*--------------------------------------------------------*/
//*  The source of connection information can be changed by
//*  altering the value of the 'is_connectfrom' variable.
//*--------------------------------------------------------*/
Choose Case is_connectfrom
		
	Case IS_USE_INIFILE						/*  Populate Database Connection from INI file  */
		string ls_inifile = "ga.ini"
		
		as_dbms			= ProfileString ( ls_inifile, "DBSegreteria", "DBMS",			"MSS Microsoft SQL Server 6.x")
		as_database		= ProfileString ( ls_inifile, "DBSegreteria", "Database",		"ga")
		as_userid		= ProfileString ( ls_inifile, "DBSegreteria", "UserID",		"")
		as_dbpass		= ProfileString ( ls_inifile, "DBSegreteria", "DBPass",		"")
		as_logid			= ProfileString ( ls_inifile, "DBSegreteria", "LogID",			"sa")
		as_logpass		= ProfileString ( ls_inifile, "DBSegreteria", "LogPassword",	"assicurato")
		as_server		= ProfileString ( ls_inifile, "DBSegreteria", "Servername",	"localhost")
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
/*  Actual DB connection */
Connect using SQLCA_src;

If SQLCA_src.SQLCode <> 0 Then
	MessageBox ("Non riesco a connettermi al Database Segreteria", SQLCA_src.SQLErrText )
End If

Return SQLCA_src.SQLCode
end function

public function integer of_disconnectdb ();//*--------------------------------------------------------*/
//*  Disconnect from database
//*--------------------------------------------------------*/
/*  Actual DB disconnection */
Disconnect using SQLCA_src;

If SQLCA_src.SQLCode <> 0 Then
	MessageBox ("Cannot Disconnect to Database", SQLCA_src.SQLErrText )
End If

Return SQLCA_src.SQLCode
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

sqlca_src= create transaction

If of_GetConnectionInfo ( ls_dbms, ls_database, ls_userid, ls_dbpass, ls_logid, ls_logpass, ls_server, ls_dbparm, ls_lock, ls_autocommit ) = 1 Then
	
	sqlca_src.DBMS			= ls_dbms
	sqlca_src.Database		= ls_database
	sqlca_src.UserID		= ls_userid
	sqlca_src.DBPass		= ls_dbpass
	sqlca_src.LogID			= ls_logid
	sqlca_src.LogPass		= ls_logpass
	sqlca_src.ServerName	= ls_server
	sqlca_src.DBParm		= ls_dbparm
	sqlca_src.Lock			= ls_lock
	Choose Case Lower ( ls_autocommit ) 
		Case "1", "true", "on", "yes"
			sqlca_src.AutoCommit	= True
		Case "0", "false", "off", "no"
			sqlca_src.AutoCommit	= False
		Case Else
			sqlca_src.AutoCommit	= False
	End Choose
	
	ls_cmdline= CommandParm()
	
	f_cmdline(ls_cmdline)
	
End If
end event
on n_connectservice_seg_in_corsi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_connectservice_seg_in_corsi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

