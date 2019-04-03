$PBExportHeader$w_visualizza_nuclei.srw
forward
global type w_visualizza_nuclei from w_centered
end type
type dw_gestione from datawindow within w_visualizza_nuclei
end type
end forward

global type w_visualizza_nuclei from w_centered
integer width = 3401
integer height = 1408
string title = "Nuclei familiari"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
boolean clientedge = true
dw_gestione dw_gestione
end type
global w_visualizza_nuclei w_visualizza_nuclei

type variables
boolean ib_codice= true
string is_codice
end variables

event open;call super::open;long ll_rows

dw_gestione.object.b_g.visible= false
dw_gestione.object.b_c.visible= false

dw_gestione.setTransObject(sqlca)

is_codice= message.stringParm
	
ll_rows=  dw_gestione.retrieve()

return ll_rows
end event

on w_visualizza_nuclei.create
int iCurrent
call super::create
this.dw_gestione=create dw_gestione
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_gestione
end on

on w_visualizza_nuclei.destroy
call super::destroy
destroy(this.dw_gestione)
end on

type dw_gestione from datawindow within w_visualizza_nuclei
event ue_cancellanucleo ( )
event type integer ue_generanucleo ( )
integer width = 3360
integer height = 1136
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_gestione_componenti"
boolean border = false
boolean livescroll = true
end type

event ue_cancellanucleo;long ll_idx

for ll_idx= 1 to this.rowCount()
	
	this.setItem(ll_idx, "codice_fam", "" )

	this.acceptText()
			
next


end event

event type integer ue_generanucleo();integer li_sumoka, li_sumtok, li_tot
long ll_found, ll_idx

// Controlla che ci siano almeno due componenti....

if rowCount() <= 1 then
	
	messageBox(parent.title, "Aggiungere almeno un altro componente", information!)
	
	return -1			
	
end if
	
// Controlla che ci sia un unico G. per tutto il nucleo...

li_sumoka= this.getItemNumber(this.getRow(), "c_sumoka")
li_sumtok=  this.getItemNumber(this.getRow(), "c_sumtok")

li_tot= li_sumoka + li_sumtok

choose case li_tot
		
	case 0
		
	messageBox(parent.title, "Nessuno dei componenti ha un Gohonzon assegnato", information!)
	
	return -1
	
case 1 // Identifica l'assegnatario, assegna i G. di famiglia mettendo F nel campo okatagi  o tokuso...
	
	if li_sumoka > 0 then
		
		ll_found= this.find( " okatagi= 'A'", 1, this.rowCount() )

		is_codice= this.getItemString(ll_found, "codice")
		
		for ll_idx= 1 to this.rowCount()
			
			this.setItem(ll_idx, "codice_fam", is_codice )
			
			if ll_idx= ll_found then continue
			
			this.setItem(ll_idx, "okatagi", "F" )

			this.acceptText()
					
		next	
		
	else
		
		ll_found= this.find( " tokuso= 'A'", 1, this.rowCount() )

		is_codice= this.getItemString(ll_found, "codice")
		
		for ll_idx= 1 to this.rowCount()
			
			this.setItem(ll_idx, "codice_fam", is_codice )
			
			if ll_idx= ll_found then continue
			
			this.setItem(ll_idx, "tokuso", "F" )

			this.acceptText()
					
		next					
		
	end if
	
	messageBox(parent.title, "Il nucleo è stato formato correttamente.", information!)
	
	return 0
		
//		if this.update()= 1 then
//
//			commit;
//
//		else
//			
//			rollback;
//			
//			return -1
//			
//		end if
//		
//		ib_codice= true
//		
//		is_codice= this.getItemString(ll_found, "codice")
//		
//		this.retrieve()
//		
//	end if
		
case is > 1
	
	messageBox(parent.title, "Solo uno dei componenti può avere un Gohonzon assegnato", information!)
	
	return -1
		
end  choose
end event

event buttonclicked;choose case dwo.name
		
//	case "b_s"
//		
//		if this.update()= 1 then
//
//				commit;
//				
//				open (w_message)
//
//			else
//				
//				rollback;
//				
//				open (w_message_negative)
//
//				return -1
//				
//		end if
//			
//			ib_codice= true
//			
//			is_codice= this.getItemString(row, "codice_fam")
//			
//			this.reset()
//			
//			this.retrieve()
		
	case "b_t" // togli dal nucleo
		
		string ls_goh
		
		this.setItem(row, "codice_fam", "")
		
		if this.getItemString(row, "okatagi")= 'F' then this.setItem(row, "okatagi", "N")
		
		if this.getItemString(row, "tokuso")= 'F' then this.setItem(row, "tokuso", "N")
		
		this.acceptText()
		
	case "b_c"
		
		long ll_idx
		
		for ll_idx= 1 to this.rowCount()
			
			this.setItem(ll_idx, "codice_fam", "" )
			
			if this.getItemString(ll_idx, "okatagi")= 'F' then this.setItem(ll_idx, "okatagi", "N")
		
			if this.getItemString(ll_idx, "tokuso")= 'F' then this.setItem(ll_idx, "tokuso", "N")

			this.acceptText()
					
		next
		
	case "b_g"
		
		integer li_sumoka, li_sumtok, li_tot
		long ll_found
		
		// Controlla che ci siano almeno due componenti....
		
		if rowCount() <= 1 then
			
			messageBox(parent.title, "Aggiungere almeno un altro componente", information!)
			
			return -1			
			
		end if
			
		// Controlla che ci sia un unico G. per tutto il nucleo...
		
		li_sumoka= this.getItemNumber(this.getRow(), "c_sumoka")
		li_sumtok=  this.getItemNumber(this.getRow(), "c_sumtok")
		
		li_tot= li_sumoka + li_sumtok
		
		choose case li_tot
				
			case 0
				
			messageBox(parent.title, "Nessuno dei componenti ha un Gohonzon assegnato", information!)
			
			return -1
			
		case 1 // Identifica l'assegnatario, assegna i G. di famiglia mettendo F nel campo okatagi o tokuso...
			
			if li_sumoka > 0 then
				
				ll_found= this.find( " okatagi= 'S'", 1, this.rowCount() )

				is_codice= this.getItemString(ll_found, "codice")
				
				for ll_idx= 1 to this.rowCount()
					
					this.setItem(ll_idx, "codice_fam", is_codice )
					
					if ll_idx= ll_found then continue
					
					this.setItem(ll_idx, "okatagi", "F" )
		
					this.acceptText()
							
				next	
				
			else
				
				ll_found= this.find( " tokuso= 'S'", 1, this.rowCount() )

				is_codice= this.getItemString(ll_found, "codice")
				
				for ll_idx= 1 to this.rowCount()
					
					this.setItem(ll_idx, "codice_fam", is_codice )
					
					if ll_idx= row then continue
					
					this.setItem(ll_idx, "tokuso", "F" )
		
					this.acceptText()
							
				next					
				
			end if
			
			if messageBox(parent.title, "Il nucleo è stato formato correttamente.Vuoi eseguire l'aggiornamento dei dati?", information!, yesNo!, 2)= 1 then
						
				if this.update()= 1 then
	
					commit;
					
					open (w_message)
	
				else
					
					rollback;
					
					open (w_message_negative)
	
					return -1
					
			end if
				
				ib_codice= true
				
				is_codice= this.getItemString(row, "codice_fam")
				
				this.reset()
				
				this.retrieve()
				
			end if
				
		case is > 1
			
			messageBox(parent.title, "Solo uno dei componenti può avere un Gohonzon assegnato", information!)
			
			return -1
				
		end  choose
		
end choose
end event

event retrievestart;//return 2 // Dopo ogni query appende i risultati a quelli già esistenti...
end event

event sqlpreview;if sqlType = previewSelect! then

	if ib_codice then // estrae tutti i componenti di un nucleo...
		
		sqlsyntax += " and codice_fam= '" + is_codice + "'"
		
	else
		
		sqlsyntax += " and codice= '" +  + is_codice + "'"
		
	end if
	
	SetSqlPreview ( sqlsyntax )
	
end if

end event

