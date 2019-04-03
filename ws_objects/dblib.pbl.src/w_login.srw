$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type st_1 from statictext within w_login
end type
type st_2 from statictext within w_login
end type
type sle_utente from singlelineedit within w_login
end type
type sle_password from singlelineedit within w_login
end type
type cb_entra from commandbutton within w_login
end type
type cb_2 from commandbutton within w_login
end type
type cb_password from commandbutton within w_login
end type
type cb_ok from commandbutton within w_login
end type
type st_connessione from statictext within w_login
end type
end forward

global type w_login from window
integer width = 1481
integer height = 948
boolean titlebar = true
string title = "Login"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
st_1 st_1
st_2 st_2
sle_utente sle_utente
sle_password sle_password
cb_entra cb_entra
cb_2 cb_2
cb_password cb_password
cb_ok cb_ok
st_connessione st_connessione
end type
global w_login w_login

forward prototypes
public function integer wf_dbconnection ()
public subroutine wf_reset ()
end prototypes

public function integer wf_dbconnection ();//  esegue l'autenticazione degli utenti

if sqlca.dbHandle() > 0 then return 0
 
if db_connection.uof_connectdb(sqlca) < 0 then
	wf_reset()
	return -1
end if

return 0
end function

public subroutine wf_reset ();st_connessione.visible= false
cb_ok.enabled= false
cb_password.enabled= false
this.enabled= true
sle_password.text= ""
sle_utente.setFocus()

end subroutine

event open;integer li_inisection

li_inisection= message.doubleParm

db_connection.uof_cmdline(commandParm() )

db_connection.uof_getinipar(li_inisection)

s_utente_s= f_getwinuser()

sle_utente.text= s_utente_s.s_nome

sle_password.setFocus()
end event

on w_login.create
this.st_1=create st_1
this.st_2=create st_2
this.sle_utente=create sle_utente
this.sle_password=create sle_password
this.cb_entra=create cb_entra
this.cb_2=create cb_2
this.cb_password=create cb_password
this.cb_ok=create cb_ok
this.st_connessione=create st_connessione
this.Control[]={this.st_1,&
this.st_2,&
this.sle_utente,&
this.sle_password,&
this.cb_entra,&
this.cb_2,&
this.cb_password,&
this.cb_ok,&
this.st_connessione}
end on

on w_login.destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_utente)
destroy(this.sle_password)
destroy(this.cb_entra)
destroy(this.cb_2)
destroy(this.cb_password)
destroy(this.cb_ok)
destroy(this.st_connessione)
end on

type st_1 from statictext within w_login
integer x = 55
integer y = 132
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 81324524
string text = "Nome utente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_login
integer x = 55
integer y = 260
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 81324524
string text = "Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_utente from singlelineedit within w_login
integer x = 425
integer y = 112
integer width = 919
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "IBeam!"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event getfocus;selectText(1, len(this.text))
end event

event modified;if len(this.text) = 0 then return -1

//cb_entra.enabled= true
end event

type sle_password from singlelineedit within w_login
integer x = 425
integer y = 240
integer width = 919
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "IBeam!"
long textcolor = 33554432
long backcolor = 16777215
boolean password = true
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

event getfocus;selectText(1, len(this.text))
end event

event losefocus;//cb_entra.enabled= true
//cb_entra.setFocus()
end event

event modified;cb_entra.enabled= true
cb_entra.setFocus()
end event

type cb_entra from commandbutton within w_login
integer x = 914
integer y = 376
integer width = 430
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
boolean enabled = false
string text = "Connessione"
boolean default = true
end type

event clicked;datastore lds_getrole
long ll_row
string ls_su, ls_password, ls_nome

if len(sle_utente.text)= 0 then
	messageBox(parent.title, "Inserire un nome utente valido.", exclamation!)
	return -1
end if

s_utente_s.s_nome= trim(sle_utente.text)

s_utente_s.s_password= sle_password.text

if s_utente_s.s_password= "" then setNull(s_utente_s.s_password)

// Identifica un eventuale utente web, il nome utente è il codice personale

ls_nome= Mid(s_utente_s.s_nome, 1, len(s_utente_s.s_nome) - 2)

if isNumber(ls_nome) then
	// verifica che il codice sia consistente
	if f_vercod(s_utente_s.s_nome) = false then
		messageBox(parent.title, "Codice personale non corretto.", stopSign!)
		wf_reset()
		return -1
	end if
	
		// se è un utente web sostituisce nei parametri di connessione
		// le credenziali passate dall'utente con quelle del generico utente
		// web_user e relativa password.
		
		db_connection.is_connectionparm_s.LogID= "webseg"
		db_connection.is_connectionparm_s.LogPass= "assicurato"
		
		if wf_dbconnection()= -1 then return -1
		
		// legge dalla tabella utenti_web verificando se:
		// l'utente web è definito,
		// se è abilitato,
		// se è ok legge la pw
		select password
		into :ls_password
		from utenti_web where codice= :s_utente_s.s_nome and flag_abilitato= 1;
		
		if trap_sql(sqlca, "WEBLOGIN01") < 0 then return -1
		
		if sqlca.sqlcode= 100 then
			messageBox(parent.title, "Utente non riconosciuto", stopSign!)
			wf_reset()
			return -1
		end if
		
		// confronta la pw con quella letta dal db
		
		if trim(s_utente_s.s_password) <> trim(ls_password) then
			messageBox(parent.title, "Password non riconosciuta")
			wf_reset()
			return -1
		end if

	else
		
		db_connection.is_connectionparm_s.LogID= s_utente_s.s_nome
		db_connection.is_connectionparm_s.LogPass= s_utente_s.s_password
		
		if wf_dbconnection()= -1 then return -1

end if

setPointer(hourGlass!)

parent.enabled= false

st_connessione.visible= true

///*
// * La connessione viene eseguita all'interno dell'oggetto n_connectservice...
// */
// 
// sqlca= create transaction
 
 //  esegue l'autenticazione degli utenti
 
//if db_connection.uof_connectdb(sqlca) < 0 then
//	st_connessione.visible= false
//	cb_ok.enabled= false
//	cb_password.enabled= false
//	parent.enabled= true
//	sle_utente.setFocus()
//	return -1
//end if

// Dopo aver effettuato la connessione ...

lds_getrole= CREATE datastore

lds_getrole.dataObject= 'ds_getrole'
lds_getrole.setTransObject(sqlca)

ll_row= lds_getrole.retrieve()
s_utente_s.id_gruppo= lds_getrole.getItemNumber(ll_row, "id")

if s_utente_s.id_gruppo= -1 then
	messageBox("Login", "Gruppo di utenza non riconosciuto", stopSign!)
	return -1
end if

select is_super_user, descrizione
into :ls_su, :s_utente_s.s_gruppo
from utenti_gruppi
where id_gruppo= : s_utente_s.id_gruppo;
if trap_sql(sqlca, "GRUPPI01") < 0 then return -1

s_utente_s.b_superuser= false
if ls_su= 'S' then s_utente_s.b_superuser= true

parent.enabled= true

st_connessione.text= "Connessione effettuata."
cb_ok.enabled= true
cb_password.enabled= true

cb_ok.setFocus()

return 0

//closeWithReturn(parent, s_utente_s)

//end if
end event

event losefocus;this.enabled= false

end event

type cb_2 from commandbutton within w_login
integer x = 914
integer y = 624
integer width = 430
integer height = 112
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
string text = "Annulla"
boolean cancel = true
end type

event clicked;if sqlca.dbhandle() > 0 then
	disconnect;
end if

s_utente_s.id_gruppo= -1
closeWithReturn(parent, s_utente_s)
end event

type cb_password from commandbutton within w_login
integer x = 425
integer y = 500
integer width = 430
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
boolean enabled = false
string text = "Cambia password"
boolean cancel = true
end type

event clicked;string new_pw

openWithParm(w_ch_pw, sle_password.text)

new_pw= message.stringParm

if isNull(new_pw) then return -1

sle_password.text= new_pw

this.enabled= false

cb_entra.enabled= false

cb_entra.setFocus()

end event

type cb_ok from commandbutton within w_login
integer x = 914
integer y = 500
integer width = 430
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
boolean enabled = false
string text = "OK"
end type

event clicked;closeWithReturn(parent, s_utente_s)
end event

event getfocus;this.enabled= true
cb_password.enabled= true
end event

type st_connessione from statictext within w_login
boolean visible = false
integer x = 256
integer y = 656
integer width = 599
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
string text = "In attesa di connessione..."
alignment alignment = right!
boolean focusrectangle = false
end type

