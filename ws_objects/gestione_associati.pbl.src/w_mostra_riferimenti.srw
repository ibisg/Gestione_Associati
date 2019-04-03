$PBExportHeader$w_mostra_riferimenti.srw
forward
global type w_mostra_riferimenti from window
end type
type uodw_riferimenti from uodw_generica within w_mostra_riferimenti
end type
end forward

global type w_mostra_riferimenti from window
integer width = 3173
integer height = 1524
boolean titlebar = true
string title = "Riferimenti"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
uodw_riferimenti uodw_riferimenti
end type
global w_mostra_riferimenti w_mostra_riferimenti

type variables
m_preview im_preview
end variables

event open;string ls_codice
s_ricercanominativa s_ricercanominativa_s

s_ricercanominativa_s= message.powerObjectParm

uodw_riferimenti.setTransObject(sqlca)

uodw_riferimenti.retrieve( s_ricercanominativa_s.codice )

this.title += " di: "+trim(s_ricercanominativa_s.nome)+" "+ trim(s_ricercanominativa_s.cognome)

end event

on w_mostra_riferimenti.create
this.uodw_riferimenti=create uodw_riferimenti
this.Control[]={this.uodw_riferimenti}
end on

on w_mostra_riferimenti.destroy
destroy(this.uodw_riferimenti)
end on

event resize;uodw_riferimenti.height= this.height - 120
end event

type uodw_riferimenti from uodw_generica within w_mostra_riferimenti
integer width = 3159
integer height = 1428
integer taborder = 10
string title = "Riferimenti"
string dataobject = "dw_riferimenti"
boolean controlmenu = true
boolean maxbox = false
boolean ib_isgrid = true
boolean ib_readonly = true
end type

event rbuttondown;call super::rbuttondown;im_preview= create m_preview

im_preview.iuodw_generica= uodw_riferimenti

im_preview.m_aggiungi.visible= false
im_preview.m_inserisci.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

im_preview.PopMenu ( w_mostra_riferimenti.PointerX(), w_mostra_riferimenti.PointerY() )
end event

event constructor;call super::constructor;
this.object.b_p.visible= NOT ib_readonly
this.object.b_aggiorna.visible= NOT ib_readonly
end event

event doubleclicked;call super::doubleclicked;//s_riferimenti s_riferimenti_s
//
//if row <= 0 then return 0
//
//s_riferimenti_s.codice=this.getItemString(row, "codice")
//
//if f_is_np(3) then return 0
//
//s_riferimenti_s.idx= this.getItemDecimal(row, "idx")
//s_riferimenti_s.rif_membri= true
//openWithParm(w_ins_riferimenti, s_riferimenti_s)
//this.retrieve(s_riferimenti_s.codice)
end event

event buttonclicked;call super::buttonclicked;if dwo.name= "b_invia" then
		
		open(w_check_pw)
		
		if message.doubleParm= -1 then return -1
		
		string ls_mail
		
		ls_mail= this.getItemString(row, "riferimento_descr")
		
		if this.getItemString(row, "cod_rif")= "MA" then
			if pos(ls_mail, "@")= 0 or len(trim(ls_mail) )= 0 then
				messageBox(parent.title, "Indirizzo di posta elettronica non valido.", exclamation!)
				return -1
			end if
			
			mailSession mSes
	
			mailReturnCode mRet
			
			mailMessage mMsg
			
			setPointer(hourGlass!)
			
			// Create a mail session
			
			mSes = create mailSession
			
			// Log on to the session
			
			mRet = mSes.mailLogon(mailNewSession!)
			
			IF mRet <> mailReturnSuccess! THEN
					MessageBox("Mail", 'Logon fallito.')
					return -1
			
			END IF
			
			mMsg.Recipient[1].address= trim(ls_mail)
			
			// Send the mail
			
			mRet = mSes.mailSend(mMsg) // +cc
			
			IF mRet <> mailReturnSuccess! THEN
					MessageBox("Mail Send", 'Mail non inviata')
					return -1
			
			END IF
			
			mSes.mailLogoff()
			
			DESTROY mSes
			
			return 0
			
		else // SMS
			
			integer li_ret
			long ll_idx
			string ls_number, ls_message
			
			open(w_composizione_sms)
			
			ls_message= message.stringParm
			
			if ls_message= "" then return -1
			
			mailFileDescription a_mailFileDescription[]
			
			mMsg.subject= "SMS"
			
			mMsg.noteText= ls_message
					
			ls_number= uodw_riferimenti.getItemString(row, "riferimento_descr")
			ls_number= f_cleanphonenumber(ls_number)
				
			if( ls_number ="" or ( NOT isNumber( ls_number ) ) ) then return -1
			
			// Numero di cellulare= tre cifre di prefisso più 7 cifre di numero telefonico
		
			/*if len(ls_number) <= 10 then*/ ls_number = '39'+ls_number
				
	//		if  mid( ls_number , 1, 2) <> '39' then ls_number = '39'+ls_number
					
			mMsg.recipient[1].name= "smsgateway"
					
			mMsg.recipient[1].address=  ls_number+"@"+s_sms_s.as_smsgateway
					
			mMsg.recipient[1].recipientType= mailTO!
			
	//		li_ret=  f_sendsms(mMsg, s_sms_s) 		
	
	//SMS

			s_sms_s.as_mailuser= s_sms_s.as_smsuser
			s_sms_s.as_mailpw= s_sms_s.as_smspw
			
			s_sms_s.as_mailfrom= s_sms_s.as_smsfrom
			
			//s_sms.as_mailfrom
			
			li_ret= f_sendmail(mMsg, s_sms_s)
			
			
	end if
	
end if
end event

