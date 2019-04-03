$PBExportHeader$w_ins_esami_sessioni_1.srw
forward
global type w_ins_esami_sessioni_1 from window
end type
type st_eventi from statictext within w_ins_esami_sessioni_1
end type
type st_liste from statictext within w_ins_esami_sessioni_1
end type
type cb_chiudi from commandbutton within w_ins_esami_sessioni_1
end type
type uodw_ins_sessione from uodw_generica within w_ins_esami_sessioni_1
end type
end forward

global type w_ins_esami_sessioni_1 from window
integer width = 2167
integer height = 1564
boolean titlebar = true
string title = "Inserimento/Modifica sessione di esame"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "Report5!"
boolean center = true
st_eventi st_eventi
st_liste st_liste
cb_chiudi cb_chiudi
uodw_ins_sessione uodw_ins_sessione
end type
global w_ins_esami_sessioni_1 w_ins_esami_sessioni_1

type variables
boolean ib_nuovo
dataWindowChild idwc_tipo, idwc_dip, idwc_sale, idwc_luoghi
dataStore ids_eventi_id
decimal id_id
string is_currentluogo, is_currentdip

s_evento is_evento_s
end variables

event closequery;choose case uodw_ins_sessione.uof_modificheincorso()
		
	case 1 to 2
		
		return 0
		
	case 3
		
		return 1
		
end choose
end event

event open;long idx, ll_ret
decimal ld_id

ids_eventi_id= create datastore

ids_eventi_id.dataObject= 'ds_eventi_id'

ids_eventi_id.setTransObject(sqlca)

s_session_s.context= "Inserimento eventi"

uodw_ins_sessione.GetChild('tipo_evento', idwc_tipo)

uodw_ins_sessione.setTransObject(sqlca)
idwc_tipo.setTransObject(sqlca)

idwc_tipo.retrieve()

idx= message.doubleParm


if idx= 0 then
		this.title= "Inserimento sessione d'esame"
		ib_nuovo= true
		uodw_ins_sessione.insertRow(0)
		uodw_ins_sessione.setItem(1, "operatore", s_utente_s.s_nome_esteso)	
		uodw_ins_sessione.setItem(1, "data_creazione", today())			
			
		if NOT f_has_p("S") then uodw_ins_sessione.setColumn("tipo_evento")
	else
		this.title= "Modifica sessione d'esame"
		uodw_ins_sessione.retrieve( idx )
		uodw_ins_sessione.Object.tipo_evento.Protect=1
	
		// id sessione esame
		ld_id= uodw_ins_sessione.getItemDecimal(1, "id")
		
		if isNull(ld_id) then return 0
		
		select count(*)
		into :ll_ret
		from eventi, esami_sessioni
		where esami_sessioni.id= :ld_id and
		eventi.id_esami_sessioni= esami_sessioni.id;
		
		if trap_sql(sqlca, "ITSESSIONI01") <0 then return -1
		
		if ll_ret > 0 then
			
					uodw_ins_sessione.Object.data_evento.Protect=1
					uodw_ins_sessione.Object.ora_inizio.Protect=1
					uodw_ins_sessione.Object.ora_fine.Protect=1					
					
					st_eventi.visible= true
					
		end if		
			
		select count(*)
		into :ll_ret
		from eventi ,  esami, esami_sessioni
		where esami_sessioni.id= :ld_id and
		eventi.id_esami_sessioni= esami_sessioni.id and
		esami.id= eventi.id;
		
		if trap_sql(sqlca, "ITSESSIONI02") <0 then return -1
		
		if ll_ret > 0 then
			
					uodw_ins_sessione.Object.data_ultimo_esame.Protect=1
					uodw_ins_sessione.Object.data_cerimonia_soglia.Protect=1
					
					uodw_ins_sessione.Object.b_cancella1.visible= 0
					uodw_ins_sessione.Object.b_cancella2.visible= 0
					
					st_liste.visible= true
					
		end if
		
end if
end event

on w_ins_esami_sessioni_1.create
this.st_eventi=create st_eventi
this.st_liste=create st_liste
this.cb_chiudi=create cb_chiudi
this.uodw_ins_sessione=create uodw_ins_sessione
this.Control[]={this.st_eventi,&
this.st_liste,&
this.cb_chiudi,&
this.uodw_ins_sessione}
end on

on w_ins_esami_sessioni_1.destroy
destroy(this.st_eventi)
destroy(this.st_liste)
destroy(this.cb_chiudi)
destroy(this.uodw_ins_sessione)
end on

type st_eventi from statictext within w_ins_esami_sessioni_1
boolean visible = false
integer x = 23
integer y = 12
integer width = 1010
integer height = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 134217752
string text = "Per questa sessione sono già state generati degli eventi e data ed orario non possono essere modificati.Potrà essere modificata solo la data diploma"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_liste from statictext within w_ins_esami_sessioni_1
boolean visible = false
integer x = 1051
integer y = 12
integer width = 1038
integer height = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 134217752
string text = "Per questa sessione sono già state generate delle liste e i criteri di partecipazione non possono essere modificati"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_chiudi from commandbutton within w_ins_esami_sessioni_1
integer x = 1614
integer y = 1320
integer width = 453
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

type uodw_ins_sessione from uodw_generica within w_ins_esami_sessioni_1
event type integer ue_delete ( long row )
event ue_postupdate ( long al_row )
integer x = 18
integer y = 224
integer width = 2117
integer height = 1080
integer taborder = 10
string dataobject = "dw_ins_esami_sessioni"
boolean maxbox = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
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
if this.uof_aggiorna() < 0 then return -1

f_log(ls_session_s, ls_message, false)

closeWithReturn(parent, id)

		

end event

event buttonclicked;call super::buttonclicked;long ll_ret
datetime ldt_null

setNull(ldt_null)

choose case dwo.name
		
	case "b_cancella1"
		
		this.setItem(row, "data_ultimo_esame", ldt_null)
		
	case "b_cancella2"		
		
		this.setItem(row, "data_cerimonia_soglia", ldt_null)
		
	case "b_cancella3"		
		
		this.setItem(row, "livello_resp_soglia", 0)
		
	case "b_aggiorna"
		
		ll_ret= ancestorReturnValue
		
		if ll_ret >= 0 then close(parent)
//		
//			if this.update() = -1 then return 0
//			decimal ld_id
//			li_tipo_evento=  this.getItemNumber(row, "tipo_evento")
//			
//			ids_eventi_id.retrieve()
//			ld_id= ids_eventi_id.getItemDecimal(row, "id")		
//			
//			if li_tipo_evento= 11 and ib_nuovo= true then // nuovo evento di tipo consulta...
//					
//					insert into consulta_presenze
//					(id_evento, codice, presenza)
//					select
//					:ld_id, codice, 0
//					from membri_gerarchica
//					where flag_consulta= '1' or flag_cn= '1' or flag_cdf= '1' or flag_auditore_consulta= '1';
//					
//					if trap_sql(sqlca, "UPDATEEVENT02") < 0 then return 0
//
//			end if
//		
//			if sqlca.sqlcode = 0 then
//				
//				commit;
//				if trap_sql(sqlca, "COMMITFAILEDUPDATEEVENT03") < 0 then return 0
//				
//				open(w_message)
//				
//			else
//				
//				rollback;
//				if trap_sql(sqlca, "UPDATEEVENT04") < 0 then return 0
//				
//				open(w_message_negative)
//				
//			end if
//				
//			
//			closeWithReturn(parent,  ld_id)
			

//	case "b_m"							
//		
//		this.event ue_delete(row)
		
end choose
end event

event itemchanged;call super::itemchanged;if dwo.name= "data_ultimo_esame" or dwo.name= "data_cerimonia_soglia" then
	
	decimal ld_id
	integer li_ret
	
	// id sessione esame
	ld_id= this.getItemDecimal(row, "id")
	
	if isNull(ld_id) then return 0
		
	select count(*)
	into :li_ret
	from eventi ,  esami, esami_sessioni
	where esami_sessioni.id= :ld_id and
	eventi.id_esami_sessioni= esami_sessioni.id and
	esami.id= eventi.id;
	
	if trap_sql(sqlca, "ITSESSIONI01") <0 then return -1
	
	if li_ret > 0 then
		
		// non è possibile modificare i criteri perchè delle liste sono già state generate...
		messageBox(parent.title, "Sono già state generate delle liste per questa sessione.~nPer modificare questa data occorre prima cancellare tutte le liste.")
		return 1
		
	end if
	
end if

if dwo.name= "data_evento" then // come default la data diploma è uguale alla data di inizio sessione ...
	
	this.setItem(row, "data_diploma", datetime(data))
	
end if
end event

event updatestart;call super::updatestart;/*

if NOT isNull(this.getItemString(getRow(), "data_diploma") ) then
	
	this.setItem(getRow(), "data_diploma", this.getItemString(getRow(), "data_evento") )
	
end if

*/
end event

