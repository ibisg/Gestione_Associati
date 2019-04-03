$PBExportHeader$w_struttura_tv_vc.srw
forward
global type w_struttura_tv_vc from window
end type
type lv_dettaglio from listview within w_struttura_tv_vc
end type
type tv_struttura from treeview within w_struttura_tv_vc
end type
end forward

global type w_struttura_tv_vc from window
integer width = 4119
integer height = 2832
boolean titlebar = true
string title = "Gestione struttura"
string menuname = "m_struttura"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 81324524
string icon = "Library5!"
event type integer ue_runquery ( integer ai_qualequery,  integer ai_source )
event type integer ue_queryofferte ( integer ai_qualequery,  integer ai_source,  long al_livello,  string as_nodo,  s_data as_data_s )
event type integer ue_cerca ( )
lv_dettaglio lv_dettaglio
tv_struttura tv_struttura
end type
global w_struttura_tv_vc w_struttura_tv_vc

type variables
boolean ib_dragdrop= false

long	il_livello
long il_queue[], il_foundhandle
m_pop_tv im_pop_tv
m_pop_lv_dettaglio im_pop_lv_dettaglio

s_struttura is_struttura_s

long il_oldhandle, il_DropTarget, il_DropLevel, il_DragLevel
treeViewItem itvi_dragged_object
end variables

forward prototypes
public function long tvf_finditem (string as_attributo, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare)
public function long tvf_searchchild (string as_attributo, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare)
public function integer tvf_genera_dettaglio (long al_handle)
public function integer tvf_cerca_nodo (ref treeview atv_arg, long al_livello, string as_nodo, long al_handle)
public function integer tvf_cerca (treeview atv_arg, long al_handle, string as_ricerca)
public function integer tvf_populate (long tvi_handle)
public function integer lvf_dettaglio (long tvi_handle)
end prototypes

event ue_runquery;integer li_ret, li_livello_raggruppamento, li_pos_raggruppamento
long ll_handle
string ls_object, ls_nodo, ls_query
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

choose case ai_qualequery
	case 1
		ls_object= 'dw_queryofferte'
	case 2
		ls_object= 'dw_queryofferte_div'
	case 3
		ls_object= 'dw_queryofferte_resp'
	case 4
		ls_object= 'dw_queryofferte_tab'
	case 5
		ls_object= 'dw_queryofferte_dettaglio'
end choose

open(w_criteri_estrazione)

s_data_s= message.powerObjectParm

if isNull(s_data_s.ls_da) then return -1

if ai_source= 1 then // la query viene richiesta dal treeView...
	
	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
	
	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
	
	is_struttura_s= ll_tvi.data
	
	if is_struttura_s.livello = MAX_LIVELLO -1 then
		
		li_livello_raggruppamento= MAX_LIVELLO
		
	else
	
		openWithParm(w_selezione_livello, is_struttura_s.livello)
	
		li_livello_raggruppamento= message.doubleParm
		
		if li_livello_raggruppamento= 0 then return -1
		
	end if
	
//	li_pos_raggruppamento= pos(s_struttura_loc.vc_nodo
	
	open(w_preview_scheda)
	
	w_preview_scheda.dw_current.dataObject= ls_object
	
	w_preview_scheda.dw_current.reset()
	
	setpointer(hourGlass!)

w_preview_scheda.setRedraw(false)

	ls_query= "select vc_nodo from struttura where livello="+string(li_livello_raggruppamento)+" and substring(vc_nodo, 1, "+string(len(is_struttura_s.vc_nodo))+") = '"+is_struttura_s.vc_nodo+"'"

	DECLARE query_cur DYNAMIC CURSOR FOR SQLSA ;
	
	PREPARE SQLSA FROM :ls_query ;
	
	OPEN DYNAMIC query_cur ;
	if trap_sql(sqlca, "RUNQUERY01") < 0 then return -1

		do while sqlca.sqlcode <> 100
			
			fetch query_cur into
			:ls_nodo;
			if sqlca.sqlcode= 100 then continue
			
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, li_livello_raggruppamento, ls_nodo, s_data_s)
			
			if li_ret= -1 then exit
	
		loop
		
		close query_cur;
	
else // la query viene richiesta dalla list view...
	
	open(w_preview_scheda)
	
	w_preview_scheda.dw_current.dataObject= ls_object

	ll_handle = lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)
	
	setpointer(hourGlass!)

	w_preview_scheda.setRedraw(false)
	
		do while ll_handle <> -1
			
			lv_dettaglio.getItem(ll_handle, ll_lvi)
			
			is_struttura_s= ll_lvi.data
		
			li_ret= event ue_queryofferte(ai_qualequery, ai_source, is_struttura_s.livello, is_struttura_s.vc_nodo, s_data_s)
			
			if li_ret= -1 then exit
			
			ll_handle = lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
			
		loop

end if

w_preview_scheda.dw_current.groupCalc()

//w_preview_scheda.dw_current.Object.DataWindow.Print.Preview= 'Yes'

w_preview_scheda.setRedraw(true)

return li_ret
end event

event ue_queryofferte;integer li_ret
string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura, ls_cod_resp, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

choose case ai_qualequery
		
	case 1

		ls_query= f_creaqueryofferte(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ls_descrizione_struttura;
			
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			if isNull(ld_importo) then ld_importo= 0.00
			
			ll_row= w_preview_scheda.dw_current.insertRow(0)
			li_ret= w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			li_ret=w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
			if ai_source= 1 then
				li_ret=w_preview_scheda.dw_current.setItem(ll_row, "livello_master", is_struttura_s.descrizione_livello)	
				li_ret=w_preview_scheda.dw_current.setItem(ll_row, "descrizione_master", is_struttura_s.descrizione_struttura+": ")	
			else
				li_ret=w_preview_scheda.dw_current.setItem(ll_row, "livello_master", "generale")	
				li_ret=w_preview_scheda.dw_current.setItem(ll_row, "descrizione_master", ": ")					
			end if
		
		loop
		
	case 2
		
		ls_query= f_creaqueryofferte_div(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)

		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ls_descrizione_struttura,
			:ls_cod_div;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_scheda.dw_current.insertRow(0)
			w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
			w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_scheda.dw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
		loop
		
	case 3
		
		ls_query= f_creaqueryofferte_resp(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
			
			PREPARE SQLSA FROM :ls_query ;
			
			OPEN DYNAMIC my_cursor ;
			if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
			
			do while sqlca.sqlcode <> 100
				FETCH my_cursor INTO 
				:ls_livello_struttura, 
				:ls_status,
				:ld_importo,
				:ld_zero,
				:ll_totale_persone,
				:ls_descrizione_struttura,
				:ls_cod_resp;
				if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
				if sqlca.sqlcode= 100 then continue
				
				ll_row= w_preview_scheda.dw_current.insertRow(0)
				w_preview_scheda.dw_current.setItem(ll_row, "cod_resp", ls_cod_resp)
				w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
				w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
				w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
				w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
				w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
				w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
				w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
			
			loop
		
	case 4
		
		ls_query= f_creaqueryofferte_tab(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ld_importo,
			:ld_zero,
			:ll_totale_persone,
			:ls_descrizione_struttura,
			:ls_cod_div,
			:ls_cod_resp;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_scheda.dw_current.insertRow(0)
			w_preview_scheda.dw_current.setItem(ll_row, "cod_resp", ls_cod_resp)
			w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)	
			w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
			w_preview_scheda.dw_current.setItem(ll_row, "cod_div", ls_cod_div)
			w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	
		
		loop
		
	case 5
		
		ls_query= f_creaqueryofferte_dettaglio(al_livello, as_nodo,as_data_s. ls_da, as_data_s.ls_a)
		
		PREPARE SQLSA FROM :ls_query ;
		
		OPEN DYNAMIC my_cursor ;
		if trap_sql(sqlca, "QUERY01") < 0 then goto closecur
		
		do while sqlca.sqlcode <> 100
			FETCH my_cursor INTO 
			:ls_livello_struttura, 
			:ls_status,
			:ld_importo,
			:ls_codice,
			:ls_cognome,
			:ls_nome,
			:ls_max_livello,
			:ls_altri_livelli,
			:ls_descrizione_struttura;
			if trap_sql(sqlca, "QUERY02") < 0 then goto closecur
			if sqlca.sqlcode= 100 then continue
			
			ll_row= w_preview_scheda.dw_current.insertRow(0)
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
			w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
			w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
			w_preview_scheda.dw_current.setItem(ll_row, "codice", ls_codice)
			w_preview_scheda.dw_current.setItem(ll_row, "cognome", ls_cognome)
			w_preview_scheda.dw_current.setItem(ll_row, "nome", ls_nome)
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_max_livello", ls_max_livello)
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_altri_livelli", ls_altri_livelli)
			w_preview_scheda.dw_current.setItem(ll_row, "descrizione_livello", ls_livello_struttura)	
		
		loop
		
end choose

CLOSE my_cursor ;
if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0

closecur: CLOSE my_cursor ;
			 trap_sql(sqlca, "QUERY03") 

return -1


end event

event ue_cerca;integer li_ret
long ll_handle
string ls_cerca
treeViewItem ltvi_item

setMicroHelp("")

il_foundhandle= 0

ll_handle= tv_struttura.findItem(currentTreeItem!, 0)

if ll_handle= -1 then return -1

li_ret= tv_struttura.getItem(ll_handle, ltvi_item)

if li_ret= -1 then return -1

open(w_cerca)

ls_cerca= message.stringParm

if isNull(ls_cerca) or ls_cerca= "" then return -1

il_foundhandle= tvf_findItem('label', ls_cerca, ll_handle, 0, false, false)

if il_foundhandle > 0 then
	tv_struttura.SetFirstVisible ( il_foundhandle )
	tv_struttura.selectItem(il_foundhandle)
	li_ret= tv_struttura.getItem(il_foundhandle, ltvi_item)
	ltvi_item.bold= true
	tv_struttura.setItem(il_foundhandle, ltvi_item)
	return 0
else
	messageBox("Ricerca", "Non ho trovato: "+ls_cerca)
	return -1
end if
end event

public function long tvf_finditem (string as_attributo, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare);integer li_next
long ll_handle, ll_parent, ll_queue[]
treeViewItem ltvi_item

if isNull(as_attributo) or isNull(al_begin) or isNull(ai_level) or isNull(ab_respectCase) or isNull(ab_fullCompare) then return -1

setPointer(hourGlass!)

if il_foundhandle= 0 then
	// reset della coda...
	il_queue= ll_queue
end if

// Inizializza la coda...
if al_begin= 0 then
	
	// ricerca sull'intero albero, cerca nodi multipli a livello 1...
	ll_handle= tv_struttura.findItem(rootTreeItem!, 0)
	
else
	
	// inizia dalla posizione data di partenza e cerca i nodi figli da quel punto in poi...
	li_next= upperBound(il_queue) + 1
	
	// aggiunge l'handle alla coda...
	il_queue[li_next]= al_begin
	
	// cerca i fratelli...
	ll_handle= tv_struttura.findItem(nextTreeItem!, al_begin)
	
end if

do while ll_handle > 0
	
	li_next= upperBound(il_queue) + 1
	il_queue[li_next]= ll_handle
	ll_handle= tv_struttura.findItem(nextTreeItem!, ll_handle)
	
loop

return tvf_searchChild(as_attributo, aa_target, al_begin, ai_level, ab_respectCase, ab_fullCompare)

return 0
end function

public function long tvf_searchchild (string as_attributo, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare);integer li_level, li_next, li_ret
long ll_handle, ll_child, ll_qposition
treeViewItem ltvi_item

ll_qposition= 1

if ll_qposition > upperBound(il_queue) then return -1

do
	
	ll_handle= il_queue[ll_qposition]
	
	if tv_struttura.getItem(ll_handle, ltvi_item) = -1 then return -1
	
	li_level= ltvi_item.level
	
	// esegue il confronto...
	if ai_level= 0 or ai_level= li_level then
		
		if tv_struttura.trigger event ue_searchcompare(ll_handle, as_attributo, aa_target, ab_respectCase, ab_fullCompare) then
			li_ret= messageBox(this.title, "Trovato! Vuoi proseguire la ricerca?", question!, yesNo!, 1)
			if li_ret= 2 then return ll_handle
		end if
		
	else
		
		if li_level > ai_level then return 0
		
	end if
	
	tv_struttura.expandItem(ll_handle)
	
	ll_child= tv_struttura.findItem(childTreeItem!, ll_handle)
	
//	tv_struttura.expandItem(ll_child)
	
	do while ll_child > 0
		
		li_next= upperBound(il_queue) + 1
		
		il_queue[li_next]= ll_child // il_queue[li_next]= ll_child
		
		ll_child= tv_struttura.findItem(nextTreeItem!, ll_child)
		
//		tv_struttura.expandItem(ll_child)
		
	loop
	
	ll_qposition++
	
loop until ll_qposition > upperBound(il_queue)

return 0
end function

public function integer tvf_genera_dettaglio (long al_handle);integer li_ret
s_struttura s_struttura_loc
treeViewItem ltvi_dettaglio

li_ret= tv_struttura.getItem(al_handle, ltvi_dettaglio)

ltvi_dettaglio.selected= true
ltvi_dettaglio.children= true

s_struttura_loc= ltvi_dettaglio.data

li_ret= tv_struttura.setItem(al_handle, ltvi_dettaglio)

lv_dettaglio.deleteItems()

//lvf_dettaglio(s_struttura_loc)

return li_ret
end function

public function integer tvf_cerca_nodo (ref treeview atv_arg, long al_livello, string as_nodo, long al_handle);integer li_ret= 1
long ll_handle
s_struttura s_struttura_loc
treeViewItem ltvi_item

//ll_handle= atv_arg.findItem(rootTreeItem!, 0)

ll_handle= al_handle

if ll_handle = -1 then messageBox("RICERCANODI-01", "Errore in ricerca root", exclamation!)

do while li_ret= 1
	
	li_ret= atv_arg.getItem(ll_handle, ltvi_item)
	
	if li_ret= -1 then continue
	
	s_struttura_loc= ltvi_item.data
	
//	messageBox("test", "target: "+string(al_livello)+" livello: "+string(s_struttura_loc.livello))

	if s_struttura_loc.livello= al_livello then
		
		if s_struttura_loc.vc_nodo= as_nodo then
			
			// ha trovato anche il nodo...
			
			atv_arg.expandItem(ll_handle)
			
			return li_ret
			
//		end if
		else
		
		// cerca tra i pari livello...
		
		ll_handle= atv_arg.findItem(nextTreeItem!, ll_handle)
		
		if ll_handle = -1 then messageBox("RICERCANODI-02", "Errore in ricerca pari livello", exclamation!)

		end if
		
	else
		
		// passa al livello superiore...
		
//		messageBox("test", "old handle "+string(ll_handle) )
		
		ll_handle= atv_arg.findItem(childTreeItem!, ll_handle)
		
//		messageBox("test", "new handle "+string(ll_handle) )
			
		if ll_handle = -1 then messageBox("RICERCANODI-03", "Errore in ricerca livello superiore", exclamation!)
		
	end if
	
loop

return li_ret
end function

public function integer tvf_cerca (treeview atv_arg, long al_handle, string as_ricerca);integer li_ret= 1
long ll_newhandle, ll_oldhandle
treeViewItem ltvi_item

setPointer(HourGlass!)

ll_oldhandle= al_handle
ll_newhandle= al_handle

do while li_ret= 1
	
	li_ret= atv_arg.getItem(ll_oldhandle, ltvi_item)
	
//	messageBox("test", "target: "+string(al_livello)+" livello: "+string(s_struttura_loc.livello))

	if li_ret > 0 then
		
		setMicroHelp(upper(ltvi_item.label))
		
		if pos(upper(as_ricerca), upper(ltvi_item.label), 1 ) > 0 then
			
			// ha trovato il target...
			
			atv_arg.expandItem(ll_newhandle)
			
			return 0
			
		else
		
			// cerca tra i pari livello...
			
			ll_newhandle= atv_arg.findItem(nextTreeItem!, ll_oldhandle)
			
			if ll_newhandle = -1 then
			
				// passa al livello superiore...
		
				tv_struttura.expandItem(ll_oldhandle)
				
				ll_newhandle= atv_arg.findItem(childTreeItem!, ll_oldhandle)
				
		//		messageBox("test", "new handle "+string(ll_handle) )
					
				//messageBox("RICERCA-03", "Errore in ricerca livello superiore", exclamation!)
			
			end if
			
			ll_oldhandle= ll_newhandle
			
		end if // end of: if pos(upper(al_ricerca)...
		
	end if // end of: if ll_handle > 0 then
	
loop

return li_ret
end function

public function integer tvf_populate (long tvi_handle);integer li_ret
long ll_handle, ll_livello, ll_codice_membro, ll_cod_div, ll_index
string ls_relazione, ls_codice, ls_descrizione_livello, ls_descrizione_struttura, ls_cognome, ls_nome, ls_cod_dip, ls_nodo, ls_parent, ls_nodo_full
treeViewItem ll_tvi
listViewItem ll_lvi
s_struttura s_struttura_loc

//ll_lev1 = tv_struttura.FindItem(CurrentTreeItem!, 0)

tv_struttura.getItem(tvi_handle, ll_tvi)

//		if ll_tvi.expandedOnce= false then

ll_livello= ll_tvi.level

if ll_livello > 0 then

	is_struttura_s= ll_tvi.data

	ls_nodo= is_struttura_s.vc_nodo
	ls_parent= is_struttura_s.vc_parent
	ll_livello= is_struttura_s.livello
	
	if ls_parent= '00' then ls_parent= ls_nodo
	
else
	
	ls_nodo= '00'
	
end if

if ll_livello <  MAX_LIVELLO then

	declare child_cur cursor for
	
	select struttura.livello, vc_nodo, relazione, vc_parent, codice, livelli_struttura.descrizione, struttura.descrizione
	from struttura, livelli_struttura
	where	struttura.livello= :ll_livello + 1 and vc_parent= :ls_nodo and
				struttura.livello= livelli_struttura.livello;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open child_cur;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch child_cur into
		:ll_livello,
		:ls_nodo,
		:ls_relazione,
		:ls_parent,
		:ls_codice,
		:ls_descrizione_livello,
		:ls_descrizione_struttura;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		is_struttura_s.livello= ll_livello
		is_struttura_s.vc_nodo= ls_nodo
		is_struttura_s.relazione= ls_relazione
		is_struttura_s.vc_parent= ls_parent
		is_struttura_s.codice= ls_codice
		is_struttura_s.descrizione_livello= ls_descrizione_livello
		is_struttura_s.descrizione_struttura= ls_descrizione_struttura
		
		if ll_tvi.expandedOnce= false then

			ll_tvi.pictureIndex= ll_livello
			ll_tvi.selectedPictureIndex= 8
			ll_tvi.selected= false
			
			ll_handle = tv_struttura.InsertItemLast(tvi_handle,ll_tvi)
			
			is_struttura_s.handle= ll_handle
			
			ll_tvi.label= f_iniziali(ls_descrizione_livello)+": "+f_iniziali(ls_descrizione_struttura)/*+" ("+string(ll_livello)+", "+string(ll_handle)+")"*/
			ll_tvi.data= is_struttura_s
			
			li_ret= tv_struttura.setItem(ll_handle, ll_tvi)
			
		end if
		
		// list view

		ll_lvi.data= is_struttura_s
		
		ll_lvi.label= f_iniziali(ls_descrizione_livello)+": "+f_iniziali(ls_descrizione_struttura)
		ll_lvi.pictureIndex= ll_livello
		ll_lvi.statePictureIndex= 1
		ll_lvi.selected= false
		
		ll_index = lv_dettaglio.addItem(ll_lvi)
		
	loop
	
	close child_cur;
	
elseif ll_livello= MAX_LIVELLO then // deve inserire i dati delle persone...
	
	declare root_cur_membri cursor for
	
	select codice, cognome, nome, cod_div
	from membri_gerarchica
	where livello= :ll_livello and vc_parent= :ls_nodo
	order by cod_div, cognome, nome;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open root_cur_membri;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch root_cur_membri into
		:ls_codice,
		:ls_cognome,
		:ls_nome,
		:ll_cod_div;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		is_struttura_s.vc_parent= ls_nodo
		is_struttura_s.livello= 8 //ll_livello
		is_struttura_s.handle= ll_handle
		
		/*-------------------------*/
		
			if ll_tvi.expandedOnce= false then

				ll_tvi.pictureIndex= 8 + ll_cod_div
				ll_tvi.selectedPictureIndex= 8 + ll_cod_div
				ll_tvi.selected= false
				
				ll_tvi.children= false
				
				ll_handle = tv_struttura.InsertItemLast(tvi_handle,ll_tvi)
				
				is_struttura_s.handle= ll_handle
				
				ll_tvi.label= f_iniziali(trim(ls_cognome)+" "+trim(ls_nome))
				ll_tvi.data= is_struttura_s
				
				li_ret= tv_struttura.setItem(ll_handle, ll_tvi)
			
			end if
		
		/*---------------------------*/
		
		ll_lvi.data= is_struttura_s
		
		ll_lvi.label= f_iniziali(trim(ls_cognome)+" "+trim(ls_nome))
		ll_lvi.pictureIndex= ll_livello+ll_cod_div
		ll_lvi.selected= false
		ll_lvi.statePictureIndex=  2
		
		ll_index = lv_dettaglio.addItem(ll_lvi)
		
	loop
	
	close root_cur_membri;

end if
	

return ll_handle
end function

public function integer lvf_dettaglio (long tvi_handle);integer li_ret
long ll_handle, ll_livello, ll_codice_membro, ll_cod_div, ll_index
string ls_relazione, ls_codice, ls_descrizione_livello, ls_descrizione_struttura, ls_cognome, ls_nome, ls_cod_dip, ls_nodo, ls_parent, ls_nodo_full
treeViewItem ll_tvi
listViewItem ll_lvi
s_struttura s_struttura_loc

//ll_lev1 = tv_struttura.FindItem(CurrentTreeItem!, 0)

tv_struttura.getItem(tvi_handle, ll_tvi)

ll_livello= ll_tvi.level

if ll_livello > 0 then

	s_struttura_loc= ll_tvi.data

	ls_nodo= s_struttura_loc.vc_nodo
	ls_parent= s_struttura_loc.vc_parent
	ll_livello= s_struttura_loc.livello
	
	if ls_parent= '00' then ls_parent= ls_nodo
	
else
	
	ls_nodo= '00'
	
end if

if ll_livello <  MAX_LIVELLO then

	declare child_cur cursor for
	
	select struttura.livello, vc_nodo, relazione, vc_parent, codice, livelli_struttura.descrizione, struttura.descrizione
	from struttura, livelli_struttura
	where	struttura.livello= :ll_livello + 1 and vc_parent= :ls_nodo and
				struttura.livello= livelli_struttura.livello;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open child_cur;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch child_cur into
		:ll_livello,
		:ls_nodo,
		:ls_relazione,
		:ls_parent,
		:ls_codice,
		:ls_descrizione_livello,
		:ls_descrizione_struttura;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		s_struttura_loc.livello= ll_livello
		s_struttura_loc.vc_nodo= ls_nodo
		s_struttura_loc.relazione= ls_relazione
		s_struttura_loc.vc_parent= ls_parent
		s_struttura_loc.codice= ls_codice
		s_struttura_loc.descrizione_livello= ls_descrizione_livello
		s_struttura_loc.descrizione_struttura= ls_descrizione_struttura
		
		// list view

		ll_lvi.data= s_struttura_loc
		
		ll_lvi.label= f_iniziali(ls_descrizione_livello)+": "+f_iniziali(ls_descrizione_struttura)
		ll_lvi.pictureIndex= ll_livello
		ll_lvi.statePictureIndex= 1
		ll_lvi.selected= false
		
		ll_index = lv_dettaglio.addItem(ll_lvi)
		
	loop
	
	close child_cur;
	
	else
	
	declare root_cur_membri cursor for
	
	select codice, cognome, nome, cod_div
	from membri_gerarchica
	where livello= :ll_livello and vc_parent= :ls_nodo
	order by cod_div, cognome, nome;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open root_cur_membri;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch root_cur_membri into
		:ls_codice,
		:ls_cognome,
		:ls_nome,
		:ll_cod_div;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		s_struttura_loc.vc_parent= ls_nodo
		s_struttura_loc.livello= ll_livello
		s_struttura_loc.handle= ll_handle
		
		ll_lvi.data= s_struttura_loc
		
		ll_lvi.label= f_iniziali(trim(ls_cognome)+" "+trim(ls_nome))
		ll_lvi.pictureIndex= ll_livello+ll_cod_div
		ll_lvi.selected= false
		ll_lvi.statePictureIndex=  2
		
		ll_index = lv_dettaglio.addItem(ll_lvi)
		
	loop
	
	close root_cur_membri;

end if
	

return ll_handle
end function
on w_struttura_tv_vc.create
if this.MenuName = "m_struttura" then this.MenuID = create m_struttura
this.lv_dettaglio=create lv_dettaglio
this.tv_struttura=create tv_struttura
this.Control[]={this.lv_dettaglio,&
this.tv_struttura}
end on

on w_struttura_tv_vc.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lv_dettaglio)
destroy(this.tv_struttura)
end on

event resize;tv_struttura.height= this.height - 180
lv_dettaglio.height= tv_struttura.height
lv_dettaglio.x= this.width/2 +15
//lv_dettaglio.x= this.width - tv_struttura.width - 30
tv_struttura.width= lv_dettaglio.x - 30
lv_dettaglio.width= this.width - (tv_struttura.width + 30) - 40

//tv_struttura.width= this.width - 120
//dw_scheda.height= tv_struttura.height
//dw_scheda= pointerX()


//dw_scheda.width= this.width - 120  - ( tv_struttura.width + tv_dettaglio.width )
end event

event open;//ids_struttura= create dataStore
//ids_membri_gerarchica= create dataStore

//dw_scheda.Object.DataWindow.Print.Preview= 'Yes'
//dw_scheda.Object.DataWindow.Zoom = 80
//dw_scheda.setTransObject(sqlca)

//ids_struttura.dataObject= "ds_struttura_query"
//ids_membri_gerarchica.dataObject= "ds_membri_gerarchica_query"

//ids_struttura.setTransObject(sqlca)
//ids_membri_gerarchica.setTransObject(sqlca)

im_pop_tv= create m_pop_tv
im_pop_lv_dettaglio= create m_pop_lv_dettaglio

// Inserisce gli item relativi al livello 0 (root )

long ll_handle

//tvf_populate_ds(0)
tvf_populate(0)
ll_handle= tv_struttura.findItem(rootTreeItem!, 0)
tv_struttura.ExpandItem ( ll_handle )
	
//dw_scheda.setFocus()

return 0
end event

type lv_dettaglio from listview within w_struttura_tv_vc
integer x = 2523
integer y = 16
integer width = 1458
integer height = 2396
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 16777215
boolean autoarrange = true
boolean extendedselect = true
boolean twoclickactivate = true
string largepicturename[] = {"download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 536870912
string smallpicturename[] = {"download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","download02.jpg","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
integer smallpicturewidth = 32
integer smallpictureheight = 32
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event rightclicked;im_pop_lv_dettaglio.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )
end event

event doubleclicked;integer li_ret= 1
long ll_nodo, ll_livello, ll_handle, ll_struttura
listViewItem llvi_dettaglio
string ls_nodo
treeViewItem ltvi_struttura
s_struttura s_struttura_loc

li_ret= getItem(index, llvi_dettaglio)
	
s_struttura_loc= llvi_dettaglio.data

// coordinate del tree view della struttura

ls_nodo= s_struttura_loc.vc_nodo

ll_livello= s_struttura_loc.livello

ll_handle= s_struttura_loc.handle

li_ret= tv_struttura.selectItem(ll_handle)

if ll_livello > MAX_LIVELLO then //return 0

openWithParm(w_schede_dati, '168306RM')

end if

// ora tv_struttura

//li_ret= tvf_cerca_nodo( tv_struttura, ll_livello, ll_nodo, ll_handle)


return 0
end event

type tv_struttura from treeview within w_struttura_tv_vc
event type boolean ue_searchcompare ( long al_handle,  string as_attributo,  any aa_target,  boolean ab_respectcase,  boolean ab_fullcompare )
integer x = 18
integer y = 16
integer width = 2501
integer height = 2396
integer taborder = 10
string dragicon = "DataPipeline!"
boolean dragauto = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long backcolor = 16777215
integer indent = 250
boolean haslines = false
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
boolean trackselect = true
string picturename[] = {"download01.jpg","download01.jpg","download01.jpg","download01.jpg","download01.jpg","download01.jpg","download01.jpg","download03.jpg","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 16777215
string statepicturename[] = {"","",""}
long statepicturemaskcolor = 536870912
end type

event ue_searchcompare;boolean lb_found= false
integer li_ret
string ls_source, ls_target
treeViewItem ltvi_item

if getItem(al_handle, ltvi_item)= -1 then return false

parent.setMicroHelp("Sto cercando in "+ltvi_item.label)

if lower(as_attributo)= 'label' then 

	if ab_respectCase then
		
		ls_source= ltvi_item.label
		ls_target= string(aa_target)
	else
		
		ls_source= upper(ltvi_item.label)
		ls_target= upper(string(aa_target))
		
	end if
	
	if ab_fullCompare then
		
		if ls_source= ls_target then lb_found= true // return true
	
	else
		
		if pos(ls_source, ls_target) > 0 then lb_found= true // return true
		
	end if

else
	
	if className(ltvi_item.data) = 'string' then
		
		if ab_respectCase then
			
			ls_source= string(ltvi_item.data)
			
			ls_target= string(aa_target)
			
		else
			
			ls_source= upper(string(ltvi_item.data))
			ls_target= upper(string(aa_target))
			
		end if
		
		if ab_fullCompare then
			
			if ls_source= ls_target then lb_found= true // return true
				
		else
			
			if pos(ls_source, ls_target) > 0 then lb_found = true // return true
			
		end if
	
	else
	
		if ltvi_item.data= aa_target then lb_found= true //return true
	
	end if

end if

return lb_found // false
end event

event selectionchanged;integer li_ret
treeViewItem ltvi_item

s_struttura s_struttura_s

//messageBox("test", "selchanged")

if ib_dragdrop then return 0

li_ret= getItem(newhandle, ltvi_item)

s_struttura_s= ltvi_item.data

if ltvi_item.expandedOnce= true and s_struttura_s.livello<= MAX_LIVELLO then  
	lv_dettaglio.deleteItems()
	tvf_populate(newhandle) // solo la list view...
else
	if  is_struttura_s.livello > MAX_LIVELLO then
		ltvi_item.children= false
	else
		ltvi_item.children= true		
	end if
end if

ltvi_item.selected= true

setItem(newhandle, ltvi_item)

li_ret= expandItem(newHandle)

return 0
end event

event rightclicked;//setpointer(hourGlass!)
//setRedraw(false)
//ExpandAll ( handle )
//setRedraw(true)
//messagebox("test", "struttura")
integer li_ret
long ll_handle
s_struttura s_struttura_loc
treeviewItem ll_tvi
	
ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
	
li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
	
s_struttura_loc= ll_tvi.data

im_pop_tv.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )

if s_struttura_loc.livello= MAX_LIVELLO then im_pop_tv.m_offerte.enabled= false

//parent.event ue_espandi_livello()
end event

event itemcollapsing;integer li_ret

lv_dettaglio.deleteItems()
tvf_populate(handle)

return 0
end event

event itempopulate;//treeViewItem ltvi_clicked
//long ll_ret
//
//getItem(handle, ltvi_clicked)
//
//	ltvi_clicked.selected= true
//	ltvi_clicked.children= true
//
//if ltvi_clicked.expandedOnce= false then
//	ll_ret= tvf_populate(handle)
//	lv_dettaglio.deleteItems()
//	selectItem(handle)
//	ll_ret= expandItem(Handle)
//	
//
//
//end if

integer li_ret
long ll_ret
s_struttura s_struttura_loc
treeViewItem ll_tvi


//if findItem(childTreeItem!, handle) = -1 then
	
//	messageBox("test"," itempop")

	
	// non ha figli quindi va popolato...
	if getItem(handle, ll_tvi) > 0 then
		
//		if ll_tvi.expandedOnce= false then
		
			lv_dettaglio.deleteItems()
			
			ll_ret= tvf_populate(handle)
			if ll_ret= 0 then
	//			ll_tvi.children= false
			else
	//			ll_tvi.pictureIndex= 12
	//			ll_tvi.bold= true
			end if
//		setItem(handle, ll_tvi)
	
//	end if
	
end if

return 0

return 0
end event

event begindrag;//This code is in the BeginDrag event script of the source TreeView:

long itemnum

// If the TreeView's DragAuto property is FALSE

This.Drag(Begin!)

ib_dragdrop= true

itemnum = 1

This.GetItem(handle, itvi_dragged_object)
il_oldhandle= handle

il_DragLevel= itvi_dragged_object.level
end event

event dragdrop;//This code is in the DragDrop event of the target TreeView:

//This.InsertItemLast(handleparent, ilvi_dragged_object)


//This example inserts the dragged object as a child of the TreeView item it is dropped upon:

long newhandle, oldhandle, targethandle

treeViewItem ltvi_target

targethandle= handle

This.GetItem(targethandle, ltvi_target)

il_DropLevel= ltvi_target.level

if il_DropLevel = il_DragLevel - 1 then
	
	newhandle= This.InsertItemSort(targethandle, itvi_dragged_object)
	
	if newhandle > 0 then
		
		This.DeleteItem(il_oldhandle)
		
		This.ExpandItem(il_oldhandle)
		
	else
		
		messageBox(parent.title, "Errore in dragdrop", exclamation!)
		
	end if

else
	
	 Drag(cancel!)
	 
	 ib_dragdrop= false
	 
end if


//This.SetRedraw(TRUE)
end event

event dragwithin;TreeViewItem ltvi_Over

If GetItem(handle, ltvi_Over) = -1 Then
	SetDropHighlight(0)
	il_DropTarget = 0
	Return
End If

il_DropLevel= il_DragLevel - 1

if ltvi_Over.level = il_DropLevel then

	SetDropHighlight(handle)
	il_DropTarget = handle

else
			
//	SetDropHighlight(0)
//	il_DropTarget = 0
		
end if

//setRedraw(true)

return 0
end event

