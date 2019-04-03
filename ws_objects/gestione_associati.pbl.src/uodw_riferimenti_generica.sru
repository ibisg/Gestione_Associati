$PBExportHeader$uodw_riferimenti_generica.sru
forward
global type uodw_riferimenti_generica from uodw_generica
end type
end forward

global type uodw_riferimenti_generica from uodw_generica
string dataobject = "dw_riferimenti"
end type
global uodw_riferimenti_generica uodw_riferimenti_generica

event buttonclicked;call super::buttonclicked;choose case dwo.name
		
//	case "b_p"
//		
////		this.setItem(uodw_rif.il_newrow, "codice", is_codice)
//		s_riferimenti s_riferimenti_s
//		s_riferimenti_s.codice= is_codice
//		s_riferimenti_s.idx= 0
//	     s_riferimenti_s.rif_membri= true
//		openWithParm(w_ins_riferimenti, s_riferimenti_s)
//		
//		this.setRedraw(false)
//			this.retrieve(is_codice)
//		this.setRedraw(true)
//		
//		// verifica che ogni per ogni tipo riferimento ci sia un riferimento preferito
////		if wf_riferimenti()= 1 then return 1

	case "b_invia"
			
			open(w_check_pw)
			
			if message.doubleParm= -1 then return -1
			
			string ls_mail
			
			ls_mail= this.getItemString(row, "riferimento_descr")
			
			if this.getItemString(row, "cod_rif")= "MA" then
				if pos(ls_mail, "@")= 0 or len(trim(ls_mail) )= 0 then
					messageBox("Errore", "Indirizzo di posta elettronica non valido.", exclamation!)
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
						
				ls_number= this.getItemString(row, "riferimento_descr")
				ls_number= f_cleanphonenumber(ls_number)
					
				if( ls_number ="" or ( NOT isNumber( ls_number ) ) ) then return -1
				
				// Numero di cellulare= tre cifre di prefisso più 7 cifre di numero telefonico
			
				if len(ls_number)= 10 then ls_number = '39'+ls_number
					
		//		if  mid( ls_number , 1, 2) <> '39' then ls_number = '39'+ls_number
						
				mMsg.recipient[1].name= "smsgateway"
						
				mMsg.recipient[1].address=  ls_number+"@"+s_sms_s.as_smsgateway
						
				mMsg.recipient[1].recipientType= mailTO!
				
				li_ret=  f_sendsms(mMsg, s_sms_s) 		
				
			end if
		
end choose
end event

on uodw_riferimenti_generica.create
call super::create
end on

on uodw_riferimenti_generica.destroy
call super::destroy
end on

