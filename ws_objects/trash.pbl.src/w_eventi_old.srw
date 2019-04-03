$PBExportHeader$w_eventi_old.srw
forward
global type w_eventi_old from w_centered
end type
type uodw_eventi from uodw_generica within w_eventi_old
end type
end forward

global type w_eventi_old from w_centered
integer width = 4338
integer height = 1840
string title = "Gestione eventi"
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Query5!"
boolean clientedge = true
boolean ib_centered = false
event ue_open ( )
uodw_eventi uodw_eventi
end type
global w_eventi_old w_eventi_old

type variables
datastore ids_scadenze_interne
dataWindowChild idwc_dipendenze, idwc_tipo_eventi, idwc_luoghi, idwc_sale
m_preview im_preview
m_gestione_eventi im_gestione_eventi
end variables

event ue_open();this.setRedraw(false)

//if message.stringParm= 'P' then
//	
//	uodw_eventi.dataObject= 'dw_eventi'
//	
//else
//	
//	uodw_eventi.dataObject= 'dw_monitor_eventi'
//	
//	uodw_eventi.Object.DataWindow.ReadOnly="Yes"
//	
//end if

uodw_eventi.GetChild('cod_dip', idwc_dipendenze)
uodw_eventi.GetChild('tipo_evento', idwc_tipo_eventi)
uodw_eventi.GetChild('cod_luogo', idwc_luoghi)
uodw_eventi.GetChild('cod_sala', idwc_sale)

uodw_eventi.setTransObject(sqlca)

idwc_dipendenze.setTransObject(sqlca)
idwc_tipo_eventi.setTransObject(sqlca)
idwc_luoghi.setTransObject(sqlca)
idwc_sale.setTransObject(sqlca)

idwc_sale.retrieve(gs_dip_operativa)
idwc_luoghi.retrieve(gs_dip_operativa)

uodw_eventi.retrieve(/*gs_dip_operativa*/)

if NOT s_utente_s.b_superuser then
	uodw_eventi.setFilter("cod_dip='"+gs_dip_operativa+"' ")
	uodw_eventi.filter()
end if

long ll_found

ll_found = uodw_eventi.Find("cod_dip='"+gs_dip_operativa+"' ", 1, uodw_eventi.RowCount())

if ll_found > 0 then uodw_eventi.expand(ll_found,1)

this.setRedraw(true)

end event

on w_eventi_old.create
int iCurrent
call super::create
this.uodw_eventi=create uodw_eventi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uodw_eventi
end on

on w_eventi_old.destroy
call super::destroy
destroy(this.uodw_eventi)
end on

event resize;call super::resize;w_frame_template w_parent

w_parent= this.parentWindow()

this.setRedraw(false)

this.height= w_parent.WorkSpaceHeight() - 240
uodw_eventi.height= this.height - 240
uodw_eventi.width= this.width - 60

if ib_centered then wf_center()

this.setRedraw(true)
end event

event open;call super::open;s_session_s.context= "Gestione eventi"

im_preview= create m_preview
im_gestione_eventi= create m_gestione_eventi

//uodw_eventi.setRowFocusIndicator(focusRect!)

event post ue_open()
end event

type uodw_eventi from uodw_generica within w_eventi_old
event type integer ue_delete ( long row )
event type integer ue_todolist ( )
event type long ue_modifica ( )
event type integer ue_vaiallevento ( )
integer width = 4279
integer taborder = 10
string dataobject = "tvdw_eventi"
boolean controlmenu = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isgrid = true
end type

event type integer ue_delete(long row);//	
//	long ll_tipo, id, ll_count
//	
//	id= this.getItemNumber(row, "id")
//	
//	ll_tipo= this.getItemNumber(row, "tipo_evento")
//	
//	choose case ll_tipo
//			
//		case is < 6 // esami
//			
//			select count(*)
//			into :ll_count
//			from esami
//			where id= :id;
//			
//			if trap_sql(sqlca, "DELEVENTI01") < 0 then return -1			
//			
//			
//		case 6 // Entrata nuovi fedeli
//			
//			select count(*)
//			into :ll_count
//			from membri_eventi
//			where id= :id;
//			
//			if trap_sql(sqlca, "DELEVENTI02") < 0 then return -1
//			
//			
//		case 7 // Consegna o sostituzione G
//			
//			select count(*)
//			into :ll_count
//			from sostituzioni
//			where id= :id;
//			
//			if trap_sql(sqlca, "DELEVENTI03") < 0 then return -1			
//			
//			
//		case else // recitazioni etc.
//			
			return 0
//			
//	end choose
//	
//	if messageBox(parent.title, "Confermi la cancellazione?", question!, yesNo!, 2)= 2 then return 0
//	
//	if ll_count > 0 then
//		
//		// da riscrivere: deve essere chiaro che la cancellazione va gestita direttamente nelle procedure.
//		messageBox(parent.title, "Per questo evento sono già stati inseriti "+string(ll_count)+ " partecipanti: la cancellazione non è possibile.", information!)
//		return -1
//		
//	end if
//	
//	if this.deleteRow(0)= 1 then this.uof_aggiorna()
//	
end event

event type integer ue_todolist();decimal ld_id
integer li_quanti, li_tipo
long ll_row

ll_row= this.getRow()

if  ll_row<= 0 then return -1

ld_id= this.getItemDecimal(ll_row, "id")

select count(*)
into :li_quanti
from eventi_compiti
where id= :ld_id;
if trap_sql(sqlca, "COUNTID01") < 0 then return -1

		if li_quanti= 0 then // se inserisco un nuovo evento...
		
			long ll_idx
			string ls_descrizione, ls_tipo_scadenza
			
			ids_scadenze_interne= create dataStore
			ids_scadenze_interne.dataObject= 'ds_scadenze_interne'
			ids_scadenze_interne.setTransObject(sqlca)
			
			li_tipo= this.getItemNumber(ll_row, "tipo_evento")
			
				// Nel caso degli esami il tipo va da 1 a 5 ...
				
				if li_tipo <= 5 then li_tipo= 5 // esami...
				
					// estrae le scadenze interne da eventi_scadenze_interne e le inserisce in eventi_compiti
					
					if ids_scadenze_interne.retrieve(li_tipo) > 0 then
					
						for ll_idx= 1 to ids_scadenze_interne.rowCount()
							
							ls_descrizione= ids_scadenze_interne.getItemString(ll_idx, "descrizione")
							ls_tipo_scadenza=  ids_scadenze_interne.getItemString(ll_idx, "tipo_scadenza")
							
							  INSERT INTO eventi_compiti  
										( id,   
										  descrizione,   
										  stato,   
										  ordine,   
										  tipo_scadenza,   
										  operatore )  
							  VALUES ( :ld_id,   
										  :ls_descrizione,   
										  '1',   
										  :ll_idx,   
										  :ls_tipo_scadenza,
										  "");
							if sqlca.sqlcode < 0 then exit

						next
						
							if sqlca.sqlcode= 0 then
								commit;
								if trap_sql(sqlca, "INSTODO02") <  0 then ld_id= -1
							else
								rollback;
								trap_sql(sqlca, "INSTODO03")
								ld_id= -1
							end if
						
				end if // se ci sono scadenze interne tabellate...
			
		end if // se nuovo evento...
		

if ld_id = -1  then return -1 

openWithParm(w_todolist, ld_id)

return message.doubleParm


end event

event type long ue_modifica();integer li_ret

if f_np(gc_op) = 1 then return 0

openWithParm(w_ins_eventi, this.getItemDecimal(this.getRow(), "id") )
li_ret= message.doubleParm
if li_ret= -1 then return -1
 this.retrieve(/*gs_dip_operativa*/)
 
 long ll_found
 
 this.setRedraw(false)

ll_found = this.Find("cod_dip='"+gs_dip_operativa+"' ", 1, this.RowCount())

if ll_found > 0 then this.expand(ll_found,1)

this.setRedraw(true)
end event

event type integer ue_vaiallevento();decimal ld_id
integer li_ret
s_evento s_evento_s

s_evento_s.id= this.getItemDecimal(this.getRow(), "id")
s_evento_s.tipo_evento= this.getItemNumber(this.getRow(), "tipo_evento")
s_evento_s.data_evento= this.getItemDatetime(this.getRow(), "data_evento")
s_evento_s.descrizione= this.getItemString(this.getRow(), "descrizione_evento")

close(parent)

w_frame_gestioneassociati.SetRedraw ( false )

choose case s_evento_s.tipo_evento
		
	case 1 to 5 // esami
		
			li_ret= OpenSheetWithParm (w_esami_tab, s_evento_s, w_frame_gestioneassociati, 3, Original! )
		
	case 6 // entrata
		
			li_ret= OpenSheetWithParm (w_entrata, s_evento_s, w_frame_gestioneassociati, 3, Original! )
		
	case 7 // consegne/sostituzioni
		
			li_ret= OpenSheetWithParm (w_consegnesostituzioni, s_evento_s, w_frame_gestioneassociati, 3, Original! )
		
end choose

w_frame_gestioneassociati.SetRedraw ( true )


return 0
end event

event buttonclicked;call super::buttonclicked;integer li_ret
decimal ld_ret
long ll_ret
string ls_find

choose case dwo.name
		
	case "b_nuovo"
		
		if f_np(gc_op) = 1 then return 0

		li_ret= open(w_ins_eventi)
		
		ld_ret= message.doubleParm
		if ld_ret= -1 then return -1
//		ll_ret= idwc_sale.retrieve(gs_dip_operativa)
//		ll_ret= idwc_luoghi.retrieve(gs_dip_operativa)
		ll_ret= this.retrieve(gs_dip_operativa)
		
		//ToRow(this.Find ( ls_find, 1, this.RowCount()) )
		
		long ll_found

		ll_found = uodw_eventi.Find("cod_dip='"+gs_dip_operativa+"' ", 1, uodw_eventi.RowCount())
		
		if ll_found > 0 then uodw_eventi.expand(ll_found,1)
		
	case "b_dip"
		
		string ls_dip
		
		li_ret= open(w_selezione_dipendenze)
		
		ls_dip= message.stringParm
		
		if ls_dip= "" then return
		
		gs_dip_operativa= ls_dip
		
//		idwc_luoghi.setTransObject(sqlca)
//		idwc_sale.setTransObject(sqlca)
//		
		ll_ret= idwc_sale.retrieve(gs_dip_operativa)
		ll_ret= idwc_luoghi.retrieve(gs_dip_operativa)	
		ll_ret= this.retrieve(gs_dip_operativa)



		
end choose
end event

event doubleclicked;call super::doubleclicked;if row <= 0 then return -1

//this.event ue_todolist()

if w_eventi.uodw_eventi.event ue_modifica()  > 0 then
	s_session_s.context= "Pianificazione eventi"
	f_log(s_session_s, "Modifica l'evento corrente", true)
end if
end event

event rbuttondown;call super::rbuttondown;//if gi_classediutenza >= gc_op then return 

if this.rowCount()= 0 then return 0
im_gestione_eventi.PopMenu ( w_eventi.PointerX(), w_eventi.PointerY() )

//im_preview.iuodw_generica= uodw_eventi
//
//im_preview.m_aggiungi.visible= false
//im_preview.m_rimuovi.visible= false
//im_preview.m_salva.visible= false
//im_preview.m_layoutdistampa.enabled= true
//
//im_preview.PopMenu ( w_eventi.PointerX(), w_eventi.PointerY() )
end event

event itemfocuschanged;call super::itemfocuschanged;//integer li_ret
//long ll_ret
//string ls_where
//
//choose case dwo.name
//		
//	case "cod_luogo"
//					
//		ls_where= " where cod_dip=~~'"+gs_dip_operativa+"~~'" 
//					
////				else
////					
////					where_clause= " and aree.cod_area<>~~'"+"A"+"~~' and territori.cod_dip=~~'"+str_ini.v_dip+"~~'" 					
////				
////				end if
//				
//		li_ret= this.GetChild ( 'cod_luogo',idwc_luoghi )
//				
//				ll_ret= f_mod_select(ls_where, idwc_luoghi)
//				
//end choose
end event

