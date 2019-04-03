$PBExportHeader$w_utenti_web_old.srw
forward
global type w_utenti_web_old from w_generica_sheet
end type
end forward

global type w_utenti_web_old from w_generica_sheet
integer width = 6382
end type
global w_utenti_web_old w_utenti_web_old

on w_utenti_web_old.create
call super::create
end on

on w_utenti_web_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type uodw_current from w_generica_sheet`uodw_current within w_utenti_web_old
integer width = 6231
string dataobject = "dw_utenti_web"
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
end type

event uodw_current::itemchanged;call super::itemchanged;//	
//	if data= "1" then
//		
//		// invia SMS
//		
//			integer li_ret
//			long ll_idx
//			string ls_number, ls_message, ls_codice
//			mailMessage mMsg
//			
//			open(w_composizione_sms)
//			
//			ls_message= message.stringParm
//			
//			if ls_message= "" then return -1
//			
//			mailFileDescription a_mailFileDescription[]
//			
//			mMsg.subject= "SMS"
//			
//			mMsg.noteText= ls_message
//					
//		//	ls_number= uodw_rif.getItemString(row, "riferimento_descr")
//		
//			select riferimento_descr
//			into :ls_number
//			from riferimenti
//			where 
//			codice= :ls_codice and
//			predefinito= 1 and
//			cod_rif= "TM";
//			
//			if trap_sql(sqlca, "SENDSMS01") <  0 then return -1
//			
//			ls_number= f_cleanphonenumber(ls_number)
//				
//			if( ls_number ="" or ( NOT isNumber( ls_number ) ) ) then return -1
//			
//			// Numero di cellulare= tre cifre di prefisso più 7 cifre di numero telefonico
//		
//			/*if len(ls_number) <= 10 then*/ ls_number = '39'+ls_number
//				
//	//		if  mid( ls_number , 1, 2) <> '39' then ls_number = '39'+ls_number
//					
//			mMsg.recipient[1].name= "smsgateway"
//					
//			mMsg.recipient[1].address=  ls_number+"@"+s_sms_s.as_smsgateway
//					
//			mMsg.recipient[1].recipientType= mailTO!
//			
//	//		li_ret=  f_sendsms(mMsg, s_sms_s) 		
//	
//	//SMS
//
//			s_sms_s.as_mailuser= s_sms_s.as_smsuser
//			s_sms_s.as_mailpw= s_sms_s.as_smspw
//			
//			s_sms_s.as_mailfrom= s_sms_s.as_smsfrom
//			
//			//s_sms.as_mailfrom
//			
//			//li_ret= f_sendmail(mMsg, s_sms_s)
//			
//			
//		end if
//		
//end if
end event

event uodw_current::doubleclicked;call super::doubleclicked;if row = 0 then return

string ls_codice

ls_codice= this.getItemString(row, "codice")


openWithParm(w_gestioneaccessoremoto, ls_codice)

this.retrieve()
this.sort()
end event

