$PBExportHeader$w_rga_membri_sheet.srw
forward
global type w_rga_membri_sheet from window
end type
type st_seleziona from statictext within w_rga_membri_sheet
end type
type pb_centromessaggi from picturebutton within w_rga_membri_sheet
end type
type pb_seleziona from picturebutton within w_rga_membri_sheet
end type
type tab_var from tab within w_rga_membri_sheet
end type
type tabpage_s from userobject within tab_var
end type
type uodw_s from uodw_generica within tabpage_s
end type
type tabpage_s from userobject within tab_var
uodw_s uodw_s
end type
type tabpage_entrata from userobject within tab_var
end type
type uodw_entrata from uodw_generica within tabpage_entrata
end type
type tabpage_entrata from userobject within tab_var
uodw_entrata uodw_entrata
end type
type tabpage_t from userobject within tab_var
end type
type uodw_t from uodw_generica within tabpage_t
end type
type tabpage_t from userobject within tab_var
uodw_t uodw_t
end type
type tabpage_e from userobject within tab_var
end type
type uodw_e from uodw_generica within tabpage_e
end type
type tabpage_e from userobject within tab_var
uodw_e uodw_e
end type
type tab_var from tab within w_rga_membri_sheet
tabpage_s tabpage_s
tabpage_entrata tabpage_entrata
tabpage_t tabpage_t
tabpage_e tabpage_e
end type
end forward

global type w_rga_membri_sheet from window
boolean visible = false
integer width = 6715
integer height = 2656
boolean titlebar = true
string title = "Gestione associati remota"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Report5!"
boolean center = true
event type integer e_accettazione ( )
event type integer e_messaggi ( )
st_seleziona st_seleziona
pb_centromessaggi pb_centromessaggi
pb_seleziona pb_seleziona
tab_var tab_var
end type
global w_rga_membri_sheet w_rga_membri_sheet

type variables
string s_log_msg, is_capitolo, is_tipo, is_competenza='I'
s_messaggi is_messaggi_s
s_rga is_rga_s
dataWindowChild idwc_gruppi, idwc_settori

//transaction isqlca

m_preview im_preview
end variables

forward prototypes
public function integer wf_retrieve ()
end prototypes

event type integer e_accettazione();long ll_ret

/*
if is_capitolo <> ""  then

	delete from rga_locks where vc_nodo= :is_capitolo using sqlca_rga;
	
	if trap_sql(sqlca_rga, "LOCKS04") < 0 then
		rollback using sqlca_rga;
		return -1
	else
		commit using sqlca_rga;
	end if
	
end if

*/

//tab_var.tabpage_i.uodw_i.reset()
tab_var.tabpage_s.uodw_s.reset()
tab_var.tabpage_e.uodw_e.reset()

pb_seleziona.enabled= false

open(w_seleziona_gruppi_modifiche)

is_rga_s= message.powerObjectParm

pb_seleziona.enabled= true

is_capitolo= is_rga_s.vc_nodo
is_tipo= is_rga_s.tipo

if is_capitolo="" OR isNull(is_capitolo) then return -1

 is_messaggi_s.vc_nodo= is_capitolo
 
 /*

select count(*)
into :ll_ret
from rga_locks
where vc_nodo= :is_capitolo
using sqlca_rga;
if trap_sql(sqlca_rga, "LOCKS01") < 0 then return -1

commit using sqlca_rga; // tanto per...

if ll_ret > 0 then
	
	is_capitolo= ""
	messageBox("RGA", "Un altro operatore sta elaborando le variazioni relative a "+is_capitolo+"~nSelezionare un altro capitolo")
	
	return 0
	
end if

insert into rga_locks (vc_nodo) values(:is_capitolo) using sqlca_rga;
if trap_sql(sqlca_rga, "LOCKS02") < 0 then return -1

*/

ll_ret=idwc_gruppi.retrieve(is_capitolo, 7)
ll_ret=idwc_settori.retrieve(is_capitolo, 6)

tab_var.selectTab(1)

select count(*)
into :ll_ret
from rga_messaggi where vc_nodo= :is_capitolo and flag_letto=0 and mittente= 'I';

 trap_sql(sqlca, "OPEN03")
 
 if ll_ret > 0 then
	
	messageBox("Messaggi", "Ci sono messaggi non letti")
	
	this.event e_messaggi()
	
end if

this.title= "Accettazione variazioni da "+is_capitolo
 
return 0
end event

event type integer e_messaggi();return openWithParm(w_rga_messaggi, is_messaggi_s)
end event

public function integer wf_retrieve ();return 0
end function

event open;integer li_ret
long ll_ret

s_session_s.context= "RGA"

/*

 sqlca_rga= create transaction

sqlca_rga.DBMS = sqlca.DBMS
sqlca_rga.ServerName = sqlca.ServerName
sqlca_rga.AutoCommit = sqlca.AutoCommit
sqlca_rga.DBParm =sqlca.DBParm
sqlca_rga.Logid= sqlca.Logid
sqlca_rga.Logpass=sqlca.Logpass

sqlca_rga.Lock = "RU"

connect using sqlca_rga;
if trap_sql(sqlca_rga, "CONNECT01") < 0 then return

*/

im_preview= create m_preview

pb_seleziona.PostEvent(Clicked!)



end event

on w_rga_membri_sheet.create
this.st_seleziona=create st_seleziona
this.pb_centromessaggi=create pb_centromessaggi
this.pb_seleziona=create pb_seleziona
this.tab_var=create tab_var
this.Control[]={this.st_seleziona,&
this.pb_centromessaggi,&
this.pb_seleziona,&
this.tab_var}
end on

on w_rga_membri_sheet.destroy
destroy(this.st_seleziona)
destroy(this.pb_centromessaggi)
destroy(this.pb_seleziona)
destroy(this.tab_var)
end on

event resize;
tab_var.height= this.height - 120 - tab_var.y
end event

event close;/*

commit using sqlca_rga;

if is_capitolo <> "" then

	delete from rga_locks where vc_nodo= :is_capitolo using sqlca_rga;
	if trap_sql(sqlca_rga, "LOCKS03") < 0 then return -1
	
	commit using sqlca_rga;
	
end if

*/

//disconnect using sqlca_rga;
end event

type st_seleziona from statictext within w_rga_membri_sheet
integer x = 165
integer y = 44
integer width = 466
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona un capitolo"
boolean focusrectangle = false
end type

type pb_centromessaggi from picturebutton within w_rga_membri_sheet
integer x = 1262
integer y = 8
integer width = 507
integer height = 128
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Centro messaggi"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 16711680
long backcolor = 67108864
end type

event clicked;parent.event e_messaggi()
end event

type pb_seleziona from picturebutton within w_rga_membri_sheet
integer x = 631
integer y = 8
integer width = 206
integer height = 128
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean originalsize = true
string picturename = "CERCA_bface.bmp"
alignment htextalign = left!
long backcolor = 134217750
end type

event clicked;pb_centromessaggi.enabled= false
 
if parent.event e_accettazione()= 0 then
	pb_centromessaggi.enabled= true
end if
end event

type tab_var from tab within w_rga_membri_sheet
event create ( )
event destroy ( )
integer x = 18
integer y = 140
integer width = 5385
integer height = 2244
integer taborder = 40
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
tabpage_s tabpage_s
tabpage_entrata tabpage_entrata
tabpage_t tabpage_t
tabpage_e tabpage_e
end type

on tab_var.create
this.tabpage_s=create tabpage_s
this.tabpage_entrata=create tabpage_entrata
this.tabpage_t=create tabpage_t
this.tabpage_e=create tabpage_e
this.Control[]={this.tabpage_s,&
this.tabpage_entrata,&
this.tabpage_t,&
this.tabpage_e}
end on

on tab_var.destroy
destroy(this.tabpage_s)
destroy(this.tabpage_entrata)
destroy(this.tabpage_t)
destroy(this.tabpage_e)
end on

event selectionchanged;long ll_rows
uodw_generica ldw
string ls_msg

if is_capitolo="" or isNull(is_capitolo) then return 0



//open(w_wait_snoopy)

choose case newindex
		
//	case 1
//		
//		ldw= tabpage_i.uodw_i
//		
//		is_competenza= 'I'
//		
//		ls_msg= "Nessuna variazione automatica pendente"
		
	case 1
		
		ldw= tabpage_s.uodw_s
		
		is_competenza= 'S'
		
		ls_msg= "Nessuna variazione da elaborare pendente"
		
	case 2
		
		ldw= tabpage_entrata.uodw_entrata
		
		is_competenza= 'S'
		
		ls_msg= "Nessun trasferimento in entrata pendente"				
		
	case 3
		
		ldw= tabpage_t.uodw_t
		
		is_competenza= 'S'
		
		ls_msg= "Nessun trasferimento in uscita pendente"		
		
	case 4
		
		ldw= tabpage_e.uodw_e
		
		is_competenza= '%'
		
		ls_msg= "Nessuna variazione in archivio"				

end choose

ldw.setTransObject(sqlca)

ldw.setRedraw(false)

	ldw.reset()
	
	if is_competenza= '%' then
		ll_rows= ldw.retrieve(is_capitolo, 'S')
		ll_rows += ldw.retrieve(is_capitolo, 'I')
	else
		ll_rows= ldw.retrieve(is_capitolo, is_competenza)
	end if
	
	ldw.height= this.height - 250 - ldw.y
	ldw.width= this.width - 120 - ldw.x
	
ldw.setRedraw(true)

if ll_rows= 0 then
		
		messageBox("RGA", ls_msg)
		selectTab(newindex+1)
		return
	end if

//close(w_wait_snoopy)
end event

type tabpage_s from userobject within tab_var
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 5349
integer height = 2116
long backcolor = 16777215
string text = "Variazioni da elaborare"
long tabbackcolor = 16777215
string picturename = "Form!"
long picturemaskcolor = 536870912
string powertiptext = "Somo le variazioni che devono essere elaborate da parte degli operatori di Segreteria"
uodw_s uodw_s
end type

on tabpage_s.create
this.uodw_s=create uodw_s
this.Control[]={this.uodw_s}
end on

on tabpage_s.destroy
destroy(this.uodw_s)
end on

type uodw_s from uodw_generica within tabpage_s
event type integer postitemchanged ( string as_codice,  string as_log_msg )
integer width = 5234
integer height = 2116
integer taborder = 50
string dataobject = "dw_rga_variazioni_offline_s"
boolean controlmenu = true
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event buttonclicked;call super::buttonclicked;this.acceptText()

string ls_message

s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.causale= "RGA_ANAG"

decimal ld_id
integer idx, li_azione
string ls_token[], ls_cod_variazione, ls_codice, ls_descrizione, ls_nome

if row= 0 or isNull(row) then return 0

ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
ls_codice= this.getItemString(getRow(), "codice")
ls_descrizione= this.getItemString(getRow(), "log_msg")
ls_nome= this.getItemString(getRow(), "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(getRow(), "id") 		

choose case dwo.name
	case "b_messaggio"
	
	if ls_nome<> "" AND NOT isNull(ls_nome) then
	 	is_messaggi_s.oggetto= ls_nome+": "+ls_cod_variazione
	else
	 	is_messaggi_s.oggetto= ls_descrizione		
	end if

	openWithParm(w_rga_messaggi_nuovi, is_messaggi_s)
			
end choose



end event

event doubleclicked;call super::doubleclicked;long ll_ret

this.acceptText()

string ls_message

s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.causale= "RGA_ANAG"

decimal ld_id
integer idx, li_flag_daeseguire
string ls_token[], ls_cod_variazione, ls_codice, ls_descrizione, ls_nome, ls_ret, ls_vc_nodo_origine, ls_vc_nodo_destinazione

ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
ls_codice= this.getItemString(getRow(), "codice")
ls_descrizione= this.getItemString(getRow(), "log_msg")
ls_nome= this.getItemString(getRow(), "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(getRow(), "id") 		
li_flag_daeseguire=  this.getItemNumber(getRow(), "flag_daeseguire") 

ls_session_s.codice= ls_codice

if li_flag_daeseguire <> 1 then return 0

openWithParm(w_rga_azioni_offline, ls_descrizione)

ls_ret= message.stringParm

choose case ls_ret
		
	case 'E'
		
		if li_flag_daeseguire= 1 then
			
					do while ls_cod_variazione <> ""	
						idx++
						ls_token[idx]= f_get_token(ls_cod_variazione, ",")
					loop	
					  
					choose case   ls_token[1]
							
						case "TRASFEND"
							  
							  ls_vc_nodo_origine=  ls_token[4]
							  ls_vc_nodo_destinazione= this.getItemString(row, "vc_parent")		  
							
							/*
							 * Crea un messaggio per il referente istituzionale 
							 */
							
							  INSERT INTO rga_messaggi  
										( 
										  vc_nodo,   
										  flag_letto,   
										  messaggio,   
										  data,   
										  mittente,   
										  oggetto )  
							  VALUES (   
										  :ls_vc_nodo_destinazione,   
										  0,   
										  "Eseguito il trasferimento in entrata di "+:ls_nome+" da: "+:ls_vc_nodo_origine+" a: "+:ls_vc_nodo_destinazione,   
										  getdate(),   
										  'S',   
										  'Conclusione trasferimento' )  ;

							if trap_sql(sqlca, "CASETRASFEND") < 0 then
							
								rollback;
								return -1
							
							end if
							
					end choose
			
					
					 /* variazione eseguita... */
					update rga_variazioni
					set flag_daeseguire= 0,
					data_variazione= getDate(),
					operatore= :s_session_s.s_utente_s.s_nome_esteso
					where id= :ld_id;
					
					if trap_sql(sqlca, "BCLICKED01") < 0 then
						
						rollback;
						return -1
						
					end if
					
					ls_message= "(RGA): "+ls_descrizione
					
					if f_log(ls_session_s, ls_message, false)= -1 then
						
						rollback;
						return -1
						
					end if		
					
					commit;
					
			end if
			
		case 'C'

				 /* variazione annullata... vuol dire che non è il caso di effettuarla perchè mal formulata */
				update rga_variazioni
				set flag_daeseguire= 2,
				data_variazione= getDate(),
				operatore= :s_session_s.s_utente_s.s_nome_esteso
				where id= :ld_id;
				
					ls_message= "(RGA) variazione annullata: "+ls_nome+" - "+ls_descrizione
					
					if f_log(ls_session_s, ls_message, false)= -1 then
						
						rollback;
						return -1
						
					end if						
				
				if messageBox("RGA", "Vuoi annullare la seguente richiesta?~n"+ls_nome+":~n"+ls_descrizione, question!, yesNo!, 2)= 2 then
					
					rollback;
					messageBox("RGA", "Operazione annullata", information!)
					
				else
				
					commit;
					open(w_message)
					
					s_messaggi ls_messaggi_s

					ls_messaggi_s.oggetto= ls_descrizione+" - La richiesta è stata respinta per le seguenti ragioni:"
	
					openWithParm(w_rga_messaggi_nuovi, ls_messaggi_s)
					
				end if	
			
		case 'A'
			
			return 0
			
	end choose
	
	
	ll_ret= this.retrieve(is_capitolo, is_competenza)
	
	return
		
		

end event

event itemchanged;//this.acceptText()
//
//string ls_message
//
//s_session ls_session_s
//
//ls_session_s= s_session_s
//
//decimal ld_id
//integer idx, li_flag_daeseguire
//string ls_cod_variazione, ls_codice, ls_descrizione, ls_nome, ls_ret	
//
//ls_session_s.causale= "RGA_ANAG"
//
//
//ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
//ls_codice= this.getItemString(getRow(), "codice")
//ls_descrizione= this.getItemString(getRow(), "log_msg")
//ls_nome= this.getItemString(getRow(), "cognome_nome")
///* puntatore alla riga di variazioni */
//ld_id= this.getItemDecimal(getRow(), "id") 		
//li_flag_daeseguire=  this.getItemNumber(getRow(), "flag_daeseguire") 
//
//li_flag_daeseguire= integer(data)
//		
// /* variazione eseguita... */
//update rga_variazioni
//set flag_daeseguire= :li_flag_daeseguire,
//data_variazione= getDate(),
//operatore= :s_session_s.s_utente_s.s_nome_esteso
//where id= :ld_id;
//
//if trap_sql(sqlca, "BCLICKED01") < 0 then
//	
//	rollback;
//	return -1
//	
//end if
//
//ls_message= "(RGA): "+ls_descrizione
//
//if f_log(ls_session_s, ls_message, false)= -1 then
//	
//	rollback;
//	return -1
//	
//end if		
//
//choose case li_flag_daeseguire
//		
//	case 1
//	
//		ls_message= "Confermi la seguente variazione?~n"+ls_descrizione
//	
//	case 2
//	
//		ls_message= "Vuoi annullare la seguente variazione?~n"+ls_descrizione	
//	
//end choose
//
//if messageBox("RGA", ls_message, question!, yesNo!, 2)= 2 then
//	
//	rollback;
//	messageBox("RGA", "Operazione annullata", information!)
//	return 1
//	
//else
//
//	commit;
//	open(w_message)
//	return 0
//	
//end if
end event

event sqlpreview;call super::sqlpreview;//integer li_pos
//string sqlsyntax1, sqlsyntax2
//
//if is_tipo <> "" then
//	
//	li_pos= pos(lower(sqlsyntax), "where")
//	
//	sqlsyntax1= mid(sqlsyntax, 1, li_pos + 5)
//	
//	sqlsyntax2= mid(sqlsyntax, len(sqlsyntax1) + 1, len(sqlsyntax) )
//	
//	sqlsyntax= sqlsyntax1 +" "+ is_tipo +" "+ sqlsyntax2
//	
//	SetSqlPreview ( sqlsyntax)
//	
//end if
end event

event rbuttondown;call super::rbuttondown;if this.ib_queryMode= true then
	messageBox("RGA", "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview.iuodw_generica= this

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

type tabpage_entrata from userobject within tab_var
integer x = 18
integer y = 112
integer width = 5349
integer height = 2116
long backcolor = 16777215
string text = "Trasferimenti in entrata"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
string picturename = "AR_LEFT.bmp"
long picturemaskcolor = 536870912
uodw_entrata uodw_entrata
end type

on tabpage_entrata.create
this.uodw_entrata=create uodw_entrata
this.Control[]={this.uodw_entrata}
end on

on tabpage_entrata.destroy
destroy(this.uodw_entrata)
end on

type uodw_entrata from uodw_generica within tabpage_entrata
integer taborder = 50
string dataobject = "dw_rga_trasfin_offline"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
end type

event doubleclicked;call super::doubleclicked;long ll_ret

this.acceptText()

string ls_message

s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.causale= "RGA_ANAG"

decimal ld_id
integer idx, li_flag_daeseguire
string ls_token[], ls_cod_variazione, ls_codice, ls_descrizione, ls_nome, ls_ret, ls_vc_nodo_origine, ls_vc_nodo_destinazione

ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
ls_codice= this.getItemString(getRow(), "codice")
ls_descrizione= this.getItemString(getRow(), "log_msg")
ls_nome= this.getItemString(getRow(), "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(getRow(), "id") 		
li_flag_daeseguire=  this.getItemNumber(getRow(), "flag_daeseguire") 

ls_session_s.codice= ls_codice

if li_flag_daeseguire <> 1 then return 0

openWithParm(w_rga_azioni_offline, ls_descrizione)

ls_ret= message.stringParm

choose case ls_ret
		
	case 'E'
		
		if li_flag_daeseguire= 1 then
			
					do while ls_cod_variazione <> ""	
						idx++
						ls_token[idx]= f_get_token(ls_cod_variazione, ",")
					loop	
					 					
					 /* variazione eseguita... */
					update rga_variazioni
					set flag_daeseguire= 0,
					data_variazione= getDate(),
					operatore= :s_session_s.s_utente_s.s_nome_esteso
					where id= :ld_id;
					
					if trap_sql(sqlca, "BCLICKED01") < 0 then
						
						rollback;
						return -1
						
					end if
					
					ls_message= "(RGA): "+ls_descrizione
					
					if f_log(ls_session_s, ls_message, false)= -1 then
						
						rollback;
						return -1
						
					end if		
					
					commit;
					
			end if
			
		case 'C'

				 /* variazione annullata... vuol dire che non è il caso di effettuarla perchè mal formulata */
				update rga_variazioni
				set flag_daeseguire= 2,
				data_variazione= getDate(),
				operatore= :s_session_s.s_utente_s.s_nome_esteso
				where id= :ld_id;
				
				if messageBox("RGA", "Vuoi annullare la seguente richiesta?~n"+ls_nome+":~n"+ls_descrizione, question!, yesNo!, 2)= 2 then
					
					rollback;
					messageBox("RGA", "Operazione annullata", information!)
					
				else
				
					commit;
					open(w_message)
					
					s_messaggi ls_messaggi_s

					ls_messaggi_s.oggetto= ls_descrizione+" - La richiesta è stata respinta per le seguenti ragioni:"
	
					openWithParm(w_rga_messaggi_nuovi, ls_messaggi_s)
					
				end if	
			
		case 'A'
			
			return 0
			
	end choose
		
		
	ll_ret= this.retrieve(is_capitolo, is_competenza)
	
	return 
		

end event

event rbuttondown;call super::rbuttondown;if this.ib_queryMode= true then
	messageBox("RGA", "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview.iuodw_generica= this

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

event buttonclicked;call super::buttonclicked;this.acceptText()

string ls_message

s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.causale= "RGA_ANAG"

decimal ld_id
integer idx, li_azione
string ls_cod_variazione, ls_descrizione

if row= 0 or isNull(row) then return 0

ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")

ls_descrizione= this.getItemString(getRow(), "log_msg")

/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(getRow(), "id") 		

choose case dwo.name
	case "b_messaggio"
	
	 	is_messaggi_s.oggetto= ls_descrizione		

		openWithParm(w_rga_messaggi_nuovi, is_messaggi_s)
			
end choose



end event

type tabpage_t from userobject within tab_var
integer x = 18
integer y = 112
integer width = 5349
integer height = 2116
long backcolor = 16777215
string text = "Inoltro trasferimenti in uscita"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
string picturename = "AR_RIGHT.bmp"
long picturemaskcolor = 553648127
uodw_t uodw_t
end type

on tabpage_t.create
this.uodw_t=create uodw_t
this.Control[]={this.uodw_t}
end on

on tabpage_t.destroy
destroy(this.uodw_t)
end on

type uodw_t from uodw_generica within tabpage_t
integer width = 6007
integer taborder = 60
string title = "Inoltro trasferimenti in uscita"
string dataobject = "dw_rga_trasfout_offline"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event doubleclicked;call super::doubleclicked;long ll_ret

this.acceptText()

string ls_message, ls_vc_nodo_destinazione, ls_tm, ls_mail, ls_tipovariazione

s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.causale= "RGA_ANAG"

decimal ld_id
integer idx, li_flag_daeseguire, li_quante
string ls_token[], ls_cod_variazione, ls_codice, ls_descrizione, ls_nome, ls_ret		

ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
ls_codice= this.getItemString(getRow(), "codice")
ls_descrizione= this.getItemString(getRow(), "log_msg")
ls_nome= this.getItemString(getRow(), "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(getRow(), "id") 		
li_flag_daeseguire=  this.getItemNumber(getRow(), "flag_daeseguire") 


ls_session_s.codice= ls_codice

openWithParm(w_rga_azioni, ls_descrizione)

ls_ret= message.stringParm

choose case ls_ret
		
	case 'E' // esegui...
		
		if li_flag_daeseguire= 1 then
							
					do while ls_cod_variazione <> ""	
						idx++
						ls_token[idx]= f_get_token(ls_cod_variazione, ",")
					loop	
					
					ls_tipovariazione= ls_token[1]
					
					if ls_tipovariazione <> 'TRASFOUT' then 
						messageBox("Trasfout", "Codice variazione errato")
						return -1
					end if
							
							/*
							  * inserisce una riga in rga_variazioni con codice TRASFEND e con vc_nodo uguale al capitolo di destinazione...
							  */
							  
							  ls_vc_nodo_destinazione=  ls_token[4]
							  
								  select riferimento_descr
								  	into :ls_tm
									from riferimenti
									where codice= :ls_codice
									and cod_rif= 'TM' and flag_riservato= 'N' and predefinito= '1';
									
								  if trap_sql(sqlca, "CASETRASFOUT01") < 0 then
									rollback;
									return -1
								end if												
									
								  select riferimento_descr
								  	into :ls_mail
									from riferimenti
									where codice= :ls_codice
									and cod_rif= 'MA' and flag_riservato= 'N' and predefinito= '1';

								  if trap_sql(sqlca, "CASETRASFOUT02") < 0 then
									rollback;
									return -1
								end if					
								
								if isNull(ls_tm) then ls_tm= ""
								if isNull(ls_mail) then ls_mail= ""
							  
							    INSERT INTO rga_variazioni  
									 (codice,   
									  vc_nodo,   
									  flag_daeseguire,   
									  log_msg,   
									  data_richiesta,   
									  data_variazione,   
									  operatore,   
									  note,   
									  cod_variazione,   
									  richiesta_da,   
									  tipo)								 	
									  SELECT
										rga_variazioni.codice,   
										:ls_vc_nodo_destinazione,   
										1,   
										"TRASFEND: Conclusione del trasferimento di "+:ls_nome+" da: "+:is_capitolo+" a: "+:ls_vc_nodo_destinazione+", Cell. "+:ls_tm+", Mail: "+:ls_mail,
										getdate(),   
										rga_variazioni.data_variazione,   
										rga_variazioni.operatore,   
										rga_variazioni.note,   
										"TRASFEND,"+:ls_codice+", "+:ls_nome+","+:is_capitolo+","+:ls_vc_nodo_destinazione+","+:ls_tm+","+:ls_mail,
										rga_variazioni.richiesta_da,
										"TRASFEND"  
									FROM rga_variazioni  
									where id= :ld_id;
									
								  if trap_sql(sqlca, "CASETRASFOUT03") < 0 then
									rollback;
									return -1
								end if			
							
					
					 /* variazione eseguita, aggiorno la tabella... */
					update rga_variazioni
					set flag_daeseguire= 0,
					data_variazione= getDate(),
					operatore= :s_session_s.s_utente_s.s_nome_esteso
					where id= :ld_id;
					
					if trap_sql(sqlca, "BCLICKED01") < 0 then
						
						rollback;
						return -1
						
					end if
					
					ls_message= "(RGA): "+ls_nome+" - "+ls_descrizione
					
					if f_log(ls_session_s, ls_message, false)= -1 then
						
						rollback;
						return -1
						
					end if		
					
					if messageBox("RGA", "Confermi la seguente variazione?~n"+ls_nome+":~n"+ls_descrizione, question!, yesNo!, 2)= 2 then
						
						rollback;
						messageBox("RGA", "Operazione annullata", information!)
						
					else
					
						commit;
						open(w_message)
						
					end if
					
			end if
			
		case 'C' // cancella ( non eseguire e cancella) la variazione...
			
			/* inizia procedura annullamento di una variazione ad opera della segreteria...*/
			
			if li_flag_daeseguire= 1 then
			// se quindi è una variazione che doveva essere eseguita (non sarebbe necessario...)
			
					/* vale per tutti i casi:  variazione eseguita... */
					update rga_variazioni
						set flag_daeseguire= 2,
						data_variazione= getDate(),
						operatore= :s_session_s.s_utente_s.s_nome_esteso
					where id= :ld_id;
					
					if trap_sql(sqlca, "ANNULLACLICKED01") < 0 then
						
						rollback;
						return -1
						
					end if
					
					ls_message= "(RGA) variazione annullata: "+ls_nome+" - "+ls_descrizione
					
					if f_log(ls_session_s, ls_message, false)= -1 then
						
						rollback;
						return -1
						
					end if							
			
			end if
				
			if messageBox("RGA", "Vuoi annullare la seguente variazione?~n"+ls_nome+":~n"+ls_descrizione, question!, yesNo!, 2)= 2 then
				
				rollback;
				messageBox("RGA", "Operazione annullata", information!)
				
			else
			
				commit;
				open(w_message)
				
				s_messaggi ls_messaggi_s

				ls_messaggi_s.oggetto= ls_descrizione+" - La richiesta è stata respinta per le seguenti ragioni:"
	
				openWithParm(w_rga_messaggi_nuovi, ls_messaggi_s)
				
			end if	
			
		case 'A'
			
			return 0
			
	end choose
	
	ll_ret= this.retrieve(is_capitolo, is_competenza)
	
	return 
		
		

end event

event buttonclicked;call super::buttonclicked;this.acceptText()

string ls_message

s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.causale= "RGA_ANAG"

decimal ld_id
integer idx, li_azione
string ls_token[], ls_cod_variazione, ls_codice, ls_descrizione, ls_nome

if row= 0 or isNull(row) then return 0

ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
ls_codice= this.getItemString(getRow(), "codice")
ls_descrizione= this.getItemString(getRow(), "log_msg")
ls_nome= this.getItemString(getRow(), "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(getRow(), "id") 		

choose case dwo.name
	case "b_messaggio"
	
	if ls_nome<> "" AND NOT isNull(ls_nome) then
	 	is_messaggi_s.oggetto= ls_descrizione
	else
	 	is_messaggi_s.oggetto= ls_cod_variazione		
	end if
	
	openWithParm(w_rga_messaggi_nuovi, is_messaggi_s)
	
end choose
end event

event rbuttondown;call super::rbuttondown;if this.ib_queryMode= true then
	messageBox("RGA", "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview.iuodw_generica= this

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

type tabpage_e from userobject within tab_var
integer x = 18
integer y = 112
integer width = 5349
integer height = 2116
long backcolor = 16777215
string text = "Archivio variazioni eseguite"
long tabbackcolor = 134217734
string picturename = "Database!"
long picturemaskcolor = 536870912
string powertiptext = "E~' l~'archivio delle variazioni già eseguite"
uodw_e uodw_e
end type

on tabpage_e.create
this.uodw_e=create uodw_e
this.Control[]={this.uodw_e}
end on

on tabpage_e.destroy
destroy(this.uodw_e)
end on

type uodw_e from uodw_generica within tabpage_e
integer width = 5714
integer height = 2088
integer taborder = 60
string dataobject = "dw_rga_variazioni_eseguite"
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_append = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
end type

event rbuttondown;call super::rbuttondown;if this.ib_queryMode= true then
	messageBox("RGA", "La funzione di Preview e gestione formato sono disponibili solo ad estrazione eseguita.",  information!)
	return 0
end if

im_preview.iuodw_generica= this

im_preview.m_aggiungi.visible= false
im_preview.m_rimuovi.visible= false
im_preview.m_salva.visible= false

im_preview.PopMenu ( parent.PointerX(), parent.PointerY() )
end event

