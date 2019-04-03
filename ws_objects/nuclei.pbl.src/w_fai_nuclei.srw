$PBExportHeader$w_fai_nuclei.srw
forward
global type w_fai_nuclei from w_ricerca_small
end type
type cb_reset from commandbutton within w_fai_nuclei
end type
type dw_gestione from datawindow within w_fai_nuclei
end type
type gb_2 from groupbox within w_fai_nuclei
end type
type gb_1 from groupbox within w_fai_nuclei
end type
end forward

global type w_fai_nuclei from w_ricerca_small
integer width = 3794
integer height = 2668
string title = "Nuclei"
boolean controlmenu = false
boolean clientedge = true
boolean ib_sqluselike = true
cb_reset cb_reset
dw_gestione dw_gestione
gb_2 gb_2
gb_1 gb_1
end type
global w_fai_nuclei w_fai_nuclei

type variables
boolean ib_codice
string is_codice, is_codice_fam, is_codice_iniziale
s_famiglia is_famiglia_s
end variables

on w_fai_nuclei.create
int iCurrent
call super::create
this.cb_reset=create cb_reset
this.dw_gestione=create dw_gestione
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reset
this.Control[iCurrent+2]=this.dw_gestione
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
end on

on w_fai_nuclei.destroy
call super::destroy
destroy(this.cb_reset)
destroy(this.dw_gestione)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;call super::open;dw_gestione.setTransObject(sqlca)

long ll_rows

s_session_s.context= "Nuclei famigliari"


//dw_gestione.object.b_g.visible= false
//dw_gestione.object.b_c.visible= false

//dw_gestione.setTransObject(sqlca)

is_famiglia_s= message.powerObjectParm

dw_current.setRowFocusIndicator(hand!)
dw_gestione.setRowFocusIndicator(hand!)
	
ib_codice= true
if is_famiglia_s.codice_fam= ""  or isNull( is_famiglia_s.codice_fam) then ib_codice= false

// per fare le prima retrieve dell'eventuale nucleo già esistente
is_codice= is_famiglia_s.codice
is_codice_fam= is_famiglia_s.codice_fam

is_codice_iniziale= is_codice
	
ll_rows=  dw_gestione.retrieve()

return ll_rows
end event

type dw_current from w_ricerca_small`dw_current within w_fai_nuclei
integer x = 37
integer y = 52
integer width = 3648
integer height = 876
string dataobject = "dw_seleziona_componenti"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_current::buttonclicked;call super::buttonclicked;if dwo.name= "b_m" then this.setItem(row, "codice_fam", "")
end event

event dw_current::doubleclicked;call super::doubleclicked;if this.getRow() <= 0 or this.Object.DataWindow.QueryMode= 'yes' then return

long ll_rows
string ls_oka, ls_tok

if ib_codice= true then
	
	messageBox(parent.title, "Il nucleo famigliare è già formato. ~nPer aggiungere o rimuovere componenti occorre prima scioglierlo.", exclamation!)
			
	return -1	
	
end if

is_codice= this.getItemString(this.getRow(), "codice")

ls_oka=  this.getItemString(this.getRow(), "okatagi")
ls_tok=  this.getItemString(this.getRow(), "tokuso")

if ls_oka= 'A' or ls_tok= 'A' then

	if dw_gestione.Find ( "okatagi= 'Si' ", 1, dw_gestione.rowCount() ) > 0 or dw_gestione.Find ( "tokuso= 'Si' ", 1, dw_gestione.rowCount() ) > 0 then
			
			messageBox(parent.title, "Un nucleo deve avere un unico assegnatario di gohonzon.", exclamation!)
			
			return -1	
			
	end if
		
end if
	

if dw_gestione.Find ( "codice= '"+is_codice+"' ", 1, dw_gestione.rowCount() ) > 0 then
	
	messageBox(parent.title, "Nominativo già presente.", exclamation!)
	
	return -1
	
end if

ib_codice= false

is_codice_fam= this.getItemString(this.getRow(), "codice_fam")

if is_codice_fam <> "" and NOT isNull(is_codice_fam) then
	ib_codice= true  // esiste un nucleo
	//is_codice= is_codice_fam
end if
	
ll_rows=  dw_gestione.retrieve()

this.deleteRow(this.getRow())

return ll_rows
end event

event dw_current::retrieveend;call super::retrieveend;commit;

if rowcount > 0 then this.scrolltoRow(1)
end event

event dw_current::rowfocuschanged;call super::rowfocuschanged;//f_select_current_row(this)
end event

type cb_importa from w_ricerca_small`cb_importa within w_fai_nuclei
integer x = 2853
integer y = 956
integer width = 466
integer height = 120
boolean enabled = true
string text = "Importa"
boolean cancel = false
end type

type cb_dbcancel from w_ricerca_small`cb_dbcancel within w_fai_nuclei
integer x = 2377
integer y = 956
integer width = 466
integer height = 120
string text = "Annulla l~'estrazione"
end type

type cb_query from w_ricerca_small`cb_query within w_fai_nuclei
integer x = 1426
integer y = 956
integer width = 466
integer height = 120
string text = "Estrazione"
end type

type cb_annulla from w_ricerca_small`cb_annulla within w_fai_nuclei
integer x = 2853
integer y = 2184
integer width = 466
integer height = 120
string text = "Chiudi"
end type

type cb_reset from commandbutton within w_fai_nuclei
boolean visible = false
integer x = 1902
integer y = 956
integer width = 466
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reset"
end type

event clicked;dw_current.reset()
dw_gestione.reset()
dw_current.Object.DataWindow.QueryMode= 'no'
cb_query.event clicked()
end event

type dw_gestione from datawindow within w_fai_nuclei
event ue_cancellanucleo ( )
event type integer ue_generanucleo ( )
integer x = 37
integer y = 1192
integer width = 3648
integer height = 960
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_gestione_componenti"
boolean border = false
boolean livescroll = true
end type

event ue_cancellanucleo();long ll_idx

for ll_idx= 1 to this.rowCount()
	
	this.setItem(ll_idx, "codice_fam", "" )

	this.acceptText()
			
next


end event

event type integer ue_generanucleo();integer li_sumoka, li_sumtok, li_tot
long ll_idx, ll_found
string ls_codice, ls_codice_fam, ls_oma_ass, ls_oma_comp
s_session ls_session_s

ls_session_s= s_session_s

// Controlla che ci siano almeno due componenti....

if rowCount() < 2 then
	
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
	
case is > 1
	messageBox(parent.title, "Solo uno dei componenti può avere un Gohonzon assegnato", information!)
	return -1
	
end choose

// cerca l'unico assegnatario di G. del nucleo...
ll_found= this.Find("okatagi= 'A' or tokuso='A' ", 1, this.RowCount())

// ne legge il codice membro...
ls_codice_fam= this.getItemString(ll_found, "codice")

// verifica se è anche assegnatario di un omamori...
ls_oma_ass=  this.getItemString(ll_found, "omamori")

if li_sumoka= 1 then // se il Goh. assegnato è un Okatagi...

	for ll_idx= 1 to this.rowCount()
		
		if  this.getItemString(ll_idx, "crimuovi")= 'S' then continue
		
		// se non è assegnatario di G. pone il flag goh = a G di famiglia...
		if  this.getItemString(ll_idx, "okatagi") <> "A"  then
			this.setItem(ll_idx, "okatagi", "F")
			
			ls_oma_comp=  this.getItemString(ll_idx, "omamori")
			
			if ls_oma_comp= 'N' and ls_oma_ass= 'A' then this.setItem(ll_idx, "omamori", "F")
			
		end if	
		
		// valorizza il codice dei componenti del nucleo = al codice dell'assegnatario...
		this.setItem(ll_idx, "codice_fam",  ls_codice_fam)			
		
	next
	
else // altrimenti è un Tokubetsu... la procedura è la stessa...
	
	for ll_idx= 1 to this.rowCount()
		
		if  this.getItemString(ll_idx, "crimuovi")= 'S' then continue
	
		if  this.getItemString(ll_idx, "tokuso") <> "A"  then 
			this.setItem(ll_idx, "tokuso", "F")
			
			ls_oma_comp=  this.getItemString(ll_idx, "omamori")
			
			if ls_oma_comp= 'N' and ls_oma_ass= 'A' then this.setItem(ll_idx, "omamori", "F")
			
		end if
		
		// valorizza il codice dei componenti del nucleo = al codice dell'assegnatario...
		this.setItem(ll_idx, "codice_fam",  ls_codice_fam)		

	next
		
end if
	
	if this.update() = 1 then
		
		string ls_message

		ls_message=  "Formato un nucleo famigliare, codice fam: "+ls_codice_fam

		f_log(ls_session_s, ls_message, false)
		
		commit;
		if trap_sql(sqlca, "CREANUCLEO01") < 0 then goto errore
		messageBox(parent.title, "Il nucleo è stato formato correttamente.", information!)
	else
		open(w_message_negative)
		goto errore
	end if
	
	is_codice_fam= is_codice
	
	ib_codice= true
	
	is_ricerca_s.i_retcode= 0
	
	return 0
	
errore:
	
	rollback;
	trap_sql(sqlca, "CREANUCLEO04")
	
	is_ricerca_s.i_retcode= -1

	//closeWithReturn(parent, is_ricerca_s)
	
	return -1
		
end event

event retrievestart;return 2 // Dopo ogni query appende i risultati a quelli già esistenti...
end event

event buttonclicked;integer li_err

string ls_message, ls_null, ls_codice_fam

s_session ls_session_s

ls_session_s= s_session_s

if row <= 0 then return 0

choose case dwo.name
		
	case "b_c"
		
		long ll_idx
		
		if messageBox(parent.title, "Confermi lo scioglimento di questo nucleo?", information!, yesNo!, 2)= 2 then return 0
		
		ls_codice_fam= this.getItemString(this.getRow(), "codice_fam")
		
		update membri_gerarchica set codice_fam= null where codice_fam= :ls_codice_fam;
		if trap_sql(sqlca, "CANCELLANUCLEO04") < 0 then goto errore
		
		commit;
		
		this.retrieve()
		
		ib_codice= false

		
//		if messageBox(parent.title, "Il nucleo è stato sciolto. Vuoi eseguire l'aggiornamento dei dati?", information!, yesNo!, 2)= 1 then
						
			if this.update()= 1 then

				commit;
				
				open (w_message)

			else
				
				rollback;
				
				open (w_message_negative)

				return -1
				
			end if
						
			dw_current.Object.DataWindow.QueryMode= 'yes'
			
			dw_gestione.reset()

			ls_session_s.causale= "STRUTTURA"
			ls_message= "Sciolto un nucleo famigliare"
			li_err= f_log(ls_session_s, ls_message, TRUE)
			if li_err= -1 then messageBox("Anagrafica variazioni", "Errore in scrittura sul log eventi", Exclamation!)		
		
	case "b_g" // genera un nucleo
		
		if this.event ue_generanucleo() <  0 then
			
			return -1
			
		else
			
//			dw_current.reset()
			
			dw_current.Object.DataWindow.QueryMode= 'yes'
			
			 is_codice_fam=  is_famiglia_s.codice
			 
			//dw_current.Object.DataWindow.QueryMode= 'yes'
			 
			 dw_gestione.reset()
			
			 dw_gestione.retrieve()
			
			return 1

//			is_ricerca_s.i_retcode= 0
//			
//			closeWithReturn(parent, is_ricerca_s)
			
			ls_session_s.causale= "STRUTTURA"
			ls_message= "Generato un nucleo famigliare"
			li_err= f_log(ls_session_s, ls_message, TRUE)
			if li_err= -1 then messageBox("Anagrafica variazioni", "Errore in scrittura sul log eventi", Exclamation!)			
				
		end if
		
end choose

return 0

errore:

rollback;
return -1
end event

event sqlpreview;if sqlType = previewSelect! then

	if ib_codice then // estrae tutti i componenti di un nucleo...
		
		sqlsyntax += " and codice_fam= '" + is_codice_fam + "'"
		
	else
		
		sqlsyntax += " and codice= '" +  + is_codice + "'"
		
	end if
	
	SetSqlPreview ( sqlsyntax )
	
end if

end event

event rowfocuschanged;//f_select_current_row(this)
end event

type gb_2 from groupbox within w_fai_nuclei
integer width = 3730
integer height = 1104
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selezione componenti"
end type

type gb_1 from groupbox within w_fai_nuclei
integer y = 1120
integer width = 3730
integer height = 1220
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gestione del nucleo"
end type

