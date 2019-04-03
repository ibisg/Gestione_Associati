$PBExportHeader$w_login_old.srw
forward
global type w_login_old from w_centered
end type
type st_connessione from statictext within w_login_old
end type
type cb_ok from commandbutton within w_login_old
end type
type cb_password from commandbutton within w_login_old
end type
type cb_2 from commandbutton within w_login_old
end type
type cb_entra from commandbutton within w_login_old
end type
type sle_password from singlelineedit within w_login_old
end type
type sle_utente from singlelineedit within w_login_old
end type
type st_2 from statictext within w_login_old
end type
type st_1 from statictext within w_login_old
end type
end forward

global type w_login_old from w_centered
integer width = 1463
integer height = 932
string title = "Autenticazione utenti"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
string icon = "typewr_red.ico"
st_connessione st_connessione
cb_ok cb_ok
cb_password cb_password
cb_2 cb_2
cb_entra cb_entra
sle_password sle_password
sle_utente sle_utente
st_2 st_2
st_1 st_1
end type
global w_login_old w_login_old

type variables

end variables

on w_login_old.create
int iCurrent
call super::create
this.st_connessione=create st_connessione
this.cb_ok=create cb_ok
this.cb_password=create cb_password
this.cb_2=create cb_2
this.cb_entra=create cb_entra
this.sle_password=create sle_password
this.sle_utente=create sle_utente
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_connessione
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_password
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_entra
this.Control[iCurrent+6]=this.sle_password
this.Control[iCurrent+7]=this.sle_utente
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
end on

on w_login_old.destroy
call super::destroy
destroy(this.st_connessione)
destroy(this.cb_ok)
destroy(this.cb_password)
destroy(this.cb_2)
destroy(this.cb_entra)
destroy(this.sle_password)
destroy(this.sle_utente)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;call super::open;integer li_inisection

li_inisection= message.doubleParm

db_connection.uof_cmdline(commandParm() )

db_connection.uof_getinipar(li_inisection)
end event

type st_connessione from statictext within w_login_old
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
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_login_old
integer x = 914
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
string text = "OK"
end type

event clicked;closeWithReturn(parent, s_utente_s)
end event

event getfocus;this.enabled= true
cb_password.enabled= true
end event

type cb_password from commandbutton within w_login_old
integer x = 425
integer y = 500
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

type cb_2 from commandbutton within w_login_old
integer x = 914
integer y = 624
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
string text = "Annulla"
boolean cancel = true
end type

event clicked;if sqlca.dbhandle() > 0 then
	disconnect;
end if

s_utente_s.id_gruppo= -1
closeWithReturn(parent, s_utente_s)
end event

type cb_entra from commandbutton within w_login_old
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

if len(sle_utente.text)= 0 then
	messageBox(parent.title, "Inserire un nome utente valido.", exclamation!)
	return -1
end if

s_utente_s.s_nome= trim(sle_utente.text)

s_utente_s.s_password= sle_password.text
if s_utente_s.s_password= "" then setNull(s_utente_s.s_password)

setPointer(hourGlass!)

//  esegue l'autenticazione degli utenti

db_connection.is_connection_parm_s.LogID= s_utente_s.s_nome
db_connection.is_connection_parm_s.LogPass= s_utente_s.s_password

parent.enabled= false

st_connessione.visible= true


/*
 * La connessione viene esguita all'interno dell'oggetto n_connectservice...
 */
 
 sqlca= create transaction
 
if db_connection.uof_connectdb(sqlca) < 0 then
	st_connessione.visible= false
	cb_ok.enabled= false
	cb_password.enabled= false
	parent.enabled= true
	sle_utente.setFocus()
	return -1
end if

// Dopo aver effettuato la connessione ...

lds_getrole= CREATE datastore

lds_getrole.dataObject= 'ds_getrole'
lds_getrole.setTransObject(sqlca)

ll_row= lds_getrole.retrieve()
s_utente_s.id_gruppo= lds_getrole.getItemNumber(ll_row, "id")

choose case s_utente_s.id_gruppo
		
	case -1
		
	messageBox("Login", "Gruppo di utenza non riconosciuto", stopSign!)
	return -1
	
case 1
	
	s_utente_s.s_gruppo= "Direzione segreteria"
	
	s_utente_s.b_superuser= true
	
case 2
	
	s_utente_s.s_gruppo= "Supervisore"	
	
	s_utente_s.b_superuser= true
	
case 3
	
	s_utente_s.s_gruppo= "Operatore segreteria"
	
	s_utente_s.b_superuser= false
	
case 4
	
	s_utente_s.s_gruppo= "Consultazione"
	
	s_utente_s.b_superuser= false
	
end choose

parent.enabled= true

st_connessione.text= "Connessione effettuata."
cb_ok.enabled= true
cb_password.enabled= true

cb_ok.setFocus()

//closeWithReturn(parent, s_utente_s)

//end if
end event

event losefocus;this.enabled= false

end event

type sle_password from singlelineedit within w_login_old
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

event losefocus;//cb_entra.enabled= true
//cb_entra.setFocus()
end event

event getfocus;selectText(1, len(this.text))
end event

event modified;cb_entra.enabled= true
end event

type sle_utente from singlelineedit within w_login_old
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
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

event modified;if len(this.text) = 0 then return -1

//cb_entra.enabled= true
end event

event getfocus;selectText(1, len(this.text))
end event

type st_2 from statictext within w_login_old
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

type st_1 from statictext within w_login_old
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

