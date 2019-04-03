$PBExportHeader$w_rga_membri.srw
forward
global type w_rga_membri from window
end type
type st_messaggi from statictext within w_rga_membri
end type
type st_1 from statictext within w_rga_membri
end type
type p_vai from picture within w_rga_membri
end type
type tab_var from tab within w_rga_membri
end type
type tabpage_i from userobject within tab_var
end type
type uodw_i from uodw_generica within tabpage_i
end type
type tabpage_i from userobject within tab_var
uodw_i uodw_i
end type
type tabpage_s from userobject within tab_var
end type
type uodw_s from uodw_generica within tabpage_s
end type
type tabpage_s from userobject within tab_var
uodw_s uodw_s
end type
type tab_var from tab within w_rga_membri
tabpage_i tabpage_i
tabpage_s tabpage_s
end type
type pb_messaggi from picturebutton within w_rga_membri
end type
end forward

global type w_rga_membri from window
boolean visible = false
integer width = 6597
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
st_messaggi st_messaggi
st_1 st_1
p_vai p_vai
tab_var tab_var
pb_messaggi pb_messaggi
end type
global w_rga_membri w_rga_membri

type variables
string s_log_msg, is_capitolo, is_tipo, is_competenza='I'
s_messaggi is_messaggi_s
s_rga is_rga_s
dataWindowChild idwc_gruppi, idwc_settori

transaction isqlca

m_preview im_preview
end variables

forward prototypes
public function integer wf_retrieve (string capitolo, string competenza)
end prototypes

public function integer wf_retrieve (string capitolo, string competenza);long ll_ret

dataWindow ldw_var

if capitolo="" or isNull(capitolo) then return 0

this.setRedraw(false)

if competenza= 'I' then
	
	ldw_var= tab_var.tabpage_i.uodw_i
	
	ldw_var.height= tab_var.tabpage_i.height - 20
	
else
	
	ldw_var= tab_var.tabpage_s.uodw_s
	
	ldw_var.height= tab_var.tabpage_s.height - 20
	
end if

	ldw_var.setTransObject(sqlca)

	ll_ret= ldw_var.retrieve(capitolo, competenza)
	
	ldw_var.scrollToRow(1)
	ldw_var.setRow(1)
	ldw_var.setFocus()

this.setRedraw(true)

if ll_ret = 0 then
	
	messageBox("RGA", "Nessun risultato")
	return 0
	
end if

return 0
end function

event open;integer li_ret
long ll_ret

isqlca= sqlca

isqlca.Lock = "RU"
isqlca.AutoCommit = False

connect using isqlca;

li_ret= tab_var.tabpage_i.uodw_i.GetChild('vc_parent', idwc_gruppi)

li_ret= tab_var.tabpage_i.uodw_i.GetChild('vc_settori',idwc_settori)

im_preview= create m_preview

//uodw_current.setTransObject(sqlca)

idwc_gruppi.setTransObject(sqlca)
idwc_settori.setTransObject(sqlca)



end event

on w_rga_membri.create
this.st_messaggi=create st_messaggi
this.st_1=create st_1
this.p_vai=create p_vai
this.tab_var=create tab_var
this.pb_messaggi=create pb_messaggi
this.Control[]={this.st_messaggi,&
this.st_1,&
this.p_vai,&
this.tab_var,&
this.pb_messaggi}
end on

on w_rga_membri.destroy
destroy(this.st_messaggi)
destroy(this.st_1)
destroy(this.p_vai)
destroy(this.tab_var)
destroy(this.pb_messaggi)
end on

event resize;
this.Y=172

tab_var.height= this.height - 20 - tab_var.y
end event

event close;delete from rga_locks where vc_nodo= :is_capitolo using isqlca;
if trap_sql(isqlca, "LOCKS03") < 0 then return -1

commit using isqlca;

disconnect using isqlca;
end event

type st_messaggi from statictext within w_rga_membri
boolean visible = false
integer x = 1984
integer y = 76
integer width = 274
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
string text = "Messaggi"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;pb_messaggi.triggerEvent(clicked!)
end event

type st_1 from statictext within w_rga_membri
integer x = 855
integer y = 76
integer width = 777
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 67108864
string text = "Accettazione richieste di variazione"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;p_vai.triggerEvent(clicked!)
end event

type p_vai from picture within w_rga_membri
integer x = 1646
integer y = 60
integer width = 110
integer height = 96
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "avanti.png"
boolean focusrectangle = false
end type

event clicked;long ll_ret

if is_capitolo <> ""  then

	delete from rga_locks where vc_nodo= :is_capitolo using isqlca;
	if trap_sql(isqlca, "LOCKS04") < 0 then return -1
	
end if

tab_var.tabpage_i.uodw_i.reset()
tab_var.tabpage_s.uodw_s.reset()

open(w_seleziona_gruppi_modifiche)

is_rga_s= message.powerObjectParm

is_capitolo= is_rga_s.vc_nodo
is_tipo= is_rga_s.tipo

if is_capitolo="" OR isNull(is_capitolo) then return -1

 is_messaggi_s.vc_nodo= is_capitolo

select count(*)
into :ll_ret
from rga_locks
where vc_nodo= :is_capitolo
using isqlca;
if trap_sql(isqlca, "LOCKS01") < 0 then return -1

if ll_ret > 0 then
	
	messageBox("RGA", "Un altro operatore sta elaborando le variazioni relative a "+is_capitolo+"~nSelezionare un altro capitolo")
	
	return 0
	
end if

insert into rga_locks (vc_nodo) values(:is_capitolo) using isqlca;
if trap_sql(isqlca, "LOCKS02") < 0 then return -1

ll_ret=idwc_gruppi.retrieve(is_capitolo, 7)
ll_ret=idwc_settori.retrieve(is_capitolo, 6)

/*
 * all'inizio devo controllare se esistono record in rga_membri senza corrispondenti record 
 * in rga_variazioni relativi ad azioni da eseguire. Se non ci sono posso cancellare i record
 * relativi al capitolo in questione da rga_membri (tabella temporanea) dato che le modifiche 
 * sono state riportate in membri_gerarchica.
 */
  
select count(*)
into :ll_ret
from rga_membri, rga_variazioni
where rga_variazioni.vc_nodo= :is_capitolo and
rga_membri.vc_parent like  :is_capitolo+"%"  and
rga_variazioni.flag_daeseguire = 1;  

if trap_sql(sqlca, "OPEN01") < 0 then return -1

if ll_ret= 0 OR isNull(ll_ret) then
	
	delete from rga_membri where vc_parent like :is_capitolo+"%";
	
	if trap_sql(sqlca, "OPEN02") < 0 then
		
		rollback;
		
	else
		
		commit;
		
	end if
	
end if

select count(*)
into :ll_ret
from rga_messaggi where vc_nodo= :is_capitolo and flag_letto=0 and mittente= 'I';

 trap_sql(sqlca, "OPEN03")
 
 if ll_ret > 0 then
	
	messageBox("Messaggi", "Ci sono messaggi non letti")
	pb_messaggi.triggerEvent(clicked!)
	
end if
 
pb_messaggi.visible= true 
st_messaggi.visible= true

tab_var.selectTab(1)

parent.title= "Accettazione variazioni da "+is_capitolo
 
 return 0
end event

type tab_var from tab within w_rga_membri
event create ( )
event destroy ( )
integer x = 46
integer y = 224
integer width = 5426
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
tabpage_i tabpage_i
tabpage_s tabpage_s
end type

on tab_var.create
this.tabpage_i=create tabpage_i
this.tabpage_s=create tabpage_s
this.Control[]={this.tabpage_i,&
this.tabpage_s}
end on

on tab_var.destroy
destroy(this.tabpage_i)
destroy(this.tabpage_s)
end on

event selectionchanged;if newindex= 1 then
	wf_retrieve(is_capitolo, 'I')
else
	wf_retrieve(is_capitolo, 'S')
end if
end event

type tabpage_i from userobject within tab_var
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5390
integer height = 2128
long backcolor = 67108864
string text = "Competenza istituzionali"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
uodw_i uodw_i
end type

on tabpage_i.create
this.uodw_i=create uodw_i
this.Control[]={this.uodw_i}
end on

on tabpage_i.destroy
destroy(this.uodw_i)
end on

type uodw_i from uodw_generica within tabpage_i
event type integer postitemchanged ( string as_codice,  string as_log_msg )
integer width = 5385
integer height = 1476
integer taborder = 50
string dataobject = "dw_rga_variazioni_offline"
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

event type integer postitemchanged(string as_codice, string as_log_msg);//// Aggiorna rga_membri...
//
//if this.update()= -1 then
//	messageBox(parent.title, "INSVAR01: Errore in aggiornamento")
//	goto errore
//end if
//	
//INSERT INTO rga_variazioni  
//		( 	codice,   
//			log_msg )  
//VALUES ( :as_codice,   
//			 :as_log_msg ) ;
//
//if trap_sql(sqlca, "INSVAR02") < 0 then goto errore
//
//commit;
//if trap_sql(sqlca, "INSVAR03") < 0 then goto errore
return 0
//
//errore:
//	rollback;
//	return -1
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

ls_cod_variazione= this.getItemString(row, "cod_variazione")
ls_codice= this.getItemString(row, "codice")
ls_descrizione= this.getItemString(row, "log_msg")
ls_nome= this.getItemString(row, "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(row, "id") 		

choose case dwo.name
	case "b_messaggio"
		
	 is_messaggi_s.oggetto= ls_nome+": "+ls_cod_variazione

	openWithParm(w_rga_messaggi_nuovi, is_messaggi_s)
			
end choose



end event

event doubleclicked;call super::doubleclicked;this.acceptText()

string ls_message, ls_vc_nodo_destinazione

s_session ls_session_s

ls_session_s= s_session_s

ls_session_s.causale= "RGA_ANAG"

decimal ld_id
integer idx, li_flag_daeseguire
string ls_token[], ls_cod_variazione, ls_codice, ls_descrizione, ls_nome, ls_ret		

ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
ls_codice= this.getItemString(getRow(), "codice")
ls_descrizione= this.getItemString(getRow(), "log_msg")
ls_nome= this.getItemString(getRow(), "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(getRow(), "id") 		
li_flag_daeseguire=  this.getItemNumber(getRow(), "flag_daeseguire") 

openWithParm(w_rga_azioni, ls_descrizione)

ls_ret= message.stringParm

choose case ls_ret
		
	case 'E'
		
		if li_flag_daeseguire= 1 then
							
					do while ls_cod_variazione <> ""	
						idx++
						ls_token[idx]= f_get_token(ls_cod_variazione, ",")
					loop	
					  
					choose case   ls_token[1]
							
						case "TRASFOUT"
							
							/*
							  * inserisce una riga in rga_variazioni con codice TRASFIN e con vc_nodo uguale al capitolo di destinazion
							  */
							  
							  ls_vc_nodo_destinazione=  ls_token[4]
							  
							    INSERT INTO rga_variazioni  
								( codice,   
								  vc_nodo,   
								  flag_daeseguire,   
								  log_msg,   
								  data_richiesta,   
								  data_variazione,   
								  operatore,   
								  note,   
								  cod_variazione,   
								  richiesta_da,   
								  tipo )  
								  SELECT rga_variazioni.codice,   
											:ls_vc_nodo_destinazione,   
											1,   
											"TRASFEND: Conclusione del trasferimento di "+:ls_nome+" da: "+:is_capitolo+" a: "+:ls_vc_nodo_destinazione,
											getdate(),   
											rga_variazioni.data_variazione,   
											rga_variazioni.operatore,   
											rga_variazioni.note,   
											"TRASFEND,"+:ls_codice+", "+:ls_nome,  
											rga_variazioni.richiesta_da,   
											"TRASFEND"  
									 FROM rga_variazioni  
									 where id= :ld_id;
							 			
							if trap_sql(sqlca, "CASETRASFOUT") < 0 then
							
								rollback;
								return -1
							
							end if
							
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
										  "Eseguire il trasferimento in entrata di "+:ls_nome+" da: "+:is_capitolo+" a: "+:ls_vc_nodo_destinazione,   
										  getdate(),   
										  'S',   
										  'Richiesta di trasferimento' )  ;

							if trap_sql(sqlca, "CASETRASFEND") < 0 then
							
								rollback;
								return -1
							
							end if

							
						case "DIV"
							
							update membri_gerarchica
							set cod_div= : ls_token[3]
							where codice= :ls_codice;
			
							if trap_sql(sqlca, "CASEDIV") < 0 then
							
								rollback;
								return -1
							
							end if
							
						case "PA"
							
							update membri_gerarchica
							set flag_npa= : ls_token[3]
							where codice= :ls_codice;
			
							if trap_sql(sqlca, "CASENPA") < 0 then
							
								rollback;
								return -1
							
							end if		
							
						case "TRASFG"
							
							update membri_gerarchica
							set vc_parent= : ls_token[3]
							where codice= :ls_codice;
			
							if trap_sql(sqlca, "CASETRASFG") < 0 then
							
								rollback;
								return -1
							
							end if					
							
						case "RESP1"
							
							update membri_gerarchica
							set cod_att_ist_1= : ls_token[3]
							where codice= :ls_codice;
			
							if trap_sql(sqlca, "CASERESP1") < 0 then
							
								rollback;
								return -1
							
							end if							
							
						case "RESP2"
							
							update membri_gerarchica
							set cod_att_ist_2= : ls_token[3]
							where codice= :ls_codice;
			
							if trap_sql(sqlca, "CASERESP2") < 0 then
							
								rollback;
								return -1
							
							end if							
							
					end choose
					
					 /* variazione eseguita... */
					update rga_variazioni
					set flag_daeseguire= 0,
					data_variazione= getDate(),
					operatore= :s_utente_s.s_nome_esteso
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
					
					wf_retrieve(is_capitolo, 'I')
					
					return 0
					
					
			end if
			
		case 'C'

				 /* variazione annullata... vuol dire che non è il caso di effettuarla perchè mal formulata */
				update rga_variazioni
				set flag_daeseguire= 2,
				data_variazione= getDate(),
				operatore= :s_utente_s.s_nome_esteso
				where id= :ld_id;
				
				if messageBox("RGA", "Vuoi annullare la seguente variazione?~n"+ls_nome+":~n"+ls_descrizione, question!, yesNo!, 2)= 2 then
					
					rollback;
					messageBox("RGA", "Operazione annullata", information!)
					
				else
				
					commit;
					open(w_message)
					
				end if
			
			this.retrieve(is_capitolo,' I')				
			
		case 'A'
			
			return 0
			
	end choose
		
		

end event

event itemchanged;//	ls_session_s.causale= "ANAG"
//	
//	ls_message= "Domicilio: "+this.getItemString(row, "ind_dom")+" - Modificato in: "+data
//			
//	ls_cognomenome= this.getItemString(row, "cognome")+" "+this.getItemString(row, "nome")
//	
//	ls_message= ls_cognomenome+": "+ls_message
//	
//	f_log(ls_session_s, ls_message, false)
end event

event sqlpreview;call super::sqlpreview;integer li_pos
string sqlsyntax1, sqlsyntax2

if is_tipo <> "" then
	
	li_pos= pos(lower(sqlsyntax), "where")
	
	sqlsyntax1= mid(sqlsyntax, 1, li_pos + 5)
	
	sqlsyntax2= mid(sqlsyntax, len(sqlsyntax1) + 1, len(sqlsyntax) )
	
	sqlsyntax= sqlsyntax1 +" "+ is_tipo +" "+ sqlsyntax2
	
	SetSqlPreview ( sqlsyntax)
	
end if
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

type tabpage_s from userobject within tab_var
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5390
integer height = 2128
long backcolor = 67108864
string text = "Competenza segreteria"
long tabtextcolor = 255
long picturemaskcolor = 536870912
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
integer width = 5367
integer height = 2128
integer taborder = 50
string dataobject = "dw_rga_variazioni_offline_s"
boolean controlmenu = true
boolean ib_isgrid = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event type integer postitemchanged(string as_codice, string as_log_msg);//// Aggiorna rga_membri...
//
//if this.update()= -1 then
//	messageBox(parent.title, "INSVAR01: Errore in aggiornamento")
//	goto errore
//end if
//	
//INSERT INTO rga_variazioni  
//		( 	codice,   
//			log_msg )  
//VALUES ( :as_codice,   
//			 :as_log_msg ) ;
//
//if trap_sql(sqlca, "INSVAR02") < 0 then goto errore
//
//commit;
//if trap_sql(sqlca, "INSVAR03") < 0 then goto errore
return 0
//
//errore:
//	rollback;
//	return -1
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

ls_cod_variazione= this.getItemString(row, "cod_variazione")
ls_codice= this.getItemString(row, "codice")
ls_descrizione= this.getItemString(row, "log_msg")
ls_nome= this.getItemString(row, "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(row, "id") 		

choose case dwo.name
	case "b_messaggio"
	
	if ls_nome<> "" AND NOT isNull(ls_nome) then
	 	is_messaggi_s.oggetto= ls_nome+": "+ls_cod_variazione
	else
	 	is_messaggi_s.oggetto= ls_cod_variazione		
	end if

	openWithParm(w_rga_messaggi_nuovi, is_messaggi_s)
			
end choose



end event

event doubleclicked;call super::doubleclicked;//this.acceptText()
//
//string ls_message
//
//s_session ls_session_s
//
//ls_session_s= s_session_s
//
//ls_session_s.causale= "RGA_ANAG"
//
//decimal ld_id
//integer idx, li_flag_daeseguire
//string ls_token[], ls_cod_variazione, ls_codice, ls_descrizione, ls_nome, ls_ret		
//
//ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
//ls_codice= this.getItemString(getRow(), "codice")
//ls_descrizione= this.getItemString(getRow(), "log_msg")
//ls_nome= this.getItemString(getRow(), "cognome_nome")
///* puntatore alla riga di variazioni */
//ld_id= this.getItemDecimal(getRow(), "id") 		
//li_flag_daeseguire=  this.getItemNumber(getRow(), "flag_daeseguire") 
//
//openWithParm(w_rga_azioni, ls_descrizione)
//
//ls_ret= message.stringParm
//
//choose case ls_ret
//		
//	case 'E'
//		
//		if li_flag_daeseguire= 1 then
//					
//					 /* variazione eseguita... */
//					update rga_variazioni
//					set flag_daeseguire= 0,
//					data_variazione= getDate(),
//					operatore= :s_utente_s.s_nome_esteso
//					where id= :ld_id;
//					
//					if trap_sql(sqlca, "BCLICKED01") < 0 then
//						
//						rollback;
//						return -1
//						
//					end if
//					
//					ls_message= "(RGA): "+ls_nome+" - "+ls_descrizione
//					
//					if f_log(ls_session_s, ls_message, false)= -1 then
//						
//						rollback;
//						return -1
//						
//					end if		
//					
//					if messageBox("RGA", "Confermi la seguente variazione?~n"+ls_nome+":~n"+ls_descrizione, question!, yesNo!, 2)= 2 then
//						
//						rollback;
//						messageBox("RGA", "Operazione annullata", information!)
//						
//					else
//					
//						commit;
//						open(w_message)
//						
//					end if
//					
//					wf_retrieve(is_capitolo, 'S')
//					
//					return 0
//					
//					
//			end if
//			
//		case 'C'
//
//				 /* variazione annullata... vuol dire che non è il caso di effettuarla perchè mal formulata */
//				update rga_variazioni
//				set flag_daeseguire= 2,
//				data_variazione= getDate(),
//				operatore= :s_utente_s.s_nome_esteso
//				where id= :ld_id;
//				
//				if messageBox("RGA", "Vuoi annullare la seguente variazione?~n"+ls_nome+":~n"+ls_descrizione, question!, yesNo!, 2)= 2 then
//					
//					rollback;
//					messageBox("RGA", "Operazione annullata", information!)
//					
//				else
//				
//					commit;
//					open(w_message)
//					
//				end if
//			
//			this.retrieve(is_capitolo,' S')				
//			
//		case 'A'
//			
//			return 0
//			
//	end choose
//		
//		
//
end event

event itemchanged;this.acceptText()

string ls_message

s_session ls_session_s

ls_session_s= s_session_s

decimal ld_id
integer idx, li_flag_daeseguire
string ls_cod_variazione, ls_codice, ls_descrizione, ls_nome, ls_ret	

ls_session_s.causale= "RGA_ANAG"


ls_cod_variazione= this.getItemString(getRow(), "cod_variazione")
ls_codice= this.getItemString(getRow(), "codice")
ls_descrizione= this.getItemString(getRow(), "log_msg")
ls_nome= this.getItemString(getRow(), "cognome_nome")
/* puntatore alla riga di variazioni */
ld_id= this.getItemDecimal(getRow(), "id") 		
li_flag_daeseguire=  this.getItemNumber(getRow(), "flag_daeseguire") 

li_flag_daeseguire= integer(data)
		
 /* variazione eseguita... */
update rga_variazioni
set flag_daeseguire= :li_flag_daeseguire,
data_variazione= getDate(),
operatore= :s_utente_s.s_nome_esteso
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

if li_flag_daeseguire= 0 then
	
	ls_message= "Confermi la seguente variazione?~n"+ls_descrizione
	
else
	
	ls_message= "Vuoi annullare la seguente variazione?~n"+ls_descrizione	
	
end if

if messageBox("RGA", ls_message, question!, yesNo!, 2)= 2 then
	
	rollback;
	messageBox("RGA", "Operazione annullata", information!)
	return 1
	
else

	commit;
	open(w_message)
	return 0
	
end if
end event

event sqlpreview;call super::sqlpreview;integer li_pos
string sqlsyntax1, sqlsyntax2

if is_tipo <> "" then
	
	li_pos= pos(lower(sqlsyntax), "where")
	
	sqlsyntax1= mid(sqlsyntax, 1, li_pos + 5)
	
	sqlsyntax2= mid(sqlsyntax, len(sqlsyntax1) + 1, len(sqlsyntax) )
	
	sqlsyntax= sqlsyntax1 +" "+ is_tipo +" "+ sqlsyntax2
	
	SetSqlPreview ( sqlsyntax)
	
end if
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

type pb_messaggi from picturebutton within w_rga_membri
boolean visible = false
integer x = 2267
integer y = 20
integer width = 192
integer height = 168
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
string picturename = "sendmail6.jpg"
alignment htextalign = left!
string powertiptext = "Invia e ricevi messaggi"
end type

event clicked;openWithParm(w_rga_messaggi, is_messaggi_s)
end event

