$PBExportHeader$w_eventi.srw
forward
global type w_eventi from window
end type
type uodw_eventi from uodw_generica within w_eventi
end type
end forward

global type w_eventi from window
integer width = 4338
integer height = 2100
boolean titlebar = true
string title = "Gestione eventi"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Report5!"
boolean clientedge = true
boolean center = true
event ue_open ( )
event type integer ue_oggi ( )
uodw_eventi uodw_eventi
end type
global w_eventi w_eventi

type variables
datastore ids_scadenze_interne
dataWindowChild idwc_dipendenze, idwc_tipo_eventi, idwc_luoghi, idwc_sale
m_preview im_preview
m_gestione_eventi im_gestione_eventi
boolean ib_solodaoggi= true
end variables
event type integer ue_oggi();long ll_found
string ls_search, ls_today

this.setRedraw(false)

uodw_eventi.reset()

ll_found= uodw_eventi.retrieve()

uodw_eventi.filter()		
	
uodw_eventi.sort()

string ls_1, ls_2

ls_1= string(time(today()), "hh:mm") 
//ls_2= string( time(ora_inizio)))

ls_search= " cod_dip='"+s_session_s.cod_dip+ "'  and date(data_evento) >= date(today()) and time(today()) >= time(ora_inizio) and time(today()) <= time(ora_fine)   "

ll_found = uodw_eventi.Find(ls_search, 1, uodw_eventi.RowCount())

if ll_found > 0 then
	
	uodw_eventi.expandAllChildren(ll_found, 1)
	//uodw_eventi.expand(ll_found, 1)
	uodw_eventi.ScrollToRow ( ll_found )
	f_select_current_row(uodw_eventi)
	
else

	ls_search= " cod_dip='"+s_session_s.cod_dip+ "'  and month( data_evento )  =  month(today())"
	
	ll_found = uodw_eventi.Find(ls_search, 1, uodw_eventi.RowCount())
	
		if ll_found > 0 then
			uodw_eventi.expandAllChildren(ll_found, 1)
		else
		
			ls_search= " cod_dip='"+s_session_s.cod_dip+ "'"
		
			ll_found = uodw_eventi.Find(ls_search, 1, uodw_eventi.RowCount())
		
			if ll_found > 0 then uodw_eventi.expandAllChildren(ll_found, 1)
			
		end if
	
end if

//if ll_found > 0 then
//	uodw_eventi.ScrollToRow ( ll_found )
//	f_select_current_row(uodw_eventi)
//end if

//ritorna:

this.setRedraw(true)

return ll_found
end event

event resize;this.setRedraw(false)

uodw_eventi.height= this.height - 240
uodw_eventi.width= this.width - 60

this.setRedraw(true)
end event

event open;s_session_s.context= "Gestione eventi"

im_preview= create m_preview
im_gestione_eventi= create m_gestione_eventi

//uodw_eventi.setRowFocusIndicator(p_pointer, 128, 0)

uodw_eventi.GetChild('cod_dip', idwc_dipendenze)
uodw_eventi.GetChild('tipo_evento', idwc_tipo_eventi)
uodw_eventi.GetChild('cod_luogo', idwc_luoghi)
uodw_eventi.GetChild('cod_sala', idwc_sale)

uodw_eventi.setTransObject(sqlca)

idwc_dipendenze.setTransObject(sqlca)
idwc_tipo_eventi.setTransObject(sqlca)
idwc_luoghi.setTransObject(sqlca)
idwc_sale.setTransObject(sqlca)

 timer(60)

idwc_sale.retrieve(s_session_s.cod_dip)
idwc_luoghi.retrieve(s_session_s.cod_dip)

// inserire cancellazione eventi passati del tipo recitazioni etc. da cancellare

DELETE from eventi
FROM eventi AS ev
INNER JOIN eventi_tipo AS evt
ON ev.tipo_evento= evt.tipo_evento
WHERE evt.flag_storico= 'N' and DATEDIFF ( day, ev.data_evento, GETDATE() ) > 1;
if trap_sql(sqlca, "DELOLDEVENTS01") < 0 then return -1

commit;
if trap_sql(sqlca, "DELOLDEVENTS02") < 0 then return -1

uodw_eventi.object.b_eventipassati.text= "Visualizza solo gli eventi di oggi e futuri"
uodw_eventi.setFilter("")

event post ue_oggi()
end event

on w_eventi.create
this.uodw_eventi=create uodw_eventi
this.Control[]={this.uodw_eventi}
end on

on w_eventi.destroy
destroy(this.uodw_eventi)
end on

event timer;this.event ue_oggi()
end event

type uodw_eventi from uodw_generica within w_eventi
event type integer ue_modifica ( )
event type integer ue_todolist ( )
event type integer ue_vaiallevento ( )
event type long ue_oggi ( )
integer taborder = 10
string dataobject = "tvdw_eventi"
boolean maxbox = false
boolean resizable = true
string icon = "Report5!"
end type

event type integer ue_modifica();decimal ld_id
integer li_ret
s_evento s_evento_s

if this.getRow() <= 0 or isNull(this.getRow() ) then return 0

if f_has_p("O") = false then return 0

s_evento_s.id= this.getItemDecimal(this.getRow(), "id")
s_evento_s.cod_dip= this.getItemString(this.getRow(), "cod_dip")
s_evento_s.cod_luogo= this.getItemString(this.getRow(), "cod_luogo")


openWithParm(w_ins_eventi, s_evento_s)
ld_id= message.doubleParm
if ld_id= -1 then return -1
 
 long ll_found
 
//this.setRedraw(false)

parent.event ue_oggi()

//this.retrieve()
//
//ll_found = this.Find("cod_dip='"+s_evento_s.cod_dip+"' ", 1, this.RowCount())
//
//if ll_found > 0 then this.expand(ll_found,1)

//this.setRedraw(true)

return 0
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

event type integer ue_vaiallevento();decimal ld_id
integer li_ret
s_evento s_evento_s

s_evento_s.id= this.getItemDecimal(this.getRow(), "id")
s_evento_s.tipo_evento= this.getItemNumber(this.getRow(), "tipo_evento")
s_evento_s.data_evento= this.getItemDatetime(this.getRow(), "data_evento")
s_evento_s.descrizione= this.getItemString(this.getRow(), "descrizione_evento")
s_evento_s.cod_dip= this.getItemString(this.getRow(), "cod_dip")
s_evento_s.id_esami_sessioni= this.getItemDecimal(this.getRow(), "id_esami_sessioni")

//close(parent)

w_frame_gestioneassociati.SetRedraw ( false )

choose case s_evento_s.tipo_evento
		
	case 1 to 5 // esami
		
			li_ret= OpenSheetWithParm (w_esami_tab, s_evento_s, w_frame_gestioneassociati, 3, Original! )
		
	case 6 // entrata
		
			li_ret= OpenSheetWithParm (w_entrata, s_evento_s, w_frame_gestioneassociati, 3, Original! )
		
	case 7 // consegne Omamori/Tokuso
		
			li_ret= OpenSheetWithParm (w_consegne_gohonzon, s_evento_s, w_frame_gestioneassociati, 3, Original! )		

	case 11 // consulta
		
			li_ret= OpenSheetWithParm (w_consulta_presenze, s_evento_s, w_frame_gestioneassociati, 3, Original! )
		

end choose

w_frame_gestioneassociati.SetRedraw ( true )


return 0
end event

event doubleclicked;call super::doubleclicked;if row <= 0 then return -1

if this.getItemNumber(row, "tipo_evento") > 7 and  this.getItemNumber(row, "tipo_evento")  <> 11 then return -1

//this.event ue_todolist()

if w_eventi.uodw_eventi.event ue_vaiallevento()  > 0 then
	s_session ls_session_s
	ls_session_s=  s_session_s
//	s_session_s.context= "Pianificazione eventi"
//	f_log(ls_session_s, "Va in gestione evento", true)
end if
end event

event buttonclicked;call super::buttonclicked;integer li_ret
long ll_ret
decimal ld_id
string ls_find, ls_search, ls_today
s_evento s_evento_s

choose case dwo.name
		
	case "b_eventipassati"
		
		if ib_solodaoggi= true then
			ib_solodaoggi= false
			this.object.b_eventipassati.text= "Visualizza tutti gli eventi"
			uodw_eventi.setFilter(" date(data_evento) >= date(today()) ")
			uodw_eventi.filter()			
		else
			ib_solodaoggi= true
			this.object.b_eventipassati.text= "Visualizza solo gli eventi di oggi e futuri"
			uodw_eventi.setFilter("")
			uodw_eventi.filter()			
		end if
		
		parent.event ue_oggi()
		
	case "b_nuovo"
		
		s_evento_s.id= 0
		s_evento_s.cod_dip= s_session_s.cod_dip
		
		li_ret= openWithParm(w_ins_eventi, s_evento_s)
		
		ld_id= message.doubleParm
		
		if ld_id= -1 then return -1

		parent.event ue_oggi()
		
	case "b_dip"
		
		string ls_dip
		
		li_ret= open(w_selezione_dipendenze)
		
		ls_dip= message.stringParm
		
		if ls_dip= "" then return
		
		s_session_s.cod_dip= ls_dip
		
//		idwc_luoghi.setTransObject(sqlca)
//		idwc_sale.setTransObject(sqlca)
//		
		ll_ret= idwc_sale.retrieve(s_session_s.cod_dip)
		ll_ret= idwc_luoghi.retrieve(s_session_s.cod_dip)	
		ll_ret= this.retrieve(s_session_s.cod_dip)
		
	case "b_oggi"
		
		parent.event ue_oggi()
		
//		uodw_eventi.setRedraw(false)
//		
//		uodw_eventi.reset()
//		
//	     uodw_eventi.retrieve()
//		uodw_eventi.sort()
//		
//		uodw_eventi.setRedraw(true)
		
end choose
end event

event rbuttondown;call super::rbuttondown;//if gi_classediutenza >= gc_op then return 

if row <= 0 then return -1

//im_gestione_eventi.PopMenu ( w_eventi.PointerX(), w_eventi.PointerY() )

im_gestione_eventi.iuodw_generica= uodw_eventi

im_gestione_eventi.m_aggiungi.visible= false
im_gestione_eventi.m_rimuovi.visible= false
im_gestione_eventi.m_salva.visible= false
im_gestione_eventi.m_layoutdistampa.enabled= true

/* > 7 vuol dire eventi che non prevedono liste */
if this.getItemNumber(row, "tipo_evento") > 7  then im_gestione_eventi.m_vaiallevento.enabled= false

im_gestione_eventi.PopMenu ( w_eventi.PointerX(), w_eventi.PointerY() )
end event

event sqlpreview;call super::sqlpreview;integer li_idx
string ls_query
	
	for li_idx= 1 to UpperBound(gs_ambiti)
		
		if li_idx=  UpperBound(gs_ambiti) then
			
			ls_query += " dipendenze.vc_nodo like  '"+gs_ambiti[li_idx]+"%') "
			
		else
			
			ls_query += " dipendenze.vc_nodo like '"+gs_ambiti[li_idx]+"%' OR "
			
		end if
		
	next				



if pos(lower(sqlsyntax), "where", 1)= 0 then
	sqlsyntax += " where ("+ls_query
else
	sqlsyntax += " and ("+ls_query
end if	

SetSqlPreview ( sqlsyntax )

end event

event treenodeselected;call super::treenodeselected;if grouplevel > 1 then return 0

if isExpanded(row, 1) then
	uodw_eventi.CollapseAll()
else
	uodw_eventi.setRedraw(false)
	uodw_eventi.collapseAll()
	uodw_eventi.expandAllChildren(row,1)
	uodw_eventi.ScrollToRow(row)
	uodw_eventi.setRedraw(true)
end if
end event

