$PBExportHeader$w_batlogon_templ.srw
forward
global type w_batlogon_templ from window
end type
type cb_cambia_pw from commandbutton within w_batlogon_templ
end type
type cb_annulla from commandbutton within w_batlogon_templ
end type
type cb_ok from commandbutton within w_batlogon_templ
end type
type sle_connessione from singlelineedit within w_batlogon_templ
end type
type dw_current from datawindow within w_batlogon_templ
end type
type cbx_altrodb from checkbox within w_batlogon_templ
end type
type st_2 from statictext within w_batlogon_templ
end type
type st_1 from statictext within w_batlogon_templ
end type
type cb_connessione from commandbutton within w_batlogon_templ
end type
type sle_password from singlelineedit within w_batlogon_templ
end type
type sle_username from singlelineedit within w_batlogon_templ
end type
end forward

global type w_batlogon_templ from window
integer x = 997
integer y = 400
integer width = 1687
integer height = 1588
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 134217748
string icon = "Question!"
boolean clientedge = true
cb_cambia_pw cb_cambia_pw
cb_annulla cb_annulla
cb_ok cb_ok
sle_connessione sle_connessione
dw_current dw_current
cbx_altrodb cbx_altrodb
st_2 st_2
st_1 st_1
cb_connessione cb_connessione
sle_password sle_password
sle_username sle_username
end type
global w_batlogon_templ w_batlogon_templ

type variables
long larghezza= 1678, altezza=800

string s_logname

end variables

forward prototypes
public function integer wf_check_pw (string user, string password)
public function integer wf_login ()
end prototypes

public function integer wf_check_pw (string user, string password);uint quanti= 0
integer i_ret= 2

//select count(*)
//into :quanti
//from master..syslogins
//where datediff(day, pwdate, getdate()) > 180 and
//		name= :user;
//		
//if trap_sql(sqlca, "CHECKPW01") < 0 then return -1
//
//if sqlca.sqlcode= 100 then return 0
//
//if quanti > 0 then 
//
//	i_ret=  messageBox(this.title, "La password e' stata impostata da piu' di 180 giorni."+&
//										"~nLa vuoi cambiare?", question!, yesNo!, 1)
//										
//end if

return i_ret
end function

public function integer wf_login ();if s_connect_par_s.database= non_attiva then
	
	messageBox(this.title, "La dipendenza selezionata non e' attiva.~n~n"+&
								  "La connessione non e' possibile.", exclamation!)
									
	return -1

end if

if trim(s_connect_par_s.dbtype)="SYBASE" then
	
	sqlca.dbms= 		s_connect_par_s.dbms
	sqlca.servername= s_connect_par_s.server
	sqlca.logid= 		trim(sle_username.text)
	sqlca.logpass= 	trim(sle_password.text)
	sqlca.database= s_connect_par_s.database
	
	/*
	 * Abilita il modo operativo asincrono,
	 * Configura  il time out sulla risposta del DBMS a 600 secondi,
	 * Rollback in caso di disconnessione prima di una commit.
	 */
	 
	sqlca.dbParm= "Async = 1, dbGetTime = 600, CommitOnDisconnect = 'No', host=~'"+nome_host+"~'"+&
						", appname=~'"+nome_applicazione+"~'"
	
elseif trim(s_connect_par_s.dbtype)="ODBC" then
	
	sqlca.dbms="ODBC"
	sqlca.dbparm="Connectstring='dsn="+s_connect_par_s.database+";uid="+lower(trim(sle_username.text))+&
							";pwd="+lower(trim(sle_password.text))+";"
							
elseif trim(s_connect_par_s.dbtype)="MSS" then
							
	sqlca.DBMS = "MSS" //"MSS Microsoft SQL Server 6.x"
	sqlca.ServerName = s_connect_par_s.server
	sqlca.logid= 		trim(sle_username.text)
	sqlca.logpass= 	trim(sle_password.text)
	sqlca.database= s_connect_par_s.database

	//SQLCA.AutoCommit = False
	SQLCA.DBParm ="CommitOnDisconnect='No', Async=1,DBGetTime=600,Language='italiano, host=~'"+nome_host+"~'"+&
							", appname=~'"+nome_applicazione+"~'"

else
	
	messageBox(this.title, "Il tipo di base dati non e' stato riconosciuto", stopSign!)
	return -1
		
end if

connect using sqlca;

if sqlca.sqldbcode= 6 then
	
	messageBox("Login", "User o password errati.", exclamation!)
	
	return -1

elseif trap_sql(sqlca, "connessione alla base dati") < 0 then

	return -1
	
//elseif f_count_db_sessions() > 1 then
//	
//	messageBox(this.title, &
//			"L'utente "+sle_username.text+" e' gia' connesso da un'altra stazione di lavoro.~n"+&
//					"Una nuova connessione non e' permessa.", stopsign!)
//									
//	disconnect using sqlca;
//									
//	return -1

end if

return 1


end function

event open;this.x= f_wcenter(this).x

this.y= f_wcenter(this).y

environment le_env
integer i_ret

i_ret = GetEnvironment(le_env)
if i_ret <> 1 then return i_ret

this.title= ragione_sociale

this.Resize( larghezza, altezza)

dw_current.setRowFocusIndicator(focusRect!)

		choose case le_env.OsType
				
			case WindowsNT!
				// Legge dal registry il nome utente
				RegistryGet ( "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer", &
													  "Logon user name", s_logname )
				
				if (s_logname = "" or isnull(s_logname)) then
					registryGet("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName", &
						  "ComputerName", nome_host)
				end if
				
				// Legge dal registry il nome della macchina su cui gira l'applicazione...
				RegistryGet("HKEY_CURRENT_USER\Volatile Environment", &
													"ClientName", nome_host)
												  if (nome_host= "" or isnull(nome_host) or nome_host="Console") then
					RegistryGet("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName", &
							  "ComputerName", nome_host)
				end if
			case Windows!
				RegistryGet ( "HKEY_LOCAL_MACHINE\Network\Logon", &
									"UserName", s_logname )					  
				// Legge dal registry il nome della macchina su cui gira l'applicazione...
				registryGet("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName", &
									"ComputerName", nome_host)
									
		end choose
			
sle_username.text= lower(trim(s_logname))

sle_password.setFocus()
end event

on w_batlogon_templ.create
this.cb_cambia_pw=create cb_cambia_pw
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.sle_connessione=create sle_connessione
this.dw_current=create dw_current
this.cbx_altrodb=create cbx_altrodb
this.st_2=create st_2
this.st_1=create st_1
this.cb_connessione=create cb_connessione
this.sle_password=create sle_password
this.sle_username=create sle_username
this.Control[]={this.cb_cambia_pw,&
this.cb_annulla,&
this.cb_ok,&
this.sle_connessione,&
this.dw_current,&
this.cbx_altrodb,&
this.st_2,&
this.st_1,&
this.cb_connessione,&
this.sle_password,&
this.sle_username}
end on

on w_batlogon_templ.destroy
destroy(this.cb_cambia_pw)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.sle_connessione)
destroy(this.dw_current)
destroy(this.cbx_altrodb)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_connessione)
destroy(this.sle_password)
destroy(this.sle_username)
end on

type cb_cambia_pw from commandbutton within w_batlogon_templ
integer x = 1253
integer y = 276
integer width = 357
integer height = 80
integer taborder = 61
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Cambia pw"
end type

event clicked;string new_pw

openWithParm(w_ch_pw, sle_password.text)

new_pw= message.stringParm

if isNull(new_pw) then return -1

sle_password.text= new_pw

this.enabled= false

cb_connessione.enabled= true

cb_connessione.setFocus()
end event

type cb_annulla from commandbutton within w_batlogon_templ
integer x = 1253
integer y = 412
integer width = 357
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
boolean cancel = true
end type

event clicked;closewithreturn(parent, -1)
end event

type cb_ok from commandbutton within w_batlogon_templ
integer x = 1253
integer y = 176
integer width = 357
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Ok"
end type

event clicked;closewithreturn(parent, 0)
end event

type sle_connessione from singlelineedit within w_batlogon_templ
integer x = 32
integer y = 540
integer width = 1577
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217742
boolean autohscroll = false
end type

type dw_current from datawindow within w_batlogon_templ
event keydown pbm_dwnkey
event type long ue_double_clicked_default ( )
integer x = 32
integer y = 708
integer width = 1577
integer height = 776
boolean vscrollbar = true
boolean livescroll = true
end type

event keydown;if key=keyenter! then
	
	long which_row

	which_row= this.getRow()

	if which_row < 1 then return
	
		this.setRow(which_row)
		
		triggerEvent(doubleClicked!)
		
end if
end event

event doubleclicked;if this.Event ue_double_clicked_default() < 0 then return -1

cb_cambia_pw.enabled= false
		
cb_connessione.setFocus()


end event

event rowfocuschanged;f_select_current_row(this)
end event

type cbx_altrodb from checkbox within w_batlogon_templ
integer x = 457
integer y = 416
integer width = 722
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217742
boolean enabled = false
string text = "&Seleziona altra Dipendenza "
end type

event clicked;setPointer(hourGlass!)

parent.setRedraw(false)

if cbx_altrodb.checked= true then

	dw_current.setTransObject(sqlca)
	
	if dw_current.retrieve()= 0 then
		
		messageBox(	parent.title, "Nessuna dipendenza definita in base dati", stopSign!)
																
	else
	
		parent.Resize( larghezza, altezza*2)
	
		cbx_altrodb.enabled= false
		
		cb_ok.enabled= false
	
	end if
	
end if

parent.setRedraw(true)

dw_current.setFocus()

end event

type st_2 from statictext within w_batlogon_templ
integer x = 142
integer y = 280
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217742
boolean enabled = false
string text = "Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_batlogon_templ
integer x = 142
integer y = 64
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 134217742
boolean enabled = false
string text = "Nome utente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_connessione from commandbutton within w_batlogon_templ
event type integer ue_connection_default ( )
integer x = 1253
integer y = 68
integer width = 357
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Co&nnessione"
boolean default = true
end type

event clicked;string area_db, dip_db

setPointer(hourGlass!)

	if sle_username.text="" OR &
		sle_password.text= "" OR &
		isNull(sle_username.text) OR &
		isNull(sle_username.text) then
		
			messageBox(parent.title, "Inserire USER e PASSWORD", exclamation!)
			
			return -1
		
	end if
				
	if parent.wf_login()< 0 then
		
		sle_password.setFocus()
	
		return -1
		
	else
		
				if event ue_connection_default() >= 0 then
		
					sle_connessione.text="Connesso con: "+dip_operativa
			
					cb_ok.enabled= true
					
					cb_ok.setFocus()
																			
					cbx_altrodb.enabled= NOT cbx_altrodb.checked
					
					this.enabled= false
					
					cb_cambia_pw.enabled= true
					
					if wf_check_pw(sle_username.text, sle_password.text)= 1 then
						
						/*
						 * Cambio di pw...
						 */
						 cb_cambia_pw.triggerEvent(clicked!)
						 
					end if
					
				else
									 
					cb_annulla.triggerEvent(clicked!)
					
					return -1
					
				end if
		
	end if
	
return 0
end event

event getfocus;cb_ok.enabled= false
end event

type sle_password from singlelineedit within w_batlogon_templ
integer x = 457
integer y = 268
integer width = 603
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean password = true
textcase textcase = lower!
integer limit = 30
borderstyle borderstyle = stylelowered!
end type

event modified;cb_connessione.enabled= true

cb_connessione.setFocus()
end event

event getfocus;sle_password.SelectText(1, Len(sle_password.Text))
end event

type sle_username from singlelineedit within w_batlogon_templ
integer x = 457
integer y = 60
integer width = 603
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
textcase textcase = lower!
integer limit = 30
borderstyle borderstyle = stylelowered!
end type

event getfocus;sle_username.SelectText(1, Len(sle_username.Text))
end event

