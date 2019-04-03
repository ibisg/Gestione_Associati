$PBExportHeader$w_struttura_tv_con_lv.srw
forward
global type w_struttura_tv_con_lv from window
end type
type lv_dettaglio from listview within w_struttura_tv_con_lv
end type
type tv_struttura from treeview within w_struttura_tv_con_lv
end type
end forward

global type w_struttura_tv_con_lv from window
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
event type integer ue_queryofferte ( integer ai_qualequery,  long al_livello,  long al_nodo,  s_data as_data_s )
event type integer ue_queryofferte_div ( integer ai_qualequery,  long al_livello,  long al_nodo,  s_data as_data_s )
event type integer ue_queryofferte_resp ( integer ai_qualequery,  long al_livello,  long al_nodo,  s_data as_data_s )
event type integer ue_queryofferte_tab ( integer ai_qualequery,  long al_livello,  long al_nodo,  s_data as_data_s )
event type integer ue_cerca ( )
event type integer ue_queryofferte_dettaglio ( integer ai_qualequery,  long al_livello,  long al_nodo,  s_data as_data_s )
event type integer ue_queryofferte_group ( integer ai_livello,  string as_nodo,  integer ai_livello_raggruppamento,  s_data as_data_s )
lv_dettaglio lv_dettaglio
tv_struttura tv_struttura
end type
global w_struttura_tv_con_lv w_struttura_tv_con_lv

type variables
long	il_livello
long il_queue[], il_foundhandle
m_pop_tv im_pop_tv
m_pop_lv_dettaglio im_pop_lv_dettaglio
end variables

forward prototypes
public function long tvf_finditem (string as_attributo, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare)
public function integer tvf_cerca_nodo (ref treeview atv_arg, long al_livello, long al_nodo, long al_handle)
public function long tvf_searchchild (string as_attributo, any aa_target, long al_begin, integer ai_level, boolean ab_respectcase, boolean ab_fullcompare)
public function integer tvf_genera_dettaglio (long al_handle)
public function integer tvf_populate (long tvi_handle)
public function integer tvf_cerca (treeview atv_arg, long al_handle, string as_ricerca)
end prototypes

event ue_runquery;integer li_ret
long ll_handle
s_struttura s_struttura_loc
s_data s_data_s
listViewItem ll_lvi
treeviewItem ll_tvi

open(w_criteri_estrazione)

s_data_s= message.powerObjectParm

if isNull(s_data_s.ls_da) then return -1

setpointer(hourGlass!)
setRedraw(false)

open(w_preview_scheda)

w_preview_scheda.setRedraw(false)

choose case ai_qualequery
	case 1
		w_preview_scheda.dw_current.dataObject= 'dw_queryofferte'
	case 2
		w_preview_scheda.dw_current.dataObject= 'dw_queryofferte_div'
	case 3
		w_preview_scheda.dw_current.dataObject= 'dw_queryofferte_resp'
	case 4
		w_preview_scheda.dw_current.dataObject= 'dw_queryofferte_tab'
	case 5
		w_preview_scheda.dw_current.dataObject= 'dw_queryofferte_dettaglio'
	case 6
		w_preview_scheda.dw_current.dataObject= 'dw_queryofferte_per_livelli'
end choose

w_preview_scheda.dw_current.setTransObject(sqlca)

w_preview_scheda.dw_current.reset()

if ai_source= 1 then // la query viene richiesta dal treeView...
	
	ll_handle = tv_struttura.FindItem(currentTreeItem!, 0)
	
	li_ret= tv_struttura.getItem(ll_handle, ll_tvi)
	
	s_struttura_loc= ll_tvi.data
	
	choose case ai_qualequery
		case 1
			li_ret= event ue_queryofferte(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
		case 2
			li_ret= event ue_queryofferte_div(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
		case 3
			li_ret= event ue_queryofferte_resp(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
		case 4
			li_ret= event ue_queryofferte_tab(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
		case 5
			li_ret= event ue_queryofferte_dettaglio(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
		case 6
			li_ret= event ue_queryofferte_group(s_struttura_loc.livello, s_struttura_loc.vc_nodo, 5, s_data_s)
	end choose
	
else // la query viene richiesta dalla list view...

	ll_handle = lv_dettaglio.FindItem(0, directionAll!, false, true, false, false)
	
	do while ll_handle <> -1
		
		lv_dettaglio.getItem(ll_handle, ll_lvi)
		
		s_struttura_loc= ll_lvi.data
	
		choose case ai_qualequery
			case 1
				li_ret= event ue_queryofferte(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
			case 2
				li_ret= event ue_queryofferte_div(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
			case 3
				li_ret= event ue_queryofferte_resp(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
			case 4
				li_ret= event ue_queryofferte_tab(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
			case 5
				li_ret= event ue_queryofferte_dettaglio(ai_qualequery, s_struttura_loc.livello, s_struttura_loc.id_nodo, s_data_s)
		end choose
		
		ll_handle = lv_dettaglio.FindItem(ll_handle, directionAll!, false, true, false, false)
	loop

end if

w_preview_scheda.dw_current.groupCalc()

w_preview_scheda.dw_current.Object.DataWindow.Print.Preview= 'Yes'

setRedraw(true)

w_preview_scheda.setRedraw(true)

return li_ret
return 0
end event
event ue_queryofferte;string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero
s_struttura s_struttura_loc

treeViewItem ll_tvi

//ls_query= f_creaqueryofferte(al_livello, al_nodo,as_data_s. ls_da, as_data_s.ls_a)
ls_query= f_creaqueryofferte_group(al_livello, al_nodo,as_data_s. ls_da, as_data_s.ls_a, 5,"0.0.0")

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

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
	
	ll_row= w_preview_scheda.dw_current.insertRow(0)
	w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
	w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
	w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
	w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
	w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
	w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
	w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	

loop

closecur: CLOSE my_cursor ;
	if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0


end event

event ue_queryofferte_div;string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero
s_struttura s_struttura_loc

treeViewItem ll_tvi

ls_query= f_creaqueryofferte_div(al_livello, al_nodo,as_data_s. ls_da, as_data_s.ls_a)

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

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

closecur: CLOSE my_cursor ;
	if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0


end event

event ue_queryofferte_resp;string ls_query, ls_status, ls_cod_resp, ls_descrizione_struttura, ls_livello_struttura
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero
s_struttura s_struttura_loc

treeViewItem ll_tvi

ls_query= f_creaqueryofferte_resp(al_livello, al_nodo,as_data_s. ls_da, as_data_s.ls_a)

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

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

closecur: CLOSE my_cursor ;
	if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0


end event

event ue_queryofferte_tab;string ls_query, ls_status, ls_cod_div, ls_cod_resp, ls_descrizione_struttura, ls_livello_struttura
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero
s_struttura s_struttura_loc

treeViewItem ll_tvi

ls_query= f_creaqueryofferte_tab(al_livello, al_nodo,as_data_s. ls_da, as_data_s.ls_a)

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

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

closecur: CLOSE my_cursor ;
	if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0


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

event ue_queryofferte_dettaglio;string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura, ls_codice, ls_cognome, ls_nome, ls_max_livello, ls_altri_livelli
long ll_totale_persone, ll_row
decimal ld_importo
s_struttura s_struttura_loc

treeViewItem ll_tvi

ls_query= f_creaqueryofferte_dettaglio(al_livello, al_nodo,as_data_s. ls_da, as_data_s.ls_a)
//ls_query= f_creaqueryofferte_per_livelli(al_livello, al_nodo,as_data_s. ls_da, as_data_s.ls_a)

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

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

w_preview_scheda.dw_current.sort()

closecur: CLOSE my_cursor ;
if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0
end event
event ue_queryofferte_group;string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero
s_struttura s_struttura_loc

treeViewItem ll_tvi

ls_query= f_creaqueryofferte_per_raggruppamenti(ai_livello, as_nodo, ai_livello_raggruppamento, as_data_s)

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

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
	
	ll_row= w_preview_scheda.dw_current.insertRow(0)
	w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
	w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
	w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
	w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
	w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
	w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
	w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	

loop

closecur: CLOSE my_cursor ;
	if trap_sql(sqlca, "QUERY03") < 0 then return -1

return 0


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

public function integer tvf_cerca_nodo (ref treeview atv_arg, long al_livello, long al_nodo, long al_handle);integer li_ret= 1
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
		
		if s_struttura_loc.id_nodo= al_nodo then
			
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

public function integer tvf_populate (long tvi_handle);integer li_ret
long ll_handle, ll_livello, ll_nodo, ll_parent, ll_codice_membro, ll_cod_div, ll_index
string ls_relazione, ls_codice, ls_descrizione, ls_cognome, ls_nome, ls_cod_dip
treeViewItem ll_tvi
listViewItem ll_lvi
s_struttura s_struttura_loc

//ll_lev1 = tv_struttura.FindItem(CurrentTreeItem!, 0)

tv_struttura.getItem(tvi_handle, ll_tvi)

ll_livello= ll_tvi.level

if ll_livello > 0 then

	s_struttura_loc= ll_tvi.data

	ll_nodo= s_struttura_loc.id_nodo
	ll_livello= s_struttura_loc.livello
	
end if

if ll_livello <  MAX_LIVELLO then

	declare child_cur cursor for
	
	select livello, id_nodo, relazione, id_parent, codice, descrizione
	from struttura
	where	livello= :ll_livello + 1 and id_parent= :ll_nodo;
	if trap_sql(sqlca, "LIV0") < 0 then return -1
	
	open child_cur;
	if trap_sql(sqlca, "LIV0.01") < 0 then return -1
	
	do while sqlca.sqlcode <> 100
		
		fetch child_cur into
		:ll_livello,
		:ll_nodo,
		:ls_relazione,
		:ll_parent,
		:ls_codice,
		:ls_descrizione;
		if trap_sql(sqlca, "LIV0.02") < 0 then return -1
		
		if sqlca.sqlcode= 100 then continue
		
		s_struttura_loc.livello= ll_livello
		s_struttura_loc.id_nodo= ll_nodo
		
		ll_tvi.pictureIndex= ll_livello
		ll_tvi.selectedPictureIndex= 8
		ll_tvi.selected= false
		
		ll_handle = tv_struttura.InsertItemLast(tvi_handle,ll_tvi)
		
		s_struttura_loc.handle= ll_handle
		
		ll_tvi.label= f_iniziali(ls_descrizione)/*+" ("+string(ll_livello)+", "+string(ll_handle)+")"*/
		ll_tvi.data= s_struttura_loc
		
		li_ret= tv_struttura.setItem(ll_handle, ll_tvi)
		
		// list view

		ll_lvi.data= s_struttura_loc
		
		ll_lvi.label= f_iniziali(ls_descrizione)
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
	where livello= :ll_livello and id_nodo= :ll_nodo
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
		
		s_struttura_loc.id_nodo= ll_nodo
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

event lvf_dettaglio;string ls_query, ls_status, ls_cod_div, ls_descrizione_struttura, ls_livello_struttura
long ll_totale_persone, ll_row
decimal ld_importo, ld_zero
s_struttura s_struttura_loc

treeViewItem ll_tvi

//ls_query= f_creaqueryofferte_dettaglio(al_livello, al_nodo,as_data_s. ls_da, as_data_s.ls_a)

DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;

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
	
	ll_row= w_preview_scheda.dw_current.insertRow(0)
//	w_preview_scheda.dw_current.setItem(ll_row, "intestazione", "Offerte dal "+as_data_s. ls_da+" al "+as_data_s.ls_a)	
	w_preview_scheda.dw_current.setItem(ll_row, "descrizione_struttura", ls_descrizione_struttura)
	w_preview_scheda.dw_current.setItem(ll_row, "status", ls_status)
	w_preview_scheda.dw_current.setItem(ll_row, "importo", ld_importo)
	w_preview_scheda.dw_current.setItem(ll_row, "importo_0", ld_zero)
	w_preview_scheda.dw_current.setItem(ll_row, "totale_persone", ll_totale_persone)
	w_preview_scheda.dw_current.setItem(ll_row, "livello_struttura", ls_livello_struttura)	

loop

closecur: CLOSE my_cursor ;
//if trap_sql(sqlca, "QUERY03") < 0 then return -1

//return 0
end event

on w_struttura_tv_con_lv.create
if this.MenuName = "m_struttura" then this.MenuID = create m_struttura
this.lv_dettaglio=create lv_dettaglio
this.tv_struttura=create tv_struttura
this.Control[]={this.lv_dettaglio,&
this.tv_struttura}
end on

on w_struttura_tv_con_lv.destroy
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

type lv_dettaglio from listview within w_struttura_tv_con_lv
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
boolean underlinehot = true
string largepicturename[] = {"GLOBES.bmp","a.gif","t.gif","h.gif","c.gif","s.gif","g.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 536870912
string smallpicturename[] = {"GLOBES.bmp","a.gif","t.gif","h.gif","c.gif","s.gif","g.gif","CharlieBrown2.gif","Fussbudget.gif","Linus.gif","Sally.gif"}
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
treeViewItem ltvi_struttura
s_struttura s_struttura_loc

li_ret= getItem(index, llvi_dettaglio)
	
s_struttura_loc= llvi_dettaglio.data

// coordinate del tree view della struttura

ll_nodo= s_struttura_loc.id_nodo

ll_livello= s_struttura_loc.livello

ll_handle= s_struttura_loc.handle

li_ret= tv_struttura.selectItem(ll_handle)

if ll_livello = MAX_LIVELLO then return 0

// ora tv_struttura

li_ret= tvf_cerca_nodo( tv_struttura, ll_livello, ll_nodo, ll_handle)


return 0
end event

type tv_struttura from treeview within w_struttura_tv_con_lv
event type boolean ue_searchcompare ( long al_handle,  string as_attributo,  any aa_target,  boolean ab_respectcase,  boolean ab_fullcompare )
integer x = 18
integer y = 16
integer width = 2501
integer height = 2396
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long backcolor = 12632256
integer indent = 250
boolean linesatroot = true
boolean hideselection = false
boolean checkboxes = true
boolean trackselect = true
boolean fullrowselect = true
boolean singleexpand = true
string picturename[] = {"Move!","a.gif","t.gif","h.gif","c.gif","s.gif","g.gif","foldopen.bmp"}
long picturemaskcolor = 553648127
string statepicturename[] = {"",""}
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

event itemexpanding;integer li_ret
long ll_ret
s_struttura s_struttura_loc
treeViewItem ll_tvi

//messageBox("test"," itemexp")

if findItem(childTreeItem!, handle) = -1 then
	// non ha figli quindi va popolato...
	if getItem(handle, ll_tvi) > 0 then
		
		lv_dettaglio.deleteItems()
		
		ll_ret= tvf_populate(handle)
		if ll_ret= 0 then
			ll_tvi.children= false
		else
//			ll_tvi.pictureIndex= 12
//			ll_tvi.bold= true
		end if
		setItem(handle, ll_tvi)
	
	end if
	
end if

return 0
end event

event selectionchanged;integer li_ret
treeViewItem ltvi_item

//messageBox("test", "selchanged")

li_ret= getItem(newhandle, ltvi_item)
ltvi_item.selected= true
ltvi_item.children= true

setItem(newhandle, ltvi_item)

li_ret= expandItem(newHandle)

return 0
end event

event rightclicked;//setpointer(hourGlass!)
//setRedraw(false)
//ExpandAll ( handle )
//setRedraw(true)
//messagebox("test", "struttura")
im_pop_tv.PopMenu ( w_frame_gestioneassociati.PointerX(), w_frame_gestioneassociati.PointerY() )

//parent.event ue_espandi_livello()
end event

event itemcollapsing;integer li_ret
treeViewItem ll_tvi

li_ret= getItem(handle, ll_tvi)

if ll_tvi.expandedOnce= false then  tvf_populate(handle)
	
	ll_tvi.pictureIndex= ll_tvi.level
	ll_tvi.bold= false
	
setItem(handle, ll_tvi)

return 0
end event

