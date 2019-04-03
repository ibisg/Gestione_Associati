$PBExportHeader$w_ins_eventi.srw
forward
global type w_ins_eventi from window
end type
type st_1 from statictext within w_ins_eventi
end type
type cb_chiudi from commandbutton within w_ins_eventi
end type
type uodw_ins_eventi from uodw_generica within w_ins_eventi
end type
end forward

global type w_ins_eventi from window
integer width = 1993
integer height = 1504
boolean titlebar = true
string title = "Inserimento eventi"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Question!"
boolean center = true
st_1 st_1
cb_chiudi cb_chiudi
uodw_ins_eventi uodw_ins_eventi
end type
global w_ins_eventi w_ins_eventi

type variables
boolean ib_nuovo
dataWindowChild idwc_tipo, idwc_dip, idwc_sale, idwc_luoghi
dataStore ids_eventi_id
decimal id_id
string is_currentluogo, is_currentdip

s_evento is_evento_s
end variables

event closequery;choose case uodw_ins_eventi.uof_modificheincorso()
		
	case 1 to 2
		
		return 0
		
	case 3
		
		return 1
		
end choose
end event

event open;ids_eventi_id= create datastore

ids_eventi_id.dataObject= 'ds_eventi_id'

ids_eventi_id.setTransObject(sqlca)

s_session_s.context= "Inserimento eventi"

uodw_ins_eventi.GetChild('cod_dip', idwc_dip)
uodw_ins_eventi.GetChild('tipo_evento', idwc_tipo)
uodw_ins_eventi.GetChild('cod_sala', idwc_sale)
uodw_ins_eventi.GetChild('cod_luogo', idwc_luoghi)

uodw_ins_eventi.setTransObject(sqlca)
idwc_dip.setTransObject(sqlca)
idwc_tipo.setTransObject(sqlca)
idwc_sale.setTransObject(sqlca)
idwc_luoghi.setTransObject(sqlca)

is_evento_s= message.powerObjectParm

idwc_dip.retrieve()
idwc_tipo.retrieve()

idwc_luoghi.retrieve(is_evento_s.cod_dip)
idwc_sale.retrieve(is_evento_s.cod_dip, is_evento_s.cod_luogo)

is_currentdip= is_evento_s.cod_dip
is_currentluogo= is_evento_s.cod_luogo

if is_evento_s.id= 0 then
		this.title= "Inserimento eventi"
		ib_nuovo= true
		uodw_ins_eventi.insertRow(0)
		uodw_ins_eventi.setItem(1, "cod_dip", is_evento_s.cod_dip)		
		uodw_ins_eventi.setItem(1, "operatore", s_session_s.s_utente_s.s_nome_esteso)	
			
		if s_session_s.s_utente_s.s_ambito <> "T" then // se l'ambito operativo non comprende tutta la struttura... 
			uodw_ins_eventi.Object.cod_dip.Protect=1
			uodw_ins_eventi.setColumn("tipo_evento")
			
		end if
		
	else
		this.title= "Modifica eventi"
		uodw_ins_eventi.retrieve( is_evento_s.id )
		
		uodw_ins_eventi.Object.cod_dip.Protect=1
		uodw_ins_eventi.Object.tipo_evento.Protect=1
		
end if
end event

on w_ins_eventi.create
this.st_1=create st_1
this.cb_chiudi=create cb_chiudi
this.uodw_ins_eventi=create uodw_ins_eventi
this.Control[]={this.st_1,&
this.cb_chiudi,&
this.uodw_ins_eventi}
end on

on w_ins_eventi.destroy
destroy(this.st_1)
destroy(this.cb_chiudi)
destroy(this.uodw_ins_eventi)
end on

type st_1 from statictext within w_ins_eventi
integer x = 562
integer y = 1276
integer width = 873
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 67108864
string text = "( N.B. i campi in rosso sono obbligatori )"
boolean focusrectangle = false
end type

type cb_chiudi from commandbutton within w_ins_eventi
integer x = 1522
integer y = 1244
integer width = 439
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;closeWithReturn(parent, -1)
end event

type uodw_ins_eventi from uodw_generica within w_ins_eventi
event type integer ue_delete ( long row )
event ue_postupdate ( long al_row )
integer x = 14
integer width = 1947
integer height = 1232
integer taborder = 10
string dataobject = "dw_ins_eventi"
boolean vscrollbar = false
end type

event type integer ue_delete(long row);integer li_ret
long ll_tipo, id, ll_count
string ls_descr, ls_data, ls_message
s_session ls_session_s

ls_session_s= s_session_s

id= this.getItemNumber(row, "id")

ll_tipo= this.getItemNumber(row, "tipo_evento")

	choose case ll_tipo
			
		case 1 to 5 // esami
			
			select count(*)
			into :ll_count
			from esami
			where id= :id;
			
			if trap_sql(sqlca, "DELEVENTI01") < 0 then return -1			
			
			
		case 6 // Entrata nuovi fedeli
			
			select count(*)
			into :ll_count
			from aspiranti_membri
			where id= :id;
			
			if trap_sql(sqlca, "DELEVENTI02") < 0 then return -1
			
			
		case 7 // Consegna o sostituzione G
			
			select count(*)
			into :ll_count
			from gohonzon_consegne
			where id= :id;
			
			if trap_sql(sqlca, "DELEVENTI03") < 0 then return -1			
			
		case 8 // Corsi
			
			select datediff(day, data_fine_evento, getDate() )
			into :li_ret
			from eventi
			where id= :id;
			
			if li_ret <= 0 then
			
				select count(*)
				into :ll_count
				from partecipanti
				where id= :id;		
				
				if trap_sql(sqlca, "DELEVENTI04") < 0 then return -1			
				
			else
				
				ll_count= 0 // permette così la cancellazione...
				
			end if
			
		case 11 // Consulta
			
			select datediff(day, data_fine_evento, getDate() )
			into :li_ret
			from eventi
			where id= :id;
			
			if li_ret <= 0 then
			
				select count(*)
				into :ll_count
				from consulta_presenze
				where id_evento= :id and
						presenza= 1;
				
				if trap_sql(sqlca, "DELEVENTI11") < 0 then return -1		
				
			else
				
				ll_count= 0 // permette così la cancellazione...
				
			end if				
			
	end choose
	
	if isNull(ll_count) then ll_count= 0
	
	if ll_count > 0 then
		
		
		messageBox(parent.title, "Questo evento è in corso e sono stati inseriti dati relativi a "+string(ll_count)+ " partecipanti: ~n"+&
											"La cancellazione sarà possibile solo alla chiusura dell'evento.", information!)
												
		return 0
		
	end if
	
if messageBox(parent.title, "Confermi la cancellazione?", question!, yesNo!, 2)= 2 then return 0

ls_descr= this.getItemString(row, "descrizione_evento")
ls_data= string(this.getItemDateTime(row, "data_evento"), "dd.mm.yyyy")
ls_message= "Eventi: "+" cancellato l'evento "+ls_descr+" del "+ls_data
		
if this.deleteRow(0)= -1 then return -1
//if this.uof_aggiorna() < 0 then return -1

f_log(ls_session_s, ls_message, false)

closeWithReturn(parent, id)

		

end event

event buttonclicked;integer li_ret, li_tipo_evento

// Non esegue la script dell'ancestor

choose case dwo.name
		
	case "b_aggiorna"
		
			if f_checknull(this) < 0 then return 0
		
			if this.update() = -1 then 
				open(w_message_negative)
				return 0
			end if
			decimal ld_id
			li_tipo_evento=  this.getItemNumber(row, "tipo_evento")
			
			ids_eventi_id.retrieve()
			ld_id= ids_eventi_id.getItemDecimal(row, "id")		
			
			if li_tipo_evento= 11 and ib_nuovo= true then // nuovo evento di tipo consulta...
					
					insert into consulta_presenze
					(id_evento, codice, adesione, presenza, note)
					select
					:ld_id, codice, 0, 0, null
					from membri_gerarchica
					where flag_consulta= '1' or flag_cn= '1' or flag_cdf= '1' or flag_auditore_consulta= '1' or flag_ministro_culto= '1';
					
					if trap_sql(sqlca, "UPDATEEVENT02") < 0 then return 0

			end if
		
			if sqlca.sqlcode = 0 then
				
				commit;
				if trap_sql(sqlca, "COMMITFAILEDUPDATEEVENT03") < 0 then return 0
				
				open(w_message)
				
			else
				
				rollback;
				if trap_sql(sqlca, "UPDATEEVENT04") < 0 then return 0
				
				open(w_message_negative)
				
			end if
				
			
			closeWithReturn(parent,  ld_id)
			

	case "b_m"							
		
		this.event ue_delete(row)
		
end choose
end event

event editchanged;call super::editchanged;datetime ldt_fine, ldt_inizio

if dwo.name= "cdurata" then
	ldt_inizio= this.getItemDateTime(row, "data_evento")
	ldt_fine= datetime(RelativeDate ( date(ldt_inizio), integer(data) - 1) )
	this.setItem(row, "data_fine_evento", ldt_fine)
	this.acceptText()
end if
end event

event itemchanged;call super::itemchanged;date ld_inizio
datetime ldt_fine, ldt_data_evento,  ldt_ora_inizio,   ldt_ora_fine,   ldt_data_creazione
decimal idx
integer li_durata, li_ret, li_tipo_evento
string ls_dipendenza,  ls_operatore , ls_null

setNull(ls_null)

idwc_sale.setTransObject(sqlca)
idwc_luoghi.setTransObject(sqlca)

choose case dwo.name
		
case "tipo_evento"
	
	if integer(data)= 6 then // cerimonie di entrata
	
		this.object.descrizione_evento_t.text= "Luogo cerimonia: ~nLa località, per es. FIRENZE"
		
		select descrizione
		into :ls_dipendenza
		from dipendenze
		where cod_dip= :is_currentdip;
		if trap_sql(sqlca, "INSEVENTI01") < 0 then return -1
		
		this.setItem(row, "descrizione_evento", upper(ls_dipendenza) )
		
		this.selectText(1, len(ls_dipendenza) )
		
		this.setColumn("descrizione_evento")
		
	else
		
		//this.object.descrizione_evento_t.text= "Luogo evento:"	
		
		if integer(data) < 6 then
			
			// verifica se esistono una o più sessioni d'esame al livello selezionato...
			
			select count(*) into :li_ret from esami_sessioni where tipo_evento= convert(integer, :data);
			
//			// deve estrarre un solo record, quello con data= MIN(data)
//			
//			select id
//			into :idx
//
//			from esami_sessioni
//			where tipo_evento= convert(integer, :data) and
//						data_evento= (select MIN(data_evento) from esami_sessioni e
//			 									where e.tipo_evento= esami_sessioni.tipo_evento);
			
			if trap_sql(sqlca, "INSEVENTI02") < 0 then return -1
			
			// se esiste estrae i dati identificativi della sessione...
			
			if isNull(li_ret) then li_ret= 0
			
			if li_ret = 0 then
				
				messageBox(parent.title, "Nessuna sessione di esame è stata definita per questo livello.")
				return 1
				
			else
				
				// quale sessione per lo stesso livello?...
				
				s_adesioni s_adesioni_s
				
				openWithParm(w_seleziona_sessione_esami,  integer(data) )
				
				s_adesioni_s= message.powerObjectParm
				
				if s_adesioni_s.id_sessione= -1 then return -1
				
				  SELECT 
						esami_sessioni.tipo_evento,   
//						convert(varchar, esami_sessioni.data_evento),   
//						convert(varchar, esami_sessioni.ora_inizio),   
//						convert(varchar, esami_sessioni.ora_fine),   
//						convert(varchar, esami_sessioni.data_creazione),   
						
						esami_sessioni.data_evento,   
						 esami_sessioni.ora_inizio,   
						esami_sessioni.ora_fine,   
						esami_sessioni.data_creazione,   						
						
						esami_sessioni.operatore  						
				 INTO 
						:li_tipo_evento, 
						:ldt_data_evento,   
						:ldt_ora_inizio,   
						:ldt_ora_fine,   
						:ldt_data_creazione,  						
						:ls_operatore  
				 FROM esami_sessioni
				 where id= :s_adesioni_s.id_sessione
				 			;
				 
				if trap_sql(sqlca, "INSEVENTI03") < 0 then return -1
				 
				 
			//  e li inserisce nei relativi campi...
			
			this.setItem(row, "id_esami_sessioni", s_adesioni_s.id_sessione)			
			this.setItem(row, "tipo_evento", li_tipo_evento)
			this.setItem(row, "data_evento", ldt_data_evento)
			this.setItem(row, "ora_inizio", ldt_ora_inizio)
			this.setItem(row, "data_fine_evento", ldt_data_evento)
			this.setItem(row, "ora_fine", ldt_ora_fine)
			this.setItem(row, "data_creazione", ldt_data_creazione) 
			this.setItem(row, "operatore", s_session_s.s_utente_s.s_nome_esteso)	
			
			this.Object.tipo_evento.Protect= 1
			this.Object.data_evento.Protect= 1
			this.Object.ora_inizio.Protect= 1
			this.Object.data_fine_evento.Protect= 1
			this.Object.ora_fine.Protect= 1
			
			this.setColumn("descrizione_evento")
	
			end if
			
		end if
		
	end if
		
case "data_evento"
//		li_durata= this.getItemNumber(row, "cdurata")
//		if isNull(li_durata) then li_durata= 1
		ld_inizio= date(datetime(data))
//		ldt_fine= datetime(RelativeDate( ld_inizio, li_durata -1) )
		li_ret= this.setItem(row, "data_fine_evento", ld_inizio)
		this.acceptText()
		
case "cod_dip"
	
//	this.GetChild('cod_luogo', idwc_luoghi)
//	idwc_luoghi.retrieve(data)
	//idwc_sale.retrieve(data, this.getItemString(row, "cod_luogo") )
		
	is_currentdip= this.getText()
	//this.setItem(row, "tipo_evento", setNull(li_durata) )
	this.setItem(row, "descrizione_evento", "")	
	this.setItem(row, "cod_luogo", "")
	this.setItem(row, "cod_sala", "")
	
case "cod_luogo"
	
	is_currentluogo= this.getText()
	this.setItem(row, "cod_sala", ls_null)
	this.GetChild('cod_sala', idwc_sale)
	
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
		
	case "cod_dip"
		
//		is_currentdip= data
		
	case "cod_luogo"
		
		this.GetChild('cod_luogo', idwc_luoghi)
		idwc_luoghi.retrieve(is_currentdip)
		
	case "cod_sala"
		
		this.GetChild('cod_sala', idwc_sale)
		idwc_sale.retrieve(is_currentdip, is_currentluogo )

end choose
end event

event retrieveend;call super::retrieveend;integer li_days
datetime ldt_1, ldt_2

if is_evento_s.id > 0 then

	ldt_1= this.getItemDateTime( this.getRow(), "data_evento")
	
	ldt_2= this.getItemDateTime( this.getRow(), "data_fine_evento")
	
	li_days= daysAfter( date(ldt_1), date(ldt_2) ) + 1
	
	this.setItem(this.getRow(), "cdurata", li_days )
	
	this.SetItemStatus(5, "cdurata", Primary!, NotModified!)

end if
end event

event updateend;call super::updateend;//integer li_tipo_evento
//decimal ld_id
//
//li_tipo_evento=  this.getItemNumber(this.getRow(), "tipo_evento")
//ld_id= this.getItemDecimal(this.getRow(), "id")		
//
//if li_tipo_evento= 11 and ib_nuovo= true then // nuovo evento di tipo consulta...
//		
//		insert into consulta_presenze
//		(id_evento, codice, presenza)
//		select
//		:ld_id, codice, 0
//		from membri_gerarchica
//		where flag_consulta= '1' or flag_cn= '1' or flag_cdf= '1' or flag_auditore_consulta= '1';
//		
//		if trap_sql(sqlca, "UPDATEEVENT02") < 0 then return 0
//
//end if
//
////if sqlca.sqlcode = 0 then
////	
////	commit;
////	if trap_sql(sqlca, "COMMITFAILEDUPDATEEVENT03") < 0 then return 0
////	
////else
////	
////	rollback;
////	if trap_sql(sqlca, "UPDATEEVENT04") < 0 then return 0
////	
////end if
//	
//
//closeWithReturn(parent,  ld_id)
end event

