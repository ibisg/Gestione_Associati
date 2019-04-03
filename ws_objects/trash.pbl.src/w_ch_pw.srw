$PBExportHeader$w_ch_pw.srw
forward
global type w_ch_pw from window
end type
type st_2 from statictext within w_ch_pw
end type
type st_1 from statictext within w_ch_pw
end type
type cb_annulla from commandbutton within w_ch_pw
end type
type cb_applica from commandbutton within w_ch_pw
end type
type sle_confirm from singlelineedit within w_ch_pw
end type
type sle_new_pw from singlelineedit within w_ch_pw
end type
type st_message from statictext within w_ch_pw
end type
end forward

global type w_ch_pw from window
integer width = 1573
integer height = 612
boolean titlebar = true
string title = "Cambia password"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean clientedge = true
boolean center = true
st_2 st_2
st_1 st_1
cb_annulla cb_annulla
cb_applica cb_applica
sle_confirm sle_confirm
sle_new_pw sle_new_pw
st_message st_message
end type
global w_ch_pw w_ch_pw

type variables
string old_pw, new_pw, is_utente
end variables

event open;old_pw= message.stringParm

is_utente= sqlca.LogId

this.title= "Cambio password per l'utente: "+is_utente
end event

on w_ch_pw.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_annulla=create cb_annulla
this.cb_applica=create cb_applica
this.sle_confirm=create sle_confirm
this.sle_new_pw=create sle_new_pw
this.st_message=create st_message
this.Control[]={this.st_2,&
this.st_1,&
this.cb_annulla,&
this.cb_applica,&
this.sle_confirm,&
this.sle_new_pw,&
this.st_message}
end on

on w_ch_pw.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_annulla)
destroy(this.cb_applica)
destroy(this.sle_confirm)
destroy(this.sle_new_pw)
destroy(this.st_message)
end on

type st_2 from statictext within w_ch_pw
integer x = 91
integer y = 228
integer width = 425
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean enabled = false
string text = "Conferma:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_ch_pw
integer x = 91
integer y = 112
integer width = 425
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean enabled = false
string text = "Nuova password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_annulla from commandbutton within w_ch_pw
integer x = 1157
integer y = 232
integer width = 320
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
boolean cancel = true
end type

event clicked;setNull(new_pw)
closeWithReturn (parent,  new_pw)
end event

type cb_applica from commandbutton within w_ch_pw
integer x = 1157
integer y = 100
integer width = 320
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Cambia"
boolean default = true
end type

event clicked;transaction sqlca_pw
int pwd_rtn
string utente, sql_statement
uint tentativo= 0
//n_connectservice_sqlca	ln_connectservice_sqlca
//
//ln_connectservice_sqlca= create n_connectservice_sqlca

new_pw= sle_new_pw.text

if new_pw = '' and sle_confirm.text = '' then
	MessageBox ( parent.title,"Riempire tutti i campi.",Exclamation! )
	sle_new_pw.SetFocus ( )
	return -1
end if

st_message.text= ""
if len(trim(sle_new_pw.text)) < 6 then
	st_message.text= "La lunghezza minima è di almeno 6 caratteri."
	sle_new_pw.setFocus()
	sle_new_pw.text= ""
	sle_confirm.text = ""
	return -1
end if

//if new_pw <> sle_confirm.text then
//	MessageBox ( parent.title,"Conferma password errata.",StopSign!)
//	sle_confirm.text = ""
//	sle_confirm.SetFocus ( )
//	return -1
//end if

if old_pw = new_pw then
	MessageBox ( parent.title,"Vecchia e nuova password sono uguali.",StopSign!)
	sle_new_pw.text = ""
	sle_confirm.text = ""
	sle_new_pw.SetFocus ( )
	return -1
end if

//utente= sqlca.logid

//disconnect using sqlca;
//if ln_connectservice_sqlca.of_disconnectdb() < 0 then return -1

//if trap_sql(sqlca, "CHPW00") < 0 then return -1

//sqlca.dbms= s_connect_par_s.dbms
//sqlca.servername= s_connect_par_s.server
//sqlca.database= "master"

//connect using sqlca;
//  esegue l'autenticazione degli utenti

SQLCA.LogPass= new_pw

//if ln_connectservice_sqlca.of_connectdb() < 0 then return -1

sqlca.autocommit= true;

DECLARE cambia procedure for master..sp_password
					@old = :old_pw, 
					@new = :new_pw,
					@loginame = :is_utente;

if trap_sql(sqlca, "CHPW02.0") < 0 then return -1

EXECUTE cambia;

if trap_sql(sqlca, "CHPW02") < 0 then
	
	sqlca.autocommit= false;
	return -1
	
end if

sqlca.autocommit= false;

pwd_rtn = sqlca.SqlDbCode

if trap_sql(sqlca, "CHPW03") < 0 then return -1

//disconnect using sqlca;

//if trap_sql(sqlca, "CHPW04") < 0 then return -1

choose case pwd_rtn
		
	case 0
		
		MessageBox ( parent.title,"La nuova password è stata registrata.")
		
		s_utente_s.s_password= new_pw
		
//		if ln_connectservice_sqlca.of_disconnectdb() < 0 then return -1
//		
//		sqlca.LogPass= new_pw
//		
////		connect using sqlca;
//		if ln_connectservice_sqlca.of_connectdb() < 0 then return -1
//		
////		if trap_sql(sqlca, "CHPW04") < 0 then return -1
		
		goto fine
		
//	case 573
//		
//		MessageBox ( parent.title,"La lunghezza minima ammessa è di 6 caratteri..."+&
//						 "~nCambio password non effettuato.",StopSign! )
//		sle_new_pw.text = ""
//		sle_confirm.text = ""
//		sle_new_pw.SetFocus ( )
//		goto errore
		
	case else
		
		MessageBox ( parent.title,"Errore di sistema "+sqlca.sqlerrtext+&
						 "~nSe l'errore si dovesse"+&
						 "~nverificare ancora, si prega"+&
						 "~n di contattare il CED.",StopSign!)
		sle_new_pw.text = ""
		sle_confirm.text = ""
		sle_new_pw.SetFocus ( )		
		goto errore

end choose

errore:

return -1

fine:

closeWithReturn (parent,  new_pw)

end event

type sle_confirm from singlelineedit within w_ch_pw
integer x = 521
integer y = 228
integer width = 576
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;//this.selectText(1, len(this.text))
end event

event losefocus;st_message.text= ""
if sle_confirm.text <> sle_new_pw.text then
	st_message.text= "La password non è stata correttamente confermata."
	//sle_confirm.setFocus()
	sle_confirm.text= ""
	return -1
end if

cb_applica.enabled= true

cb_applica.setFocus()
end event

type sle_new_pw from singlelineedit within w_ch_pw
integer x = 521
integer y = 96
integer width = 576
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

event getfocus;cb_applica.enabled= false

//this.selectText(1, len(this.text))
end event

event losefocus;//st_message.text= ""
//if len(trim(this.text)) < 6 then
//	st_message.text= "La lunghezza minima è di almeno 6 caratteri."
//	sle_new_pw.setFocus()
//	sle_new_pw.text= ""
//	return -1
//end if
//return 0
end event

type st_message from statictext within w_ch_pw
integer x = 87
integer y = 376
integer width = 1390
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

