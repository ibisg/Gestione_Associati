$PBExportHeader$w_esami_sessioni.srw
forward
global type w_esami_sessioni from window
end type
type uodw_esami_sessioni from uodw_generica within w_esami_sessioni
end type
end forward

global type w_esami_sessioni from window
integer width = 5787
integer height = 1892
boolean titlebar = true
string title = "Sessioni d~'esame"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
event type long ue_postopen ( )
uodw_esami_sessioni uodw_esami_sessioni
end type
global w_esami_sessioni w_esami_sessioni

type variables
m_preview_sessioni im_preview_sessioni
end variables

event type long ue_postopen();decimal ld_id
integer li_tipo_evento, li_livello_resp_soglia
long ll_adesioni, ll_inlista, ll_row, ll_conteggio
datetime ldt_data_evento, ldt_ora_inizio, ldt_ora_fine, ldt_data_creazione, ldt_data_ultimo_esame, ldt_data_cerimonia_soglia			
string ls_operatore, ls_query, ls_a_g, ls_liv, ls_sessione_descrizione


	open(w_wait_snoopy)

	ls_query= 	"SELECT esami_sessioni.id,   "+&
				" esami_sessioni.tipo_evento,   " +&
				" esami_sessioni.data_evento,   " +&
				" esami_sessioni.ora_inizio,   " +&
				" esami_sessioni.ora_fine,   "+ &
				" esami_sessioni.data_creazione, " +&
				" esami_sessioni.operatore,   " + &
				" esami_sessioni.data_ultimo_esame,  " + &  
				" esami_sessioni.data_cerimonia_soglia, " +&
				" (select count(*) from esami_curr e where e.id_esami_sessioni= esami_sessioni.id and convert(integer, e.cod_studio)=  esami_sessioni.tipo_evento and e.esito= ~'I~' and e.data_esame= esami_sessioni.data_evento), " +&
				" esami_sessioni.livello_resp_soglia, "+&
				" esami_sessioni.a_g,  "+&
				" esami_sessioni.descrizione  "+&
		 " FROM esami_sessioni "

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1
	
	this.setRedraw(false)
	
	uodw_esami_sessioni.reset()

		do while sqlca.sqlcode <> 100
			
			fetch query_cur into
			:ld_id,
			:li_tipo_evento,
			:ldt_data_evento,
			:ldt_ora_inizio,
			:ldt_ora_fine,
			:ldt_data_creazione,
			:ls_operatore,
			:ldt_data_ultimo_esame,
			:ldt_data_cerimonia_soglia,
			:ll_adesioni,
			:li_livello_resp_soglia,
			:ls_a_g,
			:ls_sessione_descrizione
			;
			if sqlca.sqlcode= 100 then continue
			
			ll_row= uodw_esami_sessioni.insertRow(0)	
			uodw_esami_sessioni.setItem(ll_row, "id", ld_id )	
			uodw_esami_sessioni.setItem(ll_row, "tipo_evento", li_tipo_evento)			
			uodw_esami_sessioni.setItem(ll_row, "data_evento", ldt_data_evento)
			uodw_esami_sessioni.setItem(ll_row, "ora_inizio", ldt_ora_inizio )	
			uodw_esami_sessioni.setItem(ll_row, "ora_fine", ldt_ora_fine )			
			uodw_esami_sessioni.setItem(ll_row, "data_creazione",ldt_data_creazione )			
			uodw_esami_sessioni.setItem(ll_row, "operatore", ls_operatore )
			uodw_esami_sessioni.setItem(ll_row, "data_ultimo_esame", ldt_data_ultimo_esame )			
			uodw_esami_sessioni.setItem(ll_row, "data_cerimonia_soglia", ldt_data_cerimonia_soglia )	
			uodw_esami_sessioni.setItem(ll_row, "adesioni", ll_adesioni )			
			uodw_esami_sessioni.setItem(ll_row, "livello_resp_soglia", li_livello_resp_soglia )	
			uodw_esami_sessioni.setItem(ll_row, "a_g", ls_a_g )
			uodw_esami_sessioni.setItem(ll_row, "sessione_descrizione", ls_sessione_descrizione )	
			
			ls_liv= "0"+string(li_tipo_evento - 1)
			
			ll_conteggio= f_conteggioaventidiritto_dyn(ls_liv,  ldt_data_cerimonia_soglia, ldt_data_ultimo_esame, li_livello_resp_soglia, ls_a_g)
			
			uodw_esami_sessioni.setItem(ll_row, "aventi_diritto", ll_conteggio)
			
			if ll_row= -1 then exit
			
			ll_row++
	
		loop
		
		close query_cur;

uodw_esami_sessioni.sort()
uodw_esami_sessioni.groupCalc()

this.setRedraw(true)

close(w_wait_snoopy)

uodw_esami_sessioni.Object.DataWindow.ReadOnly="Yes"

return 0
end event

on w_esami_sessioni.create
this.uodw_esami_sessioni=create uodw_esami_sessioni
this.Control[]={this.uodw_esami_sessioni}
end on

on w_esami_sessioni.destroy
destroy(this.uodw_esami_sessioni)
end on

event open;s_session_s.context= "Gestione sessioni di esame"

im_preview_sessioni= create m_preview_sessioni

uodw_esami_sessioni.setTransObject(sqlca)

post event ue_postopen()
end event

type uodw_esami_sessioni from uodw_generica within w_esami_sessioni
integer width = 5678
integer height = 1760
integer taborder = 10
string dataobject = "edw_esami_sessioni"
boolean hscrollbar = false
boolean ib_isgrid = true
boolean ib_readonly = true
boolean ib_allowrowselection = true
boolean ib_aggiorna = false
boolean ib_p = false
boolean ib_m = false
boolean ib_cerca = false
boolean ib_reset = false
end type

event rbuttondown;call super::rbuttondown;decimal ld_id
integer li_count

im_preview_sessioni.iuodw_generica= uodw_esami_sessioni

	im_preview_sessioni.m_aggiungi.visible= false
	im_preview_sessioni.m_inserisci.visible= false
	
	 im_preview_sessioni.m_rimuovi.visible= false

	
	im_preview_sessioni.m_salva.visible= false
	
	// come in eventi: se almeno un evento è stato creato va nella finestra delle medie, se no va in inserimento
	// per andare in modifica dei parametri della sessione devo per forza usare il tasto destro del mouse

im_preview_sessioni.PopMenu ( w_esami_sessioni.PointerX(), w_esami_sessioni.PointerY() )
end event

event buttonclicked;// Non deve eseguire la script ancestor

integer li_ret
string ls_message
decimal ll_id

choose case dwo.name
		
	case "b_p" 
		
		openWithParm(w_ins_esami_sessioni,  0)
		
		if message.doubleParm < 0 then return
		
		parent.event ue_postopen()
	
	case "b_m"
		
		// controlla che non ci siano eventi legati alla sessione
		
		ll_id= this.getItemDecimal(this.getRow(), "id")
		
		if isNull(ll_id) OR ll_id= 0 then return 0
		
		select count(*)
		into :li_ret	
		from eventi, esami
		where
		eventi.id= esami.id and
		eventi.id_esami_sessioni=  :ll_id;
		if trap_sql(sqlca, "CANCELLASESSIONE01") < 0 then return -1
		
		if isNull(li_ret) then li_ret= 0
		
		if li_ret > 0 then
			messageBox(parent.title, "Sono stati generati degli eventi relativi a questa sessione.~nNon è possibile procedere alla cancellazione.")
			return -1
		end if
		
		this.deleteRow(getRow())
		
		delete from esami_sessioni where id= :ll_id;
		if trap_sql(sqlca, "CANCELLASESSIONE02") < 0 then
			rollback;
			return -1
		else
			commit;
			if trap_sql(sqlca, "CANCELLASESSIONE03") < 0 then return -1	
		end if
		
		this.retrieve()
	
end choose
end event

event doubleclicked;call super::doubleclicked;decimal ld_id

ld_id= this.getItemDecimal(w_esami_sessioni.uodw_esami_sessioni.getRow(), "id")

openWithParm(w_ins_esami_sessioni, ld_id)

if message.doubleParm < 0 then return

parent.event ue_postopen()
end event

