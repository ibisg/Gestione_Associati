$PBExportHeader$w_liste_invio_tab_pb.srw
forward
global type w_liste_invio_tab_pb from window
end type
type tab_send from tab within w_liste_invio_tab_pb
end type
type tabpage_mail from userobject within tab_send
end type
type st_1 from statictext within tabpage_mail
end type
type pb_invia from picturebutton within tabpage_mail
end type
type cbx_copiamittente from checkbox within tabpage_mail
end type
type sle_oggetto from singlelineedit within tabpage_mail
end type
type cbx_receipt from checkbox within tabpage_mail
end type
type mle_messaggio from multilineedit within tabpage_mail
end type
type dw_allegati from datawindow within tabpage_mail
end type
type dw_liste_mail from datawindow within tabpage_mail
end type
type gb_3 from groupbox within tabpage_mail
end type
type gb_body from groupbox within tabpage_mail
end type
type gb_1 from groupbox within tabpage_mail
end type
type gb_4 from groupbox within tabpage_mail
end type
type gb_mittente from groupbox within tabpage_mail
end type
type sle_mittente from singlelineedit within tabpage_mail
end type
type cbx_lista from checkbox within tabpage_mail
end type
type gb_allegati from groupbox within tabpage_mail
end type
type tabpage_mail from userobject within tab_send
st_1 st_1
pb_invia pb_invia
cbx_copiamittente cbx_copiamittente
sle_oggetto sle_oggetto
cbx_receipt cbx_receipt
mle_messaggio mle_messaggio
dw_allegati dw_allegati
dw_liste_mail dw_liste_mail
gb_3 gb_3
gb_body gb_body
gb_1 gb_1
gb_4 gb_4
gb_mittente gb_mittente
sle_mittente sle_mittente
cbx_lista cbx_lista
gb_allegati gb_allegati
end type
type tabpage_sms from userobject within tab_send
end type
type cb_inviasms from commandbutton within tabpage_sms
end type
type dw_liste_sms from datawindow within tabpage_sms
end type
type gb_sms from groupbox within tabpage_sms
end type
type mle_messaggiosms from multilineedit within tabpage_sms
end type
type gb_bodysms from groupbox within tabpage_sms
end type
type tabpage_sms from userobject within tab_send
cb_inviasms cb_inviasms
dw_liste_sms dw_liste_sms
gb_sms gb_sms
mle_messaggiosms mle_messaggiosms
gb_bodysms gb_bodysms
end type
type tabpage_lettera from userobject within tab_send
end type
type cb_cancella1 from commandbutton within tabpage_lettera
end type
type dw_liste_documenti from datawindow within tabpage_lettera
end type
type gb_31 from groupbox within tabpage_lettera
end type
type gb_bodydoc from groupbox within tabpage_lettera
end type
type tabpage_lettera from userobject within tab_send
cb_cancella1 cb_cancella1
dw_liste_documenti dw_liste_documenti
gb_31 gb_31
gb_bodydoc gb_bodydoc
end type
type tabpage_etichette from userobject within tab_send
end type
type cb_setup_labels from commandbutton within tabpage_etichette
end type
type cb_stampa_etichette from commandbutton within tabpage_etichette
end type
type dw_etichette from datawindow within tabpage_etichette
end type
type gb_labels from groupbox within tabpage_etichette
end type
type tabpage_etichette from userobject within tab_send
cb_setup_labels cb_setup_labels
cb_stampa_etichette cb_stampa_etichette
dw_etichette dw_etichette
gb_labels gb_labels
end type
type tab_send from tab within w_liste_invio_tab_pb
tabpage_mail tabpage_mail
tabpage_sms tabpage_sms
tabpage_lettera tabpage_lettera
tabpage_etichette tabpage_etichette
end type
type gb_2 from groupbox within w_liste_invio_tab_pb
end type
type gb_5 from groupbox within w_liste_invio_tab_pb
end type
type gb_6 from groupbox within w_liste_invio_tab_pb
end type
type gb_7 from groupbox within w_liste_invio_tab_pb
end type
end forward

global type w_liste_invio_tab_pb from window
integer width = 4247
integer height = 2640
boolean titlebar = true
string title = "Liste automatiche"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 67108864
string icon = "postbox.ico"
boolean clientedge = true
boolean center = true
event type integer ue_list ( s_lista as_lista_s )
tab_send tab_send
gb_2 gb_2
gb_5 gb_5
gb_6 gb_6
gb_7 gb_7
end type
global w_liste_invio_tab_pb w_liste_invio_tab_pb

type variables
boolean ib_receiptrequested, ib_oktoggle= false
dataWindowChild	idwc_mailrif
decimal id_idx
string is_codice, is_cod_lista, is_descrizione_lista, is_tipo_lista

s_lista is_lista_s
end variables

forward prototypes
public function integer wf_ismessage ()
public function boolean wf_indirizzidoppi (datawindow adw_indirizzi, string as_riferimento)
public function integer wf_log_invio (integer ai_esito, s_lista as_lista_s)
end prototypes

event type integer ue_list(s_lista as_lista_s);integer li_ret
long ll_count, ll_idx

this.setRedraw(false)

id_idx= as_lista_s.idx

// verifico che nella lista ci siano dei destinatari...
select count(*)
into :ll_count
from liste_dettaglio 
where idx= :as_lista_s.idx;

if trap_sql(sqlca, "LISTA01") < 0 then goto nessuno

if ll_count= 0 or isNull(ll_count) then goto nessuno

choose case as_lista_s.tipo_lista
		
	case "MAIL"
		
		tab_send.tabpage_mail.enabled= true
		tab_send.tabpage_lettera.enabled= false
		tab_send.tabpage_etichette.enabled= false		
		tab_send.tabpage_sms.enabled= false		
		tab_send.selectTab(tab_send.tabpage_mail)
		
		tab_send.tabpage_mail.sle_oggetto.text= ""
		tab_send.tabpage_mail.mle_messaggio.text= ""
		tab_send.tabpage_mail.cbx_lista.enabled= true
		tab_send.tabpage_mail.cbx_lista.checked= false
		tab_send.tabpage_mail.cbx_receipt.enabled= true
		tab_send.tabpage_mail.cbx_receipt.checked= false
	     tab_send.tabpage_mail.cbx_copiamittente.enabled= true	
		tab_send.tabpage_mail.cbx_copiamittente.checked= false 
		tab_send.tabpage_mail.dw_liste_mail.reset()
		tab_send.tabpage_mail.dw_allegati.reset()
		tab_send.tabpage_mail.pb_invia.enabled= false

		
		//tab_send.tabpage_mail.sle_mittente.text= s_sms_s.as_mailfrom
		
		// verifico che nella lista ci siano destinatari con riferimenti del tipo relativo all'invio che voglio fare...
		
		ll_count= tab_send.tabpage_mail.dw_liste_mail.retrieve(as_lista_s.idx, as_lista_s.cod_rif)
		
		 tab_send.tabpage_mail.dw_liste_mail.setFilter ("match( riferimento_descr , '@@') or (NOT match(  riferimento_descr , '@')) or isNull(riferimento_descr) or riferimento_descr=''" )
		 	 
		 tab_send.tabpage_mail.dw_liste_mail.filter()
			for ll_idx= 1 to  ll_count
				 tab_send.tabpage_mail.dw_liste_mail.setItem(ll_idx, "invio_ok", "0")
			next
		 tab_send.tabpage_mail.dw_liste_mail.setFilter("")
		 tab_send.tabpage_mail.dw_liste_mail.filter()		
		
	case "DOC"
		
		tab_send.tabpage_mail.enabled= false
		tab_send.tabpage_lettera.enabled= true
		tab_send.tabpage_etichette.enabled= false
		tab_send.tabpage_sms.enabled= false		
		tab_send.selectTab(tab_send.tabpage_lettera)
		
	case "LABELS"
		
		tab_send.tabpage_mail.enabled= false
		tab_send.tabpage_lettera.enabled= false
		tab_send.tabpage_etichette.enabled= true		
		tab_send.tabpage_sms.enabled= false		
		tab_send.selectTab(tab_send.tabpage_etichette)
		
		ll_count= tab_send.tabpage_etichette.dw_etichette.retrieve(as_lista_s.idx)
		
	case "SMS"

		tab_send.tabpage_mail.enabled= false
		tab_send.tabpage_lettera.enabled= false
		tab_send.tabpage_etichette.enabled= false		
		tab_send.tabpage_sms.enabled= true		
		tab_send.selectTab(tab_send.tabpage_sms)
		
		// verifico che nella lista ci siano destinatari con riferimenti del tipo relativo all'invio che voglio fare...
		
		ll_count= tab_send.tabpage_sms.dw_liste_sms.retrieve(as_lista_s.idx, as_lista_s.cod_rif)
		 	 
			for ll_idx= 1 to  ll_count
				 tab_send.tabpage_mail.dw_liste_mail.setItem(ll_idx, "invio_ok", "1")
			next

		
end choose

this.setRedraw(true)

return 0

nessuno:

this.setRedraw(true)

messageBox(this.title, "Nessun destinatario definito nella lista.", information!)

return 0


end event

public function integer wf_ismessage ();choose case tab_send.selectedTab
		
	case 1 //email
		
	if len(tab_send.tabpage_mail.mle_messaggio.text) > 0 then goto message
	
	case 2 // sms
	
		if len(tab_send.tabpage_sms.mle_messaggiosms.text) > 0 then goto message	
		
	case 3 //docs
		
	//

	case 4 // etichette
	
		if tab_send.tabpage_etichette.dw_etichette.rowCount() > 0 then goto message

end choose

return 0

message:

if messageBox(this.title, "Stai scrivendo un messaggio: se prosegui verranno perse le modifiche. ~nVuoi proseguire?", question!, yesNo!, 2) = 2 then
	return 1 // non prosegue l'elaborazione
else
	return 0 // prosegue l'elaborazione
end if
end function

public function boolean wf_indirizzidoppi (datawindow adw_indirizzi, string as_riferimento);adw_indirizzi.setFilter("")
adw_indirizzi.filter()

adw_indirizzi.setFilter("riferimento_descr= '"+as_riferimento+"'")
adw_indirizzi.filter()

if adw_indirizzi.rowCount() > 1 then
	messageBox("test", "doppio: "+as_riferimento)
	return true
end if

return false
end function

public function integer wf_log_invio (integer ai_esito, s_lista as_lista_s);string ls_descrizione, ls_cod_tipo, ls_genere

	select descrizione, genere
		into	:ls_descrizione, 
				:ls_genere
	from liste
	where idx= :as_lista_s.idx;

	if trap_sql(sqlca, "LOGINVIO01") < 0 then return -1

	INSERT INTO liste_invio  
         ( idx,   
           dt_invio,   
           descrizione,
		 cod_tipo,
           utente,   
           esito )  
	VALUES 
  		( :as_lista_s.idx,   
           getDate(),   
           :ls_descrizione, 
		 :as_lista_s.tipo_lista,
           :s_utente_s.s_nome_esteso,   
           :ai_esito)  ;
			  
	if trap_sql(sqlca, "LOGINVIO02") < 0 then return -1
	
	commit;
	
	if trap_sql(sqlca, "LOGINVIO01") >=0  then return 0
			  
	rollback;

	return -1


end function

on w_liste_invio_tab_pb.create
this.tab_send=create tab_send
this.gb_2=create gb_2
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_7=create gb_7
this.Control[]={this.tab_send,&
this.gb_2,&
this.gb_5,&
this.gb_6,&
this.gb_7}
end on

on w_liste_invio_tab_pb.destroy
destroy(this.tab_send)
destroy(this.gb_2)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_7)
end on

event open;s_session_s.context= "Invio liste"

tab_send.tabpage_mail.dw_liste_mail.setTransObject(sqlca)
tab_send.tabpage_lettera.dw_liste_documenti.setTransObject(sqlca)
tab_send.tabpage_etichette.dw_etichette.setTransObject(sqlca)
tab_send.tabpage_sms.dw_liste_sms.setTransObject(sqlca)



end event

event resize;tab_send.height= this.height - tab_send.y - 180
//tab_send.x= (this.width - tab_send.width)/2

end event

event closequery;integer li_ret
li_ret= wf_ismessage() 	
return li_ret 
end event

type tab_send from tab within w_liste_invio_tab_pb
event create ( )
event destroy ( )
integer y = 4
integer width = 4101
integer height = 2492
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_mail tabpage_mail
tabpage_sms tabpage_sms
tabpage_lettera tabpage_lettera
tabpage_etichette tabpage_etichette
end type

on tab_send.create
this.tabpage_mail=create tabpage_mail
this.tabpage_sms=create tabpage_sms
this.tabpage_lettera=create tabpage_lettera
this.tabpage_etichette=create tabpage_etichette
this.Control[]={this.tabpage_mail,&
this.tabpage_sms,&
this.tabpage_lettera,&
this.tabpage_etichette}
end on

on tab_send.destroy
destroy(this.tabpage_mail)
destroy(this.tabpage_sms)
destroy(this.tabpage_lettera)
destroy(this.tabpage_etichette)
end on

event selectionchanging;if wf_ismessage()= 1 then
	return 1
else
	tab_send.tabpage_mail.mle_messaggio.text= ""
	tab_send.tabpage_mail.cbx_lista.checked= false
	tab_send.tabpage_mail.cbx_lista.enabled= true	
	tab_send.tabpage_mail.cbx_receipt.checked= false
	tab_send.tabpage_mail.cbx_copiamittente.checked= false	
end if
	
choose case newindex
		
	case 1
		
		tab_send.tabpage_mail.gb_body.height= tab_send.height - tab_send.tabpage_mail.gb_body.y - 160
		
		tab_send.tabpage_mail.gb_allegati.height= tab_send.tabpage_mail.gb_body.height
	
		tab_send.tabpage_mail.mle_messaggio.height= tab_send.tabpage_mail.gb_body.height  - 90
		
		tab_send.tabpage_mail.dw_allegati.height= tab_send.tabpage_mail.gb_allegati.height  - 90
		
	case 2
		
		tab_send.tabpage_sms.gb_bodysms.height= tab_send.height - tab_send.tabpage_sms.gb_bodysms.y - 120

//	tab_send.tabpage_sms.mle_messaggiosms.height= tab_send.tabpage_sms.gb_bodysms.y  - tab_send.tabpage_sms.mle_messaggiosms.y - 30		
		


	case 3
	
		tab_send.tabpage_lettera.gb_bodydoc.height= tab_send.height - tab_send.tabpage_lettera.gb_bodydoc.y - 180

//	tab_send.tabpage_lettera.mle_messaggio.height= tab_send.tabpage_lettera.gb_bodydoc.height  - 240
//	tab_send.tabpage_lettera.dw_allegati.height= tab_send.tabpage_lettera.gb_bodydoc.height  - 240


	case 4
	
		tab_send.tabpage_etichette.gb_labels.height= tab_send.height - tab_send.tabpage_etichette.gb_labels.y  - 180
		tab_send.tabpage_etichette.dw_etichette.height= tab_send.tabpage_etichette.gb_labels.height  - tab_send.tabpage_etichette.gb_labels.y  - tab_send.tabpage_etichette.dw_etichette.y - 30	
	
end choose
end event

type tabpage_mail from userobject within tab_send
integer x = 18
integer y = 100
integer width = 4064
integer height = 2376
boolean enabled = false
long backcolor = 67108864
string text = "e-mail"
long tabtextcolor = 8388608
long picturemaskcolor = 536870912
st_1 st_1
pb_invia pb_invia
cbx_copiamittente cbx_copiamittente
sle_oggetto sle_oggetto
cbx_receipt cbx_receipt
mle_messaggio mle_messaggio
dw_allegati dw_allegati
dw_liste_mail dw_liste_mail
gb_3 gb_3
gb_body gb_body
gb_1 gb_1
gb_4 gb_4
gb_mittente gb_mittente
sle_mittente sle_mittente
cbx_lista cbx_lista
gb_allegati gb_allegati
end type

on tabpage_mail.create
this.st_1=create st_1
this.pb_invia=create pb_invia
this.cbx_copiamittente=create cbx_copiamittente
this.sle_oggetto=create sle_oggetto
this.cbx_receipt=create cbx_receipt
this.mle_messaggio=create mle_messaggio
this.dw_allegati=create dw_allegati
this.dw_liste_mail=create dw_liste_mail
this.gb_3=create gb_3
this.gb_body=create gb_body
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_mittente=create gb_mittente
this.sle_mittente=create sle_mittente
this.cbx_lista=create cbx_lista
this.gb_allegati=create gb_allegati
this.Control[]={this.st_1,&
this.pb_invia,&
this.cbx_copiamittente,&
this.sle_oggetto,&
this.cbx_receipt,&
this.mle_messaggio,&
this.dw_allegati,&
this.dw_liste_mail,&
this.gb_3,&
this.gb_body,&
this.gb_1,&
this.gb_4,&
this.gb_mittente,&
this.sle_mittente,&
this.cbx_lista,&
this.gb_allegati}
end on

on tabpage_mail.destroy
destroy(this.st_1)
destroy(this.pb_invia)
destroy(this.cbx_copiamittente)
destroy(this.sle_oggetto)
destroy(this.cbx_receipt)
destroy(this.mle_messaggio)
destroy(this.dw_allegati)
destroy(this.dw_liste_mail)
destroy(this.gb_3)
destroy(this.gb_body)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_mittente)
destroy(this.sle_mittente)
destroy(this.cbx_lista)
destroy(this.gb_allegati)
end on

type st_1 from statictext within tabpage_mail
integer x = 466
integer y = 1536
integer width = 480
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Invia il messaggio: "
boolean focusrectangle = false
end type

type pb_invia from picturebutton within tabpage_mail
integer x = 951
integer y = 1472
integer width = 201
integer height = 176
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "sendmail6.jpg"
alignment htextalign = left!
end type

event clicked;boolean lb_doppio
integer li_ret, li_random, li_tipo
long ll_idx= 1, ll_tgt= 0, ll_found, ll_totrows, ll_totmail, ll_invio= 0, ll_modulo= 1
string ls_descr, ls_nome, ls_disclaimer
mailFileDescription a_mailFileDescription[]
mailMessage lmailMessage_s
s_sms ls_sms_s

ls_sms_s= s_sms_s

if len(mle_messaggio.text)= 0 then
	
	messageBox(parent.text, "Non è stato scritto il testo.", StopSign!)
	return 0
	
end if

if pos(mle_messaggio.text, '"') > 0 then
	
	messageBox(parent.text, "Rimuovere le virgolette dal testo del messaggio", StopSign!)
	return 0
	
end if

if sle_oggetto.text= "" or isNull(sle_oggetto.text) then
	
	messageBox(parent.text, "Occorre inserire l'oggetto del messaggio", StopSign!)
	return 0
	
end if

if pos(sle_oggetto.text, '"') > 0 then
	
	messageBox(parent.text, "Rimuovere le virgolette dall'oggetto", StopSign!)
	return 0
	
end if


if sle_mittente.text= "" or isNull(sle_mittente.text) or pos(sle_mittente.text , "@")= 0 then
	
	messageBox(parent.text, "Indirizzo mail del mittente non corretto: verificare", StopSign!)
	return 0
	
end if

if pos(sle_mittente.text, "@sgi-italia.org") = 0 then
	
	messageBox(parent.text, "L'indirizzo deve corrispondere ad una mail del dominio sgi-italia.org~n( es. xyz@sgi-italia.org )", StopSign!)
	return 0
	
end if

if pos(sle_mittente.text, " ") <> 0 then
	
	messageBox(parent.text, "L'indirizzo del mittente contiene uno spazio.~nRimuoverlo e poi ritentare l'invio del messaggio.", StopSign!)
	return 0
	
end if

open (w_email_pw)

if message.stringParm= "" then
	
	return -1
	
else
	
	ls_sms_s.as_mailpw=  message.stringParm
	
end if

this.enabled= false

 ls_sms_s.as_mailfrom= sle_mittente.text
 
 ls_sms_s.as_mailuser= sle_mittente.text

lmailMessage_s.subject= sle_oggetto.text

lmailMessage_s.noteText= mle_messaggio.text

ls_disclaimer= f_readdisclaimer()

if ls_disclaimer <> "" then 
	
	//messageBox("Disclaimer", "Errore in lettura disclaimer") 

	lmailMessage_s.noteText += ls_disclaimer
	
end if

for ll_idx= 1 to dw_allegati.rowCount()
						
		lmailMessage_s.attachmentFile[ll_idx].filename= dw_allegati.getItemString(ll_idx, "name")
		
		lmailMessage_s.attachmentFile[ll_idx].pathName=  dw_allegati.getItemString(ll_idx, "fullpath")
		
	//	lmailMessage_s.attachmentFile[ll_idx].position=  2

next	

lmailMessage_s.ReceiptRequested= ib_receiptrequested

li_random= rand(30000)

	for ll_idx= 1 to dw_liste_mail.rowCount()
		
		if dw_liste_mail.getItemString(ll_idx, "invio_ok")= '0' then continue
		
				ls_descr= f_trim_all(dw_liste_mail.getItemString(ll_idx, "riferimento_descr"))
				
				ls_nome= trim(dw_liste_mail.getItemString(ll_idx, "cognome"))+" "+trim(dw_liste_mail.getItemString(ll_idx, "nome"))
				
				if pos(ls_descr , "@")= 0 or &
									isNull(ls_descr) or &
										len(ls_descr)= 0 then continue
										
				li_tipo= integer(dw_liste_mail.getItemString(ll_idx, "tipo_invio"))				
										
				INSERT INTO liste_tmp
				(idx,
				 riferimento_descr,
				 id_session,
				 tipo_invio,
				 nome)
				 VALUES
				 (:id_idx,
				  :ls_descr,
				  :li_random,
				  :li_tipo,
				  :ls_nome);
				  
				  if trap_sql(sqlca, "INSLISTETMP01") < 0 then goto errore
				  
	next

	if cbx_copiamittente.checked= true then
		
		ll_tgt ++
		
		lmailMessage_s.recipient[ll_tgt].address= trim(sle_mittente.text)
		
		lmailMessage_s.recipient[ll_tgt].name= "Mittente"
		
		lmailMessage_s.recipient[ll_tgt].recipientType= mailBCC!	
		
		li_ret=  f_sendmail(lmailMessage_s, ls_sms_s)
		
		ll_tgt= 0
		
	end if
	
		li_tipo= 3 // default bcc
	
open(w_wait_meter)

w_wait_meter.hpb_meter.position= 0
	
select count(*) into :ll_totmail from liste_tmp where idx= :id_idx and id_session= :li_random;
	
if trap_sql(sqlca, "INSLISTETMP01.01") < 0 then goto errore
	
declare liste_cur cursor for
select distinct riferimento_descr, tipo_invio, nome
from liste_tmp
where idx= :id_idx and id_session= :li_random order by riferimento_descr;

open liste_cur;

 if trap_sql(sqlca, "INSLISTETMP02") < 0 then goto errore
	 
ll_tgt= 0
ll_idx= 0

w_wait_meter.st_wait.text= "Generazione ed invio messaggi..."
	
	do while sqlca.sqlcode <> 100
		
		fetch liste_cur into :ls_descr, :li_tipo, :ls_nome;
		
		if trap_sql(sqlca, "INSLISTETMP03") < 0 then goto errore
		
		if sqlca.sqlcode= 100 then continue
		
		ll_tgt++
		ll_idx++
	
				//li_tipo= 3 // default bcc... da rivedere
		
				lmailMessage_s.recipient[ll_tgt].address= ls_descr
		
				lmailMessage_s.recipient[ll_tgt].name= ls_nome
		
				choose case li_tipo
					case 1
							lmailMessage_s.recipient[ll_tgt].recipientType= mailTO!
					case 2
							lmailMessage_s.recipient[ll_tgt].recipientType= mailCC!				
					case 3
							lmailMessage_s.recipient[ll_tgt].recipientType= mailBCC!
				end choose	
					
				w_wait_meter.hpb_meter.position= 100*(ll_idx/ll_totmail)
				
				if ll_tgt= ll_modulo OR ll_idx= ll_totmail then
					
						ls_sms_s.ai_maxnames= ll_tgt
			
						li_ret=  f_sendmail(lmailMessage_s, ls_sms_s)
					
							IF li_ret= 1 THEN
										
										//MessageBox("Invio messaggi", "Dei messaggi non sono stati inviati.")
										// scrive NOK nella colonna "esito"
										
										dw_liste_mail.setItem(ll_idx, "esito_invio",  -1)
										
									else
										
										dw_liste_mail.setItem(ll_idx, "esito_invio", 1)
							
							end if
							
						//li_ret= 0
						
						ll_tgt= 0
			
						//w_wait_meter.hpb_meter.position= 100*(ll_invio/ll_totmail)
					 
				//end if
			
			//messageBox("test", "inviate: "+string(ll_invio))
			
			end if
			
loop

close(w_wait_meter)

delete from liste_tmp where idx= :id_idx and id_session= :li_random; // GdS 05/09/2011

if trap_sql(sqlca, "INSLISTETMP04") < 0 then goto errore
	 
MessageBox("Invio messaggi", "Messaggi inviati.")	 

//if li_ret= 0 then
//	sle_oggetto.text= ""
//	mle_messaggio.text= ""
//	cbx_lista.enabled= true
//	cbx_lista.checked= false
//	cbx_receipt.enabled= true
//	cbx_receipt.checked= false
//     cbx_copiamittente.enabled= true	
//	cbx_copiamittente.checked= false 
//	dw_liste_mail.reset()
//	dw_allegati.reset()
//	pb_invia.enabled= false
//else
//	pb_invia.enabled= true
//end if
	
return wf_log_invio(li_ret, is_lista_s) 

errore:

	close(w_wait_meter)

	rollback;

	return -1






end event

type cbx_copiamittente from checkbox within tabpage_mail
integer x = 3369
integer y = 1536
integer width = 576
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Invia copia al mittente"
end type

type sle_oggetto from singlelineedit within tabpage_mail
integer x = 18
integer y = 1320
integer width = 1938
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 16777215
boolean autohscroll = false
integer limit = 60
end type

event getfocus;this.selectText(1, Len(this.Text))
end event

type cbx_receipt from checkbox within tabpage_mail
integer x = 2853
integer y = 1540
integer width = 521
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "Ricevuta di ritorno"
end type

event clicked;if cbx_receipt.checked= true then ib_receiptrequested=true
end event

type mle_messaggio from multilineedit within tabpage_mail
integer x = 18
integer y = 1684
integer width = 1938
integer height = 500
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean vscrollbar = true
boolean autovscroll = true
integer tabstop[] = {0}
borderstyle borderstyle = stylelowered!
end type

type dw_allegati from datawindow within tabpage_mail
integer x = 2021
integer y = 1684
integer width = 1920
integer height = 500
integer taborder = 80
string title = "none"
string dataobject = "edw_allegati"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;choose case dwo.name
		
	case "b_p"
		
	string ls_docname, ls_named, ls_docdir
	long ll_row
	integer li_ret
	
	ls_docdir= s_utente_s.s_mydocuments
	
	setCurrentDirectoryW(ls_docdir)
	
	li_ret = GetFileOpenName("Seleziona un file", &
			+ ls_docname, ls_named, "doc", &
			+ "Doc Files (*.doc),*.doc,PDF Files (*.pdf), *.pdf,Excel Files (*.xls), *.xls,Text Files (*.txt),*.txt,Tutti i tipi (*.*),*.*")
			
	if li_ret= 1 then
		
		// verifica che non sia stato già allegato
		
		ll_row= this.Find ("name= ~'"+ls_named+"~'" , 1, this.rowCount() ) 
		
		if ll_row > 0 then
			messageBox("Allegati", "Questo file è già stato allegato.", information!)
			return 0
		end if
		
		ll_row= this.insertRow(0)
		this.setItem(ll_row, "fullpath", ls_docname)
		this.setItem(ll_row, "name", ls_named)
		
	end if	
		
		
	case "b_m"
		
		this.deleteRow(0)
		
end choose
end event

type dw_liste_mail from datawindow within tabpage_mail
event type integer ue_lista ( string as_cod_lista )
integer x = 18
integer y = 56
integer width = 3922
integer height = 1164
integer taborder = 30
string title = "none"
string dataobject = "dw_liste_destinatari_mail_rif"
boolean vscrollbar = true
boolean livescroll = true
end type

event type integer ue_lista(string as_cod_lista);string ls_tipo

//tab_send.enabled= false
//if tab_send.tabpage_mail.dw_liste_mail.retrieve(as_cod_lista) > 0 then tab_send.enabled= true
//
//select cod_tipo
//	into :ls_tipo
//	from liste
//where cod_lista= :as_cod_lista;
//
//if trap_sql(sqlca, "SELLISTE01") < 0 then return -1
//
//choose case ls_tipo
//		
//	case "MAIL"
//		
//		if tab_send.tabpage_mail.dw_liste_mail.retrieve(as_cod_lista) > 0 then tab_send.enabled= true
//		tab_send.tabpage_mail.enabled= true
//		tab_send.tabpage_lettera.enabled= false
//		tab_send.tabpage_etichette.enabled= false		
//		tab_send.selectTab(tab_send.tabpage_mail)
//		
//	case "DOC"
//
//		if tab_send.tabpage_lettera.dw_liste_documenti.retrieve(as_cod_lista) > 0 then tab_send.enabled= true
//		tab_send.tabpage_mail.enabled= false
//		tab_send.tabpage_lettera.enabled= true
//		tab_send.tabpage_etichette.enabled= false
//		tab_send.selectTab(tab_send.tabpage_lettera)
//		
//	case "LABELS"
//		
//		if tab_send.tabpage_etichette.dw_etichette.retrieve(as_cod_lista) > 0 then tab_send.enabled= true		
//		tab_send.tabpage_mail.enabled= false
//		tab_send.tabpage_lettera.enabled= false
//		tab_send.tabpage_etichette.enabled= true		
//		tab_send.selectTab(tab_send.tabpage_etichette)
//		
//	case "SMS"
//		
//		if tab_send.tabpage_etichette.dw_etichette.retrieve(as_cod_lista) > 0 then tab_send.enabled= true		
//		tab_send.tabpage_mail.enabled= false
//		tab_send.tabpage_lettera.enabled= false
//		tab_send.tabpage_etichette.enabled= true		
//		tab_send.selectTab(tab_send.tabpage_etichette)
//		
//end choose

return 0
end event

event retrieveend;if rowcount> 0 then
	tab_send.tabpage_mail.pb_invia.enabled= true
	sle_oggetto.text= "Invio di: "+this.getItemString(1, "liste_descrizione")
else
	sle_oggetto.text= "	"
end if

return 0
end event

event rowfocuschanged;//f_select_current_row(this)
end event

event buttonclicked;s_session ls_session_s

ls_session_s= s_session_s

choose case dwo.name
		
	case "b_ok"
		
		long ll_idx
		
		this.setRedraw(false)
		
		if ib_oktoggle= false then
			
			// tutti NOK
			
			this.setFilter("invio_ok= '1'")
			this.filter()
			
			for ll_idx= 1 to this.rowCount()
				
				this.setItem(ll_idx, "invio_ok", '0')
				
			next
			
			this.object.b_ok.text= 'Tutti'
			
		else
			
			// tutti OK
			
			this.setFilter("invio_ok= '0'")
			this.filter()
			
			for ll_idx= 1 to this.rowCount()
				
				this.setItem(ll_idx, "invio_ok", '1')
				
			next		
			
			this.object.b_ok.text= 'Nessuno'
			
		end if
		
		this.setFilter("")
		this.filter()
		
		ib_oktoggle= NOT ib_oktoggle
		
		this.setRedraw(true)
		
	case "b_ordina"
		
		string ls_sort
		
		openWIthParm(w_ordina, this)
		
		ls_sort= message.stringParm
		
		this.setSort(ls_sort)
		
		this.sort()
		
	case "b_p"
		
	case "b_m"
		
		if this.rowCount()= 0 then return 0
		
		if messageBox(parent.text, "Il destinatario verrà cancellato dalla lista solo per questo invio.~nPer cancellarlo definitivamente occorre utliizzare la procedura <Gestione anagrafica> <Liste>~nConfermi?", question!, yesNo!, 2)= 2 then return 0

		this.deleteRow(0)

		if this.rowCount()= 0 then tab_send.tabpage_mail.pb_invia.enabled= false
		
		
end choose
	
end event

type gb_3 from groupbox within tabpage_mail
integer width = 3977
integer height = 1248
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lista destinatari"
end type

type gb_body from groupbox within tabpage_mail
integer y = 1632
integer width = 1984
integer height = 564
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Testo del messaggio"
end type

type gb_1 from groupbox within tabpage_mail
integer y = 1260
integer width = 1984
integer height = 204
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Oggetto: "
end type

type gb_4 from groupbox within tabpage_mail
integer x = 1998
integer y = 1484
integer width = 1979
integer height = 152
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Opzioni"
end type

type gb_mittente from groupbox within tabpage_mail
integer x = 1998
integer y = 1260
integer width = 1979
integer height = 204
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Indirizzo email del mittente ( deve essere un~'email del tipo nome@sgi-italia.org"
end type

type sle_mittente from singlelineedit within tabpage_mail
integer x = 2016
integer y = 1320
integer width = 1925
integer height = 120
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 16777215
end type

event getfocus;this.selectText(1, Len(this.Text))
end event

event modified;if this.text <> "" and NOT isNull(this.text) then s_sms_s.as_mailfrom= this.text 
end event

type cbx_lista from checkbox within tabpage_mail
integer x = 2053
integer y = 1532
integer width = 768
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Inserisci la lista di distribuzione"
end type

event clicked;long ll_idx
string ls_destinatario

this.enabled= false

dw_liste_mail.setRedraw(false)

dw_liste_mail.setSort("nome, cognome")
dw_liste_mail.sort()

for ll_idx= 1 to dw_liste_mail.rowCount()
	
	if pos(dw_liste_mail.getItemString(ll_idx, "riferimento_descr") , "@")= 0 or &
		len(trim(dw_liste_mail.getItemString(ll_idx, "riferimento_descr")))= 0 or &
			dw_liste_mail.getItemString(ll_idx, "invio_ok")= '0' then continue
	
	ls_destinatario += "~n"+f_iniziali(trim(dw_liste_mail.getItemString(ll_idx, "nome") )+" "+trim(dw_liste_mail.getItemString(ll_idx, "cognome")))+"; "
	
next

mle_messaggio.text="Lista di distribuzione: "+ls_destinatario+"~n~n"+mle_messaggio.text

dw_liste_mail.setSort("vc_parent, cognome, nome")
dw_liste_mail.sort()

dw_liste_mail.setRedraw(true)

this.enabled= true

end event

type gb_allegati from groupbox within tabpage_mail
integer x = 1998
integer y = 1632
integer width = 1979
integer height = 564
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Allegati"
end type

type tabpage_sms from userobject within tab_send
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4064
integer height = 2376
boolean enabled = false
long backcolor = 67108864
string text = "SMS"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_inviasms cb_inviasms
dw_liste_sms dw_liste_sms
gb_sms gb_sms
mle_messaggiosms mle_messaggiosms
gb_bodysms gb_bodysms
end type

on tabpage_sms.create
this.cb_inviasms=create cb_inviasms
this.dw_liste_sms=create dw_liste_sms
this.gb_sms=create gb_sms
this.mle_messaggiosms=create mle_messaggiosms
this.gb_bodysms=create gb_bodysms
this.Control[]={this.cb_inviasms,&
this.dw_liste_sms,&
this.gb_sms,&
this.mle_messaggiosms,&
this.gb_bodysms}
end on

on tabpage_sms.destroy
destroy(this.cb_inviasms)
destroy(this.dw_liste_sms)
destroy(this.gb_sms)
destroy(this.mle_messaggiosms)
destroy(this.gb_bodysms)
end on

type cb_inviasms from commandbutton within tabpage_sms
integer x = 1367
integer y = 1500
integer width = 608
integer height = 136
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Invia >>"
end type

event clicked;boolean lb_doppio
integer li_ret, li_random
long  ll_idx= 1, ll_tgt= 1, ll_totrows
string ls_number, ls_descr, ls_testo
mailMessage lmailMessage_s
s_sms ls_sms_s

if len(mle_messaggiosms.text)= 0 then
	
	messageBox(parent.text, "Non è stato scritto il testo.", information!)
	return 0
	
end if

ls_sms_s= s_sms_s

openWithParm(w_check_pw, s_utente_s)

if message.doubleParm= -1 then return -1

mailFileDescription a_mailFileDescription[]

lmailMessage_s.subject= "SMS"

ls_testo= f_replace_chars(mle_messaggiosms.text, '"', "'")

lmailMessage_s.noteText= ls_testo

dw_liste_sms.setRedraw(false)

li_random= rand(30000)

for ll_idx= 1 to dw_liste_sms.rowCount()
	
	if dw_liste_sms.getItemString(ll_idx, "invio_ok")= '0' then continue
	
	ls_number= dw_liste_sms.getItemString(ll_idx, "riferimento_descr")
	ls_number= f_cleanphonenumber(ls_number)

 if( ls_number ="" or ( NOT isNumber( ls_number ) ) ) then continue

	// aggiunge il prefisso internazionale Italiano (39)

	ls_number = '39'+ls_number
	
	ls_number= trim(ls_number+"@"+ls_sms_s.as_smsgateway)
	
	if pos(ls_number , "@")= 0 or &
			dw_liste_sms.getItemString(ll_idx, "invio_ok")= '0' or &
				isNull(ls_number) or &
					len(trim(ls_number))= 0 then continue
					
		 INSERT INTO dbo.liste_tmp  
         		( idx,   
           	  riferimento_descr,   
                 id_session )  
		  VALUES ( :id_idx,   
					   :ls_number,   
					   :li_random );
						
		 if trap_sql(sqlca, "INSLISTETMP01") < 0 then goto errore					
						
next

declare liste_cur cursor for
select distinct riferimento_descr
from liste_tmp
where idx= :id_idx and id_session= :li_random;

open liste_cur;

 if trap_sql(sqlca, "INSLISTETMP02") < 0 then goto errore

	do while sqlca.sqlcode <> 100
	
		fetch liste_cur into :ls_descr;
		
		if trap_sql(sqlca, "INSLISTETMP03") < 0 then goto errore
		
		if sqlca.sqlcode= 100 then continue
		
			lmailMessage_s.recipient[ll_tgt].address= ls_descr
			
			lmailMessage_s.recipient[ll_tgt].recipientType= mailTO!		
			
			lmailMessage_s.recipient[ll_tgt].name= "smsgateway"
			
			ll_tgt++
		
	loop

delete from liste_tmp where idx= :id_idx and id_session= :li_random;

 if trap_sql(sqlca, "INSLISTETMP04") < 0 then goto errore

dw_liste_sms.setRedraw(true)

ls_sms_s.as_mailuser= ls_sms_s.as_smsuser
ls_sms_s.as_mailpw= ls_sms_s.as_smspw

ls_sms_s.as_mailfrom= s_sms_s.as_smsfrom

li_ret= f_sendmail(lmailMessage_s, ls_sms_s)

if li_ret= 0 then
	mle_messaggiosms.text= ""
	cb_inviasms.enabled= false
end if	

return wf_log_invio(li_ret, is_lista_s)

errore:

rollback;

return -1
end event

type dw_liste_sms from datawindow within tabpage_sms
event type integer ue_lista ( string as_cod_lista )
integer x = 18
integer y = 56
integer width = 3781
integer height = 1356
integer taborder = 40
string title = "none"
string dataobject = "dw_liste_destinatari_sms_rif"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;s_session ls_session_s

ls_session_s= s_session_s

choose case dwo.name
		
	case "b_ok"
		
		long ll_idx
		
		this.setRedraw(false)
		
		if ib_oktoggle= false then
			
			// tutti NOK
			
			this.setFilter("invio_ok= '1'")
			this.filter()
			
			for ll_idx= 1 to this.rowCount()
				
				this.setItem(ll_idx, "invio_ok", '0')
				
			next
			
			this.object.b_ok.text= 'Tutti'
			
		else
			
			// tutti OK
			
			this.setFilter("invio_ok= '0'")
			this.filter()
			
			for ll_idx= 1 to this.rowCount()
				
				this.setItem(ll_idx, "invio_ok", '1')
				
			next		
			
			this.object.b_ok.text= 'Nessuno'
			
		end if
		
		this.setFilter("")
		this.filter()
		
		ib_oktoggle= NOT ib_oktoggle
		
		this.setRedraw(true)
		
	case "b_ordina"
		
		string ls_sort
		
		openWIthParm(w_ordina, this)
		
		ls_sort= message.stringParm
		
		this.setSort(ls_sort)
		
		this.sort()
				
		
	case "b_p"
		
	case "b_m"
		
		if this.rowCount()= 0 then return 0
		
		if messageBox(parent.text, "Il destinatario verrà cancellato dalla lista solo per questo invio.~nPer cancellarlo definitivamente occorre utliizzare la procedura <Gestione anagrafica> <Liste>~nConfermi?", question!, yesNo!, 2)= 2 then return 0

		this.deleteRow(0)
		
		if this.rowCount()= 0 then tab_send.tabpage_mail.pb_invia.enabled= false
		
end choose
end event

event rowfocuschanged;f_select_current_row(this)
end event

event retrieveend;if rowcount> 0 then
	tab_send.tabpage_sms.cb_inviasms.enabled= true
	mle_messaggiosms.setFocus()
end if

return 0
end event

type gb_sms from groupbox within tabpage_sms
integer width = 3831
integer height = 1440
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lista destinatari"
end type

type mle_messaggiosms from multilineedit within tabpage_sms
integer x = 50
integer y = 1652
integer width = 3429
integer height = 280
integer taborder = 70
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autovscroll = true
integer limit = 160
integer tabstop[] = {0}
borderstyle borderstyle = stylelowered!
end type

type gb_bodysms from groupbox within tabpage_sms
integer y = 1456
integer width = 3538
integer height = 516
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Testo del messaggio ( max. 160 caratteri )"
end type

type tabpage_lettera from userobject within tab_send
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4064
integer height = 2376
boolean enabled = false
long backcolor = 67108864
string text = "Documento - Mail Merge"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_cancella1 cb_cancella1
dw_liste_documenti dw_liste_documenti
gb_31 gb_31
gb_bodydoc gb_bodydoc
end type

on tabpage_lettera.create
this.cb_cancella1=create cb_cancella1
this.dw_liste_documenti=create dw_liste_documenti
this.gb_31=create gb_31
this.gb_bodydoc=create gb_bodydoc
this.Control[]={this.cb_cancella1,&
this.dw_liste_documenti,&
this.gb_31,&
this.gb_bodydoc}
end on

on tabpage_lettera.destroy
destroy(this.cb_cancella1)
destroy(this.dw_liste_documenti)
destroy(this.gb_31)
destroy(this.gb_bodydoc)
end on

type cb_cancella1 from commandbutton within tabpage_lettera
integer x = 2647
integer y = 940
integer width = 608
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Cancella destinatario"
end type

event clicked;//if dw_liste_documenti.rowCount() > 0 then
//	dw_liste_documenti.deleteRow(0)
//	messageBox(parent.text, "Il destinatario verrà cancellato dalla lista solo per questo invio.~nPer cancellarlo definitivamente occorre utliizzare la procedura <Gestione anagrafica> <Liste>", information!)
//end if
//
//if dw_liste_documenti.rowCount()= 0 then
//	cb_cancella.enabled= false
//	pb_invia.enabled= false
//	return 
//end if


end event

type dw_liste_documenti from datawindow within tabpage_lettera
integer x = 46
integer y = 76
integer width = 3209
integer height = 840
integer taborder = 40
string title = "none"
string dataobject = "dw_liste_destinatari_doc"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//if rowcount> 0 then
//	cb_cancella.enabled= true
//	pb_invia.enabled= true
//	sle_oggetto.text= "Invio di: "+this.getItemString(1, "liste_descrizione")
//else
//	sle_oggetto.text= "	"
//end if
//
//return 0
end event

type gb_31 from groupbox within tabpage_lettera
integer width = 3319
integer height = 1080
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_bodydoc from groupbox within tabpage_lettera
integer y = 1076
integer width = 3319
integer height = 912
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Invio"
end type

type tabpage_etichette from userobject within tab_send
integer x = 18
integer y = 100
integer width = 4064
integer height = 2376
boolean enabled = false
long backcolor = 67108864
string text = "Etichette"
long tabtextcolor = 8388736
long picturemaskcolor = 536870912
cb_setup_labels cb_setup_labels
cb_stampa_etichette cb_stampa_etichette
dw_etichette dw_etichette
gb_labels gb_labels
end type

on tabpage_etichette.create
this.cb_setup_labels=create cb_setup_labels
this.cb_stampa_etichette=create cb_stampa_etichette
this.dw_etichette=create dw_etichette
this.gb_labels=create gb_labels
this.Control[]={this.cb_setup_labels,&
this.cb_stampa_etichette,&
this.dw_etichette,&
this.gb_labels}
end on

on tabpage_etichette.destroy
destroy(this.cb_setup_labels)
destroy(this.cb_stampa_etichette)
destroy(this.dw_etichette)
destroy(this.gb_labels)
end on

type cb_setup_labels from commandbutton within tabpage_etichette
integer x = 2647
integer y = 64
integer width = 507
integer height = 112
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Setup etichette"
end type

event clicked;openWithParm(w_setup_labels, dw_etichette)
end event

type cb_stampa_etichette from commandbutton within tabpage_etichette
integer x = 3159
integer y = 64
integer width = 507
integer height = 112
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa etichette"
end type

event clicked;openWithParm(w_dw_print_options, dw_etichette)
end event

type dw_etichette from datawindow within tabpage_etichette
integer x = 32
integer y = 200
integer width = 3767
integer height = 2144
integer taborder = 20
string title = "none"
string dataobject = "dw_liste_destinatari_labels"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type gb_labels from groupbox within tabpage_etichette
integer width = 3831
integer height = 2372
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_liste_invio_tab_pb
integer x = 78
integer y = 456
integer width = 480
integer height = 400
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
end type

type gb_5 from groupbox within w_liste_invio_tab_pb
integer x = 1609
integer y = 1300
integer width = 1979
integer height = 152
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Opzioni"
end type

type gb_6 from groupbox within w_liste_invio_tab_pb
integer x = 1559
integer y = 1300
integer width = 1979
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Opzioni"
end type

type gb_7 from groupbox within w_liste_invio_tab_pb
integer y = 1460
integer width = 1984
integer height = 652
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Testo del messaggio"
end type

